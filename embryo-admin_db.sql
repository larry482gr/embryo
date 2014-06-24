-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: hosted4db.ccf.auth.gr:3306
-- Generation Time: Jun 24, 2014 at 06:50 PM
-- Server version: 5.5.37-0ubuntu0.12.04.1
-- PHP Version: 5.4.16

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
  `short_desc` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `long_desc` text COLLATE utf8_unicode_ci,
  `picture` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lang_id` int(11) NOT NULL DEFAULT '1',
  `is_published` tinyint(4) NOT NULL DEFAULT '0',
  `carousel` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `published_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `picture` (`picture`),
  KEY `LANGUAGE_ID_FOREIGN_KEY` (`lang_id`),
  KEY `carousel` (`carousel`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=13 ;

--
-- Dumping data for table `articles`
--

INSERT INTO `articles` (`id`, `title`, `short_desc`, `long_desc`, `picture`, `lang_id`, `is_published`, `carousel`, `created_at`, `published_at`) VALUES
(4, 'Ιταλία: Άρση της απαγόρευσης για δωρεά σπέρματος και ωαρίων από τρίτο δότη', 'Το Συνταγματικό Δικαστήριο της Ιταλίας έκρινε αντισυνταγματικό το νόμο 40 περί απαγόρευσης της χρήσης δωρητών σπέρματος και ωαρίων από τρίτο δότη και κήρυξε την άρση της απαγόρευσής του.', 'Η δικηγόρος Maria Paolo Constantini, η οποία ήταν ενάντια στην εφαρμογή του νόμου 40, υποστήριξε ότι το κοινοβούλιο θα επανεισαγάγει τους κανόνες που ήταν σε εφαρμογή πριν το νόμο. Ωστόσο, η Υπουργός Υγείας της Ιταλίας τόνισε πως το θέμα χρήζει εκτενούς συζήτησης στο κοινοβούλιο πριν εφαρμοστεί ξανά ο παλιός νόμος, καθώς προκύπτουν ζητήματα σχετικά με την ανωνυμία του δότη και το δικαίωμα του τέκνου για γνώση των φυσικών του γονέων.\n\nΟ νόμος 40 έθετε αυστηρούς περιορισμούς σε όσους επιθυμούσαν να αποκτήσουν τέκνο μέσω εξωσωματικής και τεχνητής γονιμοποίησης, ενώ απαγόρευε την θεραπεία γονιμότητας σε ομοφυλόφιλα ζευγάρια και σε ένα μόνο γονέα. Επιπροσθέτως, σε μια διάταξή του, ο νόμος απαγόρευε τον έλεγχο των εμβρύων για γενετικές ανωμαλίες προτού εμφυτευθούν. Μάλιστα, η εν λόγω διάταξη έχει ήδη κριθεί από το Ευρωπαϊκό Δικαστήριο των Δικαιωμάτων του Ανθρώπου (ΕΔΔΑ), ότι αποτελεί κατάφωρη παραβίαση της Ευρωπαϊκής Σύμβασης των Δικαιωμάτων του Ανθρώπου (ΕΣΔΑ) και συγκεκριμένα των δικαιωμάτων  του σεβασμού της οικογένειας και της ιδιωτικής ζωής.\n\nΣύμφωνα με εκτιμήσεις, το έτος 2012 περίπου 4000 στείρα ζευγάρια κατέφευγαν στο εξωτερικό με σκοπό την ανεύρεση δωρητών σπέρματος. Ο κανόνας έβαζε φραγμούς στην επιθυμία των ζευγαριών να αποκτήσουν τα δικά τους τέκνα και να τα αναθρέψουν με αγάπη.\n\nΠηγή: <a href="http://www.bionews.org.uk/page_412161.asp?dinfo=RqF5ou7gdQttN9OUTwjl11OX&PPID=412535" target="blank">BioNews</a>', 'itcourt.jpeg', 2, 1, 1, '2014-05-25 17:56:18', '2014-05-25 17:56:18'),
(5, 'Η.Π.Α.: Ρεκόρ στις «διαθήκες ζωής» ', 'Πρόσφατη έρευνα του Πανεπιστημίου Michigan και του Veterans Affairs Ann Arbor Healthcare System αποκαλύπτει νέο αριθμό ρεκόρ για τα αμερικανικά δεδομένα στην υιοθέτηση «προγενέστερων οδηγιών» (advance directives) και την σύνταξη «διαθηκών ζωής» (living wills) από ηλικιωμένους.', 'Οι οδηγίες αυτές γνωστοποιούν εκ των προτέρων τις επιθυμίες ενός προσώπου για την ιατρική του μεταχείριση σε περίπτωση σοβαρής βλάβης της υγείας του, η οποία θα του στερεί την ικανότητα βούλησης. Συνήθως, οι οδηγίες αναφέρονται στην υποστήριξη ή την συντήρηση λειτουργιών του οργανισμού που έχουν υποστεί βλάβες ή επιτάσσουν την αποφυγή μιας επίπονης θεραπείας ή παθητική ευθανασία. Μάλιστα, οι ασθενείς μέσω των «προγενέστερων οδηγιών» μπορούν είτε να εξουσιοδοτούν τρίτο άτομο να λάβει τις σχετικές αποφάσεις είτε να ορίζουν ευθέως την επιθυμία τους κατά το χρόνο της αδυναμίας του ενδιαφερόμενου.\r\n\r\nΗ έρευνα μαρτυρά ότι τα ποσοστά των Αμερικανών που υιοθετούν τέτοιες οδηγίες είναι εντυπωσιακά. Συγκεκριμένα, παρατηρείται σχεδόν διπλάσια αύξηση των διαθηκών ζωής σε μια δεκαετία (από το 47% το 2000 στο 72% το 2010). Ωστόσο, οι οδηγίες είχαν μικρή επιρροή όσον αφορά το βαθμό νοσηλείας των ασθενών σε νοσοκομεία.\r\n\r\n«Η αύξηση των προηγούμενων οδηγιών φανερώνει ότι οι άνθρωποι είναι εξοικειωμένοι με την έννοια του θανάτου και την αντιμετώπιση που θα ήθελαν να έχουν από τα αγαπημένα τους πρόσωπα, κατά τον κρίσιμο χρόνο της λήψης μιας σοβαρής απόφασης για την συνέχιση της ζωή τους» επισημαίνουν οι ειδικοί. Επιπλέον, στην έρευνα παρατηρήθηκε ότι οι περισσότεροι Αμερικανοί εξουσιοδοτούσαν κάποιο έμπιστο τρίτο πρόσωπο να αποφασίσει και συχνά όριζαν την επιθυμία τους. Όμως, δεν ήταν και λίγοι εκείνοι που εξουσιοδοτούσαν απλώς τρίτα άτομα, δίχως να αποκαλύπτουν τις επιθυμίες τους. Εξάλλου, η αναγνώριση σε ένα πρόσωπο της ιδιότητας να λάβει τόσο σημαντικές αποφάσεις δεν είναι τόσο δύσκολη υπόθεση όσο το να λάβει κάποιος μια απόφαση για τη ζωή του, σε προγενέστερο στάδιο, δίχως τη δυνατότητα συνεκτίμησης παραγόντων, όπως η σοβαρότητα της ασθένειας ή το ενδεχόμενο μόνιμων βλαβών.\r\n\r\nΤα ηθικά διλήμματα αναφορικά με τις «διαθήκες ζωής» πληθαίνουν. Πολλοί άνθρωποι εναντιώνονται σε αυτές για θρησκευτικούς λόγους ή εξαιτίας της ιδιοσυγκρασίας τους. Επιπροσθέτως, υπάρχουν κάποιοι που πιστεύουν ότι τέτοιες κρίσιμες αποφάσεις πρέπει να λαμβάνονται από την οικογένεια του προσώπου και συνεπώς η λύση των «διαθηκών ζωής» δεν θεωρείται απ’ αυτά τα πρόσωπα δόκιμη.\r\n\r\nΠηγή: <a href="http://www.newswise.com/articles/view/615696/?sc=rsla" target="blank">Newswise</a>\r\n', 'livingwill.jpeg', 2, 1, 1, '2014-05-25 17:56:18', '2014-05-25 17:56:18'),
(6, 'Καναδάς: Τρεις νόμιμοι γονείς σε ληξιαρχική πράξη γέννησης τέκνου', 'Κάτω από το μανδύα πρόσφατης νομοθεσίας, και για πρώτη φορά στην επαρχία British Columbia (Καναδάς), ένα κοριτσάκι τριών μηνών καταχωρήθηκε στο ληξιαρχείο ως τέκνο τριών γονέων. Ένα ομοφυλόφιλο ζευγάρι γυναικών που ήθελαν να αποκτήσουν παιδί, απευθύνθηκαν σε έναν φίλο τους, ο οποίος δέχτηκε να είναι ο δότης σπέρματος. Οι μητέρες επιθυμούσαν το παιδί που θα γεννηθεί να έχει και πατρικό πρότυπο, οπότε πριν τη σύλληψη αποφάσισαν να ασκούν τη γονική μέριμνα από κοινού με τον πατέρα.', 'Όμως, παρά την ανυπέρβλητη χαρά των τριών γονιών, αρκετοί είναι εκείνοι που επισημαίνουν ότι για να ληφθούν τέτοιες αποφάσεις χρειάζεται πρωτίστως να δοθεί έμφαση στο συμφέρον του τέκνου, ενώ εκφράζονται και ηθικές ανησυχίες ως προς την επίδραση του εν λόγω προτύπου οικογένειας στην ψυχική υγεία του τέκνου. \r\n\r\nΠηγή: <a href="http://www.bionews.org.uk/page_396795.asp?dinfo=RqF5ou7gdQttN9OUTwjl11OX&PPID=397105" target="blank">BioNews</a>', 'threeparent.jpeg', 2, 1, 1, '2014-05-25 17:56:18', '2014-05-25 17:56:18'),
(10, 'ΗΠΑ: Εντάσεις προκαλούν οι «νεκρές» ζώνες γύρω από τις κλινικές όπου πραγματοποιούνται διακοπές κύησης', 'Στο Ανώτατο Δικαστήριο των Ηνωμένων Πολιτειών της Αμερικής εξετάστηκε προσφυγή κατά ενός νόμου της Μασαχουσέτης, βάσει του οποίου δεν επιτρέπεται σε άτομα που αντιτίθενται στην πραγματοποίηση διακοπών της κύησης να διατυπώνουν τις απόψεις τους σε μια ακτίνα 35 ποδιών γύρω από τις κλινικές όπου πραγματοποιούνται οι συγκεκριμένες επεμβάσεις.', 'Ο νόμος εκδόθηκε προκειμένου να σταματήσει η χρήση βίας έξω από τις συγκεκριμένες κλινικές. Ήδη το 1994 δύο εργαζόμενοι σε αυτές είχαν σκοτωθεί από άτομα που αντιτίθενται στην διακοπή της κύησης, ενώ για πολλά χρόνια οι αρχές της Μασαχουσέτης αδυνατούσαν να θέσουν τέλος στην παρενόχληση και τη βία που ασκούνταν από τα άτομα αυτά εναντίον εκείνων που επιχειρούσαν να εισέλθουν στις κλινικές. \r\n\r\nΤο 2007 αποφασίστηκε τελικά να δημιουργηθεί με νόμο μια «νεκρή» ζώνη 35 ποδιών γύρω από τις κλινικές μέσα στην οποία δεν μπορούν πλέον οι ακτιβιστές να επεμβαίνουν προκειμένου να αποτρέψουν την είσοδο ατόμων που θέλουν να υποβληθούν σε διακοπή της κύησης ή να βοηθήσουν στην πραγματοποίησή της. \r\n\r\nΟι ακτιβιστές ισχυρίστηκαν ότι ο νόμος προσβάλλει το δικαίωμά τους στην ελευθερία του λόγου και το θέμα κρίθηκε από το Ανώτατο Δικαστήριο των Ηνωμένων Πολιτειών στα μέσα Ιανουαρίου.\r\n\r\nΠηγή: USA TODAY, 17.1.2014, p. 9A.', NULL, 2, 1, 0, '2014-05-25 17:56:18', '2014-05-25 17:56:18'),
(11, 'Βέλγιο: Νομιμοποίηση της ευθανασίας σε ανηλίκους', 'Το Βέλγιο έγινε από τις 13 Φεβρουαρίου 2014 η πρώτη χώρα στον κόσμο που επιτρέπει την ευθανασία σε ανηλίκους οι οποίοι πάσχουν από ανίατη νόσο σε τελικό στάδιο, αίροντας κάθε περιορισμό ηλικίας. Μετά την έγκριση από τη βελγική Σύγκλητο, το νομοσχέδιο υιοθετήθηκε και από τη Βουλή των Αντιπροσώπων, με ψήφους 86 υπέρ, 44 κατά και 12 αποχές.', 'Με βάση τον νέο νόμο, η ευθανασία επιτρέπεται σε κάθε ανήλικο ασθενή υπό τις ακόλουθες προϋποθέσεις: ο ανήλικος θα πρέπει να πάσχει από ανίατη ασθένεια ικανή να προκαλέσει το θάνατο σε σύντομο χρονικό διάστημα, να υποφέρει από διαρκείς και αφόρητους σωματικούς πόνους, που οφείλονται είτε σε πολύ σοβαρό τραυματισμό, είτε σε ανίατη παθολογική κατάσταση και να μην μπορεί η κατάστασή του να αντιμετωπιστεί με άλλο τρόπο.\r\n\r\nΟ ανήλικος θα πρέπει να έχει την ικανότητα της διάκρισης και να έχει συνείδηση κατά τη στιγμή που εκφράζει τη βούληση να διακοπεί τεχνητά η ζωή του. Η εκτίμηση αυτής της ικανότητας γίνεται κατά περίπτωση από την ιατρική ομάδα και έναν ψυχίατρο ή έναν ανεξάρτητο ψυχολόγο. Τέλος, η πρωτοβουλία του αιτήματος πρέπει να προέρχεται από τον ίδιο τον ανήλικο, ενώ οι γονείς καλούνται να δώσουν τη συναίνεσή τους. Δεν γίνεται καμία αναφορά σε περιπτώσεις ψυχικά ασθενών ανηλίκων.\r\n\r\nΚατά τη διεξαγωγή του δημοσίου διαλόγου για τις επίμαχες διατάξεις, οι πολέμιοι του νόμου εξέφρασαν τον φόβο ότι η εξέλιξη αυτή οδηγεί αναπόφευκτα στη μαζικοποίηση των αιτημάτων ευθανασίας από ανήλικους ασθενείς. Ο σοσιαλιστής γερουσιαστής Philippe Mahoux, που συγκαταλέγεται μεταξύ των συντακτών του νόμου του 2002 για τη νομιμοποίηση της ευθανασίας σε ενήλικες και χειραφετημένους ανηλίκους (άνω το 15 ετών και υπό συγκεκριμένες προϋποθέσεις), θεωρεί ότι «ήταν αναγκαίο να βρεθεί μια λύση απέναντι στις εκκλήσεις των παιδιάτρων και νοσηλευτών που βρίσκονταν καθημερινά αντιμέτωποι με παιδιά που έπασχαν από αφόρητους σωματικούς πόνους και για τα οποία δεν μπορούσαν να κάνουν τίποτα», ενώ η Φλαμανδή βουλευτής Sonja Becq διερωτάται «εάν είναι πράγματι δυνατό ένα παιδί των επτά, οχτώ ή εννιά ετών, να εκφράσει ένα απόλυτα αυτόνομο αίτημα ευθανασίας». «Ένα μωρό προφανώς και δεν έχει καμία δυνατότητα διάκρισης. Ούτε κι ένα παιδί. Όσο για τους εφήβους, ακόμα και οι ειδικοί ψυχίατροι λένε πως είναι δύσκολο, αφού πολλές φορές δεν συνειδητοποιούν πως ο θάνατος σημαίνει ότι δεν μπορούν να γυρίσουν πίσω», τονίζει η εκπρόσωπος των Χριστιανοδημοκρατών Catherine Fonck.\r\n\r\nΠηγή: <a href="http://www.lefigaro.fr/actualite-france/2014/02/13/01016-20140213ARTFIG00343-la-belgique-vote-pour-elargir-l-euthanasie-aux-mineurs.php?pagination=11" target="blank">Le Figaro</a>', NULL, 2, 1, 0, '2014-05-25 17:56:18', '2014-05-25 17:56:18'),
(12, 'Σουηδία: Εναλλακτική πηγή εμβρυϊκών βλαστοκυττάρων', 'H ερευνητική ομάδα των καθηγητών Κ. Tryggvason και O. Hovatta, ανέπτυξε μια νέα μέθοδο, με την οποία είναι δυνατόν να χρησιμοποιηθεί ένα από τα οκτώ κύτταρα ενός γονιμοποιημένου ωαρίου για την παραγωγή εμβρυϊκών βλαστοκυττάρων, ενώ στη συνέχεια, το γονιμοποιημένο ωάριο μπορεί να καταψυχθεί και, θεωρητικά, να εμφυτευθεί στη μήτρα της γυναίκας.', 'Μέχρι σήμερα, τα βλαστοκύτταρα παράγονται από γονιμοποιημένα ωάρια που έχουν περισσεύσει στο πλαίσιο διαδικασίας εξωσωματικής γονιμοποίησης, τα οποία και δεν μπορούν στη συνέχεια να εμφυτευθούν. Το πλεονέκτημα της νέας μεθόδου είναι ότι επιτρέπει τη δημιουργία βλαστοκυττάρων από γονιμοποιημένα ωάρια, χωρίς να επηρεάζεται η βιωσιμότητα των τελευταίων, δυνατότητα που θεωρείται σημαντική για χώρες οι οποίες δεν επιτρέπουν τη χρήση περισσευούμενου γεννητικού υλικού για παραγωγή βλαστοκυττάρων.\r\n\r\nΠηγή: <a href="http://phys.org/news/2014-01-method-embryonic-stem-cells.html" target="blank">Phys.org</a>', NULL, 2, 1, 0, '2014-05-25 17:56:18', '2014-05-25 17:56:18');

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
-- Table structure for table `links`
--

CREATE TABLE IF NOT EXISTS `links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cat_id` int(11) NOT NULL,
  `header` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `prepend_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `link_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `link_label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `append_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_group` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cat_id` (`cat_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=232 ;

--
-- Dumping data for table `links`
--

INSERT INTO `links` (`id`, `cat_id`, `header`, `prepend_text`, `link_url`, `link_label`, `append_text`, `is_group`) VALUES
(1, 3, 'ΥΠΕΡΕΘΝΙΚΕΣ και ΔΙΕΘΝΕΙΣ', '', 'http://ec.europa.eu/bepa/european-group-ethics/index_en.htm', 'Ευρωπαϊκή Ένωση: European Group on Ethics', '', 0),
(2, 3, '', '', 'http://www.comstech.org/', 'Ισλαμική Διάσκεψη: Standing Committee on Scientific and Technological Cooperation', '', 0),
(3, 7, '', '', 'http://www.academyofathens.gr/', 'Ακαδημία Αθηνών', '', 0),
(4, 6, '', '', 'http://www.presidency.gr/', 'Προεδρία της Δημοκρατίας', '', 0),
(5, 6, '', '', 'http://www.primeminister.gov.gr/', 'Πρωθυπουργός', '', 0),
(6, 6, '', '', 'http://www.parliament.gr/', 'Βουλή των Ελλήνων', '', 0),
(7, 6, '', '', 'http://www.ggk.gr/', 'Γενική Γραμματεία της Κυβέρνησης', '', 0),
(8, 6, '', '', 'http://www.dpa.gr/portal/page?_pageid=33,15048&amp;_dad=portal&amp;_schema=PORTAL', 'Αρχή Προστασίας Δεδομένων Προσωπικού Χαρακτήρα', '', 0),
(13, 6, '', '', 'http://et.diavgeia.gov.gr/f/22960', 'Εθνικό Συμβούλιο Ραδιοτηλεόρασης', '', 0),
(14, 6, '', '', 'http://www.iya.gr/', 'Εθνική Αρχή για την Ιατρικώς Υποβοηθούμενη Αναπαραγωγή', '', 0),
(15, 6, '', '', 'http://www.nchr.gr/', 'Εθνική Επιτροπή για τα Δικαιώματα του Ανθρώπου', '', 0),
(16, 6, '', '', 'http://www.gsrt.gr/central.aspx?sId=119I428I1089I646I488772', 'Επιτροπή Βιοηθικής της Γενικής Γραμματείας Έρευνας &amp; Τεχνολογίας/Υπ. Ανάπτυξης', '', 0),
(17, 6, '', '', 'http://www.eom.gr/', 'Εθνικός Οργανισμός Μεταμοσχεύσεων (Ε.Ο.Μ.)', '', 0),
(18, 6, '', '', 'http://www.eof.gr/web/guest;jsessionid=63f1515aed8100a0f60ba03a0030', 'Εθνικός Οργανισμός Φαρμάκων (Ε.Ο.Φ.)', '', 0),
(19, 6, '', '', 'http://www.ekdd.gr/ekdda/index.php/gr', 'Εθνική Σχολή  Δημόσιας Διοίκησης', '', 0),
(20, 6, '', '', 'http://www.nsph.gr/default.aspx?page=home', 'Εθνική Σχολή Δημόσιας Υγείας', '', 0),
(21, 6, '', '', 'http://www.ekt.gr/', 'Εθνικό Κέντρο Τεκμηρίωσης', '', 0),
(22, 6, '', '', 'http://www.keelpno.gr/', 'Κέντρο Ελέγχου Ειδικών Λοιμώξεων', '', 0),
(23, 6, '', '', 'http://www.synigoros.gr/', 'O Συνήγορος του Πολίτη', '', 0),
(24, 6, '', '', 'http://www.synigoroskatanaloti.gr/', 'Συνήγορος του Καταναλωτή', '', 0),
(25, 6, '', '', 'http://www.moh.gov.gr/', 'Υπουργείο Υγείας και Κοινωνικής Αλληλεγγύης', '', 0),
(26, 6, '', '', 'http://www.minagric.gr/index.php/el/', 'Υπουργείο Αγροτικής Ανάπτυξης', '', 0),
(27, 6, '', '', 'http://www.ypeka.gr/', 'Υπουργείο Περιβάλλοντος, Χωροταξίας και Δημοσίων Έργων', '', 0),
(29, 7, '', '', 'http://www.fleming.gr/', '«Αλέξανδρος Φλέμινγκ»-Ερευνητικό Κέντρο Βιοϊατρικών Επιστημών', '', 0),
(30, 7, '', '', 'http://bioethics.web.auth.gr/index.php?id=2', 'Δίκτυο «Σύγχρονη Ιατρική Πράξη, Βιοιατρική και Δίκαιο», Α.Π.Θ.', '', 0),
(31, 7, '', '', 'http://www.certh.gr/', 'Εθνικό Κέντρο Έρευνας και Τεχνολογικής Ανάπτυξης (Ε.Κ.Ε.Τ.Α.)', '', 0),
(32, 7, '', '', 'http://www.eie.gr/', 'Εθνικό Ίδρυμα Ερευνών', '', 0),
(33, 7, '', '', 'http://www.nagref.gr/', 'Ε.Θ.Ι.Α.Γ.Ε.', '', 0),
(34, 7, '', '', 'http://www.demokritos.gr/', 'Ε.Κ.Ε.Φ.Ε. ΔΗΜΟΚΡΙΤΟΣ', '', 0),
(35, 7, '', '', 'http://www.bioacademy.gr/', 'Ίδρυμα Ιατροβιολογικών Ερευνών της Ακαδημίας Αθηνών', '', 0),
(37, 8, '', '', 'http://www.bioethics.org.gr/', 'Επιτροπή Βιοηθικής της Εκκλησίας της Ελλάδος', '', 0),
(38, 8, '', '', 'http://www.icu.gr/', 'Ελληνική Εταιρία Εντατικής Θεραπείας', '', 0),
(39, 8, '', '', 'http://www.eae.gr/new2/index.asp', 'Ελληνική Αιματολογική Εταιρία', '', 0),
(40, 8, '', '', 'http://www.hsog.gr/', 'Ελληνική Μαιευτική και Γυναικολογική Εταιρία', '', 0),
(41, 8, '', '', 'http://www.parents.gr/forum/showthread.php?t=81149', 'Ελληνική Εταιρεία Ψυχικής Υγείας στην Υποβοηθούμενη Αναπαραγωγή', '', 0),
(42, 8, '', '', 'http://www.nuclear-medicine.gr/', 'Ελληνική Εταιρία Πυρηνικής Ιατρικής &amp; Βιολογίας', '', 0),
(43, 8, '', '', 'http://www.psych.gr/', 'Eλληνική Ψυχιατρική Εταιρία', '', 0),
(44, 8, '', '', 'http://www.isathens.gr/', 'Ιατρικός Σύλλογος Αθηνών', '', 0),
(45, 8, '', '', 'http://www.mednet.gr/', 'Ιατρική Εταιρία Αθηνών', '', 0),
(46, 8, '', '', 'http://www.eugenfound.edu.gr/frontoffice/portal.asp?cpage=NODE&amp;cnode=1', 'Ίδρυμα Ευγενίδου', '', 0),
(47, 8, '', '', 'http://www.ich.gr/en/', 'Ινστιτούτο Υγείας Παιδιού', '', 0),
(48, 8, '', '', 'http://www.newinka.gr/', 'Ινστιτούτο Καταναλωτή', '', 0),
(49, 8, '', '', 'http://www.nomosphysis.org.gr/', 'NOMOΣ + ΦΥΣΗ', '', 0),
(50, 8, '', '', 'http://www.pis.gr/', 'Πανελλήνιος Ιατρικός Σύλλογος', '', 0),
(51, 8, '', '', 'http://www.sige.gr/newgr/', 'Σύνδεσμος Ιατρικών Γενετιστών Ελλάδος', '', 0),
(52, 9, '', '', 'http://www.mdmgreece.gr/', 'Γιατροί του Κόσμου', '', 0),
(53, 9, '', '', 'http://www.msf.gr/', 'Γιατροί Χωρίς Σύνορα', '', 0),
(54, 9, '', '', 'http://www.hlhr.gr/', 'Ελληνική Ένωση για τα Δικαιώματα του Ανθρώπου ', '', 0),
(55, 9, '', '', 'http://www.redcross.gr/', 'Ελληνικός Ερυθρός Σταυρός', '', 0),
(56, 9, '', '', 'http://www.mfhr.gr/', 'Ίδρυμα Μαραγκοπούλου για τα Δικαιώματα του Ανθρώπου', '', 0),
(57, 9, '', '', 'http://www.kostakismesogitis.gr/', 'Σύνδεσμος Αιμοδοτών-Δωρητών Οργάνων Σώματος &amp; Μέριμνας Υγείας ΚΩΣΤΑΚΗΣ ΜΕΣΟΓΙΤΗΣ', '', 0),
(58, 9, '', '', 'http://www.kethi.gr/', 'Σύνδεσμος για τα Δικαιώματα της Γυναίκας ', '', 0),
(59, 9, '', '', 'http://actupathens.blogspot.gr/', 'ACT UP-Δράσε Hellas', '', 0),
(60, 9, '', '', 'http://www.etcgroup.org/', 'Action Group on Erosion Technology and Concentration', '', 0),
(61, 9, '', '', 'http://www.councilforresponsiblegenetics.org/', 'Council for Responsible Genetics', '', 0),
(62, 9, '', '', 'http://www.genet-info.org/', 'European NGO Network on Genetic Engineering', '', 0),
(63, 9, '', '', 'http://www.genewatch.org/', 'GeneWatch UK', '', 0),
(64, 9, '', '', 'http://www.grain.org/', 'GRAIN', '', 0),
(65, 9, '', '', 'http://www.greenpeace.org/greece/el/', 'Greenpeace, Hellas', '', 0),
(66, 9, '', '', 'http://www.hgalert.org/', 'Human Genetics Alert', '', 0),
(67, 9, '', '', 'http://www.ipcb.org/', 'Indigenous Peoples Council on Biocolonialism', '', 0),
(68, 9, '', '', 'http://www.parentsguidecordblood.org/', 'Parent''s Guide to Cord Blood Foundation', '', 0),
(69, 9, '', '', 'http://www.i-sis.org.uk/index.php', 'The Institute of Science in Society', '', 0),
(70, 9, '', '', 'http://www.wwf.gr/el/', 'WWF', '', 0),
(71, 10, 'Πύλες', '', 'http://www.bioethics-today.org/', 'Bioethics Today', '', 0),
(72, 10, '', '', 'http://www.bioethics.net/', 'Bioethics Web', '', 0),
(73, 10, '', '', 'http://www.lawgenecentre.org/', 'Center for Law and Genetics', '', 0),
(74, 10, '', '', 'http://www.ethicsweb.ca/', 'Ethics Web', '', 0),
(75, 10, '', '', 'http://genethics.ca/', 'Genethics', '', 0),
(76, 10, 'Βάσεις Δεδομένων', '', 'http://www.eric-on-line.co.uk/index.php', 'Ethics Research Information Catalogue ', '', 0),
(77, 10, '', '', 'http://www.phgfoundation.org/', 'Genetics Policy Database at PHGU', '', 0),
(78, 10, '', '', 'http://www.humgen.umontreal.ca/home', 'HumGen', '', 0),
(79, 10, '', '', 'https://europa.eu/sinapse/sinapse/index.cfm?', 'Sinapse', '', 0),
(80, 11, 'Βιοηθική', '', 'http://onlinelibrary.wiley.com/journal/10.1111/(ISSN)1467-8519', 'Bioethics', '', 0),
(81, 11, '', '', 'http://www.aslme.org/Back_Issues_And_Articles?journal=JLME', 'Journal of Law, Medicine and Ethics', '', 0),
(83, 11, '', '', 'http://jme.bmj.com/', 'Journal of Medical Ethics', '', 0),
(84, 11, '', '', 'http://bioethicsreview.uoc.gr/index.html', 'Review of Bioethics', '', 0),
(85, 11, '', '', 'http://www.tandfonline.com/toc/uajb20/current#.U2ond_kyZ4Q', 'The American Journal of Bioethics', '', 0),
(86, 11, 'Γενικά', '', 'http://www.bmj.com/', 'British Medical Journal', '', 0),
(87, 11, '', '', 'http://www.hss.ed.ac.uk/', 'Genomics, Society and Policy', '', 0),
(88, 11, '', '', 'http://www.nature.com/nature/index.html', 'Nature', '', 0),
(89, 11, '', '', 'http://www.tandfonline.com/toc/cngs20/current#.U2ooFfkyZ4Q', 'New Genetics and Society', '', 0),
(90, 11, '', '', 'http://www.sciencemag.org/', 'Science', '', 0),
(91, 11, '', '', 'http://www.thelancet.com/journals/lancet/issue/current', 'The Lancet', '', 0),
(92, 11, '', '', 'http://www.press.uchicago.edu/journals.html', 'The American Journal of Human Genetics ', '', 0),
(93, 11, '', '', 'http://jama.jamanetwork.com/journal.aspx', 'The Journal of the American Medical Association ', '', 0),
(94, 11, '', '', 'https://www.mja.com.au/', 'The Medical Journal of Australia', '', 0),
(95, 11, '', '', 'http://www.nejm.org/', 'The New England Journal of Medicine', '', 0),
(96, 3, '', '', 'http://www.coe.int/T/DG3/Healthbioethic/cdbi/default_en.asp', 'Συμβούλιο της Ευρώπης, Committee on Bioethics (DH-BIO)', '', 0),
(97, 3, '', '', 'http://www.unesco.org/new/en/social-and-human-sciences/themes/bioethics/', 'ΟΥΝΕΣΚΟ', '', 0),
(98, 3, 'A', 'ALBANIA: Albanian Committee of Bioethics', '', '', '', 0),
(99, 3, '', 'ALGERIA: Conseil National de l’ Ethique des Sciences et de la Santé', '', '', '', 0),
(100, 3, '', 'ARGENTINA: National Committee of Ethics in Science and Technology (CECTE)', '', '', '', 0),
(101, 3, '', 'AUSTRALIA:', 'http://www.nhmrc.gov.au/health-ethics', 'Australian Health Ethics Committee (AHEC)', '', 0),
(102, 3, '', 'AUSTRIA: ', 'http://www.bka.gv.at/site/3575/default.aspx', 'Austrian Commission on Bioethics', '', 0),
(103, 3, 'B', 'BELARUS: National Bioethics Commitee of the Republic of Belarus', '', '', '', 0),
(104, 3, '', 'BELGIUM: ', 'http://www.health.belgium.be/', 'Belgian Advisory Committee on Bioethics', '', 0),
(105, 3, '', 'BENIN: ', 'http://www.ethique-sante.org/', 'Comite National Provisoire d''Ethique pour la Recherche en Sante', '', 0),
(106, 3, '', 'BOLIVIA: The National Ethics and Bioethics Steering Committee, Bolivian Academy of Medicine', '', '', '', 0),
(107, 3, '', 'BRAZIL: ', 'http://www.conselho.saude.gov.br/Web_comissoes/conep/index.html', 'National Bioethics Commission of Brazil', '', 0),
(108, 3, '', 'BULGARIA: ', 'http://www.bio-ethics.net/en', 'Bulgarian Center for Bioethics', '', 0),
(109, 3, 'C', 'CANADA:', 'http://www.bioethics.ca/', 'Commission de l''ethique de la Science et de la technologie', '', 1),
(110, 3, '', '', 'http://www.ncehr-cnerh.org/', 'National Council on Ethics in Human Research', '', 1),
(111, 3, '', 'COREA : ', 'http://www.koreabioethics.net/', 'The Korean Bioethics Association', '', 0),
(112, 3, '', 'COTE D’ IVOIRE: Comité Consultatif National de Bioéthique de la Republique de Côte d’ lvoire', '', '', '', 0),
(113, 3, '', 'CUBA: Cuban National Commission for Bioethics', '', '', '', 0),
(114, 3, '', 'CYPRUS: ', 'http://www.bioethics.gov.cy/Law/cnbc/cnbc.nsf/DMLindex_gr/DMLindex_gr?OpenDocument', ' Εθνική Επιτροπή Βιοηθικής Κύπρου', '', 0),
(115, 3, '', 'CZECH REPUBLIC: ', 'http://www.vyzkum.cz/Default.aspx?lang=en', 'Bioethical Commission of the Research and Development Council', '', 0),
(116, 3, 'D', 'DENMARK: ', 'http://www.etiskraad.dk/', 'Danish Council of Ethics', '', 0),
(117, 3, '', 'DOMINICAN REPUBLIC: Comisión National de Bioética', '', '', '', 0),
(118, 3, 'E', 'ECUADOR: Comité National de Bioética del Ecuador', '', '', '', 0),
(119, 3, '', 'EGYPT: ', 'http://www.egnatcom.org.eg', 'Egyptian National Commission for Education,Culture and Science', '', 0),
(120, 3, '', 'ETHIOPIA: National Ethical Clearance Committee, NECC', '', '', '', 0),
(121, 3, '', 'ESTONIA: ', 'http://www.eetikakeskus.ut.ee/en/estonian-council-bioethics-0', 'The Estonian Council on Bioethics', '', 0),
(122, 3, 'F', 'FINLAND:', 'http://www.etene.fi/en/about_us?textsize=4', ' National Advisory Board on Health Care Ethics (ETENE), Ministry of Social Affairs and Health', '', 1),
(123, 3, '', '', 'http://www.tenk.fi/', 'National Advisory Board on Research Ethics', '', 1),
(124, 3, '', 'FRANCE: ', 'http://www.ccne-ethique.fr/', 'Comite Consultatif National d’Ethique (CCNE)', '', 0),
(125, 3, 'G', 'GAMBIA : Gambia Government/MRC Ethics Committee', '', '', '', 0),
(126, 3, '', 'GEORGIA: National Bioethics Council of Georgia, NBCG', '', '', '', 0),
(127, 3, '', 'GERMANY:', 'http://www.ethikrat.org/welcome?set_language=en', 'German Ethics Council', '', 0),
(128, 3, '', 'GREECE: ', 'http://www.bioethics.gr/index.php?category_id=2', 'Εθνική Επιτροπή Βιοηθικής', '', 0),
(129, 3, 'H', 'HUNGARY: The Hungarian Medical Research Council, Scientific and Research Ethics Committee', '', '', '', 0),
(130, 3, 'I', 'ICELAND: ', 'http://www.visindasidanefnd.is/', 'The National Bioethics Committee', '', 0),
(131, 3, '', 'INDIA: ', 'http://www.icmr.nic.in/', 'Indian Council of Medical Research', '', 0),
(132, 3, '', 'INDONESIA: ', 'http://abc-9th.blogspot.gr/', 'Indonesian National Bioethics Commission ', '', 0),
(133, 3, '', 'IRAN: Committee of Bioethics, National Committee for Ethics in Science and Technology', '', '', '', 0),
(134, 3, '', 'IRELAND: ', 'http://www.dohc.ie/issues/nacb/', 'National Advisory Committee on Bioethics (IRELAND) ', '', 0),
(135, 3, '', 'ISRAEL: ', 'http://www.academy.ac.il/', 'Bioethics Advisory Committee of the Israel Academy of Science &amp; Technology', '', 0),
(136, 3, '', 'ITALY: ', 'http://www.palazzochigi.it/bioetica/eng/index.html', 'Italian National Bioethics Committee', '', 0),
(137, 3, 'J', 'JAPAN: ', 'http://www.mext.go.jp/english/', 'Bioethics Committee. Council for Science and Technology', '', 0),
(138, 3, 'L', 'LATVIA: Latvian Central Medical Ethics Committee', '', '', '', 0),
(139, 3, '', 'LITHUANIA: ', 'http://bioetika.sam.lt/', 'Lithuanian Bioethics Committee', '', 0),
(140, 3, '', 'LUXEMBOURG: ', 'http://www.cne.public.lu/', 'CNE – Commission Nationale d’Ethique', '', 0),
(141, 3, 'M', 'MALTA: ', 'http://www.gov.mt/en/Government/DOI/Pages/Department-of-Information.aspx/en/bodies/committees/bioethics.asp', 'Bioethics Consultative Committee', '', 0),
(142, 3, '', 'MEXICO: ', 'http://www.conbioetica-mexico.salud.gob.mx/interior/ingles/ingles.html', 'Comision Nacional de Bioetica (National Commission of Bioethics) ', '', 0),
(143, 3, 'N', 'NEW-ZEALAND: ', 'http://ethics.health.govt.nz/', 'New Zealand Ethics Committees', '', 0),
(144, 3, '', 'NORWAY: ', 'https://www.etikkom.no/en/In-English/', 'Forskningsetiske komiteer-Norwegian,  National Committee for Medical Research Ethics', '', 0),
(145, 3, '', 'NORDIC COUNTRIES: ', 'http://ncbio.org/nordisk/', 'Nordic Committee on Bioethics', '', 0),
(146, 3, 'P', 'POLAND: ', 'http://www.kb.mz.gov.pl/', 'Bioethics Appeals Commission', '', 0),
(147, 3, '', 'PORTUGAL: ', 'http://www.cnecv.pt/?locale=en', 'Conselho Nacional de Etica par as Ciencias da Vida, National Council of Ethics for the Life Sciences', '', 0),
(148, 3, '', 'PHILIPPINES: ', 'http://www.pchrd.dost.gov.ph/', 'Philippine Council for Health Research and Development', '', 0),
(149, 3, 'R', 'ROMANIA: ', 'http://www.cnr-unesco.ro/ro/index.php', 'The National Research Ethics Council', '', 0),
(150, 3, '', 'RUSSIA (Russian Federation): ', 'http://www.bioethics.ru/eng/', 'Bioethical Forum', '', 0),
(151, 3, 'S', 'SINGAPORE: Bioethics Advisory Committee (BAC)', '', '', '', 0),
(152, 3, '', 'SLOVAKIA: ', 'http://www.health.gov.sk/Titulka', 'Central Ethics Committee of the Ministry of Health', '', 0),
(153, 3, '', 'SLOVENIA: ', 'http://www.kme-nmec.si/', 'National Medical Ethics Committee (KME / NMEC)', '', 0),
(154, 3, '', 'SPAIN: ', 'http://www.comitedebioetica.es/?lang=en_US', 'Spanish Bioethics Committee', '', 0),
(155, 3, '', 'SWEDEN: ', 'http://www.smer.se/Bazment/2.aspx', 'The Swedish National Council on Medical Ethics (SMER)', '', 0),
(156, 3, '', 'SWITZERLAND:', 'http://www.ekah.admin.ch/en/index.html', 'Federal Ethics Committee on Non-Human Biotechnology ECNH', '', 1),
(157, 3, '', '', 'http://www.samw.ch/de/Aktuell/News.html', 'The Central Ethics Committee of the Swiss Academy of Medical Science', '', 1),
(158, 3, '', '', 'http://www.bag.admin.ch/nek-cne/index.html?lang=en', 'Swiss National Advisory Commission on Biomedical Ethics', '', 1),
(159, 3, 'T', 'TAIWAN: ', 'http://www.most.gov.tw/', 'National Science Council', '', 0),
(160, 3, '', 'THE NETHERLANDS: ', 'http://www.gezondheidsraad.nl/en', 'The Health Council of the Netherlands', '', 0),
(161, 3, '', 'TURKEY: Bioethics Committee - UNESCO', '', '', '', 0),
(162, 3, 'U', 'UNITED KINGDOM:', 'http://www.nuffieldbioethics.org/', 'Nuffield Council on Bioethics', '', 1),
(163, 3, '', '', 'http://www.hgc.gov.uk/', 'Human Genetics Commission', '', 1),
(164, 3, '', '', 'http://www.schb.org.uk/', 'Scottish Council on Human Bioethics', '', 1),
(165, 3, '', 'UNITED STATES OF AMERICA: ', 'http://www.bioethics.gov/', 'The Presidential Commission for the Study of Bioethical Issues', '', 0),
(166, 4, 'ΕΥΡΩΠΗ', '', 'http://law-constitution.web.auth.gr/bio-mel/dpms/', 'Διεπιστημονικό Δίκτυο: ΣΥΓΧΡΟΝΗ ΙΑΤΡΙΚΗ ΠΡΑΞΗ, ΒΙΟΪΑΤΡΙΚΗ ΚΑΙ ΔΙΚΑΙΟ', '- Αριστοτέλειο Πανεπιστήμιο Θεσσαλονίκης, Ελλάδα', 0),
(167, 4, '', '', 'http://bioethics.fks.uoc.gr/', 'ΠΜΣ Βιοηθικής', '- Πανεπιστήμιο Κρήτης,  Ελλάδα', 0),
(168, 4, '', '', 'https://med.kuleuven.be/nl/eng/erasmus-mundus-bioethics', 'Erasmus Mundus Master of Bioethics', '- Univerisity of Leuven, Βέλγιο', 0),
(169, 4, '', '', 'http://www.u-psud.fr/fr/les_formations/les_formations_par_diplome/masters/ethique_sciences_sante_societe.html', 'Master Ethique, Science, Sante &amp; Societe ', '- Universite Paris Sud II, Γαλλία', 0),
(170, 4, '', '', 'http://www.shef.ac.uk/law/prospective/pgt/pgprogrammes/biotech', 'Master in Biotechnological Law and Ethics', '- The University of Sheffield, Αγγλία', 0),
(171, 4, '', '', 'http://www.uu.nl/EN/faculties/Pages/default.aspx', 'Master in Applied Ethics', '- Utrecht University, Ολλανδία', 0),
(172, 4, '', '', 'http://www.uniroma1.it/didattica/master/bioetica-clinica-applicata', 'Bioetica Clinica Applicata', '- Univeristy of Rome, La Sapienza, Corsi Master,  Ιταλία', 0),
(173, 4, '', '', 'http://www.di-uni.de/index.php?id=90', 'LL.M Medizinrecht', '- Dresden International University, Γερμανία', 0),
(174, 4, '', '', 'http://imr.duslaw.de/llm-medizinrecht.html', 'LL.M Medizinrecht', '- Universitat Dusseldorf, Γερμανία', 0),
(175, 4, '', '', 'http://www.uni-muenster-llm.de/medizinrecht.html', 'LL.M. Medizinrecht', '- Universitat Munster, Γερμανία', 0),
(176, 4, '', '', 'http://web.upcomillas.es/eng/estudios/estu_mast_bio.aspx?idIdioma=ENG', 'Master in Bioethics', '- Universidad Pontificia Comillas, Ισπανία', 0),
(177, 4, '', '', 'http://www.liu.se/ikk/cte/master-in-applied-ethics?l=en', 'Master in Applied Ethics', '- Linkoping University, Σουηδία', 0),
(178, 4, 'ΑΜΕΡΙΚΗ', '', 'http://clinicalbioethics.georgetown.edu/', 'Joint doctor of Medicine and Masters Program', '- Georgetown University, Center for Clinical Bioethics', 0),
(179, 4, '', '', 'http://www.ahc.umn.edu/bioethics/education/gradprogram/home.html', 'M.A. Program in Bioethics', '- University of Minnesota, Centre for Bioethics', 0),
(180, 4, '', '', 'http://medicalethics.med.upenn.edu/education/master-of-bioethics-mbe', 'Master of Bioethics', '- University of Pennsylvania, Center for Bioethics', 0),
(181, 4, '', '', 'http://medicalethics.med.upenn.edu/education/ms-in-medical-ethics-msme', 'Master of Science in Medical Ethics', '- University of Pennsylvania, Center for Bioethics', 0),
(182, 4, '', '', 'http://ce.columbia.edu/Bioethics', 'Master of Science in Bioethics', '- Columbia University', 0),
(183, 4, '', '', 'http://www.einstein.yu.edu/education/bioethics/', 'M.Sc in Bioethics', '- Yeshiva University, Albert Einstein College of Medicine', 0),
(184, 4, '', '', 'http://reg.msu.edu/academicprograms/ProgramDetail.asp?Program=2834&amp;PType=DP', 'Master of Arts in Bioethics', '- Michigan State University, Humanities and Society', 0),
(185, 4, '', '', 'http://louisville.edu/bioethics/masters-program', 'Interdisciplinary Master of Arts in Bioethics and Medical Humanities', '- University of Louisville', 0),
(186, 4, '', '', 'http://slu.edu/x56184.xml', 'LLM in Health Law', '- Saint-Louis University', 0),
(187, 4, '', '', 'http://www.law.uh.edu/llm/health.asp', 'LLM in Health Law', '- University of Houston, Health Law and Policy Institute', 0),
(188, 4, '', '', 'http://www.bioethics.pitt.edu/academic-programs/ma-bioethics.php', 'Interdisciplinary Master of Arts in Bioethics', '- University of Pittsburgh', 0),
(189, 4, '', '', 'http://graduate.tiu.edu/academics/programs/master-of-arts-in-bioethics/index.dot', 'Master in Bioethics', '- Trinity International University', 0),
(190, 4, '', '', 'http://bioethics.uniongraduatecollege.edu/program-research.aspx', 'Master with specialization in research Ethics', '- Union Graduate College, Mount Sinai School of Medicine', 0),
(191, 4, '', '', 'http://www.amc.edu/Academic/bioethics/educational_programs/graduate_programs/degrees_certificates/master_science_bioethics.cfm', 'Master of Science in Bioethics', '- Albany Medical College', 0),
(192, 4, 'ΚΑΝΑΔΑΣ', '', 'http://jointcentreforbioethics.ca/education/mhsc.shtml', 'Master of Health Science in Bioethics', '- University of Toronto - Joint Centre for Bioethics', 0),
(193, 4, '', '', 'http://www.bioethique.umontreal.ca/', 'Programmes de Bioethique', '- University of Montreal', 0),
(194, 4, 'ΑΣΙΑ', '', 'http://cbme.nus.edu.sg/edu_postgrad.html', 'Master in Bioethics', '- Nus University of Signapore, Center of Bioethics, Σιγκαπούρη', 0),
(195, 4, 'ΑΥΣΤΡΑΛΙΑ', '', 'http://www.monash.edu.au/study/coursefinder/course/0122/', 'Master οf Bioethics', '- Monash University, Αυστραλία', 0),
(196, 5, '', '', 'http://www.aem-online.de/', 'Academy for Ethics in Medicine (AEM)', ', Göttingen, Germany', 0),
(197, 5, '', '', 'http://www.bio-ethics.net/', 'Bulgarian Center for Bioethics', ', Sofia, Bulgaria', 0),
(198, 5, '', '', 'http://www.genomicsnetwork.ac.uk/cesagen/', 'Centre for Economic and Social aspects of Genomics', ', Lancaster and Cardiff, UK', 0),
(199, 5, '', '', 'http://www.cishe.cardiff.ac.uk/', 'Cardiff Institute of Society, Health and Ethics', ', Cardiff, UK', 0),
(200, 5, '', '', 'http://www.ccels.cardiff.ac.uk/', 'Cardiff Centre for Ethics, Law and Society', ', Cardiff, UK', 0),
(201, 5, '', '', 'http://www.ethics.ubc.ca/', 'W. Maurice Young Centre for Applied Ethics, University of British Columbia', ', Vancouver, BC, Canada', 0),
(202, 5, '', '', 'http://www.uni-muenster.de/Bioethik/', 'Centre for Bioethics (CfB)', ', Munster, Germany', 0),
(203, 5, '', '', 'http://cbhd.org/', 'Center for Bioethics and Human Dignity', ', Deerfield, IL, USA', 0),
(204, 5, '', '', 'http://www.ahc.umn.edu/bioethics/', 'Center for Bioethics, Univeristy of Minnesota', ', Minneapolis, MN, USA', 0),
(205, 5, '', '', 'http://gbiomed.kuleuven.be/english/research/50000687/50000697', 'Centre for Biomedical Ethics and Law (CBMER)', ', Leuven, Netherlands', 0),
(206, 5, '', '', 'http://www.eetikakeskus.ut.ee/et?eng=', 'Centre for Ethics, University of Tartu', ', Tartu, Estonia', 0),
(207, 5, '', '', 'http://www.ceu.hu/', 'Center for Ethics and Law in Biomedicine (CELAB)', ', Budapest, Hungary', 0),
(208, 5, '', '', 'http://www.ethiclaw.dk/', 'Center for Ethics and Law in Nature and Society', ', Copenhagen, Denmark', 0),
(209, 5, '', '', 'http://www.medizinethik-bochum.de/english/index.html', 'Center for Medical Ethics Bochum (ZME)', ', Bochum, Germany', 0),
(210, 5, '', '', 'http://www.dcu.ie/', 'DCU Institute of Ethics', ', Dublin, Ireland', 0),
(211, 5, '', '', 'http://www.uu.nl/faculty/humanities/NL/organisatie/departementen/dept-filosofie-en-religiewetenschap/EthiekInstituut/Pages/default.aspx', 'Ethiek instituut, Univeristy of Utrecht', ', Utrecht, Netherlands', 0),
(212, 5, '', '', 'http://www.ethox.org.uk/', 'Ethox Centre (ETHOX)', ', Oxford, UK', 0),
(213, 5, '', '', 'http://www.drze.de/', 'German Reference Centre for Ethics in the Life Sciences (DRZE)', ', Bonn, Germany', 0),
(214, 5, '', '', 'http://www.ruhr-uni-bochum.de/malakow/index.htm', 'Institute for Medical Ethics and History of Medicine', ', Ruhr-University Bochum, Bochum, Germany', 0),
(215, 5, '', '', 'http://www.nottingham.ac.uk/iss/index.aspx', 'Institute for Science and Society, University of Nottingham', ', Nottingham, UK', 0),
(216, 5, '', '', 'http://www.ierm.at/', 'Institut fuer Ethik und Recht in der Medizin - Universitaet Wien', ', Vienna, Austria', 0),
(217, 5, '', '', 'http://www.imew.de/', 'Institute Human, Ethics and Science (IMEW)', ', Berlin, Germany', 0),
(218, 5, '', '', 'http://www.fcs.es/', 'Institute of Bioethics at the Foundation for Health Sciences', ', Madrid, Spain', 0),
(219, 5, '', '', 'http://www.ethik.uzh.ch/ibme_en.html', 'Institute of Biomedical Ethics (IBME)', ', Zurich, Switzerland', 0),
(220, 5, '', '', 'http://www.iwe.uni-bonn.de/', 'Institute of Science and Ethics (IWE)', ', Bonn, Germany', 0),
(221, 5, '', '', 'http://www.uni-ulm.de/med/institut-fuer-geschichte-theorie-und-ethik-der-medizin.html', 'Institute of the History, Philosophy and Ethics of Medicine', ', Ulm, Germany', 0),
(222, 5, '', '', 'http://www.yale.edu/bioethics/', 'Interdisciplinary Center for Bioethics, Yale University', ', New Haven, CT, USA', 0),
(223, 5, '', '', 'http://www.mer.uni-halle.de/', 'Interdsiciplinary Center of Medicine-Ethics-Law at Martin-Luther-University Halle-Wittenberg', ', Halle (Saale), Germany', 0),
(224, 5, '', '', 'http://crib.ulb.ac.be/', 'Interdisciplinary Research Centre of Bioethics (CRIB)', ', Bruxelles, Belgium', 0),
(225, 5, '', '', 'http://jointcentreforbioethics.ca/', 'Joint Center for Bioethics, Univeristy of Toronto', ', Toronto, Canada', 0),
(226, 5, '', '', 'http://www.nuffieldbioethics.org/', 'Nuffield Council on Bioethics', ', London, UK', 0),
(227, 5, '', '', 'http://www.sheffield.ac.uk/law/research/clusters/sible', 'Sheffield Institute for Biotechnological Law and Ethics (SIBLE)', ', Sheffield, UK', 0),
(228, 5, '', '', 'http://www.thehastingscenter.org/', 'The Hastings Center', ', Washington, DC, USA ', 0),
(229, 5, '', '', 'https://kennedyinstitute.georgetown.edu/', 'The Kennedy Institute of Ethics, Georgetown University', ', Washington, DC, USA', 0),
(230, 5, '', '', 'http://www.ethik.uzh.ch/index_en.html', 'The Zurich University Centre for Ethics (ZUCE)', ', Zurich, Switzerland', 0),
(231, 8, '', '', 'http://www.medlaw-bioethics.gr/', 'Όμιλος Μελέτης Ιατρικού Δικαίου και Βιοηθικής', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `link_categories`
--

CREATE TABLE IF NOT EXISTS `link_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lang_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lang_id` (`lang_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=12 ;

--
-- Dumping data for table `link_categories`
--

INSERT INTO `link_categories` (`id`, `label`, `lang_id`, `position`, `is_active`) VALUES
(3, 'Επιτροπές Βιοηθικής', 2, 1, 1),
(4, 'Εκπαίδευση στη Bιοηθική', 2, 2, 1),
(5, 'Ινστιτούτα Βιοηθικής', 2, 3, 1),
(6, 'Δημόσιοι Φορείς', 2, 4, 1),
(7, 'Ακαδημαϊκοί Φορείς', 2, 5, 1),
(8, 'Άλλοι Επιστημονικοί Φορείς', 2, 6, 1),
(9, 'Μη Κυβερνητικές Οργανώσεις (Μ.Κ.Ο.)', 2, 7, 1),
(10, 'Πύλες και Βάσεις Δεδομένων', 2, 8, 1),
(11, 'Περιοδικά', 2, 9, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=16 ;

--
-- Dumping data for table `menu_subtabs`
--

INSERT INTO `menu_subtabs` (`id`, `tab_id`, `label`, `description`, `link`, `header`, `is_divided`, `is_active`, `subtab_position`) VALUES
(10, 6, 'ΝΟΜΟΘΕΣΙΑ', NULL, 'legislation', NULL, 0, 1, 1),
(11, 6, 'ΕΥΡΩΠΑΙΚΩΝ ΔΙΚΑΣΤΗΡΙΩΝ', NULL, 'eur_courts', 'ΝΟΜΟΛΟΓΙΑ', 1, 1, 2),
(12, 6, 'ΕΘΝΙΚΩΝ ΔΙΚΑΣΤΗΡΙΩΝ', NULL, 'nat_courts', NULL, 0, 1, 2),
(13, 6, 'ΚΕΙΜΕΝΑ', 'Γνώμες και θέσεις', 'texts', NULL, 1, 1, 3),
(14, 6, 'ΒΙΒΛΙΟΓΡΑΦΙΑ', NULL, 'bibliography', NULL, 0, 1, 4),
(15, 6, 'ΜΕΛΕΤΕΣ', NULL, 'studies', NULL, 0, 1, 5);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

--
-- Dumping data for table `menu_tabs`
--

INSERT INTO `menu_tabs` (`id`, `label`, `description`, `link`, `lang_id`, `has_submenu`, `is_active`, `tab_position`) VALUES
(1, 'ΕΠΙΣΤΗΜΟΝΙΚΗ ΟΜΑΔΑ', NULL, 'research_members', 2, 0, 1, 1),
(2, 'ΕΡΕΥΝΗΤΙΚΟ ΠΡΟΓΡΑΜΜΑ', NULL, 'research_content', 2, 0, 1, 2),
(3, 'ΝΕΑ', NULL, 'news', 2, 0, 1, 3),
(4, 'ΕΚΔΗΛΩΣΕΙΣ', NULL, 'events', 2, 0, 1, 4),
(5, 'ΣΥΝΔΕΣΜΟΙ', NULL, 'links', 2, 0, 1, 5),
(6, 'ΕΝΗΜΕΡΩΣΗ', NULL, '', 2, 1, 1, 6),
(7, 'Η ΓΝΩΜΗ ΣΑΣ', NULL, 'opinion', 2, 0, 1, 7),
(8, 'ΕΠΙΚΟΙΝΩΝΙΑ', NULL, 'contact_us', 2, 0, 1, 8),
(9, 'FORUM', NULL, 'forum', 2, 0, 0, 9);

-- --------------------------------------------------------

--
-- Table structure for table `profiles`
--

CREATE TABLE IF NOT EXISTS `profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `profiles`
--

INSERT INTO `profiles` (`id`, `label`, `description`) VALUES
(1, 'admin', 'Administrator'),
(2, 'contr', 'Contributor'),
(3, 'moder', 'Moderator'),
(4, 'user', 'Guest User');

-- --------------------------------------------------------

--
-- Table structure for table `research_groups`
--

CREATE TABLE IF NOT EXISTS `research_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `lang_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lang_id` (`lang_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `research_groups`
--

INSERT INTO `research_groups` (`id`, `label`, `lang_id`) VALUES
(1, 'ΚΥΡΙΟΙ ΕΡΕΥΝΗΤΕΣ', 2),
(2, 'ΒΑΣΙΚΟΙ ΕΡΕΥΝΗΤΕΣ', 2),
(3, 'ΔΙΔΑΚΤΟΡΕΣ', 2),
(4, 'ΜΕΤΑΠΤΥΧΙΑΚΟΙ ΣΠΟΥΔΑΣΤΕΣ', 2);

-- --------------------------------------------------------

--
-- Table structure for table `research_members`
--

CREATE TABLE IF NOT EXISTS `research_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(80) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `picture` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `research_members`
--

INSERT INTO `research_members` (`id`, `group_id`, `name`, `email`, `picture`) VALUES
(1, 2, 'Έφη Κουνουγέρη – Μανωλεδάκη', 'eftihia@law.auth.gr', 'emanwledaki.jpeg'),
(2, 1, 'Ελισάβετ Συμεωνίδου-Καστανίδου', 'kastan@law.auth.gr', 'ekastanidou.jpg'),
(3, 1, 'Βασίλης Ταρλατζής', 'tarlatzis@gmail.com', 'vtarlatzis.png'),
(4, 2, 'Ελένη Ρεθυμνιωτάκη', 'erethemn@law.uoa.gr', 'erethymniwtaki.png'),
(5, 2, 'Νίκος Κουμουτζής', 'nikos_koumoutzis@hotmail.com', 'nkoumoutzis.jpg'),
(6, 2, 'Κωνσταντίνος Χατζηκώστας', 'konstantinoscha@law.auth.gr', ''),
(7, 3, 'Καλλιόπη Κηπουρίδου', 'kalliopi.kipouridou@gmail.com', 'kkhpouridou.jpg'),
(8, 3, 'Mαρία Μηλαπίδου', 'mimmaki@gmail.com', 'mmilapidou.jpg'),
(9, 3, 'Ρωξάνη Φράγκου', 'roxannefragou@hotmail.com', 'rfragou.jpg'),
(10, 4, 'Μαριάννα Βασιλείου', 'marva84@gmail.com', 'mvasileiou.jpg'),
(11, 4, 'Νίκος Δημόπουλος', '', ''),
(12, 4, 'Χριστίνα Σαχινίδου', 'sachinidouchristina@hotmail.com', 'csahinidou.jpg'),
(13, 4, 'Αντώνης Τσαλίδης', '', ''),
(14, 4, 'Θεοδώρα Χορταρά', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `research_member_info`
--

CREATE TABLE IF NOT EXISTS `research_member_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `cv` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `pubs` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `research_member_info`
--

INSERT INTO `research_member_info` (`id`, `member_id`, `cv`, `pubs`) VALUES
(1, 1, 'Πτυχιούχος και Διδάκτορας της Νομικής Σχολής του ΑΠΘ, με μεταπτυχιακές σπουδές στο Ελεύθερο Πανεπιστήμιο του Βερολίνου, η Έφη Κουνουγέρη-Μανωλεδάκη υπηρέτησε ως Καθηγήτρια του Αστικού Δικαίου στην πιο πάνω Σχολή, και από το 2012 είναι Ομότιμη Καθηγήτρια. Σήμερα διδάσκει στο Διατμηματικό Πρόγραμμα Μεταπτυχιακών Σπουδών (ΔΠΜΣ) του ΑΠΘ το μάθημα “Σύγχρονες Ιατρικές Πράξεις: Δικαιική Ρύθμιση και Βιοηθική Διάσταση”.\r\n\r\nΕίναι μέλος της «Eταιρείας Nομικών Bορείου Eλλάδος», της «Ένωσης Ελλήνων Aστικολόγων», της «Διεθνούς Ένωσης Oικογενειακού Δικαίου», της «Ελληνικής Εταιρείας για την Ψυχική Υγεία στην Υποβοηθούμενη Αναπαραγωγή» και του «Ομίλου Μελέτης Ιατρικού Δικαίου και Βιοηθικής», του οποίου υπήρξε πρόεδρος κατά τα έτη 2005-2011 και συνδιευθύνει τη σειρά των δημοσιευμάτων του («Δημοσιεύματα Ιατρικού Δικαίου και Βιοηθικής»).\r\n\r\nΔιατέλεσε μέλος της Εθνικής Αρχής Ιατρικώς Υποβοηθούμενης Αναπαραγωγής και του Δικαστηρίου Αγωγών Κακοδικίας. Υπήρξε μέλος της Oμάδας Eργασίας του Yπουργείου Δικαιοσύνης για τη μεταγλώττιση του Aστικού Kώδικα στη δημοτική γλώσσα (1987) και μέλος της Συμβουλευτικής Επιτροπής για τη συνδρομή στη σύνταξη Σχεδίου Νόμου τροποποιητικού του Αστικού Κώδικα, του Κώδικα Πολιτικής Δικονομίας και των συναφών νόμων, καθώς και για τη συμπλήρωση του Οικογενειακού Δικαίου και την καθιέρωση του Οικογενειακού Δικαστηρίου (1987). Επίσης, υπήρξε μέλος της Nομοπαρασκευαστικής Eπιτροπής για τη σύνταξη του ν. 2447/1996 που μεταρρύθμισε το δίκαιο της επιτροπείας και της υιοθεσίας, καθώς και μέλος της Nομοπαρασκευαστικής Eπιτροπής για τη σύνταξη του ν. 3089/2002 για την "Ιατρική Υποβοήθηση στην Ανθρώπινη Αναπαραγωγή". Τέλος, υπήρξε πρόεδρος της Νομοπαρασκευαστικής Επιτροπής, η οποία συγκροτήθηκε με απόφαση του Υπουργού Δικαιοσύνης το 2010 και είχε ως αντικείμενο την επεξεργασία Σχεδίου Νόμου για την “Τροποποίηση διατάξεων του Οικογενειακού Δικαίου” (με χαρακτηριστικές τις ρυθμίσεις για την επέκταση του συμφώνου συμβίωσης και στα ομόφυλα ζευγάρια).\r\n\r\nΤο συγγραφικό της έργο είναι εκτεταμένο και περιλαμβάνει μονογραφίες, βιβλία, μελέτες, φοιτητικά βοηθήματα, άρθρα σε συλλογικά έργα, δημοσιεύσεις στον ημερήσιο και περιοδικό τύπο, σχόλια σε δικαστικές αποφάσεις και βιβλιοκρισίες. Το μεγαλύτερο μέρος του έργου της είναι αφιερωμένο στο Οκογενειακό Δίκαιο, ενώ ένα άλλο σημαντικό μέρος του έχει ως αντικείμενο το Δίκαιο της Βιοτεχνολογίας, με έμφαση στην ιατρικά υποβοηθούμενη αναπαραγωγή.', ''),
(2, 2, '', ''),
(3, 3, 'Καθηγητής Μαιευτικής-Γυναικολογίας και Ανθρώπινης Αναπαραγωγής, \nΔιευθυντής Α’ Μαιευτικής και Γυναικολογικής Κλινική Α.Π.Θ.\n\nΠρώην Αναπληρωτής Πρόεδρος της Εθνικής Αρχής Ιατρικώς Υποβοηθούμενης Αναπαραγωγής\n\nΠρώην Πρόεδρος της Ευρωπαϊκής Εταιρείας Ανθρώπινης Αναπαραγωγής &amp; - Εμβρυολογίας (ESHRE), και μέλος της Επιτροπής Ηθικής και Δεοντολογίας της ESHRE\n\nΠρώην Πρόεδρος Διεθνούς Ομοσπονδίας Εταιρειών Γονιμότητας (IFFS)\nΠρώην Πρόεδρος Ιατρικής Σχολής, Αριστοτέλειο Πανεπιστήμιο Θεσσαλονίκης\nΠρόεδρος της Ελληνικής Εταιρείας Στειρότητος και Γονιμότητος\n\nΠρόεδρος της Ελληνικής Μαιευτικής και Γυναικολογικής Εταιρείας \nΑν. Πρόεδρος Συμβουλίου, Αριστοτέλειο Πανεπιστήμιο Θεσσαλονίκης\n\nΜέλος σε 26 ελληνικές και 18 ξένες Επιστημονικές Εταιρείες\n\nΜέλος της Επιτροπής Σύνταξης και Κριτής σε 7 ελληνικά και 14 διεθνή επιστημονικά περιοδικά\n\nΥπεύθυνος Έκδοσης 4 ξενόγλωσσων και 1 Ελληνικού Επιστημονικού Βιβλίου\n\n267 επιστημονικές εργασίες σε Ξενόγλωσσα Επιστημονικά Περιοδικά (με 6439 βιβλιογραφικές αναφορές) και 80 σε Ελληνικά Περιοδικά\n\n32 κεφάλαια σε Ξενόγλωσσα Βιβλία και 29 σε Ελληνικά Βιβλία\n\n45 κεφάλαια σε Πρακτικά Ξένων Συνεδρίων και 42 σε Πρακτικά Ελληνικών Συνεδρίων\n\n152 επιστημονικές εργασίες σε Ξενόγλωσσα Συνέδρια και\n92 σε Ελληνικά Συνέδρια\n', ''),
(4, 4, 'Η Ελένη Ρεθυμιωτάκη γεννήθηκε στην Αθήνα το 1964.    Σπούδασε νομικά στη Νομική Σχολή του Πανεπιστημίου Αθηνών. Έκανε μεταπτυχιακές σπουδές (D.E.A.) στο Πανεπιστήμιο Pantéon-Assas (Paris II) όπου εκπόνησε και τη διδακτορική διατριβή της με θέμα: «Από την ιατρική δεοντολογία στην βιοηθική. Μια μελέτη της Κοινωνιολογίας του δικαίου», η οποία έλαβε τιμητική διάκριση. Είναι δικηγόρος, μέλος του Δ.Σ.Α. Κατά την περίοδο 1997-2005 εργάστηκε ως έμμισθη δικηγόρος σε ασφαλιστική εταιρία με ειδίκευση την ασφάλιση εμπορικών πιστώσεων από το κίνδυνο της αφερεγγυότητας πελατών.  Το 2005 εξελέγη Λέκτορας στη Νομική Σχολή του Ε.Κ.Π.Α.  και από το 2012 είναι επίκουρη καθηγήτρια.\n\nΑσχολείται με την βιοϊατρική και την πληροφορική ως παραδείγματα πεδίων κοινωνικών σχέσεων που ρυθμίζονται μέσω της διαπλοκής  κανόνων και θεσμών του κρατικού δικαίου με κανόνες και όργανα αυτορρύθμισης. Επίσης εστιάστηκε στη σχέση δικαίου και πολιτικής στην Ε.Ε. και την πολύπλοκη σχέση της ενωσιακής έννομης τάξης με τις εθνικές. Τέλος μελετά τις σύγχρονες τάσεις εξέλιξης του οικογενειακού δικαίου, σε συνάρτηση με το μετασχηματισμό του οικογενειακού θεσμού και τα εναλλακτικά οικογενειακά σχήματα.   Κυριότερες δημοσιεύσεις:\n<ol>\n<li>Ρύθμιση ή αυτορρύθμιση; Το παράδειγμα της ιατρικά υποβοηθούμενης αναπαραγωγής,  Αθήνα-Κομοτηνή, Αντ. Ν.Σάκκουλας 2003.</li>\n<li>Πηγές του δικαίου και νομικός πλουραλισμός στην Ευρωπαϊκή Ένωση, Αθήνα-Θεσσαλονίκη, Εκδόσεις Σάκκουλα, 2012.</li> \n<li>Οικογένεια και δίκαιο στην Ελλάδα του 21ου αιώνα: Τάσεις εξατομίκευσης και συμβατικοποίησης, Γ΄ Συνέδριο Ελληνικής Κοινωνιολογικής Εταιρίας, Ελληνική κοινωνία 1975-2010, ανακατατάξεις, προκλήσεις, Αθήνα, 3-5 Νοεμβρίου 2011.</li>\n<li>European Public Sphere and Digital Political Communication: Facebook as a medium of political expression and participation, Proceedings of the 4th    International Conference on Information Law & Ethics, Bottis, M./ Alexandropoulou, E. (eds), Values and Freedoms in Modern Information Law and Ethics, 2012. –e book –</li>\n</ol>', ''),
(5, 5, 'Ο Νίκος Κουμουτζής γεννήθηκε στην Αθήνα. Είναι κάτοχος πτυχίου της Νομικής Σχολής του Εθνικού και Καποδιστριακού Πανεπιστημίου της Αθήνας, μεταπτυχιακού τίτλου (DEA) του Πανεπιστημίου Bordeaux I, με ειδίκευση στο Ιδιωτικό Δίκαιο, διδακτορικού τίτλου της Νομικής Σχολής του Εθνικού και Καποδιστριακού Πανεπιστημίου της Αθήνας (για τη διατριβή με θέμα: «Η γονική μέριμνα του γεννημένου χωρίς γάμο παιδιού και το δικαίωμα οικογενειακής ζωής του πατέρα» – βραβείο Ακαδημίας Αθηνών 2011). Στα κύρια ερευνητικά του ενδιαφέροντα περιλαμβάνoνται τα ανθρώπινα δικαιώματα, το οικογενειακό δίκαιο, ιδίως το δίκαιο της ιατρικής υποβοήθησης στην ανθρώπινη αναπαραγωγή, το δίκαιο του αδικαιολόγητου πλουτισμού, το δίκαιο των αδικοπραξιών. \r\n\r\nΕίναι δικηγόρος, μέλος του Δικηγορικού Συλλόγου Αθηνών, της Ένωσης Ελλήνων Αστικολόγων, του Ομίλου Ιατρικού Δικαίου και Βιοηθικής, της Εταιρείας Οικογενειακού Δικαίου, και συνεργάτης του περιοδικού «Χρονικά Ιδιωτικού Δικαίου». Από το 2014 υπηρετεί ως Λέκτορας στο Πανεπιστήμιο Λευκωσίας, όπου διδάσκει Ελληνικό Αστικό Δίκαιο. \r\n\r\nΜιλά Ελληνικά (μητρική γλώσσα), Γαλλικά, Αγγλικά και μπορεί να διαβάζει Γερμανικά.\r\n', ''),
(6, 6, 'Γεννήθηκε στη Θεσσαλονίκη στις 13.03.1974. Από το 1985 έως το 1991 φοίτησε στη Γερμανική Σχολή Θεσσαλονίκης (Γυμνάσιο – Λύκειο). Την  άνοιξη του 1991 συμμετείχε με επιτυχία στις εξετάσεις για την απόκτηση τίτλου πρόσβασης σε γερμανικό Πανεπιστήμιο (“Abitur”). Αποφοίτησε από την Γ΄ Λυκείου τον Ιούνιο του 1991 με βαθμό «Άριστα» – 19 και 6/10. Το Σεπτέμβριο του ίδιου έτους εγγράφηκε κατόπιν επιτυχούς συμμετοχής στις Πανελλαδικές εξετάσεις στο Τμήμα Νομικής της Σχολής Νομικών και Οικονομικών Επιστημών του Α.Π.Θ. Έλαβε το πτυχίο της Νομικής του Α.Π.Θ. το Νοέμβριο του 1995 με βαθμό «άριστα» (8,63).\r\n\r\nΤο Νοέμβριο του 1995 εγγράφηκε ως υποψήφιος διδάκτορας στη Νομική Σχολή του Πανεπιστημίου Johann Wolfgang Goethe της Φραγκφούρτης/Μ με επιβλέποντα τον καθηγητή Δρα Ulfrid Neumann και συνεπιβλέποντα  τον καθηγητή Δρα Klaus Günther.\r\n\r\nΤο Σεπτέμβριο του 1996 έλαβε τριετή υποτροφία της Γερμανικής Υπηρεσίας Ακαδημαϊκών Ανταλλαγών (DAAD) για την εκπόνηση της διδακτορικής μου διατριβής.\r\n\r\nΣτις 22.05.2000 υποστήριξε προφορικά τη διδακτορική του διατριβή κατά τον Κανονισμό Διατριβών του Πανεπιστημίου Φραγκφούρτης ενώπιον τριμελούς εξεταστικής επιτροπής. Αναγορεύτηκε ομόφωνα διδάκτωρ της Νομικής Σχολής του Πανεπιστημίου της Φραγκφούρτης με τη διάκριση “magna cum laude”.\r\n\r\nΗ διδακτορική του διατριβή με τίτλο “Die Disponibilität des Rechtsgutes Leben in ihrer Bedeutung für die Probleme von Suizid und Euthanasie” (Η δυνατότητα διάθεσης του εννόμου αγαθού της ζωής, όσον αφορά ειδικότερα τα ζητήματα της αυτοκτονίας και της ευθανασίας) δημοσιεύθηκε το 2001 με οικονομική ενίσχυση της Γερμανικής Υπηρεσίας Ακαδημαϊκών Ανταλλαγών (DAAD) στον εκδοτικό οίκο “PETER LANG” και στην επιστημονική σειρά δημοσιευμάτων “Frankfurter kriminalwissenschaftliche Studien”, η οποία διευθύνεται από καθηγητές του Πανεπιστημίου της Φραγκφούρτης.\r\n\r\nΚατά τη διάρκεια του εαρινού εξαμήνου των ακαδημαϊκών ετών 2005-06, 2006-07, 2007-08, και των ακαδημαϊκών ετών 2008-09 και 2009-2010 εργάστηκε ως ειδικός επιστήμονας στον Τομέα των Ποινικών Επιστημών του Τμήματος Νομικής της Σχολής ΝΟΠΕ του Αριστοτελείου Παν/μιου Θεσσαλονίκης, συμμετέχοντας στη διδασκαλία των μαθημάτων, «Γενικό Ποινικό Δίκαιο», «Ειδικό Ποινικό Δίκαιο», «Εμβάθυνση στο ουσιαστικό Ποινικό Δίκαιο» «Ειδικά Θέματα Ποινικού Δικαίου», «Ειδικοί Ποινικοί Νόμοι» και «Εισαγωγή στο Ελληνικό Ποινικό Δίκαιο» για γερμανόφωνους φοιτητές Erasmus. Επιπλέον συμμετείχε στην οργάνωση φοιτητικών σεμιναρίων με αντικείμενο το ηλεκτρονικό έγκλημα, τα ναρκωτικά, την ευθανασία, τη νομοθεσία των μεταμοσχεύσεων, τις προσβολές της τιμής και την ελευθερία του λόγου κ.ά.\r\n\r\nΑπό τον Ιανουάριο του 2014 υπηρετεί ως λέκτορας του ουσιαστικού ποινικού δικαίου στον Τομέα των Ποινικών Επιστημών του Τμήματος Νομικής της Σχολής ΝΟΠΕ του Αριστοτελείου Παν/μιου Θεσσαλονίκης.\r\n\r\nΑπό τις 25.09.2000 έως τις 25.08.2002 εκπλήρωσε τις στρατιωτικές του υποχρεώσεις ως Δόκιμος Έφεδρος Αξιωματικός.\r\n\r\nΕίναι δικηγόρος στο Πρωτοδικείο Θεσσαλονίκης από το 1998 και εργάζεται ως δικηγόρος.\r\n\r\nΓνωρίζει άριστα τη γερμανική (γερμανικό απολυτήριο – Abitur / διδακτορική διατριβή), την αγγλική (Cambridge First Certificate in English/Certificate of Proficiency in English) και τη γαλλική γλώσσα (Certificat de Langue Francaise/Certificat Pratique de Langue Francaise -1er DEGRE).\r\n', ''),
(7, 7, 'Η Καλλιόπη Κηπουρίδου είναι πτυχιούχος του Τμήματος Νομικής της Σχολής Νομικών και Πολιτικών Επιστημών του Αριστοτέλειου Πανεπιστημίου Θεσσαλονίκης και είναι κάτοχος Μεταπτυχιακού Διπλώματος Ειδίκευσης στον Κλάδο Ποινικών και Εγκληματολογικών Επιστημών. Το 2012 αναγορεύτηκε διδάκτορας Νομικών Επιστημών. Η εκπόνηση της διδακτορικής της διατριβής πραγματοποιήθηκε με την οικονομική υποστήριξη του Ιδρύματος Κρατικών Υποτροφιών. \r\nΑπό το έτος 2002 είναι δικηγόρος και μέλος του Δικηγορικού Συλλόγου Θεσσαλονίκης διορισμένη στο Εφετείο και από το έτος 2013 είναι μέλος του Ομίλου Μελέτης Ιατρικού Δικαίου και Βιοηθικής. Παράλληλα, διδάσκει στα πλαίσια προγράμματος επιμόρφωσης αστυνομικών αναφορικά με θέματα εξαρτήσεων που διοργανώνει ο Ο.ΚΑ.ΝΑ. (2014), έχει διδάξει στο Τ.Ε.Ι. Δυτικής Μακεδονίας-Παράρτημα Καστοριάς (ακαδημαϊκό έτος 2012-2013), σε Δημόσια Ινστιτούτα Επαγγελματικής Κατάρτισης (2007, 2010, 2012, 2013), στη Σχολή Ξεναγών Θεσσαλονίκης (2009). \r\nΚατά τα ακαδημαϊκά έτη 2011-2012 και 2012-2013 έχει συμμετάσχει ως εισηγήτρια στο Διατμηματικό Πρόγραμμα Μεταπτυχιακών Σπουδών των Σχολών Ιατρικής, Οδοντιατρικής και Νομικής και του Τμήματος Θεολογίας του Α.Π.Θ. με τίτλο «Σύγχρονες Ιατρικές Πράξεις : Δικαιϊκή Ρύθμιση και Βιοηθική Διάσταση». Από τον Ιανουάριο του 2014 πραγματοποιεί μεταδιδακτορική έρευνα στη Νομική Σχολή ΑΠΘ, στον Τομέα Ποινικών και Εγκληματολογικών Σπουδών με αντικείμενο την ¨Υποβοηθούμενη αναπαραγωγή και προστασία του εμβρύου in vitro¨ στο πλαίσιο της Δράσης ΑΡΙΣΤΕΙΑ ΙΙ που συγχρηματοδοτείται από τη Γενική Γραμματεία Έρευνας και Τεχνολογίας και το ΕΣΠΑ.\r\nΈχει συγγράψει μελέτες που έχουν δημοσιευθεί σε νομικά περιοδικά και σε συλλογικά έργα. Γνωρίζει άριστα αγγλικά και γαλλικά.\r\n', ''),
(8, 8, 'Γεννήθηκε το 1979 στη Θεσσαλονίκη. Το 1997 αποφοίτησε από το Πειραματικό Σχολείο του Πανεπιστημίου Θεσσαλονίκης με «Άριστα». Το 1998 εισήχθη στη Νομική Σχολή του ΑΠΘ από την οποία αποφοίτησε το 2002 με βαθμό «Άριστα». Από τον Αύγουστο του 2004 είναι δικηγόρος Θεσσαλονίκης. Το 2004 ολοκλήρωσε τις Μεταπτυχιακές της Σπουδές στη Νομική Σχολή του ΑΠΘ και πιο συγκεκριμένα στον Τομέα Ποινικών και Εγκληματολογικών Σπουδών με «Άριστα». Το 2011 αναγορεύτηκε διδάκτωρ της Νομικής Σχολής ΑΠΘ. Καθόλη τη διάρκεια της εκπόνησης της διδακτορικής της διατριβής υπήρξε υπότροφος του Κοινωφελούς Ιδρύματος «Αλέξανδρος Σ. Ωνάσης». Από τον Ιανουάριο του 2014 πραγματοποιεί μεταδιδακτορική έρευνα στη Νομική Σχολή ΑΠΘ, στον Τομέα Ποινικών και Εγκληματολογικών Σπουδών με αντικείμενο την ¨Υποβοηθούμενη αναπαραγωγή και προστασία του εμβρύου in vitro¨ στο πλαίσιο της Δράσης ΑΡΙΣΤΕΙΑ ΙΙ που συγχρηματοδοτείται από τη Γενική Γραμματεία Έρευνας και Τεχνολογίας και το ΕΣΠΑ.\n\nΑπό τον Ιανουάριο του 2012 συμμετέχει ως εισηγήτρια στο Διατμηματικό Πρόγραμμα Μεταπτυχιακών Σπουδών του ΑΠΘ «Σύγχρονες Ιατρικές Πράξεις: Δικαιϊκή Ρύθμιση & Βιοηθική Διάσταση», ενώ από το 2005 έχει απασχοληθεί με συμβάσεις στον Τομέα Ποινικών και Εγκληματολογικών Επιστημών της Νομικής Σχολής ΑΠΘ για την παροχή επικουρικής διδασκαλίας στους φοιτητές.\n\nΑπό το Δεκέμβριο του 2005 συμμετέχει στο θεματικό ΔΙΚΤΥΟ της Επιτροπής Ερευνών ΑΠΘ «ΣΥΓΧΡΟΝΗ ΙΑΤΡΙΚΗ ΠΡΑΞΗ, ΔΙΚΑΙΟ ΚΑΙ ΒΙΟΗΘΙΚΗ», είναι μέλος του Ομίλου Ιατρικού Δικαίου και Βιοηθικής, ενώ από τον Ιανουάριο του 2011 έως σήμερα είναι επιστημονικός συνεργάτης του περιοδικού Ιατρικό Δίκαιο και Βιοηθική.\n\nΈχει συμμετάσχει ως εισηγήτρια σε συνέδρια και σεμινάρια που άπτονται του χώρου της Βιοηθικής. Έχει συγγράψει μια μονογραφία και 19 μελέτες – σχόλια που έχουν δημοσιευτεί σε νομικά περιοδικά. Γνωρίζει άριστα Αγγλικά, Γερμανικά και Γαλλικά. Είναι έγγαμη και έχει ένα τέκνο.\n', ''),
(9, 9, 'Απόφοιτος της Νομικής Σχολής του ΔΠΘ, ολοκλήρωσε το 2005 τις Μεταπτυχιακές της Σπουδές στο Δημόσιο Δίκαιο στη Νομική Σχολή του Πανεπιστημίου Robert Schuman στο Στρασβούργο. Το Νοέμβριο του 2010 υποστήριξε τη διδακτορική της διατριβή με τίτλο Η ευθανασία και το δικαίωμα άρνησης θεραπείας ενόψει της εξέλιξης του Ευρωπαϊκού Συγκριτικού δικαίου (Γαλλία, Ελλάδα, Ελβετία, Ολλανδία, Βέλγιο, Ισπανία και Ηνωμένο Βασίλειο) και αναγορεύτηκε ομόφωνα διδάκτωρ της Νομικής Σχολής του Πανεπιστημίου του Στρασβούργου. Από το Μάρτιο του 2014 πραγματοποιεί μεταδιδακτορική έρευνα στη Νομική Σχολή του ΑΠΘ με αντικείμενο την Υποβοηθούμενη αναπαραγωγή και προστασία του εμβρύου in vitro στο πλαίσιο της Δράσης ΑΡΙΣΤΕΙΑ ΙΙ.\r\n\r\nΑπό το 2009 έως το 2011 εργάστηκε ως Attachée Temporaire d’Enseignement et de Recherche (ATER) και από το 2011 έως το 2012 ως Chargée d’Enseignement Vacataire (CEV) στη Νομική Σχολή του Πανεπιστημίου του Στρασβούργου και στο Ινστιτούτο Πολιτικών Επιστημών (IEP de Strasbourg) συμμετέχοντας στη διδασκαλία των μαθημάτων Δημόσιο Δίκαιο, Συνταγματικό Δίκαιο και Πολιτικοί Θεσμοί στη Γαλλία και το Συγκριτικό Δίκαιο. Από το 2011 έως και σήμερα διδάσκει στο Μεταπτυχιακό Πρόγραμμα του Ευρωπαϊκού κέντρου διδασκαλίας και έρευνας στην Ηθική του Πανεπιστημίου του Στρασβούργου το μάθημα Εφαρμοσμένη Ηθική. Πηγές και θεμέλια : πηγές σχετικά με τη βιοηθική. Παράλληλα, διδάσκει στο Γαλλικό Κολλέγιο-IdEF / Πανεπιστήμιο Paris 13 τα μαθήματα Εισαγωγή στο Δημόσιο Δίκαιο και Συνταγματικό Δίκαιο. \r\n\r\nΕργάζεται ως Επιστημονική Συνεργάτις στην Εθνική Επιτροπή για τα Δικαιώματα του Ανθρώπου (ΕΕΔΑ). \r\n \r\nΕίναι ειδικός συνεργάτης στο νομικό περιοδικό Συνήγορος εκδόσεων Νομική Βιβλιοθήκη με μόνιμη στήλη με τίτλο Αλλοδαποί και τα πεδία έρευνας και συγγραφικού ενδιαφέροντός της περιλαμβάνουν εκτός από τη Βιοηθική, θέματα Δικαιωμάτων του Ανθρώπου και Δικαίου Αλλοδαπών.', ''),
(10, 10, 'Η Μαριάννα Βασιλείου γεννήθηκε στη Λάρισα το 1984 και αποφοίτησε από το Ενιαίο Λύκειο Σουφλίου Έβρου το 2002. Την ίδια χρονιά εισήχθη στη Νομική Σχολή του Αριστοτελείου Πανεπιστημίου Θεσσαλονίκης και έλαβε το πτυχίο της το 2007 με βαθμό «Λίαν Καλώς». Το 2012 έλαβε Μεταπτυχιακό Δίπλωμα Ειδίκευσης του Τομέα Ποινικών και Εγκληματολογικών Επιστημών της Νομικής Σχολής του Αριστοτελείου Πανεπιστημίου Θεσσαλονίκης με βαθμό «Λίαν Καλώς». Το 2014 έλαβε Μεταπτυχιακό Δίπλωμα Ειδίκευσης «ΣΥΓΧΡΟΝΕΣ ΙΑΤΡΙΚΕΣ ΠΡΑΞΕΙΣ: ΔΙΚΑΙΪΚΗ ΡΥΘΜΙΣΗ ΚΑΙ ΒΙΟΗΘΙΚΗ ΔΙΑΣΤΑΣΗ» από το Διατμηματικό Μεταπτυχιακό Πρόγραμμα Ειδίκευσης των Σχολών Νομικής, Ιατρικής, Οδοντιατρικής και Θεολογίας του Αριστοτελείου Πανεπιστημίου Θεσσαλονίκης με βαθμό «Άριστα». Είναι υποψήφια διδάκτορας της Ιατρικής Σχολής του Αριστοτελείου Πανεπιστημίου Θεσσαλονίκης. Το θέμα της διατριβής της είναι «Κενά και ανεπάρκειες του ισχύοντος δεοντολογικού πλαισίου που ρυθμίζει τις εφαρμοζόμενες και τις αναμενόμενες να εφαρμοστούν μεθόδους ιατρικώς υποβοηθούμενης αναπαραγωγής». Από το έτος 2009 ασκεί μαχόμενη δικηγορία, ως μέλος του Δικηγορικού Συλλόγου Θεσσαλονίκης. Μιλάει άριστα αγγλικά και γαλλικά και πολύ καλά ιταλικά. \n\nΈχει λάβει μέρος ως εισηγήτρια σε ημερίδες γύρω από τη βιοηθική («Δωρεά και Μεταμόσχευση οργάνων υπό το πρίσμα του Ν. 3984/2011» και «Διακοπή της κύησης: Ιατρικά, νομικά και ηθικά ζητήματα») και έχει δημοσιεύσει σε συλλογικά έργα και σε επιστημονικά περιοδικά άρθρα σχετικά με τις μεταμοσχεύσεις, την διακοπή της κύησης και την ιατρικώς υποβοηθούμενη αναπαραγωγή σε ψυχικά ασθενείς. Το 2012 συμμετείχε στο ντοκιμαντέρ της Αλεξάνδρας Δάφνη “Break the silence” με θέμα την ενδοοικογενειακή βία.\n\nΤα επιστημονικά της ενδιαφέροντα περιλαμβάνουν, εκτός από τη βιοηθική και τη νομική, τη φεμινιστική θεώρηση του δικαίου και τη σχέση του τελευταίου με τις τέχνες εν γένει. \n', ''),
(11, 11, '', ''),
(12, 12, 'Η Χριστίνα Σαχινίδου γεννήθηκε το 1977 στη Θεσσαλονίκη. Το 1997 αποφοίτησε από το 2ο Γενικό Εσπερινό Λύκειο Θεσσαλονίκης και εισήχθη στο Τμήμα Ιατρικών Εργαστηρίων της Σχολής Επαγγελμάτων Υγείας και Πρόνοιας αποφοιτώντας το 2001 με βαθμό «άριστα» (9.00). Το 2008 εισήχθη στη Νομική Σχολή του Αριστοτελείου Πανεπιστημίου Θεσσαλονίκης από την οποία αποφοίτησε το 2012 με βαθμό «λίαν καλώς» (7.08).  Από το έτος 2012 είναι μεταπτυχιακή φοιτήτρια, ως πρώτη εισαχθείσα, Διατμηματικού Προγράμματος Μεταπτυχιακών Σπουδών (ΔΠΜΣ) του Αριστοτελείου Πανεπιστημίου Θεσσαλονίκης των τμημάτων και σχολών Νομικής, Ιατρικής, Οδοντιατρικής και Θεολογίας με τίτλο «Σύγχρονες Ιατρικές Πράξεις: Δικαιϊκή Ρύθμιση και Βιοηθική Διάσταση».  Την παρούσα χρονική περίοδο βρίσκεται στο στάδιο εκπόνησης διπλωματικής εργασίας με θέμα «Η Ιατρικώς Υποβοηθούμενη Αναπαραγωγή στους τρανσέξουαλ». \n\nΤο 2002 διορίστηκε στο Γενικό Νοσοκομείο Θεσσαλονίκης «ΙΠΠΟΚΡΑΤΕΙΟ» όπου και υπηρετεί έως σήμερα, διατελώντας υπηρεσία σε διάφορα πόστα του φορέα της και της Υγειονομικής Περιφέρειας όπου αυτός ανήκει, όπως Εθνικό Περιφερειακό Κέντρο Ιστοσυμβατότητας,  Κέντρο Μοριακού Ελέγχου Αίματος, Ιατρικό Επιστημονικό περιοδικό «Ιπποκράτεια» αλλά και ως  γραμματέας σε συλλογικά και μονομελή όργανα της Διοίκησης (Περιφερειακό Συμβούλιο Επιλογής και Αξιολόγησης Ιατρών Ε.Σ.Υ, Επιστημονικό και Διοικητικό Συμβούλιο,  γραφείο Διοικητή). \n\nΣτο επιστημονικό της έργο περιλαμβάνονται δημοσιεύσεις σε επιστημονικά περιοδικά, εισηγήσεις και ανακοινώσεις σε συνέδρια καθώς και παρακολούθηση αυτών, που άπτονται και των δύο γνωστικών πεδίων που κατέχει.\n', ''),
(13, 13, '', ''),
(14, 14, NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `static_content`
--

CREATE TABLE IF NOT EXISTS `static_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `alias` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `lang_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lang_id` (`lang_id`),
  KEY `alias` (`alias`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `static_content`
--

INSERT INTO `static_content` (`id`, `label`, `alias`, `content`, `lang_id`) VALUES
(1, 'Research Content', 'research_content', '<h4 class="static-header">THE CASE</h4>\r\nSince the birth of the first child with the help of artificial insemination till today, that the methods of assisted reproduction are being widely applied all over the world, 34 years have passed. During this period of time a debate regarding the necessity of laws and regulations governing the application of the methods of assisted reproduction and the protection of the genetic material in the laboratories has arisen.\r\n\r\nThe need of regulatory legislature also became apparent through the appreciation of the <i><strong>risks associated</strong></i> with the application of the methods of assisted reproduction. These methods pose serious threats to the health and even the life of both the mother- and the child-to-be, risks that have often been underestimated or downplayed throughout the first years of application of the methods.\r\n\r\nThe <i><strong>high cost</strong></i> associated with assisted reproduction was another, rather significant factor, calling for the development of regulatory legislature. This cost burdens mostly the infertile couples, but also affects the national health services’ budgets, since they often cover part of the expenses for the procedure.\r\n\r\nCrucial <i><strong>legal issues</strong></i> that arise by the application of the methods of assisted reproduction and <i><strong>ethical aspects</strong></i> contribute equally in the formation of the regulatory legislature. The key issue of the legal status of the genetic material of the embryo, the recognition or non of the genetic material’s legal rights are only some of the issues in dispute arising from the application of the methods of assisted reproduction. Moreover, in the development of the regulatory legislature a rather important factor has been the realization of the need to preserve the <i><strong>child’s-to-be</strong></i> benefits by adopting specific restrictions on the choice of persons that wish to have a child. Lastly, given the fact that this particular medical application has a significant impact on <i><strong>family relationships</strong></i> and creates various <i><strong>relationship issues</strong></i>, especially when third persons participate to the reproduction procedure (e.g. heterologous insemination, surrogate motherhood), a legislature governing the process was deemed necessary.\r\n\r\nIn this context the European countries have instituted laws governing the application of methods of assisted reproduction at the European and the national level. These laws, however, were brought into power at different time points across the various countries, depending on the progress in each country. The strictness or leniency of these laws reflected each country’s position on crucial issues associated with implementation of assisted reproduction, such as the determination of the specific time-point at which life begins, the nature of the genetic material, the fertilized egg and the embryo, the freedom to perform research etc.\r\n\r\nAt the same time, the treaty of Oviedo, being a framework, deals with a vast number of issues, associated with the application of Biotechnology on humans. Methods of assisted reproduction, however, are only cited in articles 14 and 18, the former prohibiting the use of the methods for selection of a future’s child sex, unless “serious hereditary sex-related disease is to be avoided” and the latter outlawing the creation of human embryos for research purposes and, in case the national laws allow in vitro research on embryos, requesting the enforcement of adequate protection of the embryo. This limited reference of the methods of assisted reproduction in the Oviedo Treaty should be associated with the fact that differences in the national and cultural heritage did not allow to reach a consensus on a number of issues. Many of the member-states of the European Council, did not sign the treaty.\r\n\r\nSince signing the Oviedo treaty, many European countries enacted laws governing the application of methods of assisted reproduction and the protection of the embryo and the fertilized egg. These laws became a necessity because of the widespread application of the methods and were in agreement with the Oviedo treaty. Given the lack of a common and binding position, it is to be expected that national laws do not regulate these crucial issues in a similar way. As a result, today, <i><strong>a mosaic of national legislatures</strong></i> has been created, with each national legislature differing from the other widely in its trends and directions.\r\n\r\nDivergences between national legislatures give rise to problems of particular importance, especially to those associated with the application and control of assisted human reproduction and in vitro research on embryos. To be mentioned are mainly:\r\n<ul>\r\n<li>The <i><strong>non-egalitarian access of all the European citizens to the achievements and advancements of the reproductive technology.</strong></i> As a result of this, many citizens seek ways to <i><strong>bypass restrictions</strong></i> in the application of methods of assisted reproduction in their countries. Furthermore <i><strong>access to the methods of assisted reproduction becomes directly associated to the individual’s financial status</strong></i>, expanding the already present class distinctions.</li>\r\n<li>In <i><strong>research</strong></i>, scientists operating in countries that have opted for a strict legislation in this field, come up against severe impediments compared to their colleagues working in other countries that have adopted more liberal approaches.</li>\r\n<li>Regulations posed by restrictive legislations, in addition to problems associated with international scientific cooperation, give rise to issues associated with the application of proportionality, since they minimize application of the methods of assisted reproduction.</li>\r\n<li>Furthermore, national legislations only seldom take into consideration the <i><strong>risks associated with assisted human reproduction</strong></i>, which are caused by the progress in the field of biotechnology.</li></ul>\r\n<h4 class="static-header">PROPOSALS</h4>\r\n\r\nThe research proposal includes:\r\n[1] Identification of the key points of current legislature regarding methods of assisted reproduction and\r\nprotection of the genetic material in Europe. The research will examine specific groups of countries. Using these criteria, the Swedish legislature was selected from the countries of Northern Europe, the German and French from the countries of Central Europe and the Greek and Italian from the countries of Southern Europe. It will also extend to the Anglo-Saxon Law of England.\r\n[2] In addition to the recording of the regulatory legislation, the research proposal will include:\r\n[a] The recording of case law, which has been created during the past 15 years, since signing the Oviedo treaty.\r\n[b] The recording of the opinions of the Heads of the Bioethics Committees of these countries on the problems, which the existing legislature has created during its application, as well as their suggestions on how to improve it.\r\n[c] The recording of the corresponding opinions of the Heads of National Agencies of Medically Assisted Reproduction, where they are operative or have at least been for some time-interval.\r\n[d] The recording of the opinions of scientific societies or groups of citizens on studying and putting forward any problems associated with the assisted reproduction and protection of the genetic material.\r\n[e] The recording of the opinion of the Head of a Center of Assisted Reproduction.\r\n[f] The collection and study of the relative bibliography, as well as of all associated decisions and reports, by the Bioethics Committees or the National Agencies of Medically Assisted Reproduction.\r\n[3] Upon completion of individual national searches, results collection and evaluation, all proposals will be recorded and comparison with data from other countries will follow. Eventually the common grounds of the individual proposals will be combined.\r\n<h4 class="static-header">METHODOLOGY</h4>\r\nThe research will be carried out through the use of two <i><strong>questionnaires</strong></i>.\r\nThe questionnaires will allow gathering of the necessary key-points in a unified way. More specifically:\r\nThe first questionnaire will focus on the content of the national legislature on assisted human reproduction and research on genetic material in the aforementioned European countries. This questionnaire will be filled in by five young researchers, doing field research in collaboration with faculty members of the countries, where the research will take place.\r\nThe second questionnaire will be aimed at reference persons, whose opinion will be requested on the enacted legislation and the problems it may cause. Furthermore, their input as to what can be done to deal with these problems will be requested.\r\nA form for the recording of jurisprudence (case law) of individual countries will also be prepared.\r\nThe questionnaires will be prepared by the five researchers under the supervision of the principal investigators. Before the questionnaires are finalized, each researcher will fill in the questionnaires with data from the Greek legislature, three times, so as to familiarize with the questionnaires and optimize their content.\r\nThe researchers will then visit each of the selected countries (Sweden, Germany, France, Italy and England) for approximately one month, to gather the necessary data. The first questionnaire will be filled in by the researcher, in collaboration with faculty members of the host country. An interview with the person of reference will be held for the second questionnaire.\r\n<h4 class="static-header">DIFFUSION OF RESEARCH RESULTS</h4>\r\nOnce the elaboration of the questionnaires, the recording of the conclusions and the formulation of proposals on confronting the problem, are all completed, the conclusive findings will be forwarded to all the reference persons, whose views had played a major role in their development.\r\n\r\nNext, a (two-day) European Congress will be organized, in which the reference-persons from Greece as well as the five countries, whose legislature will have been analyzed in depth (Sweden, Germany,\r\nFrance, Italy and England), as well as scientists from foreign universities, the Heads of the Bioethics Committees and of the National Agencies of Medically Assisted Reproduction, the European Commissioner of Justice, Fundamental Rights and Citizenship, the Presidents of IFFS and ESHRE and the President of the Council of Europe will be invited. It is estimated that approximately 120 persons will attend the meeting. The Congress and its conclusions will be published online and in the Press, and upon completion of the Congress its proceedings will be published.\r\n\r\nFurthermore, every researcher will have to publish his findings in a peer-reviewed journal upon completion of his research in the country he was assigned.\r\n\r\nThe Proceedings of the Congress and the final proposals of the research team will be delivered to the Council of Europe, to the European Commissioner of Justice, Fundamental Rights and Citizenship, to the President of the European Parliament, to the National Agencies of Medically Assisted Reproduction as well as to the President of the Greek Parliament.\r\n<h4 class="static-header">BIBLIOGRAPHICAL REFERENCES</h4>\r\n<i>Abrams Μ.</i>, The European Convention on Human Rights and Biomedicine, in Sicilianos/Gavouneli, Scientific and Technological Development and Human Rights, 2001, p. 187 ff.\r\n\r\n<i>Bondis I.</i>, Principles of Obstetrics and Gynaecology (from Greek), 2002.\r\n\r\n<i>Faßbender K.</i>, Der Schutz des Embryos und die Humangenetik: Zur Verfassungsmäßigkeit des neuen Stammzellengesetzes und des Embryonenschutzgesetzes im Lichte des einschlägigen Arzthaftungsrecht, MedR 2003, p. 279 ff.\r\n\r\n<i>Fuchs H.</i>, Protection of the embryo and stem cell research (from Greek), in M. Kaiafa-Gbandi/E. Kounougeri-Manoledaki/E. Symeonidou-Kastanidou, Publications on Medical Law and Bioethics-10, 2009, p. 7 ff.\r\n\r\n<i>Gabridou G.</i>, “The assisted reproduction as a field of public control (from Greek), in G. Papadimitriou/A. Makridimitris/Ch. Chrysanthakis, Public Law and policies in Biomedicine, 2007, p. 91 ff.\r\n\r\n<i>Hilgendorf E.</i>, The debate between Law and Bioethics in Germany, in M. Kaiafa-Gbandi/E. Kounougeri- Manoledaki/E. Symeonidou-Kastanidou, Publications on Medical Law and Bioethics-10, 2009, p. 27 ff.\r\n\r\n<i>Iliadou Aik.</i>, Biomedicine and Human Rights-Notes based on the treaty of the Council of Europe on Biomedicine (from Greek), ToS 2000, p. 257 ff.\r\n\r\n<i>Kamp I.</i>, Die Europäische Bioethik-Konvention, Medizinische Versuche an einwilligungsfähigen Menschen unter besonderer Berücksichtigung der Vorgaben im nationalen und internationalen Recht, 2000.\r\n\r\n<i>Κöck E.</i>, Der (Straf)rechtliche Schutz des Embryos, ÖJZ 2006, p. 631 ff.\r\n\r\n<i>Kounougeri-Manoledaki E.</i>, Stem cells: Legal issues and legal provisions (from Greek), Chronika Idiotikou Dikaiou 2009, p. 385 ff.\r\n\r\n<i>Koutsouradis A.</i>, Issues in surrogate motherhood – especially since law 3305/2005 (from Greek), Nomiko Vima 2006, p. 337 ff.\r\n\r\n<i>Kriari-Katrani I.</i>, Biomedical advances and Constitutional law (from Greek), 1994.\r\n\r\n<i>Kutzer K.</i>, Embryonenschutzgesetz-Wertungswidersprüche zu den Regelungen beim Schwangerschaftsabbruch, Früheuthanasie, Sterbehilfe und Transplantation?, MedR 2002, p. 24 ff. \r\n\r\n<i>Milapidou M.</i>, Preimplatation diagnosis as a form of research on human genetic material (from Greek), in M. Kaiafa-Gbandi/E. Kounougeri-Manoledaki/E. Symeonidou-Kastanidou, Publications on Medical Law and Bioethics-10, 2009, p. 63 ff.\r\n\r\n<i>Milapidou M.</i>, Physical integrity and assisted reproduction – The criminal responsibility in view of therapeutic treatment (from Greek), 2011.\r\n\r\n<i>Rethimniotaki E.</i>, Regulation or autoregulation? The case of assisted reproduction (from Greek), 2003.\r\n\r\n<i>Tarlatzis B.</i>, Artificial Insemination (from Greek), 1997.\r\n\r\n<i>Vidalis T.</i>, Life without a face. The Constitution and the use of human genetic material (from Greek), 2003.', 1),
(3, 'Ερευνητικό Πρόγραμμα', 'research_content', 'Από τη γέννηση του πρώτου παιδιού με τη βοήθεια της εξωσωματικής γονιμοποίησης, μέχρι σήμερα που οι μέθοδοι ιατρικής υποβοήθησης της αναπαραγωγής εφαρμόζονται ευρύτατα σε ολόκληρο τον κόσμο, έχουν περάσει 35 χρόνια. Κατά το χρονικό αυτό διάστημα, παράλληλα με την ιατρική - τεχνολογική πρόοδο και εξαιτίας αυτής, αναπτύχθηκε η συζήτηση σχετικά με την αναγκαιότητα νομοθετικών κειμένων και ρυθμιστικών κανόνων για την εφαρμογή των μεθόδων υποβοηθούμενης ανθρώπινης αναπαραγωγής και την προστασία του γεννητικού υλικού στα ιατρικά εργαστήρια.\n  \nΉταν αρχικά η <i><strong>έκταση</strong></i> που έλαβε η εφαρμογή των μεθόδων ιατρικής υποβοήθησης της αναπαραγωγής, η οποία συγκέντρωσε το ενδιαφέρον της κοινής γνώμης και - για τον λόγο αυτό και του ίδιου - του κράτους. Η ανάγκη για νομοθετική παρέμβαση προέκυψε εξάλλου και από τη συνειδητοποίηση των <i><strong>κινδύνων</strong></i> που συνεπάγεται η εφαρμογή των μεθόδων υποβοηθούμενης αναπαραγωγής για τη ζωή και την υγεία της μέλλουσας γυναίκας και του παιδιού που πρόκειται να γεννηθεί. Μια ακόμα ιδιαίτερα καθοριστική παράμετρος για τη διαμόρφωση ενός ρυθμιστικού νομοθετικού πλαισίου υπήρξε και το <i><strong>αυξημένο κόστος</strong></i> της εφαρμογής των μεθόδων ιατρικής υποβοήθησης της αναπαραγωγής. Στη διαμόρφωση του ρυθμιστικού πλαισίου συνέβαλαν εξίσου και τα <i><strong>ζητήματα ηθικής</strong></i>, όπως και πλειάδα <i><strong>νομικών θεμάτων</strong></i> που ανακύπτουν κατά την εφαρμογή των μεθόδων της υποβοηθούμενης ανθρώπινης αναπαραγωγής. Περαιτέρω, στη διαμόρφωση του σχετικού νομοθετικού πλαισίου καταλυτικός παράγοντας υπήρξε και η συνειδητοποίηση της ανάγκης να διασφαλιστούν τα <i><strong>συμφέροντα του παιδιού</strong></i> που πρόκειται να γεννηθεί. Τέλος, δεδομένου ότι η συγκεκριμένη ιατρική εφαρμογή έχει σημαντικό αντίκτυπο στις <i><strong>οικογενειακές σχέσεις</strong></i> και δημιουργεί μια σειρά από <i><strong>ζητήματα συγγένειας</strong></i>, η νομοθετική της ρύθμιση κρίθηκε, και για το λόγο αυτό, αναγκαία.\n\nΣτο πλαίσιο αυτό, σε ευρωπαϊκό επίπεδο, τα κράτη υιοθέτησαν νομοθετικές ρυθμίσεις για την αξιοποίηση των μεθόδων ιατρικής υποβοήθησης της αναπαραγωγής. Με δεδομένη, όμως, την έλλειψη ενιαίων και δεσμευτικών υπερεθνικών κανόνων, οι επιμέρους εθνικές νομοθεσίες δεν ρυθμίζουν με τρόπο κοινό τα κρίσιμα αυτά ζητήματα. Είναι χαρακτηριστικό ότι ακόμα και η Σύμβαση του Οβιέδο, που υπογράφηκε από τα κράτη μέλη του Συμβουλίου της Ευρώπης το 1997, κάνει περιορισμένη αναφορά στις μεθόδους ΙΥΑ, απαγορεύοντας μόνο την προεπιλογή φύλου και τη δημιουργία ανθρώπινων εμβρύων για ερευνητικούς σκοπούς. Τούτο οφείλεται στο γεγονός ότι η διαφορετική εθνική και πολιτιστική κληρονομιά, η διαφορετική ένταση της επιρροής που ασκούν οι θρησκευτικές πεποιθήσεις στη διαμόρφωση της εθνικής νομοθεσίας, ακόμα και ο διαφορετικός τρόπος που εξασκείται η ιατρική σε κάθε κράτος δεν επέτρεψαν τη διαμόρφωση μιας κοινής αντίληψης σε περισσότερα ζητήματα μεταξύ των εκπροσώπων των επιμέρους κρατών.\n\nΟι ουσιώδεις αποκλίσεις που εμφανίζουν οι επιμέρους εθνικές νομοθεσίες δημιουργούν ιδιαίτερα σοβαρά προβλήματα, οδηγώντας στη μη ισότιμη πρόσβαση όλων των πολιτών της Ευρώπης στα επιτεύγματα της αναπαραγωγικής τεχνολογίας, στη δημιουργία προβλημάτων στο επίπεδο της διεθνούς επιστημονικής συνεργασίας και στη μη ομοιόμορφη αντιμετώπιση από τις εθνικές νομοθεσίες των κινδύνων που συνδέονται με την εξέλιξη της βιοτεχνολογίας.\n \nΑυτά τα προβλήματα που δημιουργούνται από τη διαρκή εξέλιξη της βιοτεχνολογίας  στον χώρο της υποβοηθούμενης αναπαραγωγής και των ερευνών στο γεννητικό υλικό δεν μπορούν ασφαλώς να εξαλειφθούν. Ωστόσο, μπορούν να αναζητηθούν οι κοινές συνιστώσες των επιμέρους εθνικών νομοθεσιών, ώστε αυτά να περιοριστούν.\n\n Σε αυτή την κατεύθυνση κινείται η παρούσα ερευνητική πρόταση. Πιο συγκεκριμένα, η έρευνα που θα διεξαχθεί θα έχει ως στόχους: (1) να αναδείξει τα προβλήματα που περιγράφηκαν πιο πάνω και τις επιπτώσεις τους στις κοινωνίες και τη ζωή των ατόμων, (2) να καταγράψει τα αίτια που δημιουργούν τα προβλήματα αυτά, τα οποία άλλοτε σχετίζονται με την υπάρχουσα νομοθεσία ή τον τρόπο εφαρμογής της και άλλοτε με την έλλειψη νομοθεσίας και (3) να αναζητήσει προτάσεις για την αποτελεσματική αντιμετώπιση των προβλημάτων, οι οποίες μπορούν  - ή πρέπει - να γίνουν ευρύτερα αποδεκτές στον ευρωπαϊκό χώρο.\n\nΓια τον σκοπό αυτό θα γίνει:\n\n<ol><li>Καταγραφή των βασικών σημείων της ισχύουσας σήμερα στα ευρωπαϊκά κράτη νομοθεσίας σχετικά με την υποβοηθούμενη ανθρώπινη αναπαραγωγή και την προστασία του γεννητικού υλικού. Με δεδομένο ότι, παρά επιμέρους διαφοροποιήσεις, τα δίκαια συγκεκριμένων χωρών εμφανίζουν σημαντικές ομοιότητες ως προς τις βασικές τους κατευθύνσεις, και λαμβάνοντας υπόψη το γεγονός ότι αντικείμενο της έρευνας δεν είναι η απλή περιγραφή των ισχυουσών ρυθμίσεων, αλλά η <i><strong>ποιοτική ανάλυση</strong></i> του υπάρχοντος νομοθετικού πλαισίου, η έρευνα θα αφορά ομάδες και όχι το σύνολο των ευρωπαϊκών χωρών. Έτσι, από τις χώρες της Βόρειας Ευρώπης η έρευνα θα αφορά το δίκαιο της Σουηδίας, από τις χώρες της Κεντρικής Ευρώπης, τα δίκαια της Γερμανίας και της Γαλλίας, από τις χώρες της Νότιας Ευρώπης τα δίκαια της Ελλάδας και της Ιταλίας. Θα επεκταθεί επίσης στο αγγλοσαξονικό δίκαιο της Μεγάλης Βρετανίας και της Ιρλανδίας.</li>\n<li>Σε ό,τι αφορά το περιεχόμενό της, η έρευνα θα περιλαμβάνει, πέραν της καταγραφής των νομοθετικών ρυθμίσεων: (α) καταγραφή της νομολογίας που έχει διαμορφωθεί κατά τα τελευταία 15 χρόνια, μετά, δηλαδή, από τη Συνθήκη του Οβιέδο, (β) καταγραφή των απόψεων των επικεφαλής των Επιτροπών Βιοηθικής των χωρών αυτών σχετικά με τα προβλήματα που έχει δημιουργήσει η υπάρχουσα νομοθεσία κατά την εφαρμογή της αλλά και σχετικά με πιθανές βελτιώσεις της νομοθεσίας αυτής, (γ) καταγραφή αντίστοιχων απόψεων των επικεφαλής Εθνικών Αρχών Ιατρικώς Υποβοηθούμενης Αναπαραγωγής, όπου λειτουργούν ή έστω λειτούργησαν για κάποιο χρονικό διάστημα, (δ) καταγραφή των απόψεων επιστημονικών ενώσεων ή ενώσεων πολιτών για την μελέτη και ανάδειξη προβλημάτων που σχετίζονται με την υποβοηθούμενη αναπαραγωγή και την προστασία του γεννητικού υλικού, (ε) καταγραφή αντίστοιχων απόψεων του επικεφαλής ενός Κέντρου υποβοήθησης της αναπαραγωγής, (στ) συγκέντρωση και μελέτη της σχετικής βιβλιογραφίας, καθώς και σχετικών αποφάσεων και εκθέσεων που έχουν εκδώσει οι Επιτροπές Βιοηθικής ή οι Αρχές Προστασίας της Υποβοηθούμενης Αναπαραγωγής.</li>\n<li>Μετά την ολοκλήρωση των επιμέρους ερευνών, την συγκέντρωση των αποτελεσμάτων και την αξιολόγησή τους, θα καταγραφεί το σύνολο των προτάσεων και θα ακολουθήσει η διαδικασία σύγκρισης με τα δεδομένα των υπόλοιπων χωρών, καθώς και η διαδικασία σύνθεσης των κοινών τόπων των επιμέρους προτάσεων.</li></ol>\nΗ έρευνα δεν θα περιοριστεί όμως μόνο στις εθνικές νομοθεσίες. Αναγκαία κρίνεται επιπλέον η καταγραφή της νομολογίας του Ευρωπαϊκού Δικαστηρίου Δικαιωμάτων του Ανθρώπου σε θέματα που σχετίζονται με την υποβοηθούμενη αναπαραγωγή και την προστασία του γεννητικού υλικού, καθώς αποδίδει την κοινή ευρωπαϊκή αντίληψη για τα θέματα αυτά.\n\nΤέλος, η έρευνα θα εμπλουτιστεί και με την αναζήτηση και καταγραφή απόψεων διεθνών ενώσεων που ασχολούνται με τα ηθικά και νομικά ζητήματα τα οποία εγείρει η υποβοηθούμενη αναπαραγωγή, όπως η European Society of Human Reproduction and Embryology (ESHRE) και εκπροσώπων της International Federation of Fertility Societies (IFFS).\n\nΜε βάση το σύνολο αυτών των πληροφοριών, θα διατυπωθούν πλέον συγκεκριμένες προτάσεις που θα συγκεντρώνουν ευρύτερη συναίνεση σε ευρωπαϊκό επίπεδο ή που η υιοθέτησή τους είναι πλέον αναγκαία με βάση τα σύγχρονα πορίσματα της ιατρικής για την προστασία της μέλλουσας μητέρας και του παιδιού που πρόκειται να γεννηθεί.  \n\n', 2);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `profile_id` int(11) NOT NULL DEFAULT '4',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `index_users_on_profile_id` (`profile_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=16 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `profile_id`, `created_at`, `updated_at`) VALUES
(1, 'larry482gr', '2b39292acb691c8b4fcc8f9c8e4a77a0f263dff0', 'lakazantzis@gmail.com', 1, '2014-05-03 00:00:00', '2014-05-03 00:00:00'),
(2, 'stdespo', 'a09ba730bfc0a8567a182eb4e534c99425326670', 'stdespotopoulos@gmail.com', 2, '2014-05-04 19:00:00', '2014-05-04 19:00:00'),
(12, 'kastan', 'a57783a79191a9f54f767da55bb189c863dec405', 'kastan@law.auth.gr', 2, '2014-06-20 19:29:17', '2014-06-20 19:29:17'),
(14, 'Nikos Koumoutzis', '816fe42094b768098321983ed327344418c4bc06', 'nikos_koumoutzis@hotmail.com', 2, '2014-06-24 10:16:21', '2014-06-24 10:16:21'),
(15, 'chrysa', '5979226d3b0dce97c6509620c4a1fd240b3277b8', 'karagiox@otenet.gr', 4, '2014-06-24 11:59:26', '2014-06-24 11:59:26');

-- --------------------------------------------------------

--
-- Table structure for table `user_infos`
--

CREATE TABLE IF NOT EXISTS `user_infos` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `faculty` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postal_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `activated` tinyint(1) NOT NULL DEFAULT '0',
  `blacklisted` tinyint(1) NOT NULL DEFAULT '0',
  `token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_infos`
--

INSERT INTO `user_infos` (`user_id`, `first_name`, `last_name`, `faculty`, `postal_address`, `phone_number`, `activated`, `blacklisted`, `token`) VALUES
(1, 'Λάζαρος', 'Καζαντζής', NULL, NULL, NULL, 1, 0, NULL),
(2, 'Στέργιος', 'Δεσποτόπουλος', NULL, NULL, NULL, 1, 0, NULL),
(12, 'Ελισάβετ', 'Συμεωνίδου - Καστανίδου', NULL, NULL, NULL, 1, 0, NULL),
(14, 'Nikos', 'Koumoutzis', NULL, NULL, NULL, 1, 0, NULL),
(15, 'Χρύσα', 'Καραγιάννη', 'νομικός', '25ης Μαρτίου 16', '6944/530.403', 1, 0, NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `links`
--
ALTER TABLE `links`
  ADD CONSTRAINT `LINK_CAT_ID_FOREIGN_KEY` FOREIGN KEY (`cat_id`) REFERENCES `link_categories` (`id`);

--
-- Constraints for table `link_categories`
--
ALTER TABLE `link_categories`
  ADD CONSTRAINT `LANGUAGE_ID_FOREIGN_KEY` FOREIGN KEY (`lang_id`) REFERENCES `languages` (`id`);

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
