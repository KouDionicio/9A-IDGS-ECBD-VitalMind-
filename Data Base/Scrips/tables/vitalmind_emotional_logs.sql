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
-- Table structure for table `emotional_logs`
--

DROP TABLE IF EXISTS `emotional_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emotional_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `mood` enum('Muy bien','Bien','Regular','Mal','Muy mal') NOT NULL,
  `stress_level` tinyint unsigned NOT NULL,
  `energy_level` tinyint unsigned NOT NULL,
  `sleep_quality` tinyint unsigned NOT NULL,
  `notes` text,
  `log_date` date NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_emotional_logs_user_day` (`user_id`,`log_date`),
  CONSTRAINT `fk_emotional_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chk_emotional_energy` CHECK ((`energy_level` between 1 and 10)),
  CONSTRAINT `chk_emotional_sleep_quality` CHECK ((`sleep_quality` between 1 and 10)),
  CONSTRAINT `chk_emotional_stress` CHECK ((`stress_level` between 1 and 10))
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emotional_logs`
--

LOCK TABLES `emotional_logs` WRITE;
/*!40000 ALTER TABLE `emotional_logs` DISABLE KEYS */;
INSERT INTO `emotional_logs` VALUES (2,2,'Regular',8,3,7,'supongo que medio , esta muy pesado','2026-08-17','2026-08-17 21:54:58','2026-08-17 21:54:58'),(3,10,'Regular',7,4,5,'Semana con m?s estr?s y descanso irregular.','2026-07-19','2026-08-17 23:29:47','2026-08-17 23:29:47'),(4,10,'Regular',8,3,4,'Semana con m?s estr?s y descanso irregular.','2026-07-20','2026-08-17 23:29:47','2026-08-17 23:29:47'),(5,10,'Regular',7,4,5,'Semana con m?s estr?s y descanso irregular.','2026-07-21','2026-08-17 23:29:47','2026-08-17 23:29:47'),(6,10,'Regular',8,3,4,'Semana con m?s estr?s y descanso irregular.','2026-07-22','2026-08-17 23:29:47','2026-08-17 23:29:47'),(7,10,'Regular',7,4,5,'Semana con m?s estr?s y descanso irregular.','2026-07-23','2026-08-17 23:29:47','2026-08-17 23:29:47'),(8,10,'Regular',8,3,4,'Semana con m?s estr?s y descanso irregular.','2026-07-24','2026-08-17 23:29:47','2026-08-17 23:29:47'),(9,10,'Regular',7,4,5,'Semana con m?s estr?s y descanso irregular.','2026-07-25','2026-08-17 23:29:47','2026-08-17 23:29:47'),(10,10,'Regular',8,3,4,'Semana con m?s estr?s y descanso irregular.','2026-07-26','2026-08-17 23:29:47','2026-08-17 23:29:47'),(11,10,'Regular',6,5,6,'Mejorando poco a poco la rutina.','2026-07-27','2026-08-17 23:29:47','2026-08-17 23:29:47'),(12,10,'Mal',7,4,5,'Mejorando poco a poco la rutina.','2026-07-28','2026-08-17 23:29:47','2026-08-17 23:29:47'),(13,10,'Regular',6,5,6,'Mejorando poco a poco la rutina.','2026-07-29','2026-08-17 23:29:47','2026-08-17 23:29:47'),(14,10,'Regular',7,4,5,'Mejorando poco a poco la rutina.','2026-07-30','2026-08-17 23:29:47','2026-08-17 23:29:47'),(15,10,'Regular',6,5,6,'Mejorando poco a poco la rutina.','2026-07-31','2026-08-17 23:29:47','2026-08-17 23:29:47'),(16,10,'Regular',6,5,6,'Mejorando poco a poco la rutina.','2026-08-01','2026-08-17 23:29:47','2026-08-17 23:29:47'),(17,10,'Regular',7,4,5,'Mejorando poco a poco la rutina.','2026-08-02','2026-08-17 23:29:47','2026-08-17 23:29:47'),(18,10,'Regular',6,6,7,'He tenido d?as con mejor energ?a.','2026-08-03','2026-08-17 23:29:47','2026-08-17 23:29:47'),(19,10,'Bien',5,5,6,'He tenido d?as con mejor energ?a.','2026-08-04','2026-08-17 23:29:47','2026-08-17 23:29:47'),(20,10,'Bien',6,6,7,'He tenido d?as con mejor energ?a.','2026-08-05','2026-08-17 23:29:47','2026-08-17 23:29:47'),(21,10,'Regular',5,5,6,'He tenido d?as con mejor energ?a.','2026-08-06','2026-08-17 23:29:47','2026-08-17 23:29:47'),(22,10,'Bien',6,6,7,'He tenido d?as con mejor energ?a.','2026-08-07','2026-08-17 23:29:47','2026-08-17 23:29:47'),(23,10,'Bien',5,5,6,'He tenido d?as con mejor energ?a.','2026-08-08','2026-08-17 23:29:47','2026-08-17 23:29:47'),(24,10,'Regular',6,6,7,'He tenido d?as con mejor energ?a.','2026-08-09','2026-08-17 23:29:47','2026-08-17 23:29:47'),(25,10,'Muy bien',3,7,7,'Me siento mejor y estoy manteniendo una rutina m?s estable.','2026-08-10','2026-08-17 23:29:47','2026-08-17 23:29:47'),(26,10,'Muy bien',4,7,8,'Me siento mejor y estoy manteniendo una rutina m?s estable.','2026-08-11','2026-08-17 23:29:47','2026-08-17 23:29:47'),(27,10,'Bien',3,7,7,'Me siento mejor y estoy manteniendo una rutina m?s estable.','2026-08-12','2026-08-17 23:29:47','2026-08-17 23:29:47'),(28,10,'Muy bien',4,7,8,'Me siento mejor y estoy manteniendo una rutina m?s estable.','2026-08-13','2026-08-17 23:29:47','2026-08-17 23:29:47'),(29,10,'Muy bien',3,7,7,'Me siento mejor y estoy manteniendo una rutina m?s estable.','2026-08-14','2026-08-17 23:29:47','2026-08-17 23:29:47'),(30,10,'Muy bien',4,7,8,'Me siento mejor y estoy manteniendo una rutina m?s estable.','2026-08-15','2026-08-17 23:29:47','2026-08-17 23:29:47'),(31,10,'Bien',3,7,7,'Me siento mejor y estoy manteniendo una rutina m?s estable.','2026-08-16','2026-08-17 23:29:47','2026-08-17 23:29:47'),(32,10,'Muy bien',4,7,8,'Me siento mejor y estoy manteniendo una rutina m?s estable.','2026-08-17','2026-08-17 23:29:47','2026-08-17 23:29:47'),(34,10,'Regular',9,5,6,'mal','2026-08-18','2026-08-18 00:01:10','2026-08-18 00:01:10'),(35,15,'Muy bien',8,7,9,'Hoy he estado estresado','2026-08-18','2026-08-18 18:46:45','2026-08-18 18:46:45'),(36,19,'Muy mal',10,1,2,NULL,'2026-08-19','2026-08-19 18:53:16','2026-08-19 18:53:16');
/*!40000 ALTER TABLE `emotional_logs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-21  9:27:37
