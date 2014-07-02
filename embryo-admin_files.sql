-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: hosted4db.ccf.auth.gr:3306
-- Generation Time: Jul 02, 2014 at 06:32 PM
-- Server version: 5.5.37-0ubuntu0.12.04.1
-- PHP Version: 5.4.16

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
  `extention` varchar(5) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `filesize` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `file_state` tinyint(4) NOT NULL,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `file_state` (`file_state`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=190 ;

--
-- Dumping data for table `files`
--

INSERT INTO `files` (`id`, `label`, `extention`, `filesize`, `category_id`, `file_state`, `created_at`) VALUES
(100, '1_ ΝΟΜΟΘΕΣΙΑ', '.doc', 510464, 9, 1, 1403602206),
(102, '2.0_ ΠΡΟΣΩΠΑ ΑΝΑΦΟΡΑΣ', '.doc', 129536, 9, 1, 1403602255),
(103, '2.2_ ΔΙΕΥΘΥΝΤΕΣ ΙΑΤΡΙΚΩΝ ΚΕΝΤΡΩΝ', '.doc', 84480, 9, 1, 1403602268),
(104, '3. ΦΟΡΜΑ ΝΟΜΟΛΟΓΙΑΣ', '.doc', 35840, 9, 1, 1403602279),
(105, '1_ ΝΟΜΟΘΕΣΙΑ', '.doc', 510464, 10, 1, 1403602552),
(106, '2.0_ΠΡΟΣΩΠΑ ΑΝΑΦΟΡΑΣ', '.doc', 133632, 10, 1, 1403602566),
(108, '2.1_ ΔΙΕΥΘΥΝΤΕΣ ΙΑΤΡΙΚΩΝ ΚΕΝΤΡΩΝ', '.doc', 130560, 10, 3, 1403602619),
(109, '3. ΦΟΡΜΑ ΝΟΜΟΛΟΓΙΑΣ', '.doc', 35840, 10, 1, 1403602632),
(110, '4.0_ english', '.doc', 134656, 10, 1, 1403602648),
(111, '4.1_english', '.doc', 128512, 10, 1, 1403602662),
(112, '1_ ΝΟΜΟΘΕΣΙΑ', '.doc', 941568, 11, 1, 1403602797),
(114, '2_ ΝΟΜΟΛΟΓΙΑ', '.doc', 551424, 11, 1, 1403602815),
(115, '1_ ΝΟΜΟΘΕΣΙΑ', '.doc', 1039360, 12, 1, 1403602993),
(116, '1_ ΝΟΜΟΘΕΣΙΑ', '.doc', 636928, 13, 1, 1403603036),
(117, '1_ ΝΟΜΟΘΕΣΙΑ', '.docx', 108735, 14, 1, 1403603086),
(118, '2_ ΝΟΜΟΛΟΓΙΑ', '.docx', 33131, 14, 1, 1403603096),
(119, '1_ ΝΟΜΟΘΕΣΙΑ', '.doc', 690176, 15, 1, 1403603136),
(120, '1_ ΝΟΜΟΘΕΣΙΑ', '.doc', 587264, 16, 1, 1403603167),
(121, '1_ ΝΟΜΟΘΕΣΙΑ', '.doc', 728576, 17, 1, 1403603213),
(122, '1_ ΠΕΡΙΛΗΨΗ', '.docx', 67997, 18, 1, 1403603453),
(123, 'COSTA AND PAVAN v. ITALY', '.pdf', 313013, 18, 3, 1403603473),
(124, 'DICKSON v. UK', '.pdf', 371603, 18, 3, 1403603571),
(125, 'EVANS v. UK', '.pdf', 307048, 18, 3, 1403603586),
(126, 'KNECHT v. ROMANIA', '.pdf', 271351, 18, 3, 1403603602),
(127, 'S.H AND OTHERS v. AUSTRIA', '.pdf', 391978, 18, 3, 1403603620),
(128, 'X.Y AND Z. v. UK', '.pdf', 239261, 18, 3, 1403603637),
(129, 'P. B. H. v. UK', '.docx', 26814, 18, 3, 1403603695),
(130, '1_ C-363_2012', '.docx', 22650, 19, 1, 1403603732),
(131, '3.1_ ΚΟΙΟΣ', '.docx', 41838, 11, 1, 1403603955),
(132, '3.2_ ΒΟΥΛΤΣΟΣ', '.doc', 151040, 11, 1, 1403604151),
(133, '3.3_ ΓΕΝΕΣΙΣ ΑΘΗΝΩΝ', '.doc', 145408, 11, 1, 1403604165),
(134, '3.4_ ΡΕΘΥΜΙΩΤΑΚΗ', '.doc', 195072, 11, 1, 1403604181),
(135, '3.5_ ΖΕΡΒΑΚΑΚΟΥ', '.doc', 136704, 11, 1, 1403604193),
(136, '3.6_ ΚΑΛΛΙΑΚΜΑΝΗΣ', '.doc', 154624, 11, 1, 1403604208),
(138, '3.7_ ΚΟΤΖΑΜΠΑΣΗ', '.doc', 155136, 11, 1, 1403604294),
(139, '3.8_ ΚΟΥΝΟΥΓΕΡΗ', '.doc', 157696, 11, 1, 1403604310),
(140, '3.9_ Λ.ΠΑΠΑΔΟΠΟΥΛΟΥ', '.doc', 149504, 11, 1, 1403604322),
(151, '4.1_ ΚΟΓΚΙΔΟΥ', '.doc', 148480, 11, 1, 1403604862),
(152, '4.2_ ΚΟΥΜΟΥΤΖΗΣ', '.doc', 150016, 11, 1, 1403604875),
(153, '4.3_ ΚΑΖΑΝΤΖΗ- ΚΥΒΕΛΗ', '.doc', 141312, 11, 1, 1403604888),
(154, '4.4_ ΖΕΡΒΑ- ΚΥΒΕΛΗ', '.docx', 39324, 11, 1, 1403604899),
(155, '4.5_ ΑΛΕΞΟΠΟΥΛΟΥ- ΚΥΒΕΛΗ', '.docx', 39479, 11, 1, 1403604912),
(156, '4.6_ ΤΖΙΑΝΝΙΟΥ- ΚΥΒΕΛΗ', '.doc', 141824, 11, 1, 1403604928),
(157, '4.7_ ΧΡΙΣΤΟΔΟΥΛΑΚΗ- ΚΥΒΕΛΗ', '.doc', 132608, 11, 1, 1403604939),
(158, '4.8_ ΚΟΥΜΠΑΡΟΥ- MAGNA MATER', '.doc', 127488, 11, 1, 1403604952),
(161, 'iffs_surveillance_09-19-13', '.pdf', 2249872, 23, 1, 1403607944),
(162, 'EU Laws Surrogacy', '.pdf', 3992023, 23, 1, 1403608071),
(163, 'CDBI-INF(98)8PMA', '.pdf', 522271, 23, 1, 1403608101),
(164, 'CDBI-CO-GT3(2003)13E', '.pdf', 604665, 23, 1, 1403608141),
(165, 'LABASSEE c. FRANCE', '.pdf', 393315, 18, 3, 1403823949),
(166, '3.9.1_ ΛΟΥΦΟΠΟΥΛΟΣ', '.docx', 36042, 11, 1, 1403907911),
(167, '3.9.2_ ΣΚΟΡΙΝΗ', '.doc', 186368, 11, 1, 1403907946),
(168, '3.9.3_ ΠΑΠΑΖΗΣΗ', '.doc', 160768, 11, 1, 1403908009),
(183, 'ΔΙΑΛΟΓΟΣ', '.docx', 12511, 21, 3, 1403972962),
(184, 'Χώρος Μελών', '.docx', 11079, 25, 6, 1403976076),
(185, '3.9.4_ ΣΑΡΔΕΛΗ', '.doc', 146432, 11, 1, 1404022342),
(186, '3.9.5_ ΒΙΔΑΛΗΣ', '.doc', 179200, 11, 1, 1404022382),
(187, '3.9.6_ ΦΟΥΝΤΕΔΑΚΗ', '.doc', 284160, 11, 1, 1404022426),
(188, '3.9.7_ ΚΑΖΛΑΡΗΣ', '.doc', 190464, 11, 1, 1404022464),
(189, '3.9.8- 2.2_ ΠΡΑΠΑΣ', '.doc', 153088, 11, 1, 1404022501);

-- --------------------------------------------------------

--
-- Table structure for table `file_categories`
--

CREATE TABLE IF NOT EXISTS `file_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(127) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1023) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `lang_id` int(11) NOT NULL,
  `category_state` tinyint(4) NOT NULL,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_state` (`category_state`),
  KEY `lang_id` (`lang_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=26 ;

--
-- Dumping data for table `file_categories`
--

INSERT INTO `file_categories` (`id`, `label`, `description`, `parent_id`, `lang_id`, `category_state`, `created_at`) VALUES
(9, '02. ΑΡΧΙΚΑ ΕΡΩΤΗΜΑΤΟΛΟΓΙΑ', NULL, NULL, 2, 3, 1402850830),
(10, '03. ΤΕΛΙΚΑ ΕΡΩΤΗΜΑΤΟΛΟΓΙΑ', NULL, NULL, 2, 3, 1403283079),
(11, '04. ΕΛΛΑΔΑ', NULL, NULL, 2, 3, 1403477764),
(12, '05. ΓΑΛΛΙΑ', NULL, NULL, 2, 3, 1403479689),
(13, '06. Μ.ΒΡΕΤΑΝΙΑ', NULL, NULL, 2, 3, 1403479734),
(14, '07. ΙΡΛΑΝΔΙΑ', NULL, NULL, 2, 3, 1403479759),
(15, '08. ΙΤΑΛΙΑ', NULL, NULL, 2, 3, 1403479804),
(16, '09. ΓΕΡΜΑΝΙΑ', NULL, NULL, 2, 3, 1403479815),
(17, '10. ΣΟΥΗΔΙΑ', NULL, NULL, 2, 3, 1403479823),
(18, '11. ΝΟΜΟΛΟΓΙΑ ΕΔΔΑ', NULL, NULL, 2, 3, 1403603267),
(19, '12. ΝΟΜΟΛΟΓΙΑ ΔΕΕ', NULL, NULL, 2, 3, 1403603288),
(20, 'ΣΥΜΠΛΗΡΩΜΕΝΑ ΕΡΩΤΗΜΑΤΟΛΟΓΙΑ', NULL, NULL, 2, 6, 1403605102),
(21, '01. ΔΙΑΦΟΡΑ', NULL, NULL, 2, 3, 1403605459),
(22, 'ΜΕΛΕΤΕΣ - ΑΡΘΡΑ - ΠΑΡΑΤΗΡΗΣΕΙΣ ΣΤΗ ΝΟΜΟΛΟΓΙΑ', NULL, NULL, 2, 6, 1403605488),
(23, '13. ΜΕΛΕΤΕΣ- ΠΑΡΑΤΗΡΗΣΕΙΣ', NULL, NULL, 2, 3, 1403605520),
(25, 'test folder', NULL, NULL, 2, 6, 1403976053);

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
(9, 1, NULL, 1, 1402850830),
(9, 1, 1, 3, 1403283104),
(9, 12, 3, 3, 1403906354),
(9, 1, 3, 3, 1403946388),
(9, 1, 3, 3, 1403946424),
(10, 1, NULL, 1, 1403283079),
(10, 12, 1, 3, 1403906365),
(10, 1, 3, 3, 1403946446),
(11, 12, NULL, 1, 1403477764),
(11, 12, 1, 3, 1403478226),
(11, 12, 3, 3, 1403478237),
(11, 12, 3, 3, 1403479789),
(11, 12, 3, 3, 1403906378),
(11, 1, 3, 3, 1403946458),
(12, 12, NULL, 1, 1403479689),
(12, 12, 1, 3, 1403479703),
(12, 12, 3, 3, 1403479779),
(12, 12, 3, 3, 1403906391),
(12, 1, 3, 3, 1403946472),
(13, 12, NULL, 1, 1403479734),
(13, 12, 1, 3, 1403479769),
(13, 12, 3, 3, 1403906401),
(13, 1, 3, 3, 1403946483),
(14, 12, NULL, 1, 1403479759),
(14, 12, 1, 3, 1403906411),
(14, 1, 3, 3, 1403946493),
(15, 12, NULL, 1, 1403479804),
(15, 12, 1, 3, 1403906420),
(15, 1, 3, 3, 1403946503),
(16, 12, NULL, 1, 1403479815),
(16, 12, 1, 3, 1403906430),
(16, 1, 3, 3, 1403946525),
(17, 12, NULL, 1, 1403479823),
(17, 12, 1, 3, 1403906439),
(17, 1, 3, 3, 1403946552),
(18, 12, NULL, 1, 1403603267),
(18, 12, 1, 3, 1403906451),
(18, 1, 3, 3, 1403946559),
(19, 12, NULL, 1, 1403603288),
(19, 12, 1, 3, 1403906461),
(19, 1, 3, 3, 1403946566),
(20, 12, NULL, 1, 1403605102),
(20, 12, 1, 5, 1403605137),
(20, 1, 5, 6, 1403983654),
(21, 12, NULL, 1, 1403605459),
(21, 12, 1, 3, 1403906125),
(21, 1, 3, 3, 1403946434),
(22, 12, NULL, 1, 1403605488),
(22, 12, 1, 5, 1403605498),
(22, 1, 5, 6, 1403983654),
(23, 12, NULL, 1, 1403605520),
(23, 12, 1, 3, 1403906472),
(23, 1, 3, 3, 1403946573),
(25, 1, NULL, 1, 1403976053),
(25, 1, 1, 5, 1403976101),
(25, 1, 5, 6, 1403976111);

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
(100, 12, NULL, 1, 1403602206),
(102, 12, NULL, 1, 1403602255),
(103, 12, NULL, 1, 1403602268),
(104, 12, NULL, 1, 1403602279),
(105, 12, NULL, 1, 1403602552),
(106, 12, NULL, 1, 1403602566),
(108, 12, NULL, 1, 1403602619),
(108, 12, 1, 3, 1403906611),
(109, 12, NULL, 1, 1403602632),
(110, 12, NULL, 1, 1403602648),
(111, 12, NULL, 1, 1403602662),
(112, 12, NULL, 1, 1403602797),
(114, 12, NULL, 1, 1403602815),
(115, 12, NULL, 1, 1403602993),
(116, 12, NULL, 1, 1403603036),
(117, 12, NULL, 1, 1403603086),
(118, 12, NULL, 1, 1403603096),
(119, 12, NULL, 1, 1403603136),
(120, 12, NULL, 1, 1403603167),
(121, 12, NULL, 1, 1403603213),
(122, 12, NULL, 1, 1403603453),
(123, 12, NULL, 1, 1403603473),
(123, 12, 1, 3, 1404022610),
(123, 12, 3, 3, 1404022783),
(124, 12, NULL, 1, 1403603571),
(124, 12, 1, 3, 1404022621),
(124, 12, 3, 3, 1404022730),
(125, 12, NULL, 1, 1403603586),
(125, 12, 1, 3, 1404022631),
(125, 12, 3, 3, 1404022744),
(126, 12, NULL, 1, 1403603602),
(126, 12, 1, 3, 1404022644),
(126, 12, 3, 3, 1404022752),
(127, 12, NULL, 1, 1403603620),
(127, 12, 1, 3, 1404022665),
(128, 12, NULL, 1, 1403603637),
(128, 12, 1, 3, 1404022689),
(128, 12, 3, 3, 1404022769),
(129, 12, NULL, 1, 1403603695),
(129, 12, 1, 3, 1404022709),
(130, 12, NULL, 1, 1403603732),
(131, 12, NULL, 1, 1403603955),
(132, 12, NULL, 1, 1403604151),
(133, 12, NULL, 1, 1403604165),
(134, 12, NULL, 1, 1403604181),
(135, 12, NULL, 1, 1403604193),
(136, 12, NULL, 1, 1403604208),
(138, 12, NULL, 1, 1403604294),
(139, 12, NULL, 1, 1403604310),
(140, 12, NULL, 1, 1403604322),
(151, 12, NULL, 1, 1403604862),
(152, 12, NULL, 1, 1403604875),
(153, 12, NULL, 1, 1403604888),
(154, 12, NULL, 1, 1403604899),
(155, 12, NULL, 1, 1403604912),
(156, 12, NULL, 1, 1403604928),
(157, 12, NULL, 1, 1403604939),
(158, 12, NULL, 1, 1403604952),
(161, 12, NULL, 1, 1403607944),
(162, 12, NULL, 1, 1403608071),
(163, 12, NULL, 1, 1403608101),
(164, 12, NULL, 1, 1403608141),
(165, 12, NULL, 1, 1403823949),
(165, 12, 1, 3, 1404022584),
(166, 12, NULL, 1, 1403907911),
(167, 12, NULL, 1, 1403907946),
(168, 12, NULL, 1, 1403908009),
(183, 1, NULL, 1, 1403972962),
(183, 1, 1, 3, 1403972980),
(183, 1, 3, 3, 1403973004),
(183, 1, 3, 3, 1403982125),
(183, 1, 3, 3, 1403982254),
(183, 1, 3, 3, 1403982365),
(183, 1, 3, 3, 1403982375),
(184, 1, NULL, 1, 1403976076),
(184, 1, 1, 5, 1403976101),
(184, 1, 5, 6, 1403976111),
(185, 12, NULL, 1, 1404022342),
(186, 12, NULL, 1, 1404022382),
(187, 12, NULL, 1, 1404022426),
(188, 12, NULL, 1, 1404022464),
(189, 12, NULL, 1, 1404022501);

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
  ADD CONSTRAINT `CATEGORY_ID_FKEY` FOREIGN KEY (`category_id`) REFERENCES `file_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FROM_STATE_FKEY` FOREIGN KEY (`from_state`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `TO_STATE_FKEY` FOREIGN KEY (`to_state`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `file_history`
--
ALTER TABLE `file_history`
  ADD CONSTRAINT `FILE_ID_FKEY` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FILE_HISTORY_FROM_STATE_FKEY` FOREIGN KEY (`from_state`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `FILE_HISTORY_TO_STATE_FKEY` FOREIGN KEY (`to_state`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
