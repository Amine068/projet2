<?php

namespace App\Controller;

use App\Entity\Category;
use App\Form\CategoryType;
use App\Entity\Subcategory;
use App\Form\SubcategoryType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

final class CategoryController extends AbstractController
{
    #[Route('/category', name: 'app_category')]
    public function index(EntityManagerInterface $entityManager): Response
    {
        // vérification du rôle de l'utilisateur
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        // recupération des catégories pour le header et l'affichage des catégories
        $categories = $entityManager->getRepository(Category::class)->findAll();

        return $this->render('category/index.html.twig', [
            'categories' => $categories
        ]);
    }

    #[Route('/category/add', name: 'add_category')]
    #[Route('/category/edit/{id}', name: 'edit_category')]
    public function add(Category $category = null, EntityManagerInterface $entityManager, Request $request): Response
    {
        // vérification du rôle de l'utilisateur
        $this->denyAccessUnlessGranted('ROLE_ADMIN');
        
        // recupération des catégories pour le header
        $categories = $entityManager->getRepository(Category::class)->findAll();

        // si la catégorie n'existe pas on en crée une nouvelle (edit si elle existe add si elle existe pas)
        if ($category == null) {
            $category = new Category();
        }

        // création du formulaire
        $form = $this->createForm(CategoryType::class, $category);

        // traitement des données du formulaire
        $form->handleRequest($request);

        // on verifie si le formulaire est soumis et valide
        if ($form->isSubmitted() && $form->isValid()) {

            // ajout des données du formulaire a l'entité Category
            $category = $form->getData();

            // on previent doctrine de l'ajout de la catégorie
            $entityManager->persist($category);

            // on execute
            $entityManager->flush();

            // redirection vers la page des catégories
            return $this->redirectToRoute('app_category');
        }

        return $this->render('category/addedit.html.twig', [
            'form' => $form,
            'categories' => $categories
        ]);
    }

    // ajout et modification des sous-categories par rapport aux categories 
    #[Route('/category/{category}/add-subcategory', name: 'add_subcategory')]
    #[Route('/category/{category}/edit-subcategory/{subCategory}', name: 'edit_subcategory')]
    public function addSubCategoryToCategory(Category $category, Subcategory $subCategory = null,EntityManagerInterface $entityManager, Request $request): Response
    {
        // recuperation des categories pour le header
        $categories = $entityManager->getRepository(Category::class)->findAll();

        // si la sous categorie n'existe pas on en créer une nouvelle
        if ($subCategory == null) {
            $subCategory = new Subcategory();
        }

        // creation du formulaire
        $form = $this->createForm(SubcategoryType::class, $subCategory);

        // traitement des données du formulaire
        $form->handleRequest($request);

        // on verifie si le formulaire est soumis et valide
        if ($form->isSubmitted() && $form->isValid()) {

            // ajout des données du formulaire a l'entité subcategory
            $subCategory = $form->getData();

            // ajout de la sous categorie a la categorie
            $category->addSubcategory($subCategory);

            // on previent doctrine de l'ajout/modification de la catégorie et sous categorie
            $entityManager->persist($category);
            $entityManager->persist($subCategory);

            // on execute
            $entityManager->flush();

            // redirection vers la page de la categorie
            return $this->redirectToRoute('show_category', ['id' => $category->getId()]);
        }

        return $this->render('category/addeditsub.html.twig', [
            'form' => $form,
            'categories' => $categories
        ]);
    }

    //methoded de la suppression d'une sous categorie
    #[Route('/delete-subcategory/{id}', name: 'delete_subcategory')]
    public function deleteSubCategory(Subcategory $subcategory, EntityManagerInterface $entityManager): Response
    {
        // recuperation de l'id de la categorie pour la redirection
        $id = $subcategory->getCategory()->getId();

        // suppression de la sous categorie
        $entityManager->remove($subcategory);

        // on execute
        $entityManager->flush();

        // redirection vers la page de la categorie
        return $this->redirectToRoute('show_category', ['id' => $id]);
    }

    // methode du details d'une categorie
    #[Route('/category/{id}', name: 'show_category')]
    public function show(Category $category, EntityManagerInterface $entityManager): Response
    {
        // recupération des catégorie pour le header et l'affichage des catégories
        $categories = $entityManager->getRepository(Category::class)->findAll();


        return $this->render('category/show.html.twig', [
            'category' => $category,
            'categories' => $categories
        ]);
    }


    // methode de suppression d'une categorie
    #[Route('/category/delete/{id}', name: 'delete_category')]
    public function delete(Category $category, EntityManagerInterface $entityManager): Response
    {
        // suppression de la categorie
        $entityManager->remove($category);

        // execution
        $entityManager->flush();

        return $this->redirectToRoute('app_category');
    }
}
