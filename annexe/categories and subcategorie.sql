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

-- Listage des données de la table projettest_amine.category : ~9 rows (environ)
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

-- Listage des données de la table projettest_amine.subcategory : ~33 rows (environ)
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

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
