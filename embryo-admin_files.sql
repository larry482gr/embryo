-- phpMyAdmin SQL Dump
-- version 4.0.8
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 11, 2014 at 08:58 PM
-- Server version: 5.6.14
-- PHP Version: 5.4.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `embryo-admin_files`
--

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE IF NOT EXISTS `files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `filesize` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `file_state` tinyint(4) NOT NULL,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `file_state` (`file_state`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=59 ;

--
-- Dumping data for table `files`
--

INSERT INTO `files` (`id`, `label`, `filesize`, `category_id`, `file_state`, `created_at`) VALUES
(38, 'Ticketpro - Η πληρωμή έγινε δεκτή.pdf', 77102, 1, 1, 1402418232),
(39, '2.1_ ΠΡΟΣΩΠΑ ΑΝΑΦΟΡΑΣ.doc', 115200, 1, 1, 1402418283),
(40, '3. ΦΟΡΜΑ ΝΟΜΟΛΟΓΙΑΣ.doc', 35840, 1, 1, 1402418331),
(41, '1_ ΝΟΜΟΘΕΣΙΑ.doc', 510464, 1, 1, 1402418401),
(42, '2.1_ ΠΡΟΣΩΠΑ ΑΝΑΦΟΡΑΣ.doc', 115200, 1, 1, 1402419466),
(43, '2.2_ ΔΙΕΥΘΥΝΤΕΣ ΙΑΤΡΙΚΩΝ ΚΕΝΤΡΩΝ.doc', 84480, 1, 1, 1402420594),
(44, '2.2_ ΔΙΕΥΘΥΝΤΕΣ ΙΑΤΡΙΚΩΝ ΚΕΝΤΡΩΝ.doc', 84480, 1, 1, 1402420644),
(45, '2.2_ ΔΙΕΥΘΥΝΤΕΣ ΙΑΤΡΙΚΩΝ ΚΕΝΤΡΩΝ.doc', 84480, 1, 1, 1402420910),
(47, 'Χώρος Μελών.docx', 11079, 1, 1, 1402422735),
(48, '2_ ΠΡΟΣΩΠΑ ΑΝΑΦΟΡΑΣ.doc', 129536, 1, 1, 1402423073),
(49, '2.1_ ΠΡΟΣΩΠΑ ΑΝΑΦΟΡΑΣ.doc', 115200, 1, 1, 1402423126),
(50, '2_ ΠΡΟΣΩΠΑ ΑΝΑΦΟΡΑΣ.doc', 129536, 1, 1, 1402423168),
(51, '2.2_ ΔΙΕΥΘΥΝΤΕΣ ΙΑΤΡΙΚΩΝ ΚΕΝΤΡΩΝ.doc', 84480, 1, 1, 1402423212),
(52, '2_ ΠΡΟΣΩΠΑ ΑΝΑΦΟΡΑΣ.doc', 129536, 1, 1, 1402423270),
(53, '3. ΦΟΡΜΑ ΝΟΜΟΛΟΓΙΑΣ.doc', 35840, 1, 1, 1402423646),
(54, '2_ ΠΡΟΣΩΠΑ ΑΝΑΦΟΡΑΣ.doc', 129536, 1, 1, 1402423746),
(55, '2.2_ ΔΙΕΥΘΥΝΤΕΣ ΙΑΤΡΙΚΩΝ ΚΕΝΤΡΩΝ.doc', 84480, 1, 1, 1402423978),
(56, '3. ΦΟΡΜΑ ΝΟΜΟΛΟΓΙΑΣ.doc', 35840, 1, 1, 1402424207),
(57, '2_ ΠΡΟΣΩΠΑ ΑΝΑΦΟΡΑΣ.doc', 129536, 1, 1, 1402424406),
(58, '1_ ΝΟΜΟΘΕΣΙΑ.doc', 510464, 1, 1, 1402430764);

-- --------------------------------------------------------

--
-- Table structure for table `file_categories`
--

CREATE TABLE IF NOT EXISTS `file_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(127) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1023) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lang_id` int(11) NOT NULL,
  `category_state` tinyint(4) NOT NULL,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_state` (`category_state`),
  KEY `lang_id` (`lang_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=9 ;

--
-- Dumping data for table `file_categories`
--

INSERT INTO `file_categories` (`id`, `label`, `description`, `lang_id`, `category_state`, `created_at`) VALUES
(1, 'Αρχικά Ερωτηματολόγια', NULL, 2, 4, 1402158121),
(7, 'Τελικά Ερωτηματολόγια', NULL, 2, 5, 1402185230),
(8, 'babis', NULL, 2, 5, 1402430837);

-- --------------------------------------------------------

--
-- Table structure for table `file_category_history`
--

CREATE TABLE IF NOT EXISTS `file_category_history` (
  `category_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `from_state` tinyint(4) DEFAULT NULL,
  `to_state` tinyint(4) NOT NULL,
  `timedate` int(11) NOT NULL,
  PRIMARY KEY (`category_id`,`timedate`),
  KEY `from_state` (`from_state`),
  KEY `to_state` (`to_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `file_category_history`
--

INSERT INTO `file_category_history` (`category_id`, `user_id`, `from_state`, `to_state`, `timedate`) VALUES
(1, 1, NULL, 1, 1402185230),
(1, 1, 1, 5, 1402314037),
(1, 1, 5, 4, 1402314076),
(1, 1, 4, 5, 1402314101),
(1, 1, 5, 4, 1402314375),
(1, 1, 4, 5, 1402314467),
(1, 1, 5, 4, 1402314482),
(1, 1, 4, 5, 1402314493),
(1, 1, 5, 4, 1402314750),
(1, 1, 4, 5, 1402314781),
(1, 1, 5, 4, 1402314789),
(1, 1, 4, 5, 1402314838),
(1, 1, 5, 4, 1402314923),
(1, 1, 4, 5, 1402314991),
(1, 1, 5, 4, 1402315004),
(1, 1, 4, 5, 1402315072),
(1, 1, 5, 4, 1402315199),
(1, 1, 4, 5, 1402315245),
(1, 1, 5, 4, 1402315255),
(1, 1, 4, 5, 1402315395),
(1, 1, 5, 4, 1402315401),
(1, 1, 4, 5, 1402315495),
(1, 1, 5, 4, 1402315508),
(1, 1, 4, 5, 1402315547),
(1, 1, 5, 4, 1402315557),
(1, 1, 4, 5, 1402315624),
(1, 1, 5, 4, 1402315628),
(1, 1, 4, 5, 1402315639),
(1, 1, 5, 4, 1402315643),
(7, 1, NULL, 1, 1402185230),
(7, 1, 1, 5, 1402266601),
(7, 1, 5, 4, 1402266678),
(7, 1, 4, 5, 1402266872),
(7, 1, 5, 4, 1402266984),
(7, 1, 4, 5, 1402267365),
(7, 1, 5, 4, 1402273518),
(7, 1, 4, 5, 1402313596),
(7, 1, 5, 4, 1402313601),
(7, 1, 4, 5, 1402313608),
(7, 1, 5, 4, 1402313981),
(7, 1, 4, 5, 1402314033),
(7, 1, 5, 4, 1402314090),
(7, 1, 4, 5, 1402314098),
(7, 1, 5, 4, 1402314106),
(7, 1, 4, 5, 1402314119),
(7, 1, 5, 4, 1402314363),
(7, 1, 4, 5, 1402314369),
(7, 1, 5, 4, 1402314395),
(7, 1, 4, 5, 1402314472),
(7, 1, 5, 4, 1402315089),
(7, 1, 4, 5, 1402315095),
(7, 1, 5, 4, 1402315628),
(7, 1, 4, 5, 1402315637),
(7, 1, 5, 4, 1402324659),
(7, 1, 4, 5, 1402326125),
(7, 1, 5, 4, 1402326446),
(7, 1, 4, 5, 1402326791),
(7, 1, 5, 4, 1402327454),
(7, 1, 4, 5, 1402327460),
(7, 1, 5, 4, 1402327871),
(7, 1, 4, 5, 1402327883),
(7, 1, 5, 4, 1402328166),
(7, 1, 4, 5, 1402328312),
(7, 1, 5, 4, 1402328318),
(7, 1, 4, 5, 1402328451),
(7, 1, 5, 4, 1402328457),
(7, 1, 4, 5, 1402334419),
(8, 1, NULL, 1, 1402430837),
(8, 1, 1, 5, 1402431902);

-- --------------------------------------------------------

--
-- Table structure for table `file_history`
--

CREATE TABLE IF NOT EXISTS `file_history` (
  `file_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `from_state` tinyint(4) DEFAULT NULL,
  `to_state` tinyint(4) NOT NULL,
  `timedate` int(11) NOT NULL,
  PRIMARY KEY (`file_id`,`timedate`),
  KEY `from_state` (`from_state`),
  KEY `to_state` (`to_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `file_history`
--

INSERT INTO `file_history` (`file_id`, `user_id`, `from_state`, `to_state`, `timedate`) VALUES
(38, 1, NULL, 1, 1402418232),
(39, 1, NULL, 1, 1402418283),
(40, 1, NULL, 1, 1402418331),
(41, 1, NULL, 1, 1402418401),
(42, 1, NULL, 1, 1402419466),
(43, 1, NULL, 1, 1402420594),
(44, 1, NULL, 1, 1402420644),
(45, 1, NULL, 1, 1402420910),
(47, 1, NULL, 1, 1402422735),
(48, 1, NULL, 1, 1402423073),
(49, 1, NULL, 1, 1402423126),
(50, 1, NULL, 1, 1402423168),
(51, 1, NULL, 1, 1402423212),
(52, 1, NULL, 1, 1402423270),
(53, 1, NULL, 1, 1402423646),
(54, 1, NULL, 1, 1402423746),
(55, 1, NULL, 1, 1402423978),
(56, 1, NULL, 1, 1402424207),
(57, 1, NULL, 1, 1402424406),
(58, 1, NULL, 1, 1402430764);

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE IF NOT EXISTS `states` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `label` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `states`
--

INSERT INTO `states` (`id`, `label`) VALUES
(1, 'created'),
(2, 'updated'),
(3, 'renamed'),
(4, 'put back'),
(5, 'deleted'),
(6, 'purged');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `FILE_CATEGORY_ID_FKEY` FOREIGN KEY (`category_id`) REFERENCES `file_categories` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `FILE_STATE_ID_FKEY` FOREIGN KEY (`file_state`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `file_categories`
--
ALTER TABLE `file_categories`
  ADD CONSTRAINT `CATEGORY_STATE_ID_FKEY` FOREIGN KEY (`category_state`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `file_category_history`
--
ALTER TABLE `file_category_history`
  ADD CONSTRAINT `CATEGORY_ID_FKEY` FOREIGN KEY (`category_id`) REFERENCES `file_categories` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `FROM_STATE_FKEY` FOREIGN KEY (`from_state`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `TO_STATE_FKEY` FOREIGN KEY (`to_state`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `file_history`
--
ALTER TABLE `file_history`
  ADD CONSTRAINT `FILE_HISTORY_FROM_STATE_FKEY` FOREIGN KEY (`from_state`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `FILE_HISTORY_TO_STATE_FKEY` FOREIGN KEY (`to_state`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `FILE_ID_FKEY` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
