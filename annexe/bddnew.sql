-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour projet
CREATE DATABASE IF NOT EXISTS `projet` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `projet`;

-- Listage de la structure de table projet. annonce
CREATE TABLE IF NOT EXISTS `annonce` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subcategory_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  `category_id` int DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_post` datetime NOT NULL,
  `price` double NOT NULL,
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `zipcode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_validated` tinyint(1) NOT NULL DEFAULT '0',
  `is_visible` tinyint(1) NOT NULL,
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `is_archived` tinyint(1) NOT NULL,
  `telephone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F65593E55DC6FE57` (`subcategory_id`),
  KEY `IDX_F65593E5A76ED395` (`user_id`),
  KEY `IDX_F65593E512469DE2` (`category_id`),
  CONSTRAINT `FK_F65593E512469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_F65593E55DC6FE57` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategory` (`id`),
  CONSTRAINT `FK_F65593E5A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table projet.annonce : ~33 rows (environ)
INSERT INTO `annonce` (`id`, `subcategory_id`, `user_id`, `category_id`, `title`, `description`, `date_of_post`, `price`, `state`, `city`, `zipcode`, `is_validated`, `is_visible`, `is_locked`, `is_archived`, `telephone`) VALUES
	(1, 2, 7, 1, 'Testt', 'aaaa', '2025-02-24 13:50:04', 216, 'Neuf', 'Mulhouse', '68100', 1, 1, 0, 0, '0101010101'),
	(2, 2, 7, 1, 'aaa', 'aaaa', '2025-03-03 12:47:48', 21, 'Bon état', 'Mulhouse', '68100', 1, 1, 0, 0, '0101010101'),
	(3, 9, 8, 4, 'aaa', 'aaa', '2025-03-03 13:44:11', 222, 'Neuf', 'Mulhouse', '68100', 1, 1, 0, 0, '0101010101'),
	(4, 6, 2, 3, 'Ordinateur portable gaming', 'PC portable pour les jeux vidéo', '2025-03-04 10:00:00', 899.99, 'Neuf', 'Paris', '75001', 1, 1, 0, 0, '0123456789'),
	(5, 7, 3, 3, 'Ordinateur de bureau', 'PC de bureau pour le travail', '2025-03-04 11:00:00', 699.99, 'Bon état', 'Lyon', '69001', 1, 1, 0, 0, '0987654321'),
	(6, 8, 4, 3, 'Station de travail', 'PC puissant pour les professionnels', '2025-03-04 12:00:00', 1299.99, 'Neuf', 'Marseille', '13001', 1, 1, 0, 0, '0123456789'),
	(7, 9, 5, 4, 'Sacoche pour ordinateur', 'Sacoche pour transporter votre PC', '2025-03-04 13:00:00', 29.99, 'Neuf', 'Toulouse', '31000', 1, 1, 0, 0, '0987654321'),
	(8, 10, 6, 4, 'Support ordinateur portable', 'Support pour PC portable', '2025-03-04 14:00:00', 19.99, 'Bon état', 'Nice', '06000', 1, 1, 0, 0, '0123456789'),
	(9, 11, 7, 4, 'Disque dur externe', 'Disque dur pour sauvegarder vos données', '2025-03-04 15:00:00', 79.99, 'Neuf', 'Nantes', '44000', 1, 1, 0, 0, '0987654321'),
	(10, 12, 8, 4, 'Adaptateur USB', 'Adaptateur pour connecter vos périphériques', '2025-03-04 16:00:00', 9.99, 'Bon état', 'Strasbourg', '67000', 1, 1, 0, 0, '0123456789'),
	(11, 13, 9, 4, 'Câble USB', 'Câble pour charger vos appareils', '2025-03-04 17:00:00', 4.99, 'Neuf', 'Montpellier', '34000', 1, 1, 0, 0, '0987654321'),
	(12, 14, 10, 5, 'Appareil photo reflex', 'Appareil photo pour les passionnés', '2025-03-04 18:00:00', 499.99, 'Bon état', 'Bordeaux', '33000', 1, 1, 0, 0, '0123456789'),
	(13, 15, 11, 5, 'Caméra d\'action', 'Caméra pour filmer vos aventures', '2025-03-04 19:00:00', 199.99, 'Neuf', 'Lille', '59000', 1, 1, 0, 0, '0987654321'),
	(14, 16, 12, 5, 'Objectif photo', 'Objectif pour votre appareil photo', '2025-03-04 20:00:00', 99.99, 'Bon état', 'Rennes', '35000', 1, 1, 0, 0, '0123456789'),
	(15, 17, 13, 5, 'Trépied', 'Trépied pour stabiliser votre appareil photo', '2025-03-04 21:00:00', 29.99, 'Neuf', 'Reims', '51100', 1, 1, 0, 0, '0987654321'),
	(16, 18, 14, 6, 'Smartphone', 'Téléphone portable dernier cri', '2025-03-04 22:00:00', 699.99, 'Neuf', 'Le Havre', '76600', 1, 1, 0, 0, '0123456789'),
	(17, 19, 2, 6, 'Coque de téléphone', 'Coque pour protéger votre smartphone', '2025-03-04 23:00:00', 14.99, 'Bon état', 'Saint-Étienne', '42000', 1, 1, 0, 0, '0987654321'),
	(18, 20, 3, 6, 'Chargeur sans fil', 'Chargeur pour recharger votre téléphone sans fil', '2025-03-05 00:00:00', 29.99, 'Neuf', 'Toulon', '83000', 1, 1, 0, 0, '0123456789'),
	(19, 21, 4, 6, 'Support de téléphone', 'Support pour poser votre téléphone', '2025-03-05 01:00:00', 9.99, 'Bon état', 'Grenoble', '38000', 1, 1, 0, 0, '0987654321'),
	(20, 22, 5, 7, 'Jeux vidéo', 'Jeux pour console', '2025-03-05 02:00:00', 49.99, 'Neuf', 'Dijon', '21000', 1, 1, 0, 0, '0123456789'),
	(21, 23, 6, 7, 'Casque VR', 'Casque de réalité virtuelle', '2025-03-05 03:00:00', 299.99, 'Bon état', 'Angers', '49000', 1, 1, 0, 0, '0987654321'),
	(22, 24, 7, 8, 'Console de jeux', 'Console pour jouer à vos jeux préférés', '2025-03-05 04:00:00', 399.99, 'Neuf', 'Villeurbanne', '69100', 1, 1, 0, 0, '0123456789'),
	(23, 26, 8, 8, 'Manette de jeu', 'Manette pour votre console', '2025-03-05 05:00:00', 49.99, 'Bon état', 'Nîmes', '30000', 1, 1, 0, 0, '0987654321'),
	(24, 27, 9, 8, 'Carte mémoire', 'Carte mémoire pour stocker vos jeux', '2025-03-05 06:00:00', 19.99, 'Neuf', 'Aix-en-Provence', '13090', 1, 1, 0, 0, '0123456789'),
	(25, 28, 10, 8, 'Volant de course', 'Volant pour vos jeux de course', '2025-03-05 07:00:00', 149.99, 'Bon état', 'Brest', '29200', 1, 1, 0, 0, '0987654321'),
	(26, 29, 11, 9, 'Réfrigérateur', 'Réfrigérateur pour votre cuisine', '2025-03-05 08:00:00', 499.99, 'Neuf', 'Le Mans', '72000', 1, 1, 0, 0, '0123456789'),
	(27, 30, 12, 9, 'Lave-linge', 'Machine à laver pour votre linge', '2025-03-05 09:00:00', 399.99, 'Bon état', 'Clermont-Ferrand', '63000', 1, 1, 0, 0, '0987654321'),
	(28, 31, 13, 9, 'Aspirateur', 'Aspirateur pour nettoyer votre maison', '2025-03-05 10:00:00', 149.99, 'Neuf', 'Tours', '37000', 1, 1, 0, 0, '0123456789'),
	(29, 32, 14, 9, 'Four', 'Four pour cuisiner vos plats', '2025-03-05 11:00:00', 299.99, 'Bon état', 'Amiens', '80000', 1, 1, 0, 0, '0987654321'),
	(30, 33, 2, 10, 'Montre connectée', 'Montre pour suivre votre activité', '2025-03-05 12:00:00', 99.99, 'Neuf', 'Limoges', '87000', 1, 1, 0, 0, '0123456789'),
	(31, 34, 3, 10, 'Objet connecté', 'Objet connecté pour votre maison', '2025-03-05 13:00:00', 49.99, 'Bon état', 'Annecy', '74000', 1, 1, 0, 0, '0987654321'),
	(32, 35, 4, 10, 'Accessoire pour smartphone', 'Accessoire pour votre téléphone', '2025-03-05 14:00:00', 19.99, 'Neuf', 'Boulogne-Billancourt', '92100', 1, 1, 0, 0, '0123456789'),
	(33, 2, 5, 1, 'Retroprojecteur', 'Retroprojecteur pour vos présentations', '2025-03-05 15:00:00', 299.99, 'Bon état', 'Metz', '57000', 1, 1, 0, 0, '0987654321');

-- Listage de la structure de table projet. category
CREATE TABLE IF NOT EXISTS `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table projet.category : ~9 rows (environ)
INSERT INTO `category` (`id`, `name`) VALUES
	(1, 'Vidéo & Son'),
	(3, 'Ordinateur'),
	(4, 'Accessoire informatique'),
	(5, 'Photo & Caméscope'),
	(6, 'Téléphone'),
	(7, 'Jeu Vidéo'),
	(8, 'Console'),
	(9, 'Electroménager'),
	(10, 'Autre accessoire');

