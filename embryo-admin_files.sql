-- phpMyAdmin SQL Dump
-- version 4.0.8
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 08, 2014 at 03:58 AM
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
  `file_state` tinyint(4) NOT NULL,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `file_state` (`file_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

--
-- Dumping data for table `file_categories`
--

INSERT INTO `file_categories` (`id`, `label`, `description`, `lang_id`, `category_state`, `created_at`) VALUES
(1, 'Αρχικά Ερωτηματολόγια', NULL, 2, 1, 1402158121),
(7, 'Τελικά Ερωτηματολόγια', NULL, 2, 5, 1402185230);

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
(7, 1, NULL, 1, 1402185230),
(7, 1, 1, 3, 1402185307),
(7, 1, 3, 3, 1402187326),
(7, 1, 3, 5, 1402188286);

-- --------------------------------------------------------

--
-- Table structure for table `file_history`
--

CREATE TABLE IF NOT EXISTS `file_history` (
  `file_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `from_state` tinyint(4) NOT NULL,
  `to_state` tinyint(4) NOT NULL,
  `timedate` int(11) NOT NULL,
  PRIMARY KEY (`file_id`,`timedate`),
  KEY `from_state` (`from_state`),
  KEY `to_state` (`to_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE IF NOT EXISTS `states` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `label` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

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
  ADD CONSTRAINT `FILE_HISTORY_TO_STATE_FKEY` FOREIGN KEY (`to_state`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `FILE_HISTORY_FROM_STATE_FKEY` FOREIGN KEY (`from_state`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `FILE_ID_FKEY` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
