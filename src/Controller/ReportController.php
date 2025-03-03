<?php

namespace App\Controller;

use App\Entity\Report;
use App\Entity\Annonce;
use App\Entity\Category;
use App\Form\ReportType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

final class ReportController extends AbstractController
{
    #[Route('/annonce/{id}/report', name: 'report_annonce')]
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    public function report(Annonce $annonce, Request $request, EntityManagerInterface $entityManager): Response
    {
        // récupération des catégories pour l'affichage dans le header
        $categories = $entityManager->getRepository(Category::class)->findAll();
        
        // recuperation d'un potentiel signalement existant
        $existingReport = $entityManager->getRepository(Report::class)->findOneBy(['annonce' => $annonce, 'user' => $this->getUser()]);
        
        // verification si l'annonce est déjà signalée par l'utilisateur
        if ($existingReport) {
            // ajout du message d'érreur
            $this->addFlash('error', 'Vous avez déjà signalé cette annonce.');
            // redirection vers la page de l'annonce
            return $this->redirectToRoute('show_annonce', ['id' => $annonce->getId()]);
        }

        if ($annonce->isLocked()) {
            $this->addFlash('info', 'Cette annonce a déjà été signalée et est en cours de vérification.');
            return $this->redirectToRoute('show_annonce', ['id' => $annonce->getId()]);
        }
        
        // création d'une nouvelle entité Report
        $report = new Report();

        //création d'un formulaire a partir de ReportType et de l'entité Report
        $form = $this->createForm(ReportType::class, $report);

        // traitement des données du formulaire
        $form->handleRequest($request);
        
        // on verifie si le formulaire est soumis et valide
        if ($form->isSubmitted() && $form->isValid()) {

            // ajout des données du formulaire a l'entité Report
            $report = $form->getData();

            // ajout de l'annonce dans l'entité Report
            $report->setAnnonce($annonce);

            // verification du nombre de signalement si supérieur a 4 on vérouille l'annonce
            if (count($annonce->getReports()) > 4) {
                $annonce->setIsLocked(true);
            }

            // ajout de l'utilisateur dans l'entité Report
            $report->setUser($this->getUser());

            // ajout de la date de signalement
            $report->setReportedAt(new \DateTime());

            // ajout de l'état de traitement du signalement a false (non traité)
            $report->setIsHandled(false);
            
            // on previent doctrine de l'ajout d'un signalement
            $entityManager->persist($report);

            // on ajoute le signalement a l'annonce
            $annonce->addReport($report);

            // on execute
            $entityManager->flush();
            
            // ajout du message de succès de creation d'un signalement
            $this->addFlash('success', 'Annonce signalée avec succès. Merci pour votre vigilance.');
            
            //redirection vers la page de l'annonce
            return $this->redirectToRoute('show_annonce', ['id' => $annonce->getId()]);
        }

        return $this->render('report/index.html.twig', [
            'form' => $form,
            'categories' => $categories,
            'annonce' => $annonce
        ]);
    }
}