-- Listage de la structure de table projet. conversation
CREATE TABLE IF NOT EXISTS `conversation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `annonce_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8A8E26E98805AB2F` (`annonce_id`),
  KEY `IDX_8A8E26E9A76ED395` (`user_id`),
  CONSTRAINT `FK_8A8E26E98805AB2F` FOREIGN KEY (`annonce_id`) REFERENCES `annonce` (`id`),
  CONSTRAINT `FK_8A8E26E9A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table projet.conversation : ~0 rows (environ)

-- Listage de la structure de table projet. doctrine_migration_versions
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Listage des données de la table projet.doctrine_migration_versions : ~5 rows (environ)
INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
	('DoctrineMigrations\\Version20250224134724', '2025-02-24 13:47:28', 73),
	('DoctrineMigrations\\Version20250303063048', '2025-03-03 06:31:00', 125),
	('DoctrineMigrations\\Version20250303073357', '2025-03-03 07:34:04', 52),
	('DoctrineMigrations\\Version20250303101256', '2025-03-03 10:13:00', 84),
	('DoctrineMigrations\\Version20250303130808', '2025-03-03 13:08:12', 76);

-- Listage de la structure de table projet. image
CREATE TABLE IF NOT EXISTS `image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `annonce_id` int NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C53D045F8805AB2F` (`annonce_id`),
  CONSTRAINT `FK_C53D045F8805AB2F` FOREIGN KEY (`annonce_id`) REFERENCES `annonce` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table projet.image : ~3 rows (environ)
