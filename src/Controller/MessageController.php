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

    // methode de creation de conversaiton a partir d'une annonce
    #[Route('/messages/{id}', name: 'app_message')]
    public function create_conversation(Annonce $annonce, EntityManagerInterface $entityManager): Response
    {
        // verification que l'utilisateur est connecté
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');

        // recuperation d'une potentiel conversation existante
        $conversation = $entityManager->getRepository(Conversation::class)->findOneBy(['Annonce' => $annonce, 'user' => $this->getUser()]);

        // verification de si cette même conversation existe (si elle n'existe pas on la crée)
        if (!$conversation) {
            $conversation = new Conversation();

            // on ajoute l'annonce a la conversation
            $conversation->setAnnonce($annonce);

            // on ajoute l'utilisateur a la conversation
            $conversation->setUser($this->getUser());

            // on previent doctrine de l'ajout de la conversation
            $entityManager->persist($conversation);

            // on execute
            $entityManager->flush();
        }

        // redirection vers la page de la conversation
        return $this->redirectToRoute('app_conversation', ['id' => $conversation->getId()]);
    }

    // methode de l'affichage de la conversation et de l'ajout de message
    #[Route('/conversation/{id}', name: 'app_conversation')]
    public function conversation(Conversation $conversation, Request $request, EntityManagerInterface $entityManager): Response
    {
        // verification que l'utilisateur est connecté
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');

        // recuperation des catégories pour l'affichage dans le header
        $categories = $entityManager->getRepository(Category::class)->findAll();

        // création d'une nouvelle entité Message
        $message = new Message();

        // création du formulaire
        $form = $this->createForm(MessageType::class, $message);
        
        // traitement des données du formulaire
        $form->handleRequest($request);
    
        // on verifie si le formulaire est soumis et valide
        if ($form->isSubmitted() && $form->isValid()) {
            
            //on ajoute l'auteur du message (l'utilisateur connecté) a l'entité Message
            $message->setWriter($this->getUser());

            //on ajoute la date d'envoi du message
            $message->setSendDate(new \DateTime());

            //on ajoute le message a la conversation
            $message->setConversation($conversation);

            // on previent doctrine de l'ajout du message
            $entityManager->persist($message);

            // on execute
            $entityManager->flush();
    
            // Retourner une réponse JSON pour l'AJAX
            return $this->json([
                'success' => true,
                'message' => [
                    'text' => $message->getText(),
                    'writer' => $message->getWriter()->getUsername(),
                    'sendDate' => $message->getSendDate()->format('H:i d/m/Y')
                ]
            ]);
        }
    
        // recuperation des messages de la conversation pour l'affichage
        $messages = $entityManager->getRepository(Message::class)->findBy(['conversation' => $conversation], ['sendDate' => 'ASC']);
    
        return $this->render('message/conversation.html.twig', [
            'categories' => $categories,
            'conversation' => $conversation,
            'messages' => $messages,
            'form' => $form
        ]);
    }    
}
