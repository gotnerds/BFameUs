-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 30, 2015 at 06:24 PM
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
-- Table structure for table `adsplus`
--

CREATE TABLE IF NOT EXISTS `adsplus` (
  `text1` varchar(24) DEFAULT NULL,
  `text2` varchar(24) DEFAULT NULL,
  `text3` varchar(24) DEFAULT NULL,
  `num1` int(11) DEFAULT NULL,
  `num2` int(11) DEFAULT NULL,
  `num3` int(11) DEFAULT NULL,
  `identifier` tinytext,
  `indexer` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`indexer`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `adsplus`
--

INSERT INTO `adsplus` (`text1`, `text2`, `text3`, `num1`, `num2`, `num3`, `identifier`, `indexer`) VALUES
('yes', '00000', NULL, NULL, NULL, NULL, 'longtail', 1);

-- --------------------------------------------------------

--
-- Table structure for table `adverts`
--

CREATE TABLE IF NOT EXISTS `adverts` (
  `ads_left` text,
  `ads_right` text,
  `ads_top` text,
  `ads_bottom` text,
  `preloaded` varchar(20) DEFAULT 'yes',
  `ads_home_right` text,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `adverts`
--

INSERT INTO `adverts` (`ads_left`, `ads_right`, `ads_top`, `ads_bottom`, `preloaded`, `ads_home_right`, `id`) VALUES
(NULL, NULL, NULL, NULL, 'yes', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `audiocomments`
--

CREATE TABLE IF NOT EXISTS `audiocomments` (
  `by_id` int(11) DEFAULT NULL,
  `by_username` varchar(24) DEFAULT NULL,
  `audio_id` int(11) DEFAULT NULL,
  `comments` text,
  `todays_date` datetime DEFAULT NULL,
  `indexer` int(11) NOT NULL AUTO_INCREMENT,
  `flag_counter` int(4) NOT NULL DEFAULT '0',
  `rating_number_votes` int(11) DEFAULT NULL,
  `rating_total_points` int(11) DEFAULT NULL,
  `updated_rating` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`indexer`),
  KEY `by_id` (`by_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `audiocomments_rating`
--

CREATE TABLE IF NOT EXISTS `audiocomments_rating` (
  `user_id` int(11) DEFAULT NULL,
  `IP` varchar(15) DEFAULT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `indexer` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`indexer`),
  KEY `comment_id` (`comment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `audiocomments_replys`
--

CREATE TABLE IF NOT EXISTS `audiocomments_replys` (
  `by_id` int(12) DEFAULT NULL,
  `by_username` varchar(255) DEFAULT NULL,
  `audiocomment_id` int(12) DEFAULT NULL,
  `comment_reply` text,
  `todays_date` datetime DEFAULT NULL,
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`indexer`),
  KEY `audiocomment_id` (`audiocomment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `audios`
--

CREATE TABLE IF NOT EXISTS `audios` (
  `audio_id` varchar(24) DEFAULT NULL,
  `album_id` int(6) NOT NULL DEFAULT '0',
  `title` text,
  `title_seo` varchar(48) DEFAULT NULL,
  `artist` text,
  `description` text,
  `tags` text,
  `audio_length` varchar(12) DEFAULT NULL,
  `cat_id` smallint(4) DEFAULT NULL,
  `channel` varchar(24) DEFAULT NULL,
  `album` varchar(24) DEFAULT NULL,
  `album_year` smallint(4) DEFAULT NULL,
  `location_recorded` text,
  `allow_comments` varchar(4) DEFAULT NULL,
  `allow_embedding` varchar(4) DEFAULT NULL,
  `public_private` varchar(12) DEFAULT NULL,
  `date_uploaded` datetime DEFAULT NULL,
  `allow_ratings` varchar(4) DEFAULT NULL,
  `rating_number_votes` int(11) DEFAULT NULL,
  `rating_total_points` int(11) DEFAULT NULL,
  `updated_rating` int(11) DEFAULT NULL,
  `indexer` int(11) NOT NULL AUTO_INCREMENT,
  `approved` varchar(24) DEFAULT NULL,
  `number_of_views` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `featured` varchar(12) DEFAULT NULL,
  `playtime` datetime DEFAULT NULL,
  `flag_counter` int(4) NOT NULL DEFAULT '0',
  `media_location` varchar(25) NOT NULL DEFAULT 'localhost',
  `media_quality` varchar(25) NOT NULL DEFAULT 'standard',
  PRIMARY KEY (`indexer`),
  KEY `audio_id` (`audio_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `audio_albums`
--

CREATE TABLE IF NOT EXISTS `audio_albums` (
  `album_name` varchar(48) DEFAULT NULL,
  `album_name_seo` varchar(48) DEFAULT NULL,
  `album_description` text,
  `date_created` datetime DEFAULT NULL,
  `public_private` varchar(7) NOT NULL DEFAULT 'public',
  `active` varchar(3) NOT NULL DEFAULT 'yes',
  `album_id` int(9) NOT NULL AUTO_INCREMENT,
  `genre_id` int(4) NOT NULL,
  `has_audio` char(3) NOT NULL DEFAULT 'no',
  `album_picture` varchar(48) DEFAULT NULL,
  PRIMARY KEY (`album_id`),
  KEY `album_name` (`album_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `audio_favorites`
--

CREATE TABLE IF NOT EXISTS `audio_favorites` (
  `user_id` smallint(8) DEFAULT NULL,
  `audio_id` smallint(8) DEFAULT NULL,
  `indexer_fav` smallint(8) NOT NULL AUTO_INCREMENT,
  `audio_status` varchar(12) DEFAULT 'active',
  `owner_id` smallint(8) DEFAULT NULL,
  PRIMARY KEY (`indexer_fav`),
  KEY `audio_id` (`audio_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE IF NOT EXISTS `blogs` (
  `indexer` int(9) NOT NULL AUTO_INCREMENT,
  `blog_owner` varchar(24) DEFAULT NULL,
  `user_id` int(9) DEFAULT NULL,
  `viewtime` datetime DEFAULT NULL,
  `title` text,
  `title_seo` text,
  `description` text,
  `tags` text,
  `category` varchar(24) DEFAULT NULL,
  `category_id` tinyint(6) NOT NULL,
  `blog_story` text,
  `date_created` datetime DEFAULT NULL,
  `allow_replies` varchar(3) NOT NULL DEFAULT 'yes',
  `allow_ratings` varchar(3) NOT NULL DEFAULT 'yes',
  `rating_number_votes` int(9) DEFAULT '0',
  `rating_total_points` int(9) DEFAULT '0',
  `updated_rating` int(9) DEFAULT '0',
  `public_private` varchar(24) NOT NULL DEFAULT 'public',
  `approved` varchar(24) DEFAULT NULL,
  `number_of_views` int(9) NOT NULL DEFAULT '0',
  `featured` varchar(3) DEFAULT 'no',
  `promoted` varchar(3) NOT NULL DEFAULT 'no',
  `flag_counter` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`indexer`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `blog_categories`
--

CREATE TABLE IF NOT EXISTS `blog_categories` (
  `category_id` int(12) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(48) DEFAULT NULL,
  `category_name_seo` varchar(48) DEFAULT NULL,
  `category_description` text,
  `date_created` datetime DEFAULT NULL,
  `category_picture` varchar(32) DEFAULT 'none.gif',
  `has_blogs` varchar(3) NOT NULL DEFAULT 'no',
  PRIMARY KEY (`category_id`),
  KEY `category_name` (`category_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `blog_categories`
--

INSERT INTO `blog_categories` (`category_id`, `category_name`, `category_name_seo`, `category_description`, `date_created`, `category_picture`, `has_blogs`) VALUES
(1, 'People', 'People', 'Articles on People', '2009-02-21 15:06:01', 'none.gif', 'yes'),
(2, 'Places', 'Places', 'Places of Interest', '2009-02-21 15:06:01', 'none.gif', 'yes'),
(3, 'Personal', 'Personal', 'Personal Writings', '2009-02-21 15:06:01', 'none.gif', 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `blog_replys`
--

CREATE TABLE IF NOT EXISTS `blog_replys` (
  `by_id` int(12) DEFAULT NULL,
  `by_username` varchar(36) DEFAULT NULL,
  `blog_id` int(12) DEFAULT NULL,
  `reply_body` text,
  `todays_date` datetime DEFAULT NULL,
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`indexer`),
  KEY `by_id` (`by_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `channels`
--

CREATE TABLE IF NOT EXISTS `channels` (
  `channel_id` int(12) NOT NULL AUTO_INCREMENT,
  `channel_name` varchar(48) DEFAULT NULL,
  `channel_name_seo` varchar(48) DEFAULT NULL,
  `channel_description` text,
  `date_created` datetime DEFAULT NULL,
  `channel_picture` varchar(32) DEFAULT 'none.gif',
  PRIMARY KEY (`channel_id`),
  KEY `channel_name` (`channel_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `emails`
--

CREATE TABLE IF NOT EXISTS `emails` (
  `description` text,
  `email_body` text,
  `email_subject` text,
  `email_id` int(12) DEFAULT NULL,
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`indexer`),
  KEY `email_id` (`email_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE IF NOT EXISTS `favorites` (
  `user_id` int(12) DEFAULT NULL,
  `video_id` int(12) DEFAULT NULL,
  `indexer_fav` int(12) NOT NULL AUTO_INCREMENT,
  `video_status` varchar(48) DEFAULT 'active',
  `owner_id` int(12) DEFAULT NULL,
  PRIMARY KEY (`indexer_fav`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `features_settings`
--

CREATE TABLE IF NOT EXISTS `features_settings` (
  `audio` varchar(5) NOT NULL DEFAULT 'yes',
  `images` varchar(5) NOT NULL DEFAULT 'yes',
  `blogs` varchar(5) NOT NULL DEFAULT 'yes',
  `video_comments` varchar(5) NOT NULL DEFAULT 'yes',
  `blog_comments` varchar(5) NOT NULL DEFAULT 'yes',
  `audio_comments` varchar(5) NOT NULL DEFAULT 'yes',
  `image_comments` varchar(5) NOT NULL DEFAULT 'yes',
  `profile_comments` varchar(5) NOT NULL DEFAULT 'yes',
  `stats` varchar(5) NOT NULL DEFAULT 'yes',
  `confirmation_email` varchar(5) NOT NULL DEFAULT 'yes',
  `custome_profile` varchar(5) NOT NULL DEFAULT 'no',
  `language` varchar(255) NOT NULL DEFAULT 'english',
  `theme` varchar(255) NOT NULL DEFAULT 'default'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `features_settings`
--

INSERT INTO `features_settings` (`audio`, `images`, `blogs`, `video_comments`, `blog_comments`, `audio_comments`, `image_comments`, `profile_comments`, `stats`, `confirmation_email`, `custome_profile`, `language`, `theme`) VALUES
('yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'yes', 'no', 'english', 'bfameus');

-- --------------------------------------------------------

--
-- Table structure for table `flagging`
--

CREATE TABLE IF NOT EXISTS `flagging` (
  `user_id` int(12) DEFAULT NULL,
  `flag_type` varchar(20) DEFAULT NULL,
  `content_id` int(12) DEFAULT NULL,
  `today_date` datetime DEFAULT NULL,
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`indexer`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `friends`
--

CREATE TABLE IF NOT EXISTS `friends` (
  `user_id` int(12) DEFAULT NULL,
  `invitation_id` varchar(48) DEFAULT NULL,
  `friends_id` int(12) DEFAULT NULL,
  `invitation_type` varchar(48) DEFAULT NULL,
  `blocked_users` varchar(255) DEFAULT NULL,
  `invitation_status` varchar(255) DEFAULT NULL,
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  `my_username` varchar(36) DEFAULT NULL,
  `friends_username` varchar(36) DEFAULT NULL,
  `todays_date` datetime DEFAULT NULL,
  PRIMARY KEY (`indexer`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `general_settings`
--

CREATE TABLE IF NOT EXISTS `general_settings` (
  `site_name` varchar(100) DEFAULT 'Video Site',
  `site_base_url` varchar(100) DEFAULT 'http://www.yourdomain.com',
  `delete_original` varchar(5) DEFAULT 'yes',
  `delete_avi` varchar(5) DEFAULT 'yes',
  `path_to_mencoder` varchar(100) DEFAULT '/usr/bin/mencoder',
  `path_to_ffmpeg` varchar(100) DEFAULT '/usr/bin/ffmpeg',
  `path_to_flvtool2` varchar(100) DEFAULT '/usr/bin/flvtool2',
  `auto_play_index` varchar(5) DEFAULT 'false',
  `auto_play` varchar(5) DEFAULT 'false',
  `video_buffer_time` tinyint(5) DEFAULT '2',
  `allow_multiple_video_comments` varchar(5) DEFAULT 'yes',
  `maximum_size` int(11) DEFAULT '202400',
  `maximum_size_human_readale` varchar(20) DEFAULT '100kb',
  `auto_approve_profile_photo` varchar(5) DEFAULT 'no',
  `debug_mode` varchar(5) DEFAULT 'no',
  `from_system_name` varchar(100) DEFAULT 'Video Site Team',
  `notifications_from_email` varchar(100) DEFAULT 'team@yourdomain.com',
  `search_page_limits` int(5) DEFAULT '8',
  `groups_main_limit` int(5) DEFAULT '8',
  `groups_home_video_limit` int(5) DEFAULT '8',
  `comment_page_limits` int(5) DEFAULT '6',
  `see_more_limits` int(5) DEFAULT '8',
  `date_format` varchar(10) DEFAULT 'd-m-y',
  `auto_approve_videos` varchar(5) DEFAULT 'yes',
  `admin_maximum_display` int(5) NOT NULL DEFAULT '25',
  `flagging_threshold_limits` int(5) NOT NULL DEFAULT '7',
  `seemore_limits_wide` int(5) NOT NULL DEFAULT '2',
  `allow_download` varchar(5) NOT NULL DEFAULT 'yes',
  `enable_audio` varchar(5) NOT NULL DEFAULT 'yes',
  `path_to_php` varchar(50) NOT NULL DEFAULT '/usr/bin/php',
  `log_encoder` varchar(5) NOT NULL DEFAULT 'no',
  `config_recent_title_length` varchar(250) NOT NULL DEFAULT '14',
  `play_list_bottom_ad` varchar(5) NOT NULL DEFAULT 'no',
  KEY `site_name` (`site_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `general_settings`
--

INSERT INTO `general_settings` (`site_name`, `site_base_url`, `delete_original`, `delete_avi`, `path_to_mencoder`, `path_to_ffmpeg`, `path_to_flvtool2`, `auto_play_index`, `auto_play`, `video_buffer_time`, `allow_multiple_video_comments`, `maximum_size`, `maximum_size_human_readale`, `auto_approve_profile_photo`, `debug_mode`, `from_system_name`, `notifications_from_email`, `search_page_limits`, `groups_main_limit`, `groups_home_video_limit`, `comment_page_limits`, `see_more_limits`, `date_format`, `auto_approve_videos`, `admin_maximum_display`, `flagging_threshold_limits`, `seemore_limits_wide`, `allow_download`, `enable_audio`, `path_to_php`, `log_encoder`, `config_recent_title_length`, `play_list_bottom_ad`) VALUES
('BFAMEUS', 'http://10.10.10.1/BFameUs/', 'yes', 'yes', '/usr/bin/mencoder', '/usr/bin/ffmpeg', '/usr/bin/flvtool2', 'false', 'false', 5, 'yes', 202400, '100kb', 'no', 'no', 'Video Site Team', 'linish@localmail.altd.in', 8, 8, 8, 6, 8, 'm-d-y', 'yes', 25, 7, 2, 'yes', 'yes', '/usr/bin/php', 'no', '14', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `genre`
--

CREATE TABLE IF NOT EXISTS `genre` (
  `channel_name` varchar(250) DEFAULT NULL,
  `channel_description` text,
  `date_created` varchar(20) DEFAULT NULL,
  `active` varchar(3) NOT NULL DEFAULT 'yes',
  `channel_id` bigint(20) NOT NULL,
  `has_audio` char(3) NOT NULL DEFAULT 'no',
  `channel_picture` varchar(250) DEFAULT 'none.gif',
  PRIMARY KEY (`channel_id`),
  KEY `channel_name` (`channel_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `genre`
--

INSERT INTO `genre` (`channel_name`, `channel_description`, `date_created`, `active`, `channel_id`, `has_audio`, `channel_picture`) VALUES
('Blues', 'Blues', '2008-08-11 13:31:27', 'yes', 0, 'no', 'none.gif'),
('Classic Rock', 'Classic Rock', '2008-08-11 13:31:27', 'yes', 1, 'no', 'none.gif'),
('Country', 'Country', '2008-08-11 13:31:27', 'yes', 2, 'no', 'none.gif'),
('Dance', 'Dance', '2008-08-11 13:31:27', 'yes', 3, 'no', 'none.gif'),
('Disco', 'Disco', '2008-08-11 13:31:27', 'yes', 4, 'no', 'none.gif'),
('Funk', 'Funk', '2008-08-11 13:31:27', 'yes', 5, 'no', 'none.gif'),
('Grunge', 'Grunge', '2008-08-11 13:31:27', 'yes', 6, 'no', 'none.gif'),
('Hip-Hop', 'Hip-Hop', '2008-08-11 13:31:27', 'yes', 7, 'yes', 'none.gif'),
('Jazz', 'Jazz', '2008-08-11 13:31:27', 'yes', 8, 'no', 'none.gif'),
('Metal', 'Metal', '2008-08-11 13:31:27', 'yes', 9, 'no', 'none.gif'),
('New Age', 'New Age', '2008-08-11 13:31:27', 'yes', 10, 'no', 'none.gif'),
('Oldies', 'Oldies', '2008-08-11 13:31:27', 'yes', 11, 'yes', 'none.gif'),
('Other', 'Other', '2008-08-11 13:31:27', 'yes', 12, 'yes', 'none.gif'),
('Pop', 'Pop', '2008-08-11 13:31:27', 'yes', 13, 'no', 'none.gif'),
('R&B', 'R&B', '2008-08-11 13:31:27', 'yes', 14, 'no', 'none.gif'),
('Rap', 'Rap', '2008-08-11 13:31:27', 'yes', 15, 'no', 'none.gif'),
('Reggae', 'Reggae', '2008-08-11 13:31:27', 'yes', 16, 'no', 'none.gif'),
('Rock', 'Rock', '2008-08-11 13:31:27', 'yes', 17, 'no', 'none.gif'),
('Techno', 'Techno', '2008-08-11 13:31:27', 'yes', 18, 'no', 'none.gif'),
('Industrial', 'Industrial', '2008-08-11 13:31:27', 'yes', 19, 'no', 'none.gif'),
('Alternative', 'Alternative', '2008-08-11 13:31:27', 'yes', 20, 'no', 'none.gif'),
('Ska', 'Ska', '2008-08-11 13:31:27', 'yes', 21, 'no', 'none.gif'),
('Death Metal', 'Death Metal', '2008-08-11 13:31:27', 'yes', 22, 'no', 'none.gif'),
('Pranks', 'Pranks', '2008-08-11 13:31:27', 'yes', 23, 'no', 'none.gif'),
('Soundtrack', 'Soundtrack', '2008-08-11 13:31:27', 'yes', 24, 'no', 'none.gif'),
('Euro-Techno', 'Euro-Techno', '2008-08-11 13:31:27', 'yes', 25, 'no', 'none.gif'),
('Ambient', 'Ambient', '2008-08-11 13:31:27', 'yes', 26, 'no', 'none.gif'),
('Trip-Hop', 'Trip-Hop', '2008-08-11 13:31:27', 'yes', 27, 'no', 'none.gif'),
('Vocal', 'Vocal', '2008-08-11 13:31:27', 'yes', 28, 'no', 'none.gif'),
('Jazz+Funk', 'Jazz+Funk', '2008-08-11 13:31:27', 'yes', 29, 'no', 'none.gif'),
('Fusion', 'Fusion', '2008-08-11 13:31:27', 'yes', 30, 'no', 'none.gif'),
('Trance', 'Trance', '2008-08-11 13:31:27', 'yes', 31, 'no', 'none.gif'),
('Classical', 'Classical', '2008-08-11 13:31:27', 'yes', 32, 'no', 'none.gif'),
('Instrumental', 'Instrumental', '2008-08-11 13:31:27', 'yes', 33, 'no', 'none.gif'),
('Acid', 'Acid', '2008-08-11 13:31:27', 'yes', 34, 'no', 'none.gif'),
('House', 'House', '2008-08-11 13:31:27', 'yes', 35, 'no', 'none.gif'),
('Game', 'Game', '2008-08-11 13:31:27', 'yes', 36, 'no', 'none.gif'),
('Sound Clip', 'Sound Clip', '2008-08-11 13:31:27', 'yes', 37, 'no', 'none.gif'),
('Gospel', 'Gospel', '2008-08-11 13:31:27', 'yes', 38, 'no', 'none.gif'),
('Noise', 'Noise', '2008-08-11 13:31:27', 'yes', 39, 'no', 'none.gif'),
('AlternRock', 'AlternRock', '2008-08-11 13:31:27', 'yes', 40, 'no', 'none.gif'),
('Bass', 'Bass', '2008-08-11 13:31:27', 'yes', 41, 'no', 'none.gif'),
('Soul', 'Soul', '2008-08-11 13:31:27', 'yes', 42, 'no', 'none.gif'),
('Punk', 'Punk', '2008-08-11 13:31:27', 'yes', 43, 'no', 'none.gif'),
('Space', 'Space', '2008-08-11 13:31:27', 'yes', 44, 'no', 'none.gif'),
('Meditative', 'Meditative', '2008-08-11 13:31:27', 'yes', 45, 'no', 'none.gif'),
('Instrumental Pop', 'Instrumental Pop', '2008-08-11 13:31:27', 'yes', 46, 'no', 'none.gif'),
('Instrumental Rock', 'Instrumental Rock', '2008-08-11 13:31:27', 'yes', 47, 'no', 'none.gif'),
('Ethnic', 'Ethnic', '2008-08-11 13:31:27', 'yes', 48, 'no', 'none.gif'),
('Gothic', 'Gothic', '2008-08-11 13:31:27', 'yes', 49, 'no', 'none.gif'),
('Darkwave', 'Darkwave', '2008-08-11 13:31:27', 'yes', 50, 'no', 'none.gif'),
('Techno-Industrial', 'Techno-Industrial', '2008-08-11 13:31:27', 'yes', 51, 'no', 'none.gif'),
('Electronic', 'Electronic', '2008-08-11 13:31:27', 'yes', 52, 'no', 'none.gif'),
('Pop-Folk', 'Pop-Folk', '2008-08-11 13:31:27', 'yes', 53, 'no', 'none.gif'),
('Eurodance', 'Eurodance', '2008-08-11 13:31:27', 'yes', 54, 'no', 'none.gif'),
('Dream', 'Dream', '2008-08-11 13:31:27', 'yes', 55, 'no', 'none.gif'),
('Southern Rock', 'Southern Rock', '2008-08-11 13:31:27', 'yes', 56, 'no', 'none.gif'),
('Comedy', 'Comedy', '2008-08-11 13:31:27', 'yes', 57, 'no', 'none.gif'),
('Cult', 'Cult', '2008-08-11 13:31:27', 'yes', 58, 'no', 'none.gif'),
('Gangsta', 'Gangsta', '2008-08-11 13:31:27', 'yes', 59, 'no', 'none.gif'),
('Top 40', 'Top 40', '2008-08-11 13:31:27', 'yes', 60, 'no', 'none.gif'),
('Christian Rap', 'Christian Rap', '2008-08-11 13:31:27', 'yes', 61, 'no', 'none.gif'),
('Pop/Funk', 'Pop/Funk', '2008-08-11 13:31:27', 'yes', 62, 'no', 'none.gif'),
('Jungle', 'Jungle', '2008-08-11 13:31:27', 'yes', 63, 'no', 'none.gif'),
('Native American', 'Native American', '2008-08-11 13:31:27', 'yes', 64, 'no', 'none.gif'),
('Cabaret', 'Cabaret', '2008-08-11 13:31:27', 'yes', 65, 'no', 'none.gif'),
('New Wave', 'New Wave', '2008-08-11 13:31:27', 'yes', 66, 'no', 'none.gif'),
('Psychadelic', 'Psychadelic', '2008-08-11 13:31:27', 'yes', 67, 'no', 'none.gif'),
('Rave', 'Rave', '2008-08-11 13:31:27', 'yes', 68, 'no', 'none.gif'),
('Showtunes', 'Showtunes', '2008-08-11 13:31:27', 'yes', 69, 'no', 'none.gif'),
('Trailer', 'Trailer', '2008-08-11 13:31:27', 'yes', 70, 'no', 'none.gif'),
('Lo-Fi', 'Lo-Fi', '2008-08-11 13:31:27', 'yes', 71, 'no', 'none.gif'),
('Tribal', 'Tribal', '2008-08-11 13:31:27', 'yes', 72, 'no', 'none.gif'),
('Acid Punk', 'Acid Punk', '2008-08-11 13:31:27', 'yes', 73, 'no', 'none.gif'),
('Acid Jazz', 'Acid Jazz', '2008-08-11 13:31:27', 'yes', 74, 'no', 'none.gif'),
('Polka', 'Polka', '2008-08-11 13:31:27', 'yes', 75, 'no', 'none.gif'),
('Retro', 'Retro', '2008-08-11 13:31:27', 'yes', 76, 'no', 'none.gif'),
('Musical', 'Musical', '2008-08-11 13:31:27', 'yes', 77, 'no', 'none.gif'),
('Rock & Roll', 'Rock & Roll', '2008-08-11 13:31:27', 'yes', 78, 'no', 'none.gif'),
('Hard Rock', 'Hard Rock', '2008-08-11 13:31:27', 'yes', 79, 'no', 'none.gif'),
('Folk', 'Folk', '2008-08-11 13:31:27', 'yes', 80, 'no', 'none.gif'),
('Folk-Rock', 'Folk-Rock', '2008-08-11 13:31:27', 'yes', 81, 'no', 'none.gif'),
('National Folk', 'National Folk', '2008-08-11 13:31:27', 'yes', 82, 'no', 'none.gif'),
('Swing', 'Swing', '2008-08-11 13:31:27', 'yes', 83, 'no', 'none.gif'),
('Fast Fusion', 'Fast Fusion', '2008-08-11 13:31:27', 'yes', 84, 'no', 'none.gif'),
('Bebob', 'Bebob', '2008-08-11 13:31:27', 'yes', 85, 'no', 'none.gif'),
('Latin', 'Latin', '2008-08-11 13:31:27', 'yes', 86, 'no', 'none.gif'),
('Revival', 'Revival', '2008-08-11 13:31:27', 'yes', 87, 'no', 'none.gif'),
('Celtic', 'Celtic', '2008-08-11 13:31:27', 'yes', 88, 'no', 'none.gif'),
('Bluegrass', 'Bluegrass', '2008-08-11 13:31:27', 'yes', 89, 'no', 'none.gif'),
('Avantgarde', 'Avantgarde', '2008-08-11 13:31:27', 'yes', 90, 'no', 'none.gif'),
('Gothic Rock', 'Gothic Rock', '2008-08-11 13:31:27', 'yes', 91, 'no', 'none.gif'),
('Progressive Rock', 'Progressive Rock', '2008-08-11 13:31:27', 'yes', 92, 'no', 'none.gif'),
('Psychedelic Rock', 'Psychedelic Rock', '2008-08-11 13:31:27', 'yes', 93, 'no', 'none.gif'),
('Symphonic Rock', 'Symphonic Rock', '2008-08-11 13:31:27', 'yes', 94, 'no', 'none.gif'),
('Slow Rock', 'Slow Rock', '2008-08-11 13:31:27', 'yes', 95, 'no', 'none.gif'),
('Big Band', 'Big Band', '2008-08-11 13:31:27', 'yes', 96, 'no', 'none.gif'),
('Chorus', 'Chorus', '2008-08-11 13:31:27', 'yes', 97, 'no', 'none.gif'),
('Easy Listening', 'Easy Listening', '2008-08-11 13:31:27', 'yes', 98, 'no', 'none.gif'),
('Acoustic', 'Acoustic', '2008-08-11 13:31:27', 'yes', 99, 'no', 'none.gif'),
('Humour', 'Humour', '2008-08-11 13:31:27', 'yes', 100, 'no', 'none.gif'),
('Speech', 'Speech', '2008-08-11 13:31:27', 'yes', 101, 'no', 'none.gif'),
('Chanson', 'Chanson', '2008-08-11 13:31:27', 'yes', 102, 'no', 'none.gif'),
('Opera', 'Opera', '2008-08-11 13:31:27', 'yes', 103, 'no', 'none.gif'),
('Chamber Music', 'Chamber Music', '2008-08-11 13:31:27', 'yes', 104, 'no', 'none.gif'),
('Sonata', 'Sonata', '2008-08-11 13:31:27', 'yes', 105, 'no', 'none.gif'),
('Symphony', 'Symphony', '2008-08-11 13:31:27', 'yes', 106, 'no', 'none.gif'),
('Booty Bass', 'Booty Bass', '2008-08-11 13:31:27', 'yes', 107, 'no', 'none.gif'),
('Primus', 'Primus', '2008-08-11 13:31:27', 'yes', 108, 'no', 'none.gif'),
('Porn Groove', 'Porn Groove', '2008-08-11 13:31:27', 'yes', 109, 'no', 'none.gif'),
('Satire', 'Satire', '2008-08-11 13:31:27', 'yes', 110, 'no', 'none.gif'),
('Slow Jam', 'Slow Jam', '2008-08-11 13:31:27', 'yes', 111, 'no', 'none.gif'),
('Club', 'Club', '2008-08-11 13:31:27', 'yes', 112, 'no', 'none.gif'),
('Tango', 'Tango', '2008-08-11 13:31:27', 'yes', 113, 'no', 'none.gif'),
('Samba', 'Samba', '2008-08-11 13:31:27', 'yes', 114, 'no', 'none.gif'),
('Folklore', 'Folklore', '2008-08-11 13:31:27', 'yes', 115, 'no', 'none.gif'),
('Ballad', 'Ballad', '2008-08-11 13:31:27', 'yes', 116, 'no', 'none.gif'),
('Power Ballad', 'Power Ballad', '2008-08-11 13:31:27', 'yes', 117, 'no', 'none.gif'),
('Rhythmic Soul', 'Rhythmic Soul', '2008-08-11 13:31:27', 'yes', 118, 'no', 'none.gif'),
('Freestyle', 'Freestyle', '2008-08-11 13:31:27', 'yes', 119, 'no', 'none.gif'),
('Duet', 'Duet', '2008-08-11 13:31:27', 'yes', 120, 'no', 'none.gif'),
('Punk Rock', 'Punk Rock', '2008-08-11 13:31:27', 'yes', 121, 'no', 'none.gif'),
('Drum Solo', 'Drum Solo', '2008-08-11 13:31:27', 'yes', 122, 'no', 'none.gif'),
('Acapella', 'Acapella', '2008-08-11 13:31:27', 'yes', 123, 'no', 'none.gif'),
('Euro-House', 'Euro-House', '2008-08-11 13:31:27', 'yes', 124, 'no', 'none.gif'),
('Dance Hall', 'Dance Hall', '2008-08-11 13:31:27', 'yes', 125, 'no', 'none.gif');

-- --------------------------------------------------------

--
-- Table structure for table `group_comments`
--

CREATE TABLE IF NOT EXISTS `group_comments` (
  `by_id` int(12) DEFAULT NULL,
  `by_username` varchar(36) DEFAULT NULL,
  `group_id` int(12) DEFAULT NULL,
  `comments` text,
  `todays_date` datetime DEFAULT NULL,
  `flag_counter` int(4) NOT NULL DEFAULT '0',
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  `topic_id` int(12) DEFAULT NULL,
  PRIMARY KEY (`indexer`),
  KEY `by_id` (`by_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `group_membership`
--

CREATE TABLE IF NOT EXISTS `group_membership` (
  `member_id` int(12) DEFAULT NULL,
  `member_username` varchar(36) DEFAULT NULL,
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  `today_date` datetime DEFAULT NULL,
  `group_admin` varchar(36) DEFAULT NULL,
  `group_id` int(12) DEFAULT NULL,
  `approved` varchar(24) DEFAULT 'yes',
  PRIMARY KEY (`indexer`),
  KEY `member_id` (`member_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `group_profile`
--

CREATE TABLE IF NOT EXISTS `group_profile` (
  `group_name` text,
  `group_name_seo` text,
  `public_private` varchar(8) DEFAULT NULL,
  `todays_date` datetime DEFAULT NULL,
  `group_description` text,
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  `featured` varchar(6) DEFAULT 'no',
  `admin_id` int(12) DEFAULT NULL,
  `flag_counter` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`indexer`),
  KEY `admin_id` (`admin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `group_topics`
--

CREATE TABLE IF NOT EXISTS `group_topics` (
  `group_id` int(12) DEFAULT NULL,
  `todays_date` datetime DEFAULT NULL,
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  `topic_title` text,
  PRIMARY KEY (`indexer`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `group_videos`
--

CREATE TABLE IF NOT EXISTS `group_videos` (
  `video_id` int(12) DEFAULT NULL,
  `group_id` int(12) DEFAULT NULL,
  `member_id` int(12) DEFAULT NULL,
  `todays_date` datetime DEFAULT NULL,
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  `video_status` varchar(36) DEFAULT 'active',
  PRIMARY KEY (`indexer`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `imagecomments`
--

CREATE TABLE IF NOT EXISTS `imagecomments` (
  `by_id` int(12) DEFAULT NULL,
  `by_username` varchar(255) DEFAULT NULL,
  `image_id` int(12) DEFAULT NULL,
  `comments` text,
  `todays_date` datetime DEFAULT NULL,
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  `flag_counter` tinyint(4) NOT NULL DEFAULT '0',
  `allow_ratings` varchar(3) NOT NULL DEFAULT 'yes',
  `rating_number_votes` int(11) DEFAULT NULL,
  `rating_total_points` int(11) DEFAULT NULL,
  `updated_rating` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`indexer`),
  KEY `image_id` (`image_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `imagecomments_rating`
--

CREATE TABLE IF NOT EXISTS `imagecomments_rating` (
  `user_id` int(11) DEFAULT NULL,
  `IP` varchar(15) DEFAULT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `indexer` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`indexer`),
  KEY `comment_id` (`comment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `imagecomments_replys`
--

CREATE TABLE IF NOT EXISTS `imagecomments_replys` (
  `by_id` int(12) DEFAULT NULL,
  `by_username` varchar(255) DEFAULT NULL,
  `imagecomment_id` int(12) DEFAULT NULL,
  `comment_reply` text,
  `todays_date` datetime DEFAULT NULL,
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`indexer`),
  KEY `by_id` (`by_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE IF NOT EXISTS `images` (
  `indexer` int(9) NOT NULL AUTO_INCREMENT,
  `image_id` varchar(24) DEFAULT NULL,
  `gallery_id` int(9) NOT NULL DEFAULT '0',
  `user_id` int(9) DEFAULT NULL,
  `viewtime` datetime DEFAULT NULL,
  `title` text,
  `title_seo` text,
  `description` text,
  `tags` text,
  `gallery_name` text,
  `date_recorded` datetime DEFAULT NULL,
  `date_uploaded` datetime DEFAULT NULL,
  `image_size` varchar(12) DEFAULT NULL,
  `allow_comments` varchar(3) DEFAULT NULL,
  `allow_embedding` varchar(3) DEFAULT NULL,
  `allow_ratings` varchar(3) DEFAULT NULL,
  `rating_number_votes` int(9) DEFAULT NULL,
  `rating_total_points` int(9) DEFAULT NULL,
  `updated_rating` int(9) DEFAULT NULL,
  `public_private` varchar(24) DEFAULT NULL,
  `approved` varchar(24) DEFAULT NULL,
  `number_of_views` int(9) DEFAULT NULL,
  `featured` varchar(3) DEFAULT 'no',
  `promoted` varchar(3) NOT NULL DEFAULT 'no',
  `flag_counter` int(4) NOT NULL DEFAULT '0',
  `media_location` varchar(25) NOT NULL DEFAULT 'localhost',
  `media_quality` varchar(25) NOT NULL DEFAULT 'standard',
  PRIMARY KEY (`indexer`),
  KEY `image_id` (`image_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `image_favorites`
--

CREATE TABLE IF NOT EXISTS `image_favorites` (
  `user_id` smallint(8) DEFAULT NULL,
  `image_id` smallint(8) DEFAULT NULL,
  `indexer_fav` smallint(8) NOT NULL AUTO_INCREMENT,
  `image_status` varchar(12) DEFAULT 'active',
  `owner_id` smallint(8) DEFAULT NULL,
  PRIMARY KEY (`indexer_fav`),
  KEY `image_id` (`image_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `image_galleries`
--

CREATE TABLE IF NOT EXISTS `image_galleries` (
  `gallery_id` int(12) NOT NULL AUTO_INCREMENT,
  `has_images` tinyint(1) NOT NULL DEFAULT '0',
  `user_id` int(12) NOT NULL,
  `gallery_name` varchar(48) DEFAULT NULL,
  `gallery_name_seo` varchar(48) DEFAULT NULL,
  `gallery_description` text,
  `gallery_tags` text NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `approved` varchar(36) NOT NULL DEFAULT 'yes',
  `public_private` varchar(24) NOT NULL DEFAULT 'public',
  `gallery_picture` varchar(32) DEFAULT 'none.png',
  `number_of_views` int(11) NOT NULL DEFAULT '0',
  `viewtime` datetime NOT NULL,
  `allow_comments` varchar(8) NOT NULL DEFAULT 'yes',
  `allow_ratings` varchar(3) NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`gallery_id`),
  KEY `gallery_name` (`gallery_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `image_settings`
--

CREATE TABLE IF NOT EXISTS `image_settings` (
  `album_pic_maxwidth` varchar(10) NOT NULL DEFAULT '600',
  `album_pic_maxheight` varchar(10) NOT NULL DEFAULT '600',
  `album_pic_minwidth` varchar(10) NOT NULL DEFAULT '300',
  `album_pic_minheight` varchar(10) NOT NULL DEFAULT '300',
  `album_pic_maxsize` varchar(10) NOT NULL DEFAULT '600000',
  `member_max_albums` varchar(10) NOT NULL DEFAULT '6',
  `pictures_max_per_album` varchar(10) NOT NULL DEFAULT '50'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `image_settings`
--

INSERT INTO `image_settings` (`album_pic_maxwidth`, `album_pic_maxheight`, `album_pic_minwidth`, `album_pic_minheight`, `album_pic_maxsize`, `member_max_albums`, `pictures_max_per_album`) VALUES
('600', '600', '300', '300', '600000', '6', '50');

-- --------------------------------------------------------

--
-- Table structure for table `media_rating`
--

CREATE TABLE IF NOT EXISTS `media_rating` (
  `user_id` int(12) DEFAULT NULL,
  `IP` varchar(15) NOT NULL,
  `media_id` int(12) DEFAULT NULL,
  `media_type` varchar(24) NOT NULL,
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`indexer`),
  KEY `IP` (`IP`),
  KEY `media_id` (`media_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `member_profile`
--

CREATE TABLE IF NOT EXISTS `member_profile` (
  `account_type` varchar(36) NOT NULL,
  `number_of_views` int(9) NOT NULL DEFAULT '0',
  `viewtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_group` varchar(12) NOT NULL DEFAULT 'member',
  `email_address` varchar(80) NOT NULL,
  `user_name` varchar(36) NOT NULL,
  `password` varchar(32) NOT NULL,
  `passwordSalt` varchar(4) DEFAULT NULL,
  `first_name` varchar(36) DEFAULT NULL,
  `last_name` varchar(36) DEFAULT NULL,
  `zip_code` int(5) DEFAULT NULL,
  `country` text,
  `rating_number_votes` int(9) NOT NULL DEFAULT '0',
  `rating_total_points` int(9) NOT NULL DEFAULT '0',
  `updated_rating` int(9) NOT NULL DEFAULT '0',
  `last_seen` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_ip` varchar(15) NOT NULL DEFAULT '000.000.000.000' COMMENT 'needed later for ip banning',
  `birthday` date DEFAULT NULL,
  `gender` text,
  `relationship_status` text,
  `about_me` text,
  `personal_website` text,
  `home_town` text,
  `home_country` text,
  `current_country` text,
  `high_school` text,
  `college` text,
  `work_places` text,
  `interests` text,
  `fav_movies` text,
  `fav_music` text,
  `current_city` text,
  `user_id` int(12) NOT NULL AUTO_INCREMENT,
  `confirm_email_code` varchar(32) DEFAULT NULL,
  `account_status` varchar(24) DEFAULT NULL,
  `random_code` varchar(32) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `moderator` tinyint(4) NOT NULL DEFAULT '0',
  `flag_counter` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  KEY `user_name` (`user_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `member_profile`
--

INSERT INTO `member_profile` (`account_type`, `number_of_views`, `viewtime`, `user_group`, `email_address`, `user_name`, `password`, `passwordSalt`, `first_name`, `last_name`, `zip_code`, `country`, `rating_number_votes`, `rating_total_points`, `updated_rating`, `last_seen`, `user_ip`, `birthday`, `gender`, `relationship_status`, `about_me`, `personal_website`, `home_town`, `home_country`, `current_country`, `high_school`, `college`, `work_places`, `interests`, `fav_movies`, `fav_music`, `current_city`, `user_id`, `confirm_email_code`, `account_status`, `random_code`, `date_created`, `moderator`, `flag_counter`) VALUES
('standard', 0, '0000-00-00 00:00:00', 'admin', 'linish@localmail.altd.in', 'admin', '5f4dcc3b5aa765d61d8327deb882cf99', '3336', NULL, NULL, NULL, NULL, 0, 0, 0, '0000-00-00 00:00:00', '000.000.000.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'active', 'R6Qt8uj4vzcndeHfN7hdhqihmVAumKY2', '2015-01-30 10:17:58', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE IF NOT EXISTS `messages` (
  `from_username` varchar(36) NOT NULL DEFAULT '',
  `subject` text NOT NULL,
  `message` text NOT NULL,
  `todays_date` datetime NOT NULL,
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  `to_id` int(12) NOT NULL DEFAULT '0',
  `email_read` varchar(10) NOT NULL DEFAULT 'no',
  PRIMARY KEY (`indexer`),
  KEY `to_id` (`to_id`),
  KEY `from_username` (`from_username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `messages_sent`
--

CREATE TABLE IF NOT EXISTS `messages_sent` (
  `to_username` varchar(36) NOT NULL DEFAULT '',
  `subject` text NOT NULL,
  `message` text NOT NULL,
  `todays_date` datetime NOT NULL,
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  `from_id` int(12) NOT NULL DEFAULT '0',
  PRIMARY KEY (`indexer`),
  KEY `from_id` (`from_id`),
  KEY `to_username` (`to_username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `newsletter`
--

CREATE TABLE IF NOT EXISTS `newsletter` (
  `message` text NOT NULL,
  `subject` varchar(120) NOT NULL,
  KEY `subject` (`subject`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `news_flash`
--

CREATE TABLE IF NOT EXISTS `news_flash` (
  `news_id` int(12) NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `publish` varchar(3) NOT NULL DEFAULT 'yes',
  `news_flash` text,
  `news_picture` varchar(24) DEFAULT 'none.gif',
  `news_headline` text NOT NULL,
  PRIMARY KEY (`news_id`),
  KEY `date_created` (`date_created`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `online`
--

CREATE TABLE IF NOT EXISTS `online` (
  `user_ip` varchar(15) NOT NULL,
  `cookie` varchar(32) DEFAULT NULL,
  `session` varchar(32) DEFAULT NULL,
  `last_active` int(11) NOT NULL,
  `last_seen` datetime DEFAULT NULL,
  `logged_in_id` int(11) NOT NULL,
  `logged_in_username` varchar(36) NOT NULL,
  `indexer` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`indexer`),
  KEY `user_ip` (`user_ip`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `online`
--

INSERT INTO `online` (`user_ip`, `cookie`, `session`, `last_active`, `last_seen`, `logged_in_id`, `logged_in_username`, `indexer`) VALUES
('10.10.10.9', NULL, NULL, 1422619450, '2015-01-30 17:34:10', 0, 'guest', 2);

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

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE IF NOT EXISTS `permissions` (
  `user_group` varchar(20) NOT NULL,
  `edit_comments_video` tinyint(4) NOT NULL DEFAULT '0',
  `edit_comments_blog` tinyint(4) NOT NULL DEFAULT '0',
  `edit_comments_audio` tinyint(4) NOT NULL DEFAULT '0',
  `edit_comments_pictures` tinyint(4) NOT NULL DEFAULT '0',
  `edit_comments_group` tinyint(4) NOT NULL DEFAULT '0',
  `edit_comments_profile` tinyint(4) NOT NULL DEFAULT '0',
  `edit_details_member` tinyint(4) NOT NULL DEFAULT '0',
  `edit_details_video` tinyint(4) NOT NULL DEFAULT '0',
  `edit_details_audio` tinyint(4) NOT NULL DEFAULT '0',
  `edit_details_album` tinyint(4) NOT NULL DEFAULT '0',
  `edit_details_picture` tinyint(4) NOT NULL DEFAULT '0',
  `edit_details_blog` tinyint(4) NOT NULL DEFAULT '0',
  `del_comments_video` tinyint(4) NOT NULL DEFAULT '0',
  `del_comments_blog` tinyint(4) NOT NULL DEFAULT '0',
  `del_comments_audio` tinyint(4) NOT NULL DEFAULT '0',
  `del_comments_pictures` tinyint(4) NOT NULL DEFAULT '0',
  `del_comments_group` tinyint(4) NOT NULL DEFAULT '0',
  `del_comments_profile` tinyint(4) NOT NULL DEFAULT '0',
  `del_blog` tinyint(4) NOT NULL DEFAULT '0',
  `del_video` tinyint(4) NOT NULL DEFAULT '0',
  `del_audio` tinyint(4) NOT NULL DEFAULT '0',
  `del_picture` tinyint(4) NOT NULL DEFAULT '0',
  `del_album` tinyint(4) NOT NULL DEFAULT '0',
  `edit_comments_video_own` tinyint(4) NOT NULL DEFAULT '0',
  `edit_comments_blog_own` tinyint(4) NOT NULL DEFAULT '0',
  `edit_comments_audio_own` tinyint(4) NOT NULL DEFAULT '0',
  `edit_comments_pictures_own` tinyint(4) NOT NULL DEFAULT '0',
  `edit_comments_profile_own` tinyint(4) NOT NULL DEFAULT '0',
  `edit_details_member_own` tinyint(4) NOT NULL DEFAULT '0',
  `edit_details_video_own` tinyint(4) NOT NULL DEFAULT '0',
  `edit_details_audio_own` tinyint(4) NOT NULL DEFAULT '0',
  `edit_details_album_own` tinyint(4) NOT NULL DEFAULT '0',
  `edit_details_picture_own` tinyint(4) NOT NULL DEFAULT '0',
  `edit_details_blog_own` tinyint(4) NOT NULL DEFAULT '0',
  `del_comments_video_own` tinyint(4) NOT NULL DEFAULT '0',
  `del_comments_blog_own` tinyint(4) NOT NULL DEFAULT '0',
  `del_comments_audio_own` tinyint(4) NOT NULL DEFAULT '0',
  `del_comments_pictures_own` tinyint(4) NOT NULL DEFAULT '0',
  `del_comments_group_own` tinyint(4) NOT NULL DEFAULT '0',
  `del_comments_profile_own` tinyint(4) NOT NULL DEFAULT '0',
  `del_blog_own` tinyint(4) NOT NULL DEFAULT '0',
  `del_video_own` tinyint(4) NOT NULL DEFAULT '0',
  `del_audio_own` tinyint(4) NOT NULL DEFAULT '0',
  `del_picture_own` tinyint(4) NOT NULL DEFAULT '0',
  `del_album_own` tinyint(4) NOT NULL DEFAULT '0',
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  `edit_comments_group_own` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`indexer`),
  KEY `user_group` (`user_group`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`user_group`, `edit_comments_video`, `edit_comments_blog`, `edit_comments_audio`, `edit_comments_pictures`, `edit_comments_group`, `edit_comments_profile`, `edit_details_member`, `edit_details_video`, `edit_details_audio`, `edit_details_album`, `edit_details_picture`, `edit_details_blog`, `del_comments_video`, `del_comments_blog`, `del_comments_audio`, `del_comments_pictures`, `del_comments_group`, `del_comments_profile`, `del_blog`, `del_video`, `del_audio`, `del_picture`, `del_album`, `edit_comments_video_own`, `edit_comments_blog_own`, `edit_comments_audio_own`, `edit_comments_pictures_own`, `edit_comments_profile_own`, `edit_details_member_own`, `edit_details_video_own`, `edit_details_audio_own`, `edit_details_album_own`, `edit_details_picture_own`, `edit_details_blog_own`, `del_comments_video_own`, `del_comments_blog_own`, `del_comments_audio_own`, `del_comments_pictures_own`, `del_comments_group_own`, `del_comments_profile_own`, `del_blog_own`, `del_video_own`, `del_audio_own`, `del_picture_own`, `del_album_own`, `indexer`, `edit_comments_group_own`) VALUES
('member', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
('standard_mod', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1),
('global_mod', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1),
('admin', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `pictures`
--

CREATE TABLE IF NOT EXISTS `pictures` (
  `file_name` varchar(48) DEFAULT NULL,
  `user_id` int(12) DEFAULT NULL,
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  `todays_date` datetime DEFAULT NULL,
  `approved` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`indexer`),
  KEY `file_name` (`file_name`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `privacy`
--

CREATE TABLE IF NOT EXISTS `privacy` (
  `videocomments` varchar(6) DEFAULT 'yes',
  `profilecomments` varchar(6) DEFAULT 'yes',
  `privatemessage` varchar(6) DEFAULT 'yes',
  `friendsinvite` varchar(6) DEFAULT 'yes',
  `newsletter` varchar(6) DEFAULT 'yes',
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  `user_id` int(12) DEFAULT NULL,
  `publicfavorites` varchar(6) DEFAULT 'yes',
  `publicplaylists` varchar(6) DEFAULT 'yes',
  PRIMARY KEY (`indexer`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `privacy`
--

INSERT INTO `privacy` (`videocomments`, `profilecomments`, `privatemessage`, `friendsinvite`, `newsletter`, `indexer`, `user_id`, `publicfavorites`, `publicplaylists`) VALUES
('yes', 'yes', 'yes', 'yes', 'yes', 1, 1, 'yes', 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `profilecomments`
--

CREATE TABLE IF NOT EXISTS `profilecomments` (
  `by_id` int(11) DEFAULT NULL,
  `by_username` varchar(24) DEFAULT NULL,
  `members_id` int(11) DEFAULT NULL,
  `comments` text,
  `todays_date` datetime DEFAULT NULL,
  `flag_counter` int(4) NOT NULL DEFAULT '0',
  `indexer` int(11) NOT NULL AUTO_INCREMENT,
  `rating_number_votes` int(11) DEFAULT NULL,
  `rating_total_points` int(11) DEFAULT NULL,
  `updated_rating` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`indexer`),
  KEY `by_id` (`by_id`),
  KEY `members_id` (`members_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `profilecomments_rating`
--

CREATE TABLE IF NOT EXISTS `profilecomments_rating` (
  `user_id` int(11) DEFAULT NULL,
  `IP` varchar(15) DEFAULT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `indexer` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`indexer`),
  KEY `user_id` (`user_id`),
  KEY `comment_id` (`comment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `profilecomments_replys`
--

CREATE TABLE IF NOT EXISTS `profilecomments_replys` (
  `by_id` int(12) DEFAULT NULL,
  `by_username` varchar(24) DEFAULT NULL,
  `profilecomment_id` int(12) DEFAULT NULL,
  `comment_reply` text,
  `todays_date` datetime DEFAULT NULL,
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`indexer`),
  KEY `by_id` (`by_id`),
  KEY `profilecomment_id` (`profilecomment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sub_channels`
--

CREATE TABLE IF NOT EXISTS `sub_channels` (
  `has_vids` varchar(3) NOT NULL DEFAULT 'no',
  `sub_channel_id` int(12) NOT NULL AUTO_INCREMENT,
  `parent_channel_id` int(12) NOT NULL,
  `sub_channel_name` varchar(48) DEFAULT NULL,
  `sub_channel_name_seo` varchar(48) DEFAULT NULL,
  `sub_channel_description` text,
  `date_created` datetime DEFAULT NULL,
  `sub_channel_picture` varchar(32) DEFAULT 'none.gif',
  PRIMARY KEY (`sub_channel_id`),
  KEY `parent_channel_id` (`parent_channel_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `videocomments`
--

CREATE TABLE IF NOT EXISTS `videocomments` (
  `by_id` int(12) DEFAULT NULL,
  `by_username` varchar(36) DEFAULT NULL,
  `edit_user_id` tinyint(9) NOT NULL DEFAULT '0',
  `video_id` int(12) DEFAULT NULL,
  `comments` text,
  `todays_date` datetime DEFAULT NULL,
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  `allow_ratings` varchar(3) NOT NULL DEFAULT 'yes',
  `rating_number_votes` int(11) DEFAULT NULL,
  `rating_total_points` int(11) DEFAULT NULL,
  `updated_rating` int(11) NOT NULL DEFAULT '0',
  `flag_counter` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`indexer`),
  KEY `by_id` (`by_id`),
  KEY `video_id` (`video_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `videocomments_rating`
--

CREATE TABLE IF NOT EXISTS `videocomments_rating` (
  `user_id` int(11) DEFAULT NULL,
  `IP` varchar(15) DEFAULT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `indexer` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`indexer`),
  KEY `user_id` (`user_id`),
  KEY `comment_id` (`comment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `videocomments_replys`
--

CREATE TABLE IF NOT EXISTS `videocomments_replys` (
  `by_id` int(12) DEFAULT NULL,
  `by_username` varchar(36) DEFAULT NULL,
  `videocomment_id` int(12) DEFAULT NULL,
  `comment_reply` text,
  `todays_date` datetime DEFAULT NULL,
  `edit_user_id` tinyint(9) DEFAULT '0',
  `indexer` int(12) NOT NULL AUTO_INCREMENT,
  `flag_counter` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`indexer`),
  KEY `by_id` (`by_id`),
  KEY `videocomment_id` (`videocomment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `videos`
--

CREATE TABLE IF NOT EXISTS `videos` (
  `indexer` int(9) NOT NULL AUTO_INCREMENT,
  `video_id` varchar(25) DEFAULT NULL,
  `type` varchar(4) NOT NULL DEFAULT 'flv',
  `response_id` varchar(24) NOT NULL DEFAULT '0',
  `channel_id` int(9) NOT NULL DEFAULT '0',
  `sub_channel_id` int(9) NOT NULL DEFAULT '0',
  `user_id` int(9) DEFAULT NULL,
  `viewtime` datetime DEFAULT NULL,
  `title` text,
  `title_seo` text,
  `description` text,
  `tags` text,
  `channel` varchar(24) DEFAULT NULL,
  `date_recorded` datetime DEFAULT NULL,
  `date_uploaded` datetime DEFAULT NULL,
  `location_recorded` varchar(48) NOT NULL DEFAULT 'Unkown',
  `video_length` varchar(12) DEFAULT NULL,
  `allow_comments` varchar(3) DEFAULT NULL,
  `allow_embedding` varchar(3) DEFAULT NULL,
  `allow_ratings` varchar(3) DEFAULT NULL,
  `rating_number_votes` int(9) DEFAULT NULL,
  `rating_total_points` int(9) DEFAULT NULL,
  `updated_rating` int(9) DEFAULT NULL,
  `public_private` varchar(24) DEFAULT NULL,
  `approved` varchar(24) DEFAULT NULL,
  `number_of_views` int(9) DEFAULT NULL,
  `featured` varchar(3) DEFAULT 'no',
  `promoted` varchar(3) NOT NULL DEFAULT 'no',
  `flag_counter` int(4) NOT NULL DEFAULT '0',
  `video_type` varchar(25) NOT NULL DEFAULT 'uploaded',
  `embed_id` varchar(25) DEFAULT NULL,
  `media_location` varchar(25) NOT NULL DEFAULT 'localhost',
  `media_quality` varchar(25) NOT NULL DEFAULT 'standard',
  PRIMARY KEY (`indexer`),
  KEY `video_id` (`video_id`),
  KEY `response_id` (`response_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `video_playlist`
--

CREATE TABLE IF NOT EXISTS `video_playlist` (
  `list_id` int(11) NOT NULL AUTO_INCREMENT,
  `list_name` text NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`list_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `video_playlist_lists`
--

CREATE TABLE IF NOT EXISTS `video_playlist_lists` (
  `list_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `video_id` int(11) DEFAULT NULL,
  `video_file_name` varchar(250) DEFAULT '',
  `video_position` int(11) DEFAULT NULL,
  `indexer` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`indexer`),
  KEY `list_id` (`list_id`),
  KEY `user_id` (`user_id`),
  KEY `video_id` (`video_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `video_settings`
--

CREATE TABLE IF NOT EXISTS `video_settings` (
  `video_watermark` varchar(5) DEFAULT 'no',
  `video_watermark_place` varchar(20) DEFAULT 'right_bottom',
  `video_resize` varchar(5) DEFAULT 'yes',
  `video_convert_pass` varchar(5) DEFAULT '1',
  `video_ffmpeg_size` varchar(20) DEFAULT '560x420',
  `video_ffmpeg_bit_rate` varchar(20) DEFAULT '300k',
  `video_ffmpeg_audio_rate` varchar(10) DEFAULT '44100',
  `video_ffmpeg_high_quality` varchar(5) DEFAULT 'no',
  `video_ffmpeg_hq` varchar(25) DEFAULT '-sameq',
  `video_ffmpeg_hq_size` varchar(12) DEFAULT '720x480',
  `video_ffmpeg_qmax` varchar(5) DEFAULT '3',
  `video_mencoder_vbitrate` varchar(5) DEFAULT '800',
  `video_mencoder_scale` varchar(20) DEFAULT '560:420',
  `video_mencoder_srate` varchar(20) DEFAULT '22050',
  `video_mencoder_audio_rate` varchar(5) DEFAULT '56'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `video_settings`
--

INSERT INTO `video_settings` (`video_watermark`, `video_watermark_place`, `video_resize`, `video_convert_pass`, `video_ffmpeg_size`, `video_ffmpeg_bit_rate`, `video_ffmpeg_audio_rate`, `video_ffmpeg_high_quality`, `video_ffmpeg_hq`, `video_ffmpeg_hq_size`, `video_ffmpeg_qmax`, `video_mencoder_vbitrate`, `video_mencoder_scale`, `video_mencoder_srate`, `video_mencoder_audio_rate`) VALUES
('no', 'right_bottom', 'yes', '1', '560x420', '300k', '44100', 'no', '-sameq', '720x480', '3', '800', '560:420', '22050', '56');

-- --------------------------------------------------------

--
-- Table structure for table `views_tracker`
--

CREATE TABLE IF NOT EXISTS `views_tracker` (
  `ipaddress` varchar(25) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `media_type` varchar(10) DEFAULT NULL,
  `media_id` int(20) DEFAULT NULL,
  `date_viewed` date DEFAULT NULL,
  `indexer` int(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`indexer`),
  KEY `media_id` (`media_id`),
  KEY `media_type` (`media_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