INSERT INTO `image` (`id`, `annonce_id`, `path`) VALUES
	(1, 1, '67c5b22b6c2bc.png'),
	(2, 2, '67c5a4f4be311.png'),
	(3, 3, '67c5b22b6c2bc.png');

-- Listage de la structure de table projet. message
CREATE TABLE IF NOT EXISTS `message` (
  `id` int NOT NULL AUTO_INCREMENT,
  `conversation_id` int NOT NULL,
  `writer_id` int NOT NULL,
  `text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `send_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B6BD307F9AC0396` (`conversation_id`),
  KEY `IDX_B6BD307F1BC7E6B6` (`writer_id`),
  CONSTRAINT `FK_B6BD307F1BC7E6B6` FOREIGN KEY (`writer_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_B6BD307F9AC0396` FOREIGN KEY (`conversation_id`) REFERENCES `conversation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table projet.message : ~0 rows (environ)

-- Listage de la structure de table projet. messenger_messages
CREATE TABLE IF NOT EXISTS `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table projet.messenger_messages : ~0 rows (environ)

-- Listage de la structure de table projet. report
CREATE TABLE IF NOT EXISTS `report` (
  `id` int NOT NULL AUTO_INCREMENT,
  `annonce_id` int NOT NULL,
  `user_id` int NOT NULL,
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_handled` tinyint(1) NOT NULL,
  `reported_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C42F77848805AB2F` (`annonce_id`),
  KEY `IDX_C42F7784A76ED395` (`user_id`),
  CONSTRAINT `FK_C42F77848805AB2F` FOREIGN KEY (`annonce_id`) REFERENCES `annonce` (`id`),
  CONSTRAINT `FK_C42F7784A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table projet.report : ~2 rows (environ)
INSERT INTO `report` (`id`, `annonce_id`, `user_id`, `reason`, `is_handled`, `reported_at`) VALUES
	(7, 3, 7, 'annonce non conforme', 1, '2025-03-03 13:56:46'),
	(8, 2, 7, 'annonce', 0, '2025-03-03 14:04:55');

-- Listage de la structure de table projet. subcategory
CREATE TABLE IF NOT EXISTS `subcategory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DDCA44812469DE2` (`category_id`),
  CONSTRAINT `FK_DDCA44812469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table projet.subcategory : ~33 rows (environ)
INSERT INTO `subcategory` (`id`, `category_id`, `name`) VALUES
	(2, 1, 'Retroprojecteur'),
	(3, 1, 'table de mixage'),
	(4, 1, 'Téléviseurs'),
	(5, 1, 'Barres de son'),
	(6, 3, 'Ordinateur portables'),
	(7, 3, 'Ordinateurs de bureau'),
	(8, 3, 'Station de travail'),
	(9, 4, 'Sacoches et sacs'),
	(10, 4, 'Support ordinateur portable'),
	(11, 4, 'Disques durs externes'),
	(12, 4, 'Adaptateur et hubs USB'),
	(13, 4, 'Câbles et chargeurs'),
	(14, 5, 'Appareil photo'),
	(15, 5, 'Caméra d\'action'),
	(16, 5, 'Objectifs photo'),
	(17, 5, 'Trépieds et stabilisateurs'),
	(18, 6, 'Smartphones'),
	(19, 6, 'Coques et étuis'),
	(20, 6, 'Chargeurs sans fil'),
	(21, 6, 'Supports de téléphone'),
	(22, 7, 'Jeux vidéo'),
	(23, 7, 'Réalité virtuelle'),
	(24, 8, 'Console de jeux'),
	(26, 8, 'Accessoires de console'),
	(27, 8, 'Carte mémoire et disque dur'),
	(28, 8, 'Volants et pédales'),
	(29, 9, 'Réfrigérateurs et congélateurs'),
	(30, 9, 'Lave-linge et sèche-linge'),
	(31, 9, 'Aspirateurs'),
	(32, 9, 'Cuisine'),
	(33, 10, 'Montre connectées'),
	(34, 10, 'Objets connectés'),
	(35, 10, 'Autres accessoires');

-- Listage de la structure de table projet. user
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `google_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_anonymize` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table projet.user : ~14 rows (environ)
INSERT INTO `user` (`id`, `email`, `roles`, `password`, `is_verified`, `google_id`, `username`, `avatar`, `is_anonymize`) VALUES
	(1, '2182aa8056694e570c8f8a7956b0d48ff9d971a12171801e394ec96c4e4d4361', '["ROLE_DELETE"]', 'ddb4108226edf511398f1b6658371c1273601ba987894a117f44bc9637d644eb', 0, NULL, '67c567e3b2c0e', NULL, 1),
	(2, 'tizane005@gmail.com', '["ROLE_USER", "ROLE_MODERATEUR"]', NULL, 0, '118425511114362492438', 'tizanee', NULL, 0),
	(3, '802e4c266eaf1e25909d33d0ef4e2308e80e5e054853b2c69814af270a06bd5b', '["ROLE_DELETE"]', '47acfee8345f100dfa9d8af8cb453478c1433a09840f653f6b4c10a5508f920a', 1, NULL, '67c5697ded8ac', NULL, 1),
	(4, 'ee638be5c985a8925fc7aaeebd9bd5f1225a6503e97ba2eea2d3fcfd5b2b336c', '["ROLE_DELETE"]', '03842c651a1422763c345fd3bc3911459e8b11f3d3391e379f9b9db86735b74d', 1, NULL, '67c5686a8d706', NULL, 1),
	(5, 'ba1adce6ff0ff44d58c06eaa78fcd36264d8fa1bb1a7c8ddbf2f3bb2be5f0f73', '["ROLE_DELETE"]', '2d420ff50acfa3cc343585597274020fe4e29885706e4e2ffcb1e263c757d53f', 1, NULL, '67c5687f37007', NULL, 1),
	(6, '9a8cfbb3fab698feb3d7ef07e0eac7f13359b0a89467fa98ec3efeb0c13a5229', '["ROLE_DELETE"]', '92f5a387c9ea18b3e11a425edb16d8efd41cbdd3ffeedcfd3737032809a5676e', 1, NULL, '67c568b2ea995', NULL, 1),
	(7, 'aminebouguettaya5@gmail.com', '["ROLE_ADMIN"]', NULL, 1, '111905829402869664208', 'Amine', NULL, 0),
	(8, 'aaa@aaa.fr', '["ROLE_USER"]', '$2y$13$xIJAAJitCqbWHRIu4j.90e7EamNLBT/m2Uy8HeDSS9opoRqjXwyNq', 1, NULL, 'aaaa', NULL, 0),
	(9, 'ccc@ccc.fr', '["ROLE_USER"]', '$2y$13$qFIkLlZqe6MDsMRFXBb5SOF.bkWleGKJat/v3lftXBSHnpmR3Y5t2', 0, NULL, 'ccc', NULL, 0),
	(10, 'user1@example.com', '["ROLE_USER"]', 'password1', 1, NULL, 'john_doe', NULL, 0),
	(11, 'user2@example.com', '["ROLE_USER"]', 'password2', 1, NULL, 'jane_doe', NULL, 0),
	(12, 'user3@example.com', '["ROLE_MODERATEUR"]', 'password3', 1, NULL, 'mod_user', NULL, 0),
	(13, 'user4@example.com', '["ROLE_USER"]', 'password4', 1, NULL, 'random_user', NULL, 0),
	(14, 'user5@example.com', '["ROLE_ADMIN"]', 'password5', 1, NULL, 'admin_user', NULL, 0);

-- Listage de la structure de table projet. user_favorite_annonce
CREATE TABLE IF NOT EXISTS `user_favorite_annonce` (
  `user_id` int NOT NULL,
  `annonce_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`annonce_id`),
  KEY `IDX_D6147F56A76ED395` (`user_id`),
  KEY `IDX_D6147F568805AB2F` (`annonce_id`),
  CONSTRAINT `FK_D6147F568805AB2F` FOREIGN KEY (`annonce_id`) REFERENCES `annonce` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_D6147F56A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table projet.user_favorite_annonce : ~0 rows (environ)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
