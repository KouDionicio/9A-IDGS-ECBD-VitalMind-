CREATE DATABASE  IF NOT EXISTS `vitalmind` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `vitalmind`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: vitalmind
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `symptom_logs`
--

DROP TABLE IF EXISTS `symptom_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `symptom_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `pain` int NOT NULL DEFAULT '0',
  `temperature` decimal(4,1) DEFAULT NULL,
  `systolic` int DEFAULT NULL,
  `diastolic` int DEFAULT NULL,
  `glucose` int DEFAULT NULL,
  `weight` decimal(5,1) DEFAULT NULL,
  `heart_rate` int DEFAULT NULL,
  `mood` enum('Muy bien','Bien','Regular','Mal','Muy mal') DEFAULT NULL,
  `notes` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_symptom_logs_user` (`user_id`),
  CONSTRAINT `fk_symptom_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `symptom_logs`
--

LOCK TABLES `symptom_logs` WRITE;
/*!40000 ALTER TABLE `symptom_logs` DISABLE KEYS */;
INSERT INTO `symptom_logs` VALUES (2,10,3,36.7,118,76,96,50.4,78,'Regular','Dolor de cabeza leve despu?s de una jornada pesada.','2026-07-21 00:00:00'),(3,10,2,36.6,116,74,91,50.3,76,'Bien','Ligero cansancio durante la tarde.','2026-07-26 00:00:00'),(4,10,4,36.8,120,78,99,50.2,80,'Regular','Dolor muscular leve despu?s de ejercicio.','2026-07-31 00:00:00'),(5,10,3,36.6,117,75,94,50.1,77,'Bien','Dolor de cabeza ocasional.','2026-08-06 00:00:00'),(6,10,2,36.5,115,73,92,50.0,75,'Bien','Sin molestias importantes.','2026-08-11 00:00:00'),(7,10,1,36.5,114,72,90,49.9,74,'Muy bien','Mejor sensaci?n general durante el d?a.','2026-08-15 00:00:00'),(8,10,9,36.5,128,80,67,78.0,77,'Muy mal','Me siento mal','2026-08-18 16:09:03'),(9,12,8,39.0,120,79,92,72.0,72,'Mal','Me siento muy mal...','2026-08-18 18:28:28'),(10,12,8,39.0,120,82,91,72.0,73,'Mal','Me siento muy mall.','2026-08-18 18:33:37'),(11,15,2,36.0,120,80,90,78.0,72,'Bien','Dolor de cabeza','2026-08-18 18:49:06'),(12,16,4,39.0,120,80,90,69.0,72,'Regular','Me siento mal, me mareo mucho al caminar.','2026-08-18 19:20:25'),(13,16,0,NULL,NULL,NULL,NULL,NULL,NULL,'Regular',NULL,'2026-08-18 19:23:24'),(14,17,4,37.1,112,80,90,56.0,80,'Regular','Tomando paracetamol con coca bien fría ','2026-08-19 00:17:42'),(15,10,10,41.9,120,80,57,50.0,120,'Muy mal','Me quiero morir','2026-08-19 19:20:58'),(16,10,10,67.0,954,12,2,158.0,20,'Muy bien','Me quiero suicidar porque el randini me reprovo alv','2026-08-19 19:25:18');
/*!40000 ALTER TABLE `symptom_logs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-21  9:27:38
