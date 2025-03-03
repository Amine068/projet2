<?php

namespace App\Controller;

use App\Entity\User;
use App\Entity\Report;
use App\Entity\Category;
use App\Form\AdminUserType;
use Symfony\Component\Mime\Email;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

final class AdminController extends AbstractController
{

    #[Route('/admin', name: 'app_admin')]
    public function index(EntityManagerInterface $entityManager): Response
    {
        // vérification du rôle de l'utilisateur pour l'accès à la page d'administration
        $this->denyAccessUnlessGranted('ROLE_MODERATEUR');
        
        // récupération des catégories pour l'affichage dans le header
        $categories = $entityManager->getRepository(Category::class)->findAll();

        return $this->render('admin/index.html.twig', [
            "categories" => $categories,
        ]);
    }

    #[Route('/admin/user', name: 'app_admin_user')]
    public function user(EntityManagerInterface $entityManager): Response
    {
        // vérification du rôle de l'utilisateur
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        // récupération des catégories pour l'affichage dans le header
        $categories = $entityManager->getRepository(Category::class)->findAll();

        // récupération de tous les utilisateurs
        $users = $entityManager->getRepository(User::class)->findAll();

        return $this->render('admin/user.html.twig', [
            "categories" => $categories,
            "users" => $users,
        ]);
    }

    // methode qui permet a un admin de modifier un utilisateur
    #[Route('/admin/user/{id}', name: 'app_admin_user_edit')]
    public function edituser(User $user, Request $request, EntityManagerInterface $entityManager): Response
    {
        // vérification du rôle de l'utilisateur
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        // récupération des catégories pour l'affichage dans le header
        $categories = $entityManager->getRepository(Category::class)->findAll();

        // récupération de l'utilisateur à modifier
        $user = $entityManager->getRepository(User::class)->findOneby(['id' => $user->getId()]);

        // création du formulaire
        $form = $this->createForm(AdminUserType::class, $user);

        // traitement des données du formulaire
        $form->handleRequest($request);

        // on verifie si le formulaire est soumis et valide
        if ($form->isSubmitted() && $form->isValid()) {

            //récupération des rôle de l'utilisateur
            $roles = $form->get('roles')->getData();
            // on vérifie si l'utilisateur a le rôle ROLE_USER
            if (!in_array('ROLE_USER', $roles)) {
                $roles[] = 'ROLE_USER';
            }
            // ajout des rôles à l'utilisateur
            $user->setRoles($roles);

            //ajout du nom d'utilisateur
            $user->setUsername($form->get('username')->getData());

            // persist et flush
            $entityManager->persist($user);
            $entityManager->flush();
            // redirection vers la page d'administration des utilisateurs
            return $this->redirectToRoute('app_admin_user');
        }

        return $this->render('admin/edituser.html.twig', [
            "categories" => $categories,
            "form" => $form,
        ]);
    }

    // methode qui permet a un admin d'affichier les signalements
    #[Route('/admin/reports', name: 'app_reports')]
    public function reports(EntityManagerInterface $entityManager): Response
    {
        // vérification du rôle de l'utilisateur
        $this->denyAccessUnlessGranted('ROLE_MODERATEUR');

        // récupération des catégories pour l'affichage dans le header
        $categories = $entityManager->getRepository(Category::class)->findAll();

        // récupération des signalements non traités
        $reports = $entityManager->getRepository(Report::class)->findBy(['isHandled' => false]);

        return $this->render('admin/reports.html.twig', [
            "categories" => $categories,
            "reports" => $reports,
        ]);
    }

    //methode qui permet d'afficher le détail d'un signalement
    #[Route('/admin/report/{id}', name: 'show_report')]
    public function showReport(Report $report, EntityManagerInterface $entityManager): Response
    {

        // vérification du rôle de l'utilisateur
        $this->denyAccessUnlessGranted('ROLE_MODERATEUR');

        // récupération des catégories pour l'affichage dans le header
        $categories = $entityManager->getRepository(Category::class)->findAll();

        // récupération du signalement sélectionné
        $report = $entityManager->getRepository(Report::class)->findOneby(['id' => $report->getId()]);

        return $this->render('admin/showreport.html.twig', [
            "categories" => $categories,
            "report" => $report,
        ]);
    }

    // methode qui permet de supprimer une annonce signalée (archivée)
    #[Route('/admin/report/{id}/delete', name: 'delete_report')]
    public function deleteReport(Report $report, EntityManagerInterface $entityManager, MailerInterface $mailer): Response
    {
        // vérification du rôle de l'utilisateur
        $this->denyAccessUnlessGranted('ROLE_MODERATEUR');

        // rend le signalement traité
        $report->setIsHandled(true);

        // récupération de l'annonce liée au signalement
        $annonce = $report->getAnnonce();

        $user = $annonce->getUser();

        if (!$user->isAnonymize()) {
            $this->sendmail($user->getEmail(), 'Annonce signalée', 'Votre annonce:'.$annonce->getTitle().'a été supprimée car elle ne respecte pas les règles de notre site.', $mailer);
        }
        
        // on archive l'annonce (fausse supression)
        $annonce->setIsArchived(true);

        // on previent doctrine de la modification d'une entité
        $entityManager->persist($report);
        $entityManager->persist($annonce);
        // on execute
        $entityManager->flush();

        // redirection vers la page des signalements
        return $this->redirectToRoute('app_reports');

    }

    // envoie de l'email par rapport a l'annonce supprimé 
    private function sendmail($dest, $objet, $message, $mailer)
    {
        $email = (new Email())
            ->from('test@exemple.fr')
            ->to($dest)
            ->subject($objet)
            ->text($message);

        dump($email);
        $mailer->send($email);
        
    }

    // methode qui permet lorsque l'annonce signalé ne pose pas problème d'être remise en ligne
    #[Route('/admin/report/{id}/ignore', name: 'ignore_report')]
    public function ignoreReport(Report $report, EntityManagerInterface $entityManager): Response
    {
        // vérification du rôle de l'utilisateur
        $this->denyAccessUnlessGranted('ROLE_MODERATEUR');

        // rend le signalement traité
        $report->setIsHandled(true);

        //recupération de l'annonce liée au signalement
        $annonce = $report->getAnnonce();

        // si l'annonce est vérouillé on la dévérouille
        if ($annonce->isLocked()) {
            $annonce->setIsLocked(false);
        }

        // previent doctrine de la modification des entités
        $entityManager->persist($report);
        $entityManager->persist($annonce);

        // execute
        $entityManager->flush();

        // redirection vers la page des signalements
        return $this->redirectToRoute('app_reports');
    }
}
