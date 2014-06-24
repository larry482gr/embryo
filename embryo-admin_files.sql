-- phpMyAdmin SQL Dump
-- version 4.0.8
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 24, 2014 at 06:17 PM
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
  `extention` varchar(5) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `filesize` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `file_state` tinyint(4) NOT NULL,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `file_state` (`file_state`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=165 ;

--
-- Dumping data for table `files`
--

INSERT INTO `files` (`id`, `label`, `extention`, `filesize`, `category_id`, `file_state`, `created_at`) VALUES
(100, '1_ ΝΟΜΟΘΕΣΙΑ (4)', '.doc', 510464, 9, 1, 1403602206),
(102, '2.0_ ΠΡΟΣΩΠΑ ΑΝΑΦΟΡΑΣ (2)', '.doc', 129536, 9, 1, 1403602255),
(103, '2.2_ ΔΙΕΥΘΥΝΤΕΣ ΙΑΤΡΙΚΩΝ ΚΕΝΤΡΩΝ (1)', '.doc', 84480, 9, 1, 1403602268),
(104, '3. ΦΟΡΜΑ ΝΟΜΟΛΟΓΙΑΣ (2)', '.doc', 35840, 9, 1, 1403602279),
(105, '1_ ΝΟΜΟΘΕΣΙΑ (5)', '.doc', 510464, 10, 1, 1403602552),
(106, '2.0_ΠΡΟΣΩΠΑ ΑΝΑΦΟΡΑΣ (1)', '.doc', 133632, 10, 1, 1403602566),
(108, '2_1_ ΔΙΕΥΘΥΝΤΕΣ ΙΑΤΡΙΚΩΝ ΚΕΝΤΡΩΝ', '.doc', 130560, 10, 1, 1403602619),
(109, '3. ΦΟΡΜΑ ΝΟΜΟΛΟΓΙΑΣ (3)', '.doc', 35840, 10, 1, 1403602632),
(110, '4.0_ english', '.doc', 134656, 10, 1, 1403602648),
(111, '4.1_english', '.doc', 128512, 10, 1, 1403602662),
(112, '1_ ΝΟΜΟΘΕΣΙΑ (6)', '.doc', 941568, 11, 1, 1403602797),
(114, '2_ ΝΟΜΟΛΟΓΙΑ', '.doc', 551424, 11, 1, 1403602815),
(115, '1_ ΝΟΜΟΘΕΣΙΑ (8)', '.doc', 1039360, 12, 1, 1403602993),
(116, '1_ ΝΟΜΟΘΕΣΙΑ (9)', '.doc', 636928, 13, 1, 1403603036),
(117, '1_ ΝΟΜΟΘΕΣΙΑ (1)', '.docx', 108735, 14, 1, 1403603086),
(118, '2_ ΝΟΜΟΛΟΓΙΑ (1)', '.docx', 33131, 14, 1, 1403603096),
(119, '1_ ΝΟΜΟΘΕΣΙΑ (10)', '.doc', 690176, 15, 1, 1403603136),
(120, '1_ ΝΟΜΟΘΕΣΙΑ (11)', '.doc', 587264, 16, 1, 1403603167),
(121, '1_ ΝΟΜΟΘΕΣΙΑ (12)', '.doc', 728576, 17, 1, 1403603213),
(122, '1_ ΠΕΡΙΛΗΨΗ', '.docx', 67997, 18, 1, 1403603453),
(123, 'CASE OF COSTA AND PAVAN v_ ITALY', '.pdf', 313013, 18, 1, 1403603473),
(124, 'CASE OF DICKSON v_ THE UNITED KINGDOM', '.pdf', 371603, 18, 1, 1403603571),
(125, 'CASE OF EVANS v_ THE UNITED KINGDOM', '.pdf', 307048, 18, 1, 1403603586),
(126, 'CASE OF KNECHT v_ ROMANIA', '.pdf', 271351, 18, 1, 1403603602),
(127, 'CASE OF S_H_ AND OTHERS v_ AUSTRIA', '.pdf', 391978, 18, 1, 1403603620),
(128, 'CASE OF X Y AND Z v_ THE UNITED KINGDOM', '.pdf', 239261, 18, 1, 1403603637),
(129, 'P_ B_ H_ v_ UK', '.docx', 26814, 18, 1, 1403603695),
(130, '1_ C-363_2012', '.docx', 22650, 19, 1, 1403603732),
(131, '3.1_ ΚΟΙΟΣ', '.docx', 41838, 11, 1, 1403603955),
(132, '3.2_ ΒΟΥΛΤΣΟΣ', '.doc', 151040, 11, 1, 1403604151),
(133, '3.3_ ΓΕΝΕΣΙΣ ΑΘΗΝΩΝ', '.doc', 145408, 11, 1, 1403604165),
(134, '3.4_ ΡΕΘΥΜΙΩΤΑΚΗ', '.doc', 195072, 11, 1, 1403604181),
(135, '3.5_ ΖΕΡΒΑΚΑΚΟΥ', '.doc', 136704, 11, 1, 1403604193),
(136, '3.6_ ΚΑΛΛΙΑΚΜΑΝΗΣ', '.doc', 154624, 11, 1, 1403604208),
(137, '3.7_ΚΟΤΖΑΜΠΑΣΗ', '.doc', 155136, 11, 5, 1403604221),
(138, '3.7_ ΚΟΤΖΑΜΠΑΣΗ', '.doc', 155136, 11, 1, 1403604294),
(139, '3.8_ ΚΟΥΝΟΥΓΕΡΗ', '.doc', 157696, 11, 1, 1403604310),
(140, '3.9_ Λ.ΠΑΠΑΔΟΠΟΥΛΟΥ', '.doc', 149504, 11, 1, 1403604322),
(141, '3.10_ΛΟΥΦΟΠΟΥΛΟΣ', '.docx', 36042, 11, 5, 1403604333),
(142, '3.10_ ΛΟΥΦΟΠΟΥΛΟΣ', '.docx', 36042, 11, 1, 1403604421),
(143, '3.11_ ΣΚΟΡΙΝΗ', '.doc', 186368, 11, 1, 1403604440),
(144, '3.12_ ΠΑΠΑΖΗΣΗ', '.doc', 160768, 11, 1, 1403604453),
(145, '3.13_ ΣΑΡΔΕΛΗ', '.doc', 146432, 11, 1, 1403604465),
(146, '3.14_ ΒΙΔΑΛΗΣ', '.doc', 179200, 11, 1, 1403604478),
(147, '3.15_ ΦΟΥΝΤΕΔΑΚΗ', '.doc', 284160, 11, 1, 1403604492),
(148, '3.16_ ΚΑΖΛΑΡΗΣ', '.doc', 190464, 11, 1, 1403604504),
(149, '3.17- 2.2_ ΠΡΑΠΑΣ', '.doc', 153088, 11, 1, 1403604520),
(150, '4.1_ ΑΛΕΞΟΠΟΥΛΟΥ_ΣΩΜΑΤΕΙΟ ΚΥΒΕΛΗ', '.docx', 39479, 11, 5, 1403604688),
(151, '4.1_ ΚΟΓΚΙΔΟΥ', '.doc', 148480, 11, 1, 1403604862),
(152, '4.2_ ΚΟΥΜΟΥΤΖΗΣ', '.doc', 150016, 11, 1, 1403604875),
(153, '4.3_ ΚΑΖΑΝΤΖΗ- ΚΥΒΕΛΗ', '.doc', 141312, 11, 1, 1403604888),
(154, '4.4_ ΖΕΡΒΑ- ΚΥΒΕΛΗ', '.docx', 39324, 11, 1, 1403604899),
(155, '4.5_ ΑΛΕΞΟΠΟΥΛΟΥ- ΚΥΒΕΛΗ', '.docx', 39479, 11, 1, 1403604912),
(156, '4.6_ ΤΖΙΑΝΝΙΟΥ- ΚΥΒΕΛΗ', '.doc', 141824, 11, 1, 1403604928),
(157, '4.7_ ΧΡΙΣΤΟΔΟΥΛΑΚΗ- ΚΥΒΕΛΗ', '.doc', 132608, 11, 1, 1403604939),
(158, '4.8_ ΚΟΥΜΠΑΡΟΥ- MAGNA MATER', '.doc', 127488, 11, 1, 1403604952),
(159, 'ΠΡΟΤΑΣΕΙΣ - ΣΚΕΨΕΙΣ', '.docx', 12511, 21, 5, 1403607035),
(160, 'ΔΙΑΛΟΓΟΣ', '.docx', 12511, 21, 1, 1403607256),
(161, 'iffs_surveillance_09-19-13', '.pdf', 2249872, 23, 1, 1403607944),
(162, 'EU Laws Surrogacy', '.pdf', 3992023, 23, 1, 1403608071),
(163, 'CDBI-INF(98)8PMA', '.pdf', 522271, 23, 1, 1403608101),
(164, 'CDBI-CO-GT3(2003)13E', '.pdf', 604665, 23, 1, 1403608141);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=24 ;

--
-- Dumping data for table `file_categories`
--

INSERT INTO `file_categories` (`id`, `label`, `description`, `parent_id`, `lang_id`, `category_state`, `created_at`) VALUES
(9, 'ΑΡΧΙΚΑ ΕΡΩΤΗΜΑΤΟΛΟΓΙΑ', NULL, NULL, 2, 3, 1402850830),
(10, 'ΤΕΛΙΚΑ ΕΡΩΤΗΜΑΤΟΛΟΓΙΑ', NULL, NULL, 2, 1, 1403283079),
(11, 'ΕΛΛΑΔΑ', NULL, NULL, 2, 3, 1403477764),
(12, 'ΓΑΛΛΙΑ', NULL, NULL, 2, 3, 1403479689),
(13, 'Μ.ΒΡΕΤΑΝΙΑ', NULL, NULL, 2, 3, 1403479734),
(14, 'ΙΡΛΑΝΔΙΑ', NULL, NULL, 2, 1, 1403479759),
(15, 'ΙΤΑΛΙΑ', NULL, NULL, 2, 1, 1403479804),
(16, 'ΓΕΡΜΑΝΙΑ', NULL, NULL, 2, 1, 1403479815),
(17, 'ΣΟΥΗΔΙΑ', NULL, NULL, 2, 1, 1403479823),
(18, 'ΝΟΜΟΛΟΓΙΑ ΕΔΔΑ', NULL, NULL, 2, 1, 1403603267),
(19, 'ΝΟΜΟΛΟΓΙΑ ΔΕΕ', NULL, NULL, 2, 1, 1403603288),
(20, 'ΣΥΜΠΛΗΡΩΜΕΝΑ ΕΡΩΤΗΜΑΤΟΛΟΓΙΑ', NULL, NULL, 2, 5, 1403605102),
(21, 'ΔΙΑΦΟΡΑ', NULL, NULL, 2, 1, 1403605459),
(22, 'ΜΕΛΕΤΕΣ - ΑΡΘΡΑ - ΠΑΡΑΤΗΡΗΣΕΙΣ ΣΤΗ ΝΟΜΟΛΟΓΙΑ', NULL, NULL, 2, 5, 1403605488),
(23, 'ΜΕΛΕΤΕΣ- ΠΑΡΑΤΗΡΗΣΕΙΣ', NULL, NULL, 2, 1, 1403605520);

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
(10, 1, NULL, 1, 1403283079),
(11, 12, NULL, 1, 1403477764),
(11, 12, 1, 3, 1403478226),
(11, 12, 3, 3, 1403478237),
(11, 12, 3, 3, 1403479789),
(12, 12, NULL, 1, 1403479689),
(12, 12, 1, 3, 1403479703),
(12, 12, 3, 3, 1403479779),
(13, 12, NULL, 1, 1403479734),
(13, 12, 1, 3, 1403479769),
(14, 12, NULL, 1, 1403479759),
(15, 12, NULL, 1, 1403479804),
(16, 12, NULL, 1, 1403479815),
(17, 12, NULL, 1, 1403479823),
(18, 12, NULL, 1, 1403603267),
(19, 12, NULL, 1, 1403603288),
(20, 12, NULL, 1, 1403605102),
(20, 12, 1, 5, 1403605137),
(21, 12, NULL, 1, 1403605459),
(22, 12, NULL, 1, 1403605488),
(22, 12, 1, 5, 1403605498),
(23, 12, NULL, 1, 1403605520);

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
(124, 12, NULL, 1, 1403603571),
(125, 12, NULL, 1, 1403603586),
(126, 12, NULL, 1, 1403603602),
(127, 12, NULL, 1, 1403603620),
(128, 12, NULL, 1, 1403603637),
(129, 12, NULL, 1, 1403603695),
(130, 12, NULL, 1, 1403603732),
(131, 12, NULL, 1, 1403603955),
(132, 12, NULL, 1, 1403604151),
(133, 12, NULL, 1, 1403604165),
(134, 12, NULL, 1, 1403604181),
(135, 12, NULL, 1, 1403604193),
(136, 12, NULL, 1, 1403604208),
(137, 12, NULL, 1, 1403604221),
(137, 12, 1, 5, 1403604235),
(138, 12, NULL, 1, 1403604294),
(139, 12, NULL, 1, 1403604310),
(140, 12, NULL, 1, 1403604322),
(141, 12, NULL, 1, 1403604333),
(141, 12, 1, 5, 1403604343),
(142, 12, NULL, 1, 1403604421),
(143, 12, NULL, 1, 1403604440),
(144, 12, NULL, 1, 1403604453),
(145, 12, NULL, 1, 1403604465),
(146, 12, NULL, 1, 1403604478),
(147, 12, NULL, 1, 1403604492),
(148, 12, NULL, 1, 1403604504),
(149, 12, NULL, 1, 1403604520),
(150, 12, NULL, 1, 1403604688),
(150, 12, 1, 5, 1403604706),
(151, 12, NULL, 1, 1403604862),
(152, 12, NULL, 1, 1403604875),
(153, 12, NULL, 1, 1403604888),
(154, 12, NULL, 1, 1403604899),
(155, 12, NULL, 1, 1403604912),
(156, 12, NULL, 1, 1403604928),
(157, 12, NULL, 1, 1403604939),
(158, 12, NULL, 1, 1403604952),
(159, 12, NULL, 1, 1403607035),
(159, 12, 1, 5, 1403607214),
(160, 12, NULL, 1, 1403607256),
(161, 12, NULL, 1, 1403607944),
(162, 12, NULL, 1, 1403608071),
(163, 12, NULL, 1, 1403608101),
(164, 12, NULL, 1, 1403608141);

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
