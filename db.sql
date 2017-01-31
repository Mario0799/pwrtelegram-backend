-- MySQL dump 10.13  Distrib 5.5.54, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: pwrtelegram
-- ------------------------------------------------------
-- Server version	5.5.54-0+deb8u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `pwrtelegram`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `pwrtelegram` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `pwrtelegram`;

--
-- Table structure for table `broadcast`
--

DROP TABLE IF EXISTS `broadcast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `broadcast` (
  `namespace` varchar(255) NOT NULL,
  `chat_id` varchar(255) NOT NULL,
  `subbed` tinyint(1) NOT NULL,
  UNIQUE KEY `namespace` (`namespace`,`chat_id`,`subbed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dl`
--

DROP TABLE IF EXISTS `dl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dl` (
  `file_id` varchar(255) DEFAULT NULL,
  `file_size` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `bot` varchar(255) NOT NULL,
  `location` mediumtext NOT NULL,
  `mime` varchar(255) NOT NULL,
  `backend` int(10) unsigned NOT NULL,
  UNIQUE KEY `file_id` (`file_id`,`file_size`,`file_path`,`bot`,`backend`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dl_new`
--

DROP TABLE IF EXISTS `dl_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dl_new` (
  `file_id` varchar(255) DEFAULT NULL,
  `file_size` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `bot` varchar(255) NOT NULL,
  `location` text NOT NULL,
  `mime` varchar(255) NOT NULL,
  UNIQUE KEY `file_id` (`file_id`,`file_size`,`file_path`,`bot`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hooks`
--

DROP TABLE IF EXISTS `hooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hooks` (
  `user` varchar(255) NOT NULL,
  `hash` varchar(255) NOT NULL,
  UNIQUE KEY `user` (`user`,`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ul`
--

DROP TABLE IF EXISTS `ul`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ul` (
  `file_id` varchar(255) DEFAULT NULL,
  `file_size` int(11) NOT NULL,
  `file_hash` varchar(255) NOT NULL,
  `file_type` varchar(255) DEFAULT NULL,
  `bot` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  UNIQUE KEY `file_id` (`file_id`,`file_hash`,`bot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Current Database: `deeppwrtelegram`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `deeppwrtelegram` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `deeppwrtelegram`;

--
-- Table structure for table `broadcast`
--

DROP TABLE IF EXISTS `broadcast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `broadcast` (
  `namespace` varchar(255) NOT NULL,
  `chat_id` varchar(255) NOT NULL,
  `subbed` tinyint(1) NOT NULL,
  UNIQUE KEY `namespace` (`namespace`,`chat_id`,`subbed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dl`
--

DROP TABLE IF EXISTS `dl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dl` (
  `file_id` varchar(255) DEFAULT NULL,
  `file_size` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `bot` varchar(255) NOT NULL,
  `location` mediumtext NOT NULL,
  `mime` varchar(255) NOT NULL,
  `backend` int(10) unsigned NOT NULL,
  UNIQUE KEY `file_id` (`file_id`,`file_size`,`file_path`,`bot`,`backend`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hooks`
--

DROP TABLE IF EXISTS `hooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hooks` (
  `user` varchar(255) NOT NULL,
  `hash` varchar(255) NOT NULL,
  UNIQUE KEY `user` (`user`,`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ul`
--

DROP TABLE IF EXISTS `ul`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ul` (
  `file_id` varchar(255) DEFAULT NULL,
  `file_size` int(11) NOT NULL,
  `file_hash` varchar(255) NOT NULL,
  `file_type` varchar(255) DEFAULT NULL,
  `bot` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  UNIQUE KEY `file_id` (`file_id`,`file_size`,`file_hash`,`file_type`,`bot`,`file_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-30 17:13:07
