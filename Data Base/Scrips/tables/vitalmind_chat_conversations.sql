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
-- Table structure for table `chat_conversations`
--

DROP TABLE IF EXISTS `chat_conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_conversations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `title` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Conversaci├â┬│n de VitalMind',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_chat_conversations_user_id` (`user_id`),
  CONSTRAINT `fk_chat_conversations_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_conversations`
--

LOCK TABLES `chat_conversations` WRITE;
/*!40000 ALTER TABLE `chat_conversations` DISABLE KEYS */;
INSERT INTO `chat_conversations` VALUES (1,10,'Conversaci├│n de VitalMind','2026-08-17 20:24:53','2026-08-17 20:49:00'),(2,10,'Nueva conversaci├│n','2026-08-17 20:48:59','2026-08-17 20:48:59'),(3,10,'que es mejor react o angular','2026-08-17 20:49:13','2026-08-17 20:49:36'),(4,10,'┬┐C├│mo mejorar mi sue├▒o?','2026-08-17 20:49:52','2026-08-17 21:44:24'),(5,2,'Hola , no me siento bien','2026-08-17 21:55:33','2026-08-18 01:07:34'),(6,10,'cuantos token estoy usando al preguntarte esto','2026-08-17 22:09:54','2026-08-17 22:38:38'),(7,10,'┬┐C├│mo mejorar mi sue├▒o?','2026-08-17 23:18:49','2026-08-18 00:56:37'),(8,10,'chat gpt o gemini','2026-08-18 00:57:09','2026-08-18 03:00:35'),(9,10,'Esto es una prueba','2026-08-18 15:53:57','2026-08-19 19:22:16'),(10,11,'¿Cómo mejorar mi sueño?','2026-08-18 18:23:23','2026-08-18 18:24:22'),(11,12,'Me duele mucho la cabeza, me siento muy mareada','2026-08-18 18:45:21','2026-08-18 18:46:03'),(12,15,'Nueva conversación','2026-08-18 18:45:48','2026-08-18 18:45:48'),(13,17,'¿Cómo mejorar mi sueño?','2026-08-19 00:13:52','2026-08-19 00:14:54'),(14,19,'Me siento muy mal, me quiero colgar del techo','2026-08-19 18:54:46','2026-08-19 18:55:13');
/*!40000 ALTER TABLE `chat_conversations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-21  9:27:30
