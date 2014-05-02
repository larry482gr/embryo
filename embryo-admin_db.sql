
-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 03, 2014 at 12:14 AM
-- Server version: 5.5.37-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `embryo-admin_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `articles`
--

CREATE TABLE IF NOT EXISTS `articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(160) COLLATE utf8_unicode_ci NOT NULL,
  `short_desc` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `long_desc` text COLLATE utf8_unicode_ci,
  `lang_id` int(11) NOT NULL DEFAULT '1',
  `is_published` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `published_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `LANGUAGE_ID_FOREIGN_KEY` (`lang_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `articles`
--

INSERT INTO `articles` (`id`, `title`, `short_desc`, `long_desc`, `lang_id`, `is_published`, `created_at`, `published_at`) VALUES
(1, 'First Article', 'This is the first preview site of the respective academic reseach.', NULL, 1, 1, '2014-05-01 18:41:50', '2014-05-01 18:41:50'),
(2, 'Second Article', 'Well, I ''m waiting for your thoughts and proposals concerning this preview. And of course we should arrange a meeting in order to provide me more details on the project''s requirements.', NULL, 1, 1, '2014-05-01 18:41:50', '2014-05-01 18:41:50'),
(3, 'Πρώτο Άρθρο', 'Το παρόν είναι το πρώτο προσχέδιο του ιστοχώρου του ακαδημαϊκού προγράμματος "Έμβρυο".', NULL, 2, 1, '2014-05-02 15:09:25', '2014-05-02 15:09:25');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE IF NOT EXISTS `languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locale` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `language` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `locale`, `language`) VALUES
(1, 'en', 'English'),
(2, 'gr', 'Ελληνικά');

-- --------------------------------------------------------

--
-- Table structure for table `menu_subtabs`
--

CREATE TABLE IF NOT EXISTS `menu_subtabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tab_id` int(11) NOT NULL,
  `label` varchar(160) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `link` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `header` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_divided` tinyint(4) NOT NULL DEFAULT '0',
  `is_active` tinyint(4) NOT NULL DEFAULT '0',
  `subtab_position` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tab_id` (`tab_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

--
-- Dumping data for table `menu_subtabs`
--

INSERT INTO `menu_subtabs` (`id`, `tab_id`, `label`, `description`, `link`, `header`, `is_divided`, `is_active`, `subtab_position`) VALUES
(1, 3, 'Submenu 1', NULL, NULL, NULL, 0, 1, 1),
(2, 3, 'Submenu 2', 'Short description', NULL, NULL, 0, 1, 2),
(3, 3, 'Submenu 3', NULL, NULL, NULL, 0, 1, 3),
(6, 3, 'Separated Submenu', NULL, NULL, 'Dropdown header', 1, 1, 4),
(7, 3, 'One more separated Submenu', 'Divided short description.', NULL, NULL, 1, 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `menu_tabs`
--

CREATE TABLE IF NOT EXISTS `menu_tabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `link` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lang_id` int(11) NOT NULL DEFAULT '1',
  `has_submenu` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `tab_position` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lang_id` (`lang_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `menu_tabs`
--

INSERT INTO `menu_tabs` (`id`, `label`, `description`, `link`, `lang_id`, `has_submenu`, `is_active`, `tab_position`) VALUES
(1, 'Menu 1', 'Menu 1 description', NULL, 1, 0, 1, 1),
(2, 'Menu 2', NULL, NULL, 1, 0, 1, 2),
(3, 'Menu with submenu', NULL, NULL, 1, 1, 1, 3),
(4, 'Menu 1', 'Περιγραφή Menu 1', NULL, 2, 0, 1, 2),
(5, 'Menu 2', NULL, NULL, 2, 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `profiles`
--

CREATE TABLE IF NOT EXISTS `profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `profiles`
--

INSERT INTO `profiles` (`id`, `label`, `description`) VALUES
(1, 'admin', 'Administrator'),
(2, 'moder', 'Moderator'),
(3, 'user', 'Guest User');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `profile_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_users_on_profile_id` (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user_infos`
--

CREATE TABLE IF NOT EXISTS `user_infos` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `activated` tinyint(1) NOT NULL DEFAULT '0',
  `blacklisted` tinyint(1) NOT NULL DEFAULT '0',
  `reports` tinyint(4) NOT NULL DEFAULT '0',
  `token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `menu_subtabs`
--
ALTER TABLE `menu_subtabs`
  ADD CONSTRAINT `TAB_ID_FOREIGN_KEY` FOREIGN KEY (`tab_id`) REFERENCES `menu_tabs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `menu_tabs`
--
ALTER TABLE `menu_tabs`
  ADD CONSTRAINT `LANGUAGE_ID_FOREIGN_KAY` FOREIGN KEY (`lang_id`) REFERENCES `languages` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `PROFILE_ID_FOREIGN_KEY` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`);

--
-- Constraints for table `user_infos`
--
ALTER TABLE `user_infos`
  ADD CONSTRAINT `USER_ID_FOREIGN_KEY` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
