<?php

namespace App\Controller;

use App\Entity\Annonce;
use App\Entity\Message;
use App\Entity\Category;
use App\Form\MessageType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

final class MessageController extends AbstractController
{

    // #[Route('/messages/{id}', name: 'app_message')]
    // public function index(Annonce $annonce, Request $request, EntityManagerInterface $entityManager): Response
    // {
    //     $categories = $entityManager->getRepository(Category::class)->findAll();
    //     $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');
        
    //     $message = new Message();
    //     $message->setUserSender($this->getUser());
    //     $message->setUserReciver($annonce->getUser());
    //     $message->setSendDate(new \DateTime());
    //     $message->setAnnonce($annonce);

    //     $form = $this->createForm(MessageType::class, $message);
    //     $form->handleRequest($request);

    //     if ($form->isSubmitted() && $form->isValid()) {
    //         $entityManager->persist($message);
    //         $entityManager->flush();

    //         return $this->redirectToRoute('app_message', ['id' => $annonce->getId()]);
    //     }

    //     $messages = $entityManager->getRepository(Message::class)->findBy(['Annonce' => $annonce],['sendDate' => 'ASC']);

    //     return $this->render('message/index.html.twig', [
    //         'categories' => $categories,
    //         'annonce' => $annonce,
    //         'messages' => $messages,
    //         'form' => $form
    //     ]);
    // }
}
