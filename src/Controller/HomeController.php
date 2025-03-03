<?php

namespace App\Controller;

use App\Entity\Annonce;
use App\Entity\Category;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

final class HomeController extends AbstractController
{
    // affichage de la page d'accueil
    #[Route('/', name: 'app_home')]
    public function index(EntityManagerInterface $entityManager): Response
    {
        // récupération des catégories pour l'affichage dans le header
        $categories = $entityManager->getRepository(Category::class)->findAll();

        // récupération des annonces pour l'affichage sur la page d'accueil (non archivées, visibles et non verrouillées)
        $annonces = $entityManager->getRepository(Annonce::class)->findBy(['isArchived' => false, 'isVisible' => true, 'isLocked' => false]);

        return $this->render('home/index.html.twig', [
            'categories' => $categories,
            'annonces' => $annonces
        ]);
    }

    // recherche d'annonces
    #[Route('/search', name: 'search_annonces')]
    public function search(Request $request, EntityManagerInterface $entityManager): Response
    {
        // récupération des catégories pour l'affichage dans le header
        $categories = $entityManager->getRepository(Category::class)->findAll();

        // récupération de l'entré dans le champ de recherche par l'utilisateur
        $recherche = $request->query->get('recherche');

        // recherche des annonces en fonction de la recherche de l'utilisateur
        $annonces = $entityManager->getRepository(Annonce::class)->search($recherche);

        return $this->render('home/index.html.twig', [
            'annonces' => $annonces,
            'categories' => $categories
        ]);
    }

    
}
