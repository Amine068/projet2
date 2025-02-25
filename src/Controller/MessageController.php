<?php

namespace App\Controller;

use App\Entity\Annonce;
use App\Entity\Message;
use App\Entity\Category;
use App\Form\MessageType;
use App\Entity\Conversation;
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

    #[Route('/messages/{id}', name: 'app_message')]
    public function create_conversation(Annonce $annonce, EntityManagerInterface $entityManager): Response
    {
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');

        $conversation = $entityManager->getRepository(Conversation::class)->findOneBy(['Annonce' => $annonce, 'user' => $this->getUser()]);

        if (!$conversation) {
            $conversation = new Conversation();
            $conversation->setAnnonce($annonce);
            $conversation->setUser($this->getUser());
            // $conversation->addParticipant($annonce->getUser());
            $entityManager->persist($conversation);
            $entityManager->flush();
        }

        return $this->redirectToRoute('app_conversation', ['id' => $conversation->getId()]);
    }

    #[Route('/conversation/{id}', name: 'app_conversation')]
    public function conversation(Conversation $conversation, Request $request, EntityManagerInterface $entityManager): Response
    {
        $categories = $entityManager->getRepository(Category::class)->findAll();
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');

        $message = new Message();
        $message->setWriter($this->getUser());
        $message->setSendDate(new \DateTime());
        $message->setConversation($conversation);

        $form = $this->createForm(MessageType::class, $message);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($message);
            $entityManager->flush();

            return $this->redirectToRoute('app_conversation', ['id' => $conversation->getId()]);
        }

        $messages = $entityManager->getRepository(Message::class)->findBy(['conversation' => $conversation], ['sendDate' => 'ASC']);

        return $this->render('message/conversation.html.twig', [
            'categories' => $categories,
            'conversation' => $conversation,
            'messages' => $messages,
            'form' => $form
        ]);
    }
}
