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
-- Table structure for table `medications`
--

DROP TABLE IF EXISTS `medications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `name` varchar(120) NOT NULL,
  `dose` varchar(80) NOT NULL,
  `frequency` varchar(80) NOT NULL,
  `time_label` varchar(80) NOT NULL,
  `color` varchar(20) NOT NULL DEFAULT '#0F766E',
  `taken` tinyint(1) NOT NULL DEFAULT '0',
  `type` enum('pastilla','capsula','jarabe','inyeccion') NOT NULL DEFAULT 'pastilla',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_medications_user` (`user_id`),
  CONSTRAINT `fk_medications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medications`
--

LOCK TABLES `medications` WRITE;
/*!40000 ALTER TABLE `medications` DISABLE KEYS */;
INSERT INTO `medications` VALUES (1,2,'Metformina','850mg','Diario','08:00','#0F766E',1,'pastilla','2026-08-11 00:56:01','2026-08-11 00:56:01'),(2,2,'Losart├ín','50mg','Diario','08:00','#2563EB',1,'pastilla','2026-08-11 00:56:01','2026-08-20 06:15:10'),(3,2,'Salbutamol','100mcg','PRN','Seg├║n necesidad','#8B5CF6',0,'inyeccion','2026-08-11 00:56:01','2026-08-11 00:56:01'),(4,2,'Vitamina D','1000UI','Diario','12:00','#F59E0B',1,'capsula','2026-08-11 00:56:01','2026-08-11 00:56:01'),(5,2,'Omega 3','1g','Diario','13:00','#22C55E',1,'capsula','2026-08-11 00:56:01','2026-08-20 06:15:07'),(7,10,'Metformina','850mg','Diario','08:00','#0F766E',1,'pastilla','2026-08-17 23:26:52','2026-08-17 23:26:52'),(8,10,'Losart├â┬ín','50mg','Diario','08:00','#2563EB',1,'pastilla','2026-08-17 23:26:52','2026-08-17 23:26:52'),(9,10,'Vitamina D','1000UI','Diario','12:00','#F59E0B',1,'capsula','2026-08-17 23:26:52','2026-08-17 23:26:52'),(10,10,'Omega 3','1g','Diario','13:00','#22C55E',1,'capsula','2026-08-17 23:26:52','2026-08-17 23:29:47'),(12,10,'Aspirina','55mg','Diario','08:00','#0F766E',1,'pastilla','2026-08-18 00:56:35','2026-08-18 02:08:43'),(13,10,'Ejemplo','500 mg','Cada 8 horas','08:00','#0F766E',0,'jarabe','2026-08-18 16:18:05','2026-08-18 16:18:05'),(14,11,'Ejemplo','566','Cada 12 horas','08:00','#0F766E',0,'pastilla','2026-08-18 18:23:20','2026-08-18 18:23:20'),(15,15,'Amoxicilina','500g','Diario','13:20','#0F766E',1,'pastilla','2026-08-18 18:50:58','2026-08-18 18:51:02'),(16,19,'Prednisolona','10mg','Diario','12:00','#0F766E',0,'pastilla','2026-08-19 18:53:57','2026-08-19 18:53:57'),(17,4,'Omeprazol','20mg','Diario','07:00','#8B5CF6',1,'capsula','2026-08-20 04:50:15','2026-08-20 04:50:15'),(18,4,'Paracetamol','500mg','Cada 8 horas','08:00','#2563EB',0,'pastilla','2026-08-20 04:50:15','2026-08-20 04:50:15'),(19,4,'Losartán','50mg','Diario','08:00','#0F766E',0,'pastilla','2026-08-20 04:50:15','2026-08-20 04:50:15'),(20,4,'Metformina','850mg','Diario','08:00','#F59E0B',0,'pastilla','2026-08-20 04:50:15','2026-08-20 04:50:15'),(21,4,'Omega 3','1g','Diario','13:00','#F59E0B',0,'capsula','2026-08-20 04:50:15','2026-08-20 04:50:15');
/*!40000 ALTER TABLE `medications` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-21  9:27:31
