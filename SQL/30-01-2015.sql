-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 30, 2015 at 05:34 PM
-- Server version: 5.5.41
-- PHP Version: 5.3.10-1ubuntu3.15

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `gotnerds_bfameus`
--

-- --------------------------------------------------------

--
-- Table structure for table `page_content`
--

CREATE TABLE IF NOT EXISTS `page_content` (
  `page_id` int(11) NOT NULL AUTO_INCREMENT,
  `page_title` varchar(255) NOT NULL,
  `page_content` text NOT NULL,
  `page_slug` varchar(255) NOT NULL,
  PRIMARY KEY (`page_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `page_content`
--

INSERT INTO `page_content` (`page_id`, `page_title`, `page_content`, `page_slug`) VALUES
(1, 'About Us', '<p>This is a demo page only.</p>\r\n        \r\n        <p>You can add your "About Us" content here!</p>\r\n        \r\n        <p>It is recommended that you have a basic knowledge of <a href="http://www.w3.org/MarkUp/Guide/">HTML</a> before editing this page.  It would also help you to have some knowledge of <a href="http://www.w3.org/Style/Examples/011/firstcss">CSS.</a></p>\r\n        \r\n        <p>You can edit this page by opening <strong>themes/default/templates/generic_aboutus.htm</strong> in your favorite text or WYSIWYG editor!  Be sure to delete this line after editing.</p>', 'about-us'),
(3, 'Terms of Use', '<p>This is a demo page only.</p>\r\n        \r\n        <p>You can add your "Terms of Use" content here!</p>\r\n        \r\n        <p>It is recommended that you have a basic knowledge of <a href="http://www.w3.org/MarkUp/Guide/">HTML</a> before editing this page.  It would also help you to have some knowledge of <a href="http://www.w3.org/Style/Examples/011/firstcss">CSS.</a></p>\r\n        \r\n        <p>You can edit this page by opening <strong>themes/default/templates/generic_terms.htm</strong> in your favorite text or WYSIWYG editor!  Be sure to delete this line after editing.</p>', 'terms-of-use'),
(4, 'Advertise With Us', '<p>This is a demo page only.</p>\r\n        \r\n        <p>You can add your "Advertise With Us" content here!</p>\r\n        \r\n        <p>It is recommended that you have a basic knowledge of <a href="http://www.w3.org/MarkUp/Guide/">HTML</a> before editing this page.  It would also help you to have some knowledge of <a href="http://www.w3.org/Style/Examples/011/firstcss">CSS.</a></p>\r\n        \r\n        <p>You can edit this page by opening <strong>themes/default/templates/generic_advertise.htm</strong> in your favorite text or WYSIWYG editor!  Be sure to delete this line after editing.</p>', 'advertise-with-us');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
