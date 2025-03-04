<?php

namespace App\Controller;

use App\Entity\Annonce;
use App\Entity\Category;
use App\Entity\Subcategory;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Serializer\SerializerInterface;
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

        if (isset($_GET['recherche']) || isset($_GET['categoryFilter']) || isset($_GET['subcategoryFilter']) || isset($_GET['localisation']) || isset($_GET['prixMin']) || isset($_GET['prixMax']))
        {
            $recherche = filter_var($request->query->get('recherche'), FILTER_SANITIZE_FULL_SPECIAL_CHARS);
            $category = filter_var($request->query->get('categoryFilter'), FILTER_VALIDATE_INT);
            $subcategory = filter_var($request->query->get('subcategoryFilter'), FILTER_VALIDATE_INT);
            $localisation = filter_var($request->query->get('localisation'), FILTER_SANITIZE_FULL_SPECIAL_CHARS);
            $prixMin = filter_var($request->query->get('prixMin'), FILTER_VALIDATE_INT);
            $prixMax = filter_var($request->query->get('prixMax'), FILTER_VALIDATE_INT);


            // dd($recherche, $category, $subcategory, $localisation, $prixMin, $prixMax);

            if ((isset($prixMin) && isset($prixMax)) && ($prixMin > $prixMax)) {
                $this->addFlash('error', 'Le prix minimum ne peut pas être supérieur au prix maximum');
                return $this->redirectToRoute('app_home');
            }

            $annonces = $entityManager->getRepository(Annonce::class)->searchWithFilter($recherche, $category, $subcategory, $localisation, $prixMin, $prixMax);

            if ($request->isXmlHttpRequest()) {
                foreach ($annonces as $annonce) {
                    $annoncesArray[] = [
                        'id' => $annonce->getId(),
                        'title' => $annonce->getTitle(),
                        'description' => $annonce->getDescription(),
                        'date_of_post' => $annonce->getDateOfPost(),
                        'price' => $annonce->getPrice(),
                        'city' => $annonce->getCity(),
                        'zipcode' => $annonce->getZipcode(),
                    ];
                }

                return $this->json($annoncesArray);

            } else {
                return $this->render('home/search.html.twig', [
                    'annonces' => $annonces,
                    'categories' => $categories
                ]);
            }

        }

        // recherche des annonces en fonction de la recherche de l'utilisateur
        $annonces = $entityManager->getRepository(Annonce::class)->search();

        return $this->render('home/search.html.twig', [
            'annonces' => $annonces,
            'categories' => $categories
        ]);
    }

    #[Route('/testSearch', name: 'testSearch')]
    public function testSearch(Request $request, EntityManagerInterface $entityManager): Response
    {

        if (isset($_GET['recherche']) || isset($_GET['categoryFilter']) || isset($_GET['subcategoryFilter']) || isset($_GET['localisation']) || isset($_GET['prixMin']) || isset($_GET['prixMax']))
        {
            $recherche = filter_var($request->query->get('recherche'), FILTER_SANITIZE_FULL_SPECIAL_CHARS);
            $category = filter_var($request->query->get('categoryFilter'), FILTER_VALIDATE_INT);
            $subcategory = filter_var($request->query->get('subcategoryFilter'), FILTER_VALIDATE_INT);
            $localisation = filter_var($request->query->get('localisation'), FILTER_SANITIZE_FULL_SPECIAL_CHARS);
            $prixMin = filter_var($request->query->get('prixMin'), FILTER_VALIDATE_INT);
            $prixMax = filter_var($request->query->get('prixMax'), FILTER_VALIDATE_INT);


            if ((isset($prixMin) && isset($prixMax)) && ($prixMin > $prixMax)) {
                $this->addFlash('error', 'Le prix minimum ne peut pas être supérieur au prix maximum');
                return $this->redirectToRoute('app_home');
            }

            $annonces = $entityManager->getRepository(Annonce::class)->searchWithFilter($recherche, $category, $subcategory, $localisation, $prixMin, $prixMax);

            foreach ($annonces as $annonce) {
                $annoncesArray[] = [
                    'id' => $annonce->getId(),
                    'title' => $annonce->getTitle(),
                    'description' => $annonce->getDescription(),
                    'date_of_post' => $annonce->getDateOfPost(),
                    'price' => $annonce->getPrice(),
                    'city' => $annonce->getCity(),
                    'zipcode' => $annonce->getZipcode(),
                ];
            }

            return $this->json($annoncesArray);
        }
    }

    // methode pour la recuperation des souscategorie a partir des categorie pour le filtre de recherche
    #[Route('/filterCategory', name: 'filterCategory')]
    public function filterCategory(Request $request, EntityManagerInterface $entityManager): JsonResponse
    {
        // récupération de l'id de la catégorie sélectionnée par l'utilisateur via la requete ajax
        $categoryId = $request->query->get('category');

        // recupération des sous-categorie en fonction de la catégorie
        $subCategories = $entityManager->getRepository(Subcategory::class)->findBy(['category' => $categoryId]);

        // boucle sur les souscatégorie pour passer de d'objet a un tableau (pour qui puisse être envoyé sous format json)
        foreach ($subCategories as $subCategory) {
            $subCategoriesArray[] = [
                'id' => $subCategory->getId(),
                'name' => $subCategory->getName()
            ];
        }

        // renvoie du resultat sous format json
        return $this->json($subCategoriesArray);
    }
}
