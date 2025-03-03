<?php

namespace App\Controller;

use App\Entity\User;
use App\Form\UserType;
use App\Entity\Annonce;
use App\Entity\Category;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

final class ProfileController extends AbstractController
{
    // methode pour l'affichae de la page de profil de l'utilisateur connecté
    #[Route('/account', name: 'app_account')]
    public function index(EntityManagerInterface $entityManager): Response
    {
        // verficiation de si l'utilisateur est connecté
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');

        // recuperation de l'utilisateur en session
        $user = $this->getUser();

        // recuperation des catégories pour l'affichage dans le header
        $categories = $entityManager->getRepository(Category::class)->findAll();

        // recuperation des annonces de l'utilisateur, 
        $annonces = $entityManager->getRepository(Annonce::class)->findBy(['user' => $user, "isArchived" => false]);

        // on vérifie si un avatar existe pour le placeholder
        $avatarExists = file_exists($this->getParameter('avatar_directory') . '/' . $user->getAvatar());

        return $this->render('profile/index.html.twig', [
            'categories' => $categories,
            'annonces' => $annonces,
            'avatarExists' => $avatarExists
        ]);
    }

    // methode pour la modification du profile de l'utilisateur
    #[Route('/account/edit', name: 'edit_account')]
    public function edit(Request $request, EntityManagerInterface $entityManager): Response
    {
        // vérification de si l'utilisateur est connecté
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');

        // recupération des catégories pour l'affichage dans le header
        $categories = $entityManager->getRepository(Category::class)->findAll();

        // recupération de l'utilisateur en session
        $user = $this->getUser();

        // création du formulaire
        $form = $this->createForm(UserType::class, $user);

        // traitement des données du formulaire
        $form->handleRequest($request);

        // on verifie si le formulaire est soumis et valide
        if ($form->isSubmitted() && $form->isValid()) {

            // recupération de l'avatar et envoyé par l'utilisateur
            $avatar = $form->get('avatar')->getData();

            // si il existe
            if ($avatar) {
                // on vérifie si l'utilisateur possède un avatar et si le fichier existe si c'est le cas on le supprime
                if ($user->getAvatar() && file_exists($this->getParameter('avatar_directory').'/'.$user->getAvatar())) {
                    unlink($this->getParameter('avatar_directory').'/'.$user->getAvatar());
                }

                // on donne un nom unique a l'avatar
                $newAvatar = uniqid() . '.' . $avatar->guessExtension();

                // on ajoute l'image dans le dossier adéquat
                $avatar->move($this->getParameter('avatar_directory'), $newAvatar);

                // on ajoute le nom de l'image a l'entité User
                $user->setAvatar($newAvatar);
            }

            // ajout des données du formulaire a l'entité User
            $user = $form->getData();

            // on previent doctrine de la modification de l'entité user
            $entityManager->persist($user);

            // on execute
            $entityManager->flush();

            // on redirige vers le profile de l'utilisateur
            return $this->redirectToRoute('app_account');
        }
        return $this->render('profile/edit.html.twig', [
            'categories' => $categories,
            'form' => $form
        ]);
    }

    // methode pour la suppression du compte de l'utilisateur (anonymisation)
    #[Route('/account/delete', name:'delete_account')]
    public function deleteAccount(EntityManagerInterface $entityManager): Response
    {   
        // on verifie que l'utlisateur est connecté
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');

        // on recupère l'utilisateur en session
        $user = $this->getUser();

        // on anonymise l'utilisateur avec la methode anonymizeUser()
        $this->anonymizeUser($user);

        // on previent doctrine de la modification de l'entité user
        $entityManager->persist($user);

        // on execute
        $entityManager->flush();

        // redirection vers la page de deconnexion
        return $this->redirectToRoute('app_logout');
    }

    // methode qui anonymise un utilisateur
    private function anonymizeUser(User $user)
    {
        // generation d'un nouveau nom d'utilisateur
        $newUsername = uniqid();

        // generation d'un nouvel faux email
        $newEmail = hash('sha256', uniqid());

        // generation d'un nouveau faux mot de passe
        $newPassword = hash('sha256', uniqid());

        // on ajoute les données générées a l'entité User
        $user->setUsername($newUsername);
        $user->setEmail($newEmail);
        $user->setPassword($newPassword);

        // changement du role de l'utilisateur
        $user->setRoles(['ROLE_DELETE']);

        // on rends null les données de l'utilisateur
        $user->setGoogleId(null);

        // on rend le boolean isAnonymize a true
        $user->setIsAnonymize(true);
    }

    // methode d'affichage des annonces favorites de l'utilisateur
    #[Route('/account/favorites', name: 'app_favorites')]
    public function show_favorites(EntityManagerInterface $entityManager): Response
    {
        // on vérifie que l'utilisateur est connecté
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');

        // on récupère les catégorie pour l'affichage dans le header
        $categories = $entityManager->getRepository(Category::class)->findAll();

        return $this->render('profile/favorites.html.twig', [
            'categories' => $categories
        ]);
    }

    // methode d'ajout d'une annonce aux favoris
    #[Route('/account/favorites/add/{id}', name: 'add_favorite')]
    public function add_favorite(Annonce $annonce, EntityManagerInterface $entityManager): Response
    {
        // vérifiation de l'authentification de l'utilisateur
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');

        // recuperation de l'utilisateur en session
        $user = $this->getUser();

        // ajout de l'annonce dans les favoris de l'utilisateur
        $user->addFavoriteAnnonce($annonce);

        // on previent doctrine de la modification de l'entité user
        $entityManager->persist($user);

        // on execute
        $entityManager->flush();

        // redirection vers la page des favoris
        return $this->redirectToRoute('app_favorites');
    }

    // methode qui permet de supprimer une annonce des favoris
    #[Route('/account/favorites/remove/{id}', name: 'remove_favorite')]
    public function remove_favorite(Annonce $annonce, EntityManagerInterface $entityManager): Response
    {
        // on verifie si l'utilisateur est connecté
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');

        // récupération de l'utilisateur en sesssion
        $user = $this->getUser();

        // on supprime l'annonce des favoris de l'utilisateur
        $user->removeFavoriteAnnonce($annonce);

        // on previent doctrine de la modification de l'entité user
        $entityManager->persist($user);

        // on execute
        $entityManager->flush();

        // redirection vers la page des favoris
        return $this->redirectToRoute('app_favorites');
    }
}
