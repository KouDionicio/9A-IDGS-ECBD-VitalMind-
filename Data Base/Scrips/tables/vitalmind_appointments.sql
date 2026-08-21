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
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `specialty` varchar(120) NOT NULL,
  `doctor` varchar(120) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` varchar(10) NOT NULL,
  `place` varchar(160) NOT NULL,
  `color` varchar(20) NOT NULL DEFAULT '#0F766E',
  `status` enum('proxima','completada','cancelada') NOT NULL DEFAULT 'proxima',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_appointments_user` (`user_id`),
  CONSTRAINT `fk_appointments_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (1,2,'Cardiolog├¡a','Dr. Mart├¡nez L├│pez','2025-07-15','10:30','Cl├¡nica San Rafael','#EF4444','cancelada','2026-08-11 00:56:01','2026-08-19 19:00:04'),(2,2,'Endocrinolog├¡a','Dra. Garc├¡a Ruiz','2025-07-22','09:00','Hospital Central','#8B5CF6','proxima','2026-08-11 00:56:01','2026-08-11 00:56:01'),(3,2,'M├®dico general','Dr. S├ínchez Vega','2025-06-10','11:00','Centro de Salud Norte','#0F766E','completada','2026-08-11 00:56:01','2026-08-11 00:56:01'),(4,2,'Oftalmolog├¡a','Dra. Torres Ramos','2025-06-01','15:30','├ôptica Visi├│n Salud','#2563EB','completada','2026-08-11 00:56:01','2026-08-11 00:56:01'),(5,6,'Neurología','Dr. Hernández Díaz','2026-11-15','11:45','Centro de Salud Norte','#0F766E','cancelada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(6,6,'Medicina general','Dr. Martínez López','2026-08-08','17:15','Hospital Regional','#EC4899','completada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(7,6,'Endocrinología','Dra. García Ruiz','2026-10-08','10:45','Clínica San Rafael','#2563EB','cancelada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(8,6,'Cardiología','Dr. Martínez López','2026-07-12','13:15','Clínica San Rafael','#8B5CF6','cancelada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(9,6,'Dermatología','Dra. Torres Ramos','2026-09-26','11:45','Centro de Salud Norte','#8B5CF6','proxima','2026-08-20 04:52:40','2026-08-20 04:52:40'),(10,6,'Nutrición','Dra. Morales Pérez','2026-08-01','16:45','Centro de Salud Norte','#F97316','proxima','2026-08-20 04:52:40','2026-08-20 04:52:40'),(11,6,'Dermatología','Dra. Morales Pérez','2026-10-30','08:00','Hospital Regional','#22C55E','proxima','2026-08-20 04:52:40','2026-08-20 04:52:40'),(12,6,'Neurología','Dra. García Ruiz','2026-10-06','10:00','Centro de Salud Norte','#F59E0B','cancelada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(13,6,'Neurología','Dr. Hernández Díaz','2026-08-06','10:30','Clínica San Rafael','#F97316','proxima','2026-08-20 04:52:40','2026-08-20 04:52:40'),(14,6,'Medicina general','Dr. Sánchez Vega','2026-10-12','15:15','Clínica VitalMind','#F59E0B','cancelada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(15,6,'Nutrición','Dr. Sánchez Vega','2026-09-27','17:00','Clínica San Rafael','#8B5CF6','completada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(16,6,'Nutrición','Dra. Torres Ramos','2026-10-08','17:45','Centro de Salud Norte','#2563EB','proxima','2026-08-20 04:52:40','2026-08-20 04:52:40'),(17,6,'Cardiología','Dr. Martínez López','2026-07-04','19:30','Hospital Regional','#EC4899','proxima','2026-08-20 04:52:40','2026-08-20 04:52:40'),(18,6,'Nutrición','Dr. Martínez López','2026-08-21','07:00','Centro de Salud Norte','#2563EB','proxima','2026-08-20 04:52:40','2026-08-20 04:52:40'),(19,6,'Medicina general','Dra. García Ruiz','2026-10-06','14:00','Hospital Regional','#8B5CF6','proxima','2026-08-20 04:52:40','2026-08-20 04:52:40'),(20,6,'Cardiología','Dr. Sánchez Vega','2026-11-04','09:30','Hospital Regional','#F59E0B','cancelada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(21,6,'Cardiología','Dr. Martínez López','2026-07-03','14:00','Clínica VitalMind','#8B5CF6','proxima','2026-08-20 04:52:40','2026-08-20 04:52:40'),(22,6,'Oftalmología','Dr. Sánchez Vega','2026-11-16','15:15','Clínica San Rafael','#2563EB','cancelada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(23,6,'Neurología','Dra. Torres Ramos','2026-06-26','12:15','Clínica VitalMind','#22C55E','cancelada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(24,6,'Cardiología','Dr. Hernández Díaz','2026-06-23','16:30','Clínica San Rafael','#F59E0B','proxima','2026-08-20 04:52:40','2026-08-20 04:52:40'),(25,6,'Neurología','Dr. Sánchez Vega','2026-07-25','07:15','Clínica San Rafael','#2563EB','cancelada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(26,6,'Oftalmología','Dr. Martínez López','2026-08-02','07:30','Clínica San Rafael','#EC4899','cancelada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(27,6,'Dermatología','Dr. Hernández Díaz','2026-10-12','16:30','Hospital Regional','#8B5CF6','completada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(28,6,'Dermatología','Dr. Sánchez Vega','2026-10-28','12:15','Hospital Regional','#0F766E','proxima','2026-08-20 04:52:40','2026-08-20 04:52:40'),(29,6,'Dermatología','Dr. Sánchez Vega','2026-08-23','13:45','Hospital Regional','#F59E0B','completada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(30,6,'Dermatología','Dr. Sánchez Vega','2026-08-31','10:30','Hospital Regional','#2563EB','proxima','2026-08-20 04:52:40','2026-08-20 04:52:40'),(31,6,'Endocrinología','Dr. Hernández Díaz','2026-09-07','15:00','Clínica San Rafael','#F59E0B','completada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(32,6,'Cardiología','Dra. Morales Pérez','2026-09-20','17:30','Clínica VitalMind','#0F766E','completada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(33,6,'Dermatología','Dra. García Ruiz','2026-07-25','19:00','Hospital Regional','#EC4899','completada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(34,6,'Neurología','Dr. Martínez López','2026-09-24','11:45','Centro de Salud Norte','#F59E0B','completada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(35,6,'Nutrición','Dra. García Ruiz','2026-11-11','15:30','Hospital Central','#2563EB','cancelada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(36,6,'Endocrinología','Dra. Morales Pérez','2026-07-30','16:00','Hospital Central','#EC4899','proxima','2026-08-20 04:52:40','2026-08-20 04:52:40'),(37,6,'Medicina general','Dra. Morales Pérez','2026-08-03','12:45','Hospital Central','#F59E0B','proxima','2026-08-20 04:52:40','2026-08-20 04:52:40'),(38,6,'Cardiología','Dra. Morales Pérez','2026-08-05','16:15','Clínica VitalMind','#2563EB','cancelada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(39,6,'Medicina general','Dra. Torres Ramos','2026-08-18','10:45','Centro de Salud Norte','#0F766E','proxima','2026-08-20 04:52:40','2026-08-20 04:52:40'),(40,6,'Medicina general','Dr. Hernández Díaz','2026-06-28','11:45','Clínica VitalMind','#F97316','cancelada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(41,6,'Neurología','Dra. García Ruiz','2026-11-06','18:30','Clínica VitalMind','#22C55E','completada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(42,6,'Cardiología','Dra. Morales Pérez','2026-08-14','14:30','Clínica VitalMind','#F59E0B','completada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(43,6,'Medicina general','Dr. Martínez López','2026-10-04','11:15','Clínica VitalMind','#2563EB','cancelada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(44,6,'Endocrinología','Dra. Torres Ramos','2026-08-11','11:45','Clínica VitalMind','#EC4899','cancelada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(45,6,'Oftalmología','Dr. Sánchez Vega','2026-11-05','14:15','Centro de Salud Norte','#0F766E','proxima','2026-08-20 04:52:40','2026-08-20 04:52:40'),(46,6,'Nutrición','Dra. Torres Ramos','2026-06-22','07:15','Clínica San Rafael','#2563EB','proxima','2026-08-20 04:52:40','2026-08-20 04:52:40'),(47,6,'Neurología','Dr. Martínez López','2026-10-24','08:00','Clínica VitalMind','#F97316','cancelada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(48,6,'Oftalmología','Dr. Martínez López','2026-06-25','15:00','Clínica San Rafael','#F97316','completada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(49,6,'Endocrinología','Dra. García Ruiz','2026-10-29','14:30','Hospital Central','#EC4899','proxima','2026-08-20 04:52:40','2026-08-20 04:52:40'),(50,6,'Endocrinología','Dra. Torres Ramos','2026-08-14','17:45','Hospital Regional','#EC4899','proxima','2026-08-20 04:52:40','2026-08-20 04:52:40'),(51,6,'Cardiología','Dra. García Ruiz','2026-08-10','13:15','Clínica San Rafael','#8B5CF6','cancelada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(52,6,'Oftalmología','Dr. Martínez López','2026-09-29','10:15','Clínica San Rafael','#F97316','completada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(53,6,'Nutrición','Dr. Sánchez Vega','2026-09-05','12:45','Clínica VitalMind','#F97316','completada','2026-08-20 04:52:40','2026-08-20 04:52:40'),(54,6,'Dermatología','Dr. Martínez López','2026-10-31','08:45','Hospital Central','#0F766E','cancelada','2026-08-20 04:52:40','2026-08-20 04:52:40');
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
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
