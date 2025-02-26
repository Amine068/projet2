<?php

namespace App\Controller;

use App\Entity\User;
use App\Entity\Category;
use App\Form\AdminUserType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

final class AdminController extends AbstractController
{
    #[Route('/admin', name: 'app_admin')]
    public function index(EntityManagerInterface $entityManager): Response
    {

        $categories = $entityManager->getRepository(Category::class)->findAll();

        return $this->render('admin/index.html.twig', [
            "categories" => $categories,
        ]);
    }

    #[Route('/admin/user', name: 'app_admin_user')]
    public function user(EntityManagerInterface $entityManager): Response
    {
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        $categories = $entityManager->getRepository(Category::class)->findAll();
        $users = $entityManager->getRepository(User::class)->findAll();

        return $this->render('admin/user.html.twig', [
            "categories" => $categories,
            "users" => $users,
        ]);
    }

    #[Route('/admin/user/{id}', name: 'app_admin_user_edit')]
    public function edituser(User $user, Request $request, EntityManagerInterface $entityManager): Response
    {
        $this->denyAccessUnlessGranted('ROLE_ADMIN');

        $categories = $entityManager->getRepository(Category::class)->findAll();
        $user = $entityManager->getRepository(User::class)->findOneby(['id' => $user->getId()]);
        $form = $this->createForm(AdminUserType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($user);
            $entityManager->flush();
            return $this->redirectToRoute('app_admin_user');
        }

        return $this->render('admin/edituser.html.twig', [
            "categories" => $categories,
            "form" => $form,
        ]);
    }
}
