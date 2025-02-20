<?php

namespace App\Controller;

use App\Entity\Annonce;
use App\Entity\Message;
use App\Form\MessageType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

final class MessageController extends AbstractController
{
    #[Route('/message', name: 'app_message')]
    public function index(): Response
    {
        return $this->render('message/index.html.twig', [
        ]);
    }

    #[Route('/messages/{id}', name: 'app_messages')]
    public function send(Annonce $annonce, Request $request, EntityManagerInterface $entityManager): Response
    {
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');
        
        $message = new Message();
        $message->setUserSender($this->getUser());
        $message->setAnnonce($annonce);

        $form = $this->createForm(MessageType::class, $message);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($message);
            $entityManager->flush();

            return $this->redirectToRoute('app_messages', ['id' => $annonce->getId()]);
        }

        $messages = $entityManager->getRepository(Message::class)->findBy(
            ['annonce' => $annonce],
            ['createdAt' => 'ASC']
        );

        return $this->render('messages/index.html.twig', [
            'annonce' => $annonce,
            'messages' => $messages,
            'form' => $form
        ]);
    }
}
