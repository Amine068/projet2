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
        $categories = $entityManager->getRepository(Category::class)->findAll();
        
        $existingReport = $entityManager->getRepository(Report::class)->findOneBy(['annonce' => $annonce, 'user' => $this->getUser()]);
        
        if ($existingReport) {
            $this->addFlash('error', 'Vous avez déjà signalé cette annonce.');
            return $this->redirectToRoute('show_annonce', ['id' => $annonce->getId()]);
        }

        if ($annonce->isLocked()) {
            $this->addFlash('info', 'Cette annonce a déjà été signalée et est en cours de vérification.');
            return $this->redirectToRoute('show_annonce', ['id' => $annonce->getId()]);
        }
        
        $report = new Report();

        $form = $this->createForm(ReportType::class, $report);

        $form->handleRequest($request);
        
        
        if ($form->isSubmitted() && $form->isValid()) {
            $report = $form->getData();
            $report->setAnnonce($annonce);
            $report->setUser($this->getUser());
            $report->setReportedAt(new \DateTime());
            $report->setIsHandled(false);
            
            $entityManager->persist($report);
            $annonce->addReport($report);
            $entityManager->flush();
            
            $this->addFlash('success', 'Annonce signalée avec succès. Merci pour votre vigilance.');
            
            return $this->redirectToRoute('show_annonce', ['id' => $annonce->getId()]);
        }
        
        $this->addFlash('error', 'Une erreur est survenue lors du signalement');
        return $this->redirectToRoute('show_annonce', ['id' => $annonce->getId()]);
    }
}