CREATE DATABASE  IF NOT EXISTS `carrers` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `carrers`;
-- MySQL dump 10.13  Distrib 5.5.37, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: carrers
-- ------------------------------------------------------
-- Server version	5.5.37-0ubuntu0.13.10.1

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
-- Table structure for table `tbl_job`
--

DROP TABLE IF EXISTS `tbl_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_job` (
  `ID` int(11) NOT NULL,
  `Title` varchar(50) DEFAULT NULL,
  `Description` varchar(150) DEFAULT NULL,
  `Type` enum('Permanent','Part-Time','Full-Time') DEFAULT NULL,
  `Experience` varchar(45) DEFAULT NULL,
  `BeginDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `TravelRequired` enum('TRUE','FALSE') DEFAULT NULL,
  `RelocationCovered` enum('TRUE','FALSE') DEFAULT NULL,
  `Posted_date` date DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_job`
--

LOCK TABLES `tbl_job` WRITE;
/*!40000 ALTER TABLE `tbl_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_job_location`
--

DROP TABLE IF EXISTS `tbl_job_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_job_location` (
  `ID_job` int(11) NOT NULL,
  `ID_location` int(11) NOT NULL,
  `Street` varchar(60) DEFAULT NULL,
  `PostalCode` varchar(20) DEFAULT NULL,
  `Latitude` float DEFAULT NULL,
  `Longitude` float DEFAULT NULL,
  PRIMARY KEY (`ID_job`,`ID_location`),
  KEY `fk_tbl_job_location_2_idx` (`ID_location`),
  CONSTRAINT `fk_tbl_job_location_1` FOREIGN KEY (`ID_job`) REFERENCES `tbl_job` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_job_location_2` FOREIGN KEY (`ID_location`) REFERENCES `tbl_locations` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_job_location`
--

LOCK TABLES `tbl_job_location` WRITE;
/*!40000 ALTER TABLE `tbl_job_location` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_job_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_job_payment`
--

DROP TABLE IF EXISTS `tbl_job_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_job_payment` (
  `ID_job` int(11) NOT NULL,
  `ID_payment` int(11) NOT NULL,
  PRIMARY KEY (`ID_job`,`ID_payment`),
  KEY `fk_tbl_job_payment_2_idx` (`ID_payment`),
  CONSTRAINT `fk_tbl_job_payment_1` FOREIGN KEY (`ID_job`) REFERENCES `tbl_job` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_job_payment_2` FOREIGN KEY (`ID_payment`) REFERENCES `tbl_payment` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_job_payment`
--

LOCK TABLES `tbl_job_payment` WRITE;
/*!40000 ALTER TABLE `tbl_job_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_job_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_job_recruiter`
--

DROP TABLE IF EXISTS `tbl_job_recruiter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_job_recruiter` (
  `ID_job` int(11) NOT NULL,
  `ID_recruiter` int(11) NOT NULL,
  PRIMARY KEY (`ID_job`,`ID_recruiter`),
  KEY `fk_tbl_job_recruiter_2_idx` (`ID_recruiter`),
  CONSTRAINT `fk_tbl_job_recruiter_1` FOREIGN KEY (`ID_job`) REFERENCES `tbl_job` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_job_recruiter_2` FOREIGN KEY (`ID_recruiter`) REFERENCES `tbl_recruiter` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_job_recruiter`
--

LOCK TABLES `tbl_job_recruiter` WRITE;
/*!40000 ALTER TABLE `tbl_job_recruiter` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_job_recruiter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_job_req`
--

DROP TABLE IF EXISTS `tbl_job_req`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_job_req` (
  `ID_job` int(11) NOT NULL,
  `ID_req` int(11) NOT NULL,
  PRIMARY KEY (`ID_job`,`ID_req`),
  KEY `fk_tbl_job_req_2_idx` (`ID_req`),
  CONSTRAINT `fk_tbl_job_req_1` FOREIGN KEY (`ID_job`) REFERENCES `tbl_job` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_job_req_2` FOREIGN KEY (`ID_req`) REFERENCES `tbl_requirements` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_job_req`
--

LOCK TABLES `tbl_job_req` WRITE;
/*!40000 ALTER TABLE `tbl_job_req` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_job_req` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_job_skills`
--

DROP TABLE IF EXISTS `tbl_job_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_job_skills` (
  `ID_job` int(11) NOT NULL,
  `ID_skils` int(11) NOT NULL,
  PRIMARY KEY (`ID_job`,`ID_skils`),
  KEY `fk_tbl_job_skills_2_idx` (`ID_skils`),
  CONSTRAINT `fk_tbl_job_skills_1` FOREIGN KEY (`ID_job`) REFERENCES `tbl_job` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_job_skills_2` FOREIGN KEY (`ID_skils`) REFERENCES `tbl_skills` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_job_skills`
--

LOCK TABLES `tbl_job_skills` WRITE;
/*!40000 ALTER TABLE `tbl_job_skills` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_job_skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_locations`
--

DROP TABLE IF EXISTS `tbl_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_locations` (
  `ID` int(11) NOT NULL,
  `City` varchar(50) NOT NULL,
  `State` varchar(50) NOT NULL,
  `Country` varchar(40) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_locations`
--

LOCK TABLES `tbl_locations` WRITE;
/*!40000 ALTER TABLE `tbl_locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_payment`
--

DROP TABLE IF EXISTS `tbl_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_payment` (
  `ID` int(11) NOT NULL,
  `Min_Amount` int(11) DEFAULT NULL,
  `Max_Amount` int(11) DEFAULT NULL,
  `Type` enum('Hour','Day','Week','Month','Year') DEFAULT NULL,
  `Exchange` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_payment`
--

LOCK TABLES `tbl_payment` WRITE;
/*!40000 ALTER TABLE `tbl_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_recruiter`
--

DROP TABLE IF EXISTS `tbl_recruiter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_recruiter` (
  `ID` int(11) NOT NULL,
  `Name` varchar(70) DEFAULT NULL,
  `PageUrl` varchar(150) DEFAULT NULL,
  `LogoUrl` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_recruiter`
--

LOCK TABLES `tbl_recruiter` WRITE;
/*!40000 ALTER TABLE `tbl_recruiter` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_recruiter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_requirements`
--

DROP TABLE IF EXISTS `tbl_requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_requirements` (
  `ID` int(11) NOT NULL,
  `Description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_requirements`
--

LOCK TABLES `tbl_requirements` WRITE;
/*!40000 ALTER TABLE `tbl_requirements` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_requirements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_skills`
--

DROP TABLE IF EXISTS `tbl_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_skills` (
  `ID` int(11) NOT NULL,
  `Description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_skills`
--

LOCK TABLES `tbl_skills` WRITE;
/*!40000 ALTER TABLE `tbl_skills` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_skills` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-02-05  9:55:51
