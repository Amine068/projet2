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
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_post` datetime NOT NULL,
  `price` double NOT NULL,
  `state` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zipcode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_validated` tinyint(1) NOT NULL DEFAULT '0',
  `is_visible` tinyint(1) NOT NULL,
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `telephone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F65593E55DC6FE57` (`subcategory_id`),
  KEY `IDX_F65593E5A76ED395` (`user_id`),
  KEY `IDX_F65593E512469DE2` (`category_id`),
  CONSTRAINT `FK_F65593E512469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_F65593E55DC6FE57` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategory` (`id`),
  CONSTRAINT `FK_F65593E5A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table projet.annonce : ~0 rows (environ)
INSERT INTO `annonce` (`id`, `subcategory_id`, `user_id`, `category_id`, `title`, `description`, `date_of_post`, `price`, `state`, `city`, `zipcode`, `is_validated`, `is_visible`, `is_locked`, `telephone`) VALUES
	(1, 2, 1, 1, 'Testt', 'aaaa', '2025-02-24 13:50:04', 216, 'Neuf', 'Mulhouse', '68100', 0, 0, 0, '0101010101');

-- Listage de la structure de table projet. category
CREATE TABLE IF NOT EXISTS `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table projet.conversation : ~0 rows (environ)
INSERT INTO `conversation` (`id`, `annonce_id`, `user_id`) VALUES
	(1, 1, 2);

-- Listage de la structure de table projet. doctrine_migration_versions
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- Listage des données de la table projet.doctrine_migration_versions : ~0 rows (environ)
INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
	('DoctrineMigrations\\Version20250224134724', '2025-02-24 13:47:28', 73),
	('DoctrineMigrations\\Version20250303063048', '2025-03-03 06:31:00', 125);

-- Listage de la structure de table projet. image
CREATE TABLE IF NOT EXISTS `image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `annonce_id` int NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C53D045F8805AB2F` (`annonce_id`),
  CONSTRAINT `FK_C53D045F8805AB2F` FOREIGN KEY (`annonce_id`) REFERENCES `annonce` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table projet.image : ~0 rows (environ)
INSERT INTO `image` (`id`, `annonce_id`, `path`) VALUES
	(1, 1, '67bc790cad314.jpg');

-- Listage de la structure de table projet. message
CREATE TABLE IF NOT EXISTS `message` (
  `id` int NOT NULL AUTO_INCREMENT,
  `conversation_id` int NOT NULL,
  `writer_id` int NOT NULL,
  `text` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `send_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B6BD307F9AC0396` (`conversation_id`),
  KEY `IDX_B6BD307F1BC7E6B6` (`writer_id`),
  CONSTRAINT `FK_B6BD307F1BC7E6B6` FOREIGN KEY (`writer_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_B6BD307F9AC0396` FOREIGN KEY (`conversation_id`) REFERENCES `conversation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table projet.message : ~11 rows (environ)
INSERT INTO `message` (`id`, `conversation_id`, `writer_id`, `text`, `send_date`) VALUES
	(1, 1, 2, 'test', '2025-02-24 13:58:06'),
	(2, 1, 2, 'aaa', '2025-02-24 13:58:46'),
	(4, 1, 2, 'aaa', '2025-02-24 14:57:07'),
	(5, 1, 2, 'aaaaaaa', '2025-02-24 14:57:20'),
	(6, 1, 1, 'aaa', '2025-02-24 14:57:57'),
	(7, 1, 2, 'qsqd', '2025-02-24 14:58:11'),
	(8, 1, 1, 'aaa', '2025-02-24 14:58:56'),
	(9, 1, 1, 'asdq', '2025-02-24 15:04:52'),
	(10, 1, 2, 'bonjour', '2025-02-24 15:05:02'),
	(11, 1, 1, 'bonjour test', '2025-02-24 15:05:35'),
	(12, 1, 2, 'ca va', '2025-02-24 15:06:10');

-- Listage de la structure de table projet. messenger_messages
CREATE TABLE IF NOT EXISTS `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_handled` tinyint(1) NOT NULL,
  `reported_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_C42F77848805AB2F` (`annonce_id`),
  KEY `IDX_C42F7784A76ED395` (`user_id`),
  CONSTRAINT `FK_C42F77848805AB2F` FOREIGN KEY (`annonce_id`) REFERENCES `annonce` (`id`),
  CONSTRAINT `FK_C42F7784A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table projet.report : ~0 rows (environ)

-- Listage de la structure de table projet. subcategory
CREATE TABLE IF NOT EXISTS `subcategory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `google_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_anonymize` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table projet.user : ~2 rows (environ)
INSERT INTO `user` (`id`, `email`, `roles`, `password`, `is_verified`, `google_id`, `username`, `avatar`, `is_anonymize`) VALUES
	(1, 'aminebouguettaya5@gmail.com', '["ROLE_ADMIN"]', NULL, 0, '111905829402869664208', 'Amine', NULL, 0),
	(2, 'tizane005@gmail.com', '["ROLE_USER", "ROLE_MODERATEUR", "ROLE_ADMIN"]', NULL, 0, '118425511114362492438', 'tizanee', NULL, 0);

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
