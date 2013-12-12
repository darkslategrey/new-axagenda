-- MySQL dump 10.13  Distrib 5.5.34, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: mycalendar_default
-- ------------------------------------------------------
-- Server version	5.5.34-0ubuntu0.13.04.1-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `calendar_event`
--

DROP TABLE IF EXISTS `calendar_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_event` (
  `id` bigint(255) NOT NULL AUTO_INCREMENT,
  `userId` bigint(255) NOT NULL,
  `calendarId` bigint(255) NOT NULL,
  `repeatType` longtext NOT NULL,
  `startTime` varchar(255) NOT NULL,
  `endTime` varchar(255) NOT NULL,
  `creation_date` datetime NOT NULL,
  `description` longtext,
  `subject` varchar(255) DEFAULT NULL,
  `update_date` datetime NOT NULL,
  `locked` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2A9BEA59743E7F7` (`calendarId`),
  KEY `FK2A9BEA59581C403A` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_event`
--

LOCK TABLES `calendar_event` WRITE;
/*!40000 ALTER TABLE `calendar_event` DISABLE KEYS */;
INSERT INTO `calendar_event` VALUES (1,1,1,'no','2013-12-09 11:00','2013-12-09 12:00','2013-12-11 19:21:44','ljkfkldsjlk','kfjskljfkld','2013-12-11 19:21:44',0),(2,1,2,'no','2013-12-10 13:00','2013-12-10 14:00','2013-12-11 19:22:54','ljfkldls','ljdflkjs','2013-12-11 19:22:54',0);
/*!40000 ALTER TABLE `calendar_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendar_event_reminder`
--

DROP TABLE IF EXISTS `calendar_event_reminder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_event_reminder` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `eventId` int(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `early` int(255) NOT NULL,
  `unit` varchar(255) NOT NULL,
  `alerted` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_event_reminder`
--

LOCK TABLES `calendar_event_reminder` WRITE;
/*!40000 ALTER TABLE `calendar_event_reminder` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendar_event_reminder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendar_setting`
--

DROP TABLE IF EXISTS `calendar_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_setting` (
  `userId` int(255) NOT NULL,
  `hourFormat` varchar(255) DEFAULT NULL,
  `dayFormat` varchar(255) DEFAULT NULL,
  `weekFormat` varchar(255) DEFAULT NULL,
  `monthFormat` varchar(255) DEFAULT NULL,
  `fromtoFormat` varchar(255) DEFAULT NULL,
  `activeStartTime` varchar(255) NOT NULL,
  `activeEndTime` varchar(255) NOT NULL,
  `createByDblclick` tinyint(1) NOT NULL,
  `hideInactiveRow` tinyint(1) NOT NULL,
  `singleDay` tinyint(1) NOT NULL,
  `language` varchar(255) NOT NULL,
  `intervalSlot` int(255) NOT NULL DEFAULT '30',
  `startDay` varchar(255) NOT NULL DEFAULT '0',
  `readOnly` tinyint(1) DEFAULT NULL,
  `initialView` int(11) NOT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_setting`
--

LOCK TABLES `calendar_setting` WRITE;
/*!40000 ALTER TABLE `calendar_setting` DISABLE KEYS */;
INSERT INTO `calendar_setting` VALUES (1,'24','l M d Y','m/d(D)','m/d','m/d/Y','09:00','19:00',0,0,0,'fr',30,'0',0,1);
/*!40000 ALTER TABLE `calendar_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendar_type`
--

DROP TABLE IF EXISTS `calendar_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_type` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `userId` int(255) NOT NULL,
  `color` varchar(255) NOT NULL,
  `creation_date` datetime NOT NULL,
  `description` longtext,
  `hide` tinyint(1) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7503A39B581C403A` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_type`
--

LOCK TABLES `calendar_type` WRITE;
/*!40000 ALTER TABLE `calendar_type` DISABLE KEYS */;
INSERT INTO `calendar_type` VALUES (1,1,'blue','2013-10-22 09:28:52',NULL,0,'demo','2013-12-11 19:23:21'),(2,1,'purple','2013-12-11 19:22:20','demo 2',0,'demo 2','2013-12-11 19:23:28');
/*!40000 ALTER TABLE `calendar_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_show` int(1) NOT NULL,
  `enabled` int(1) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `passwd` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'demo','demo',0,0,'demo','demo','demo','demo');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-12-12  5:22:50
