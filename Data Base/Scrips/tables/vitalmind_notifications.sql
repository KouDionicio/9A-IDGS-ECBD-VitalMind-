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
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `kind` enum('tip','reminder','ai','alert') NOT NULL DEFAULT 'tip',
  `title` varchar(180) NOT NULL,
  `body` text NOT NULL,
  `time_label` varchar(80) NOT NULL DEFAULT 'Ahora',
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_notifications_user` (`user_id`),
  CONSTRAINT `fk_notifications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (19,1,'tip','Hola','eres un usuario activo','Ahora',1,'2026-08-17 21:59:06','2026-08-17 22:03:46'),(20,2,'tip','Hola','eres un usuario activo','Ahora',1,'2026-08-17 21:59:06','2026-08-17 22:03:46'),(21,10,'tip','Hola','eres un usuario activo','Ahora',1,'2026-08-17 21:59:06','2026-08-17 22:03:46'),(22,1,'tip','hi','df','Ahora',1,'2026-08-18 01:43:46','2026-08-18 01:59:02'),(23,2,'tip','hi','df','Ahora',1,'2026-08-18 01:43:46','2026-08-18 01:59:02'),(24,10,'tip','hi','df','Ahora',1,'2026-08-18 01:43:46','2026-08-18 01:59:02'),(25,1,'tip','Prueba','prueba','Ahora',1,'2026-08-18 02:03:23','2026-08-18 02:08:14'),(26,2,'tip','Prueba','prueba','Ahora',1,'2026-08-18 02:03:23','2026-08-18 02:08:14'),(27,10,'tip','Prueba','prueba','Ahora',1,'2026-08-18 02:03:23','2026-08-18 02:08:14'),(28,2,'alert','Esto es una prueba','Alerta esto es una prueba','Ahora',0,'2026-08-18 02:28:38','2026-08-18 02:28:38'),(29,10,'alert','Esto es una prueba','Alerta esto es una prueba','Ahora',1,'2026-08-18 02:28:38','2026-08-18 02:38:27'),(30,3,'tip','hi','goo','Ahora',0,'2026-08-18 02:29:05','2026-08-18 02:29:05'),(31,4,'tip','hi','goo','Ahora',0,'2026-08-18 02:29:05','2026-08-18 02:29:05'),(32,5,'tip','hi','goo','Ahora',0,'2026-08-18 02:29:05','2026-08-18 02:29:05'),(33,6,'tip','hi','goo','Ahora',0,'2026-08-18 02:29:05','2026-08-18 02:29:05'),(34,7,'tip','hi','goo','Ahora',0,'2026-08-18 02:29:05','2026-08-18 02:29:05'),(35,8,'tip','hi','goo','Ahora',0,'2026-08-18 02:29:05','2026-08-18 02:29:05'),(36,9,'tip','hi','goo','Ahora',0,'2026-08-18 02:29:05','2026-08-18 02:29:05'),(37,3,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:03','2026-08-18 02:30:03'),(38,4,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:03','2026-08-18 02:30:03'),(39,5,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:03','2026-08-18 02:30:03'),(40,6,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:03','2026-08-18 02:30:03'),(41,7,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:03','2026-08-18 02:30:03'),(42,8,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:03','2026-08-18 02:30:03'),(43,9,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:03','2026-08-18 02:30:03'),(44,3,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:04','2026-08-18 02:30:04'),(45,4,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:04','2026-08-18 02:30:04'),(46,5,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:04','2026-08-18 02:30:04'),(47,6,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:04','2026-08-18 02:30:04'),(48,7,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:04','2026-08-18 02:30:04'),(49,8,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:04','2026-08-18 02:30:04'),(50,9,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:04','2026-08-18 02:30:04'),(51,3,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:04','2026-08-18 02:30:04'),(52,4,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:04','2026-08-18 02:30:04'),(53,5,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:04','2026-08-18 02:30:04'),(54,6,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:04','2026-08-18 02:30:04'),(55,7,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:04','2026-08-18 02:30:04'),(56,8,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:04','2026-08-18 02:30:04'),(57,9,'tip','hi','goo','Ahora',0,'2026-08-18 02:30:04','2026-08-18 02:30:04'),(58,2,'tip','Prueba','Prueba','Ahora',0,'2026-08-18 02:38:10','2026-08-18 02:38:10'),(59,10,'tip','Prueba','Prueba','Ahora',1,'2026-08-18 02:38:10','2026-08-18 02:38:27'),(60,2,'reminder','socker','sockert','Ahora',0,'2026-08-18 03:36:41','2026-08-18 03:36:41'),(61,3,'reminder','socker','sockert','Ahora',0,'2026-08-18 03:36:41','2026-08-18 03:36:41'),(62,4,'reminder','socker','sockert','Ahora',0,'2026-08-18 03:36:41','2026-08-18 03:36:41'),(63,5,'reminder','socker','sockert','Ahora',0,'2026-08-18 03:36:41','2026-08-18 03:36:41'),(64,6,'reminder','socker','sockert','Ahora',0,'2026-08-18 03:36:41','2026-08-18 03:36:41'),(65,7,'reminder','socker','sockert','Ahora',0,'2026-08-18 03:36:41','2026-08-18 03:36:41'),(66,8,'reminder','socker','sockert','Ahora',0,'2026-08-18 03:36:41','2026-08-18 03:36:41'),(67,9,'reminder','socker','sockert','Ahora',0,'2026-08-18 03:36:41','2026-08-18 03:36:41'),(68,10,'reminder','socker','sockert','Ahora',1,'2026-08-18 03:36:41','2026-08-18 03:37:31'),(69,2,'reminder','hi','erfr','Ahora',0,'2026-08-18 03:37:12','2026-08-18 03:37:12'),(70,10,'reminder','hi','erfr','Ahora',1,'2026-08-18 03:37:12','2026-08-18 03:37:31'),(71,2,'reminder','prueba 2','erfr','Ahora',0,'2026-08-18 03:37:43','2026-08-18 03:37:43'),(72,10,'reminder','prueba 2','erfr','Ahora',1,'2026-08-18 03:37:43','2026-08-18 15:53:44'),(73,2,'tip','prueba 203895','los marcianos llegasron ya','Ahora',0,'2026-08-19 19:03:52','2026-08-19 19:03:52'),(74,10,'tip','prueba 203895','los marcianos llegasron ya','Ahora',1,'2026-08-19 19:03:52','2026-08-19 19:22:40'),(75,11,'tip','prueba 203895','los marcianos llegasron ya','Ahora',0,'2026-08-19 19:03:52','2026-08-19 19:03:52'),(76,12,'tip','prueba 203895','los marcianos llegasron ya','Ahora',0,'2026-08-19 19:03:52','2026-08-19 19:03:52'),(77,15,'tip','prueba 203895','los marcianos llegasron ya','Ahora',0,'2026-08-19 19:03:52','2026-08-19 19:03:52'),(78,16,'tip','prueba 203895','los marcianos llegasron ya','Ahora',0,'2026-08-19 19:03:52','2026-08-19 19:03:52'),(79,17,'tip','prueba 203895','los marcianos llegasron ya','Ahora',0,'2026-08-19 19:03:52','2026-08-19 19:03:52'),(80,18,'tip','prueba 203895','los marcianos llegasron ya','Ahora',0,'2026-08-19 19:03:52','2026-08-19 19:03:52'),(81,19,'tip','prueba 203895','los marcianos llegasron ya','Ahora',0,'2026-08-19 19:03:52','2026-08-19 19:03:52');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-21  9:27:32
