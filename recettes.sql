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


-- Listage de la structure de la base pour recettes
CREATE DATABASE IF NOT EXISTS `recettes` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `recettes`;

-- Listage de la structure de table recettes. categorie
CREATE TABLE IF NOT EXISTS `categorie` (
  `id_categorie` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_categorie`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table recettes.categorie : ~3 rows (environ)
INSERT INTO `categorie` (`id_categorie`, `nom`) VALUES
	(1, 'entrée'),
	(2, 'plat'),
	(3, 'dessert');

-- Listage de la structure de table recettes. contenir
CREATE TABLE IF NOT EXISTS `contenir` (
  `id_recette` int NOT NULL,
  `id_ingredient` int NOT NULL,
  `quantite` int NOT NULL DEFAULT '0',
  KEY `id_recette` (`id_recette`),
  KEY `id_ingredient` (`id_ingredient`),
  CONSTRAINT `FK_contenir_ingredient` FOREIGN KEY (`id_ingredient`) REFERENCES `ingredient` (`id_ingredient`),
  CONSTRAINT `FK_contenir_recette` FOREIGN KEY (`id_recette`) REFERENCES `recette` (`id_recette`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table recettes.contenir : ~16 rows (environ)
INSERT INTO `contenir` (`id_recette`, `id_ingredient`, `quantite`) VALUES
	(1, 3, 200),
	(1, 13, 1),
	(1, 12, 1),
	(1, 5, 2),
	(10, 6, 1),
	(10, 7, 90),
	(10, 11, 1),
	(10, 13, 1),
	(11, 11, 1),
	(11, 17, 2),
	(11, 16, 3),
	(11, 13, 1),
	(7, 10, 5),
	(7, 14, 200),
	(7, 15, 50),
	(7, 11, 1);

-- Listage de la structure de table recettes. ingredient
CREATE TABLE IF NOT EXISTS `ingredient` (
  `id_ingredient` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL DEFAULT '',
  `uniteDeMesure` varchar(50) NOT NULL DEFAULT '',
  `prix` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_ingredient`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table recettes.ingredient : ~17 rows (environ)
INSERT INTO `ingredient` (`id_ingredient`, `nom`, `uniteDeMesure`, `prix`) VALUES
	(1, 'tomates', 'kg', 1.5),
	(2, 'ognion', 'kg', 2),
	(3, 'fromage', 'g', 1),
	(4, 'riz', 'g', 1.2),
	(5, 'patates douces ', 'g', 4),
	(6, 'salade', 'piece', 0.99),
	(7, 'caviar', 'g', 100),
	(8, 'saumon', 'pavet', 5),
	(9, 'veau', 'kg', 9),
	(10, 'mangue ', 'piece ', 3),
	(11, 'citron', 'kg', 3),
	(12, 'ail', 'kg', 5.5),
	(13, 'huile d\'olive', 'bouteille', 10),
	(14, 'creme fouettée', 'ml', 2),
	(15, 'sucre', 'g', 1.9),
	(16, 'avocat mur ', 'piece', 2.99),
	(17, 'crevettes', 'kg ', 15);

-- Listage de la structure de table recettes. recette
CREATE TABLE IF NOT EXISTS `recette` (
  `id_recette` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL DEFAULT '0',
  `duree` int NOT NULL DEFAULT '0',
  `instructions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_categorie` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_recette`),
  KEY `id_categorie` (`id_categorie`),
  CONSTRAINT `FK_recette_categorie` FOREIGN KEY (`id_categorie`) REFERENCES `categorie` (`id_categorie`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table recettes.recette : ~6 rows (environ)
INSERT INTO `recette` (`id_recette`, `nom`, `duree`, `instructions`, `id_categorie`) VALUES
	(1, 'gratin', 75, '-Préchauffez votre four à 180°C (350°F).\r\n\r\n-Épluchez les patates douces et coupez-les en fines tranches d\'environ 3-4 mm d\'épaisseur.\r\n\r\n-Beurrez légèrement un plat à gratin.\r\n\r\n-Disposez une première couche de tranches de patates douces dans le plat.\r\n\r\n-Saupoudrez d\'ail émincé sur les patates douces, puis ajoutez une partie du fromage râpé.\r\n\r\n-Répétez les couches jusqu\'à épuisement des ingrédients, en terminant par une couche de fromage sur le dessus.\r\n\r\n-Dans un bol, mélangez la crème fraîche avec du sel et du poivre selon votre goût, puis versez ce mélange uniformément sur le gratin.\r\n\r\n-Couvrez le plat d\'aluminium et enfournez-le pendant environ 40 à 50 minutes, ou jusqu\'à ce que les patates douces soient tendres lorsque vous les piquez avec un couteau.\r\n\r\n-Enlevez l\'aluminium et laissez gratiner le dessus pendant quelques minutes supplémentaires, jusqu\'à ce qu\'il soit doré et croustillant.\r\n\r\n-Une fois cuit, sortez le gratin du four et laissez-le reposer quelques minutes avant de servir.', 2),
	(4, 'Saumon grillé avec riz aux légumes', 45, 'Préparez le saumon en le grillant avec un peu d\'huile d\'olive, du sel et du poivre.\r\n\r\nPendant que le saumon cuit, préparez un riz aux légumes en faisant revenir des oignons hachés dans une poêle avec un peu d\'huile d\'olive. Ajoutez ensuite des tomates coupées en dés et laissez mijoter jusqu\'à ce qu\'elles ramollissent. Incorporez ensuite le riz cuit et mélangez bien.\r\n\r\nServez le saumon grillé avec une portion de riz aux légumes.', 2),
	(7, 'Mousse légère à la mangue', 15, 'Épluchez la mangue, retirez le noyau et coupez-la en dés.\r\n\r\nMixez les dés de mangue jusqu\'à obtenir une purée lisse et homogène. Si vous le souhaitez, vous pouvez ajouter un peu de jus de citron vert pour rehausser la saveur de la mangue.\r\n\r\nDans un bol, montez la crème fouettée avec le sucre jusqu\'à ce qu\'elle forme des pics fermes.\r\n\r\nIncorporez délicatement la purée de mangue à la crème fouettée en effectuant des mouvements de pliage avec une spatule, afin de conserver la légèreté de la mousse.\r\n\r\nRépartissez la mousse dans des coupes ou des verrines individuelles.\r\n\r\nPlacez les coupes au réfrigérateur pendant au moins 1 à 2 heures pour que la mousse prenne et soit bien fraîche.\r\n\r\nAvant de servir, vous pouvez décorer chaque portion de quelques morceaux de mangue frais ou de zestes de citron vert pour une touche de fraîcheur supplémentaire.', 3),
	(8, 'Mousse légère aux fraises', 15, 'Lavez les fraises, équeutez-les et coupez-les en morceaux.\r\n\r\nMixez les fraises jusqu\'à obtenir une purée lisse et homogène.\r\n\r\nDans un bol, montez la crème fouettée avec le sucre jusqu\'à ce qu\'elle forme des pics fermes.\r\n\r\nIncorporez délicatement la purée de fraises à la crème fouettée en effectuant des mouvements de pliage avec une spatule, afin de conserver la légèreté de la mousse.\r\n\r\nRépartissez la mousse dans des coupes ou des verrines individuelles.\r\n\r\nPlacez les coupes au réfrigérateur pendant au moins 1 à 2 heures pour que la mousse prenne et soit bien fraîche.\r\n\r\nAvant de servir, vous pouvez décorer chaque portion avec quelques fraises fraîches coupées en morceaux ou quelques zestes de citron vert pour une touche de fraîcheur supplémentaire.', 3),
	(10, 'Salade de caviar et avocat sur lit de roquette', 20, 'Lavez et essorez la roquette, puis disposez-la sur des assiettes de service pour former un lit de verdure.\r\n\r\nÉpluchez et dénoyautez l\'avocat, puis coupez-le en tranches ou en dés selon votre préférence. Arrosez les morceaux d\'avocat avec un peu de jus de citron pour éviter qu\'ils ne brunissent.\r\n\r\nDisposez les tranches d\'avocat sur la roquette, en les répartissant uniformément.\r\n\r\nAjoutez une généreuse portion de salade de caviar sur les tranches d\'avocat. Veillez à répartir le caviar de manière équilibrée sur chaque assiette.\r\n\r\nAssaisonnez la salade avec un filet d\'huile d\'olive, un peu de jus de citron frais, du sel et du poivre selon votre goût.\r\n\r\nVous pouvez également ajouter quelques herbes fraîches comme de l\'aneth ou du persil pour agrémenter la présentation et ajouter de la saveur.', 1),
	(11, 'Salade de crevettes, avocat et agrumes', 30, 'Préparez vos agrumes en les pelant à vif et en les coupant en tranches ou en segments.\r\n\r\nCoupez l\'avocat en tranches ou en dés.\r\n\r\nDisposez la roquette ou la laitue dans un grand saladier ou sur des assiettes individuelles.\r\n\r\nAjoutez les crevettes cuites et décortiquées sur le lit de verdure.\r\n\r\nDisposez les tranches d\'avocat et les segments d\'agrumes sur les crevettes.\r\n\r\nPour la vinaigrette, mélangez de l\'huile d\'olive, du vinaigre balsamique, de la moutarde, du sel et du poivre dans un petit bol. Versez cette vinaigrette sur la salade juste avant de servir.\r\n\r\nSi vous le souhaitez, ajoutez des noix ou des amandes grillées pour ajouter une touche de croquant à la salade.', 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
