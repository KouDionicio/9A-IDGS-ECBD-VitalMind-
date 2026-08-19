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

--
-- Table structure for table `audit_logs`
--

DROP TABLE IF EXISTS `audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `actor_id` bigint unsigned DEFAULT NULL,
  `action` varchar(120) NOT NULL,
  `entity` varchar(120) NOT NULL,
  `entity_id` varchar(120) DEFAULT NULL,
  `payload` longtext NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_audit_logs_actor` (`actor_id`),
  CONSTRAINT `fk_audit_logs_actor` FOREIGN KEY (`actor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=371 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_logs`
--

LOCK TABLES `audit_logs` WRITE;
/*!40000 ALTER TABLE `audit_logs` DISABLE KEYS */;
INSERT INTO `audit_logs` VALUES (1,NULL,'auth.register','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-11 01:08:59'),(2,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-11 01:13:30'),(3,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-11 01:16:11'),(4,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-11 01:16:56'),(5,10,'notifications.mark_all_read','notifications',NULL,'{\"modified\":3}','2026-08-11 01:17:02'),(6,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-11 01:18:00'),(7,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-11 01:18:08'),(8,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 19:26:33'),(9,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 19:33:29'),(10,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 19:42:46'),(11,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 19:42:46'),(12,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 19:42:46'),(13,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 19:48:05'),(14,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 19:56:53'),(15,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 20:24:45'),(16,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 20:27:32'),(17,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 20:36:06'),(18,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 20:48:39'),(19,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 20:50:05'),(20,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-17 20:50:56'),(21,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 20:51:15'),(22,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-17 20:51:28'),(23,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 20:52:55'),(24,10,'notifications.mark_all_read','notifications',NULL,'{\"modified\":10}','2026-08-17 20:53:09'),(25,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 21:15:57'),(26,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 21:21:54'),(27,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 21:38:01'),(28,2,'auth.login','users','2','{\"email\":\"maria@email.com\"}','2026-08-17 21:40:49'),(29,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 21:44:11'),(30,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 21:53:27'),(31,2,'auth.login','users','2','{\"email\":\"maria@email.com\"}','2026-08-17 21:54:32'),(32,2,'notifications.mark_all_read','notifications',NULL,'{\"modified\":0}','2026-08-17 21:55:08'),(33,2,'notifications.mark_all_read','notifications',NULL,'{\"modified\":0}','2026-08-17 21:55:10'),(34,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 21:56:49'),(35,10,'notifications.mark_all_read','notifications',NULL,'{\"modified\":0}','2026-08-17 21:56:53'),(36,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-17 21:58:25'),(37,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 21:59:11'),(38,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 22:03:34'),(39,10,'notifications.mark_all_read','notifications',NULL,'{\"modified\":3}','2026-08-17 22:03:46'),(40,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 22:08:46'),(41,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 22:08:46'),(42,10,'notifications.mark_all_read','notifications',NULL,'{\"modified\":0}','2026-08-17 22:09:32'),(43,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 22:11:08'),(44,10,'medical_history.create','medical_history_items','1','{\"id\":1,\"userId\":10,\"category\":\"medications\",\"description\":\"Medicamento\"}','2026-08-17 22:13:19'),(45,10,'medical_history.delete','medical_history_items','1','{}','2026-08-17 22:13:32'),(46,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 22:18:24'),(47,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 22:22:22'),(48,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 22:37:42'),(49,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 22:46:53'),(50,10,'medications.create','medications','6','{\"id\":6,\"userId\":10,\"name\":\"Aspriina\",\"dose\":\"500 mg\",\"frequency\":\"Semanal\",\"time\":\"08:00\",\"color\":\"#0F766E\",\"taken\":false,\"tomado\":false,\"type\":\"pastilla\"}','2026-08-17 22:51:54'),(51,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 22:52:08'),(52,10,'notifications.mark_all_read','notifications',NULL,'{\"modified\":0}','2026-08-17 22:52:58'),(53,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 22:55:40'),(54,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 22:58:33'),(55,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 23:12:01'),(56,2,'auth.login','users','2','{\"email\":\"maria@email.com\"}','2026-08-17 23:14:23'),(57,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 23:18:22'),(58,2,'auth.login','users','2','{\"email\":\"maria@email.com\"}','2026-08-17 23:20:11'),(59,2,'auth.login','users','2','{\"email\":\"maria@email.com\"}','2026-08-17 23:31:05'),(60,2,'auth.login','users','2','{\"email\":\"maria@email.com\"}','2026-08-17 23:31:10'),(61,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 23:38:16'),(62,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-17 23:50:05'),(63,10,'medications.update','medications','11','{\"id\":11,\"userId\":10,\"name\":\"Salbutamol\",\"dose\":\"100mcg\",\"frequency\":\"PRN\",\"time\":\"18:00\",\"time_label\":\"18:00\",\"color\":\"#8B5CF6\",\"taken\":false,\"tomado\":false,\"type\":\"inyeccion\"}','2026-08-17 23:51:36'),(64,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":1.88,\"value\":2,\"goal\":2}','2026-08-17 23:52:55'),(65,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:52:56'),(66,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:28'),(67,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:29'),(68,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:29'),(69,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:29'),(70,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:30'),(71,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:30'),(72,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:30'),(73,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:30'),(74,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:31'),(75,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:32'),(76,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:32'),(77,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:32'),(78,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:32'),(79,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:33'),(80,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:33'),(81,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:33'),(82,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:33'),(83,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:34'),(84,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:35'),(85,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:36'),(86,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:36'),(87,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:49'),(88,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:50'),(89,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:50'),(90,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:51'),(91,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:51'),(92,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:53:51'),(93,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:54:50'),(94,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:54:51'),(95,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:54:52'),(96,10,'habits.increment','habit_logs','146','{\"key\":\"exercise\",\"date\":\"2026-08-17\",\"previousValue\":50,\"value\":45,\"goal\":45}','2026-08-17 23:54:53'),(97,10,'habits.increment','habit_logs','146','{\"key\":\"exercise\",\"date\":\"2026-08-17\",\"previousValue\":45,\"value\":45,\"goal\":45}','2026-08-17 23:54:53'),(98,10,'habits.increment','habit_logs','146','{\"key\":\"exercise\",\"date\":\"2026-08-17\",\"previousValue\":45,\"value\":45,\"goal\":45}','2026-08-17 23:54:54'),(99,10,'habits.increment','habit_logs','146','{\"key\":\"exercise\",\"date\":\"2026-08-17\",\"previousValue\":45,\"value\":45,\"goal\":45}','2026-08-17 23:54:54'),(100,10,'habits.increment','habit_logs','146','{\"key\":\"exercise\",\"date\":\"2026-08-17\",\"previousValue\":45,\"value\":45,\"goal\":45}','2026-08-17 23:54:54'),(101,10,'habits.increment','habit_logs','149','{\"key\":\"sleep\",\"date\":\"2026-08-17\",\"previousValue\":7.05,\"value\":8,\"goal\":8}','2026-08-17 23:54:57'),(102,10,'habits.increment','habit_logs','149','{\"key\":\"sleep\",\"date\":\"2026-08-17\",\"previousValue\":8,\"value\":8,\"goal\":8}','2026-08-17 23:54:57'),(103,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:55:01'),(104,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:55:02'),(105,10,'habits.increment','habit_logs','150','{\"key\":\"water\",\"date\":\"2026-08-17\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-17 23:55:02'),(106,10,'habits.increment','habit_logs','148','{\"key\":\"nutrition\",\"date\":\"2026-08-17\",\"previousValue\":4,\"value\":5,\"goal\":5}','2026-08-17 23:55:04'),(107,10,'habits.increment','habit_logs','147','{\"key\":\"meditation\",\"date\":\"2026-08-17\",\"previousValue\":10,\"value\":10,\"goal\":10}','2026-08-17 23:55:05'),(108,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 00:00:34'),(109,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 00:01:46'),(110,10,'habits.increment','habit_logs','256','{\"key\":\"water\",\"date\":\"2026-08-18\",\"value\":1,\"goal\":2}','2026-08-18 00:03:41'),(111,10,'habits.increment','habit_logs','256','{\"key\":\"water\",\"date\":\"2026-08-18\",\"previousValue\":1,\"value\":2,\"goal\":2}','2026-08-18 00:03:41'),(112,10,'habits.increment','habit_logs','256','{\"key\":\"water\",\"date\":\"2026-08-18\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-18 00:03:41'),(113,10,'habits.increment','habit_logs','256','{\"key\":\"water\",\"date\":\"2026-08-18\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-18 00:03:41'),(114,10,'habits.increment','habit_logs','256','{\"key\":\"water\",\"date\":\"2026-08-18\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-18 00:03:42'),(115,10,'habits.increment','habit_logs','256','{\"key\":\"water\",\"date\":\"2026-08-18\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-18 00:03:42'),(116,10,'habits.increment','habit_logs','256','{\"key\":\"water\",\"date\":\"2026-08-18\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-18 00:03:42'),(117,10,'habits.increment','habit_logs','256','{\"key\":\"water\",\"date\":\"2026-08-18\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-18 00:03:42'),(118,10,'habits.increment','habit_logs','256','{\"key\":\"water\",\"date\":\"2026-08-18\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-18 00:03:42'),(119,10,'habits.increment','habit_logs','256','{\"key\":\"water\",\"date\":\"2026-08-18\",\"previousValue\":2,\"value\":2,\"goal\":2}','2026-08-18 00:03:43'),(120,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"value\":1,\"goal\":30}','2026-08-18 00:03:44'),(121,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":1,\"value\":2,\"goal\":30}','2026-08-18 00:03:44'),(122,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":2,\"value\":3,\"goal\":30}','2026-08-18 00:03:45'),(123,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":3,\"value\":4,\"goal\":30}','2026-08-18 00:03:46'),(124,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":4,\"value\":5,\"goal\":30}','2026-08-18 00:03:47'),(125,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":5,\"value\":6,\"goal\":30}','2026-08-18 00:03:47'),(126,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":6,\"value\":7,\"goal\":30}','2026-08-18 00:03:47'),(127,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":7,\"value\":8,\"goal\":30}','2026-08-18 00:03:47'),(128,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":8,\"value\":9,\"goal\":30}','2026-08-18 00:03:47'),(129,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":9,\"value\":10,\"goal\":30}','2026-08-18 00:03:48'),(130,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":10,\"value\":11,\"goal\":30}','2026-08-18 00:03:48'),(131,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":11,\"value\":12,\"goal\":30}','2026-08-18 00:03:48'),(132,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":12,\"value\":13,\"goal\":30}','2026-08-18 00:03:48'),(133,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":13,\"value\":14,\"goal\":30}','2026-08-18 00:03:48'),(134,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":14,\"value\":15,\"goal\":30}','2026-08-18 00:03:48'),(135,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":15,\"value\":16,\"goal\":30}','2026-08-18 00:03:49'),(136,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":16,\"value\":17,\"goal\":30}','2026-08-18 00:03:49'),(137,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":17,\"value\":18,\"goal\":30}','2026-08-18 00:03:49'),(138,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":18,\"value\":19,\"goal\":30}','2026-08-18 00:03:49'),(139,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":19,\"value\":20,\"goal\":30}','2026-08-18 00:03:49'),(140,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":20,\"value\":21,\"goal\":30}','2026-08-18 00:03:50'),(141,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":21,\"value\":22,\"goal\":30}','2026-08-18 00:03:50'),(142,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":22,\"value\":23,\"goal\":30}','2026-08-18 00:03:50'),(143,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":23,\"value\":24,\"goal\":30}','2026-08-18 00:03:50'),(144,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":24,\"value\":25,\"goal\":30}','2026-08-18 00:03:50'),(145,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":25,\"value\":26,\"goal\":30}','2026-08-18 00:03:50'),(146,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":26,\"value\":27,\"goal\":30}','2026-08-18 00:03:51'),(147,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":27,\"value\":28,\"goal\":30}','2026-08-18 00:03:51'),(148,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":28,\"value\":29,\"goal\":30}','2026-08-18 00:03:51'),(149,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":29,\"value\":30,\"goal\":30}','2026-08-18 00:03:51'),(150,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":30,\"value\":30,\"goal\":30}','2026-08-18 00:03:51'),(151,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":30,\"value\":30,\"goal\":30}','2026-08-18 00:03:52'),(152,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":30,\"value\":30,\"goal\":30}','2026-08-18 00:03:52'),(153,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":30,\"value\":30,\"goal\":30}','2026-08-18 00:03:52'),(154,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":30,\"value\":30,\"goal\":30}','2026-08-18 00:03:52'),(155,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":30,\"value\":30,\"goal\":30}','2026-08-18 00:03:52'),(156,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":30,\"value\":30,\"goal\":30}','2026-08-18 00:03:53'),(157,10,'habits.increment','habit_logs','257','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":30,\"value\":30,\"goal\":30}','2026-08-18 00:03:53'),(158,10,'habits.increment','habit_logs','258','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"value\":1,\"goal\":8}','2026-08-18 00:03:57'),(159,10,'habits.increment','habit_logs','258','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":1,\"value\":2,\"goal\":8}','2026-08-18 00:03:57'),(160,10,'habits.increment','habit_logs','258','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":2,\"value\":3,\"goal\":8}','2026-08-18 00:03:57'),(161,10,'habits.increment','habit_logs','258','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":3,\"value\":4,\"goal\":8}','2026-08-18 00:03:58'),(162,10,'habits.increment','habit_logs','258','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":4,\"value\":5,\"goal\":8}','2026-08-18 00:03:58'),(163,10,'habits.increment','habit_logs','258','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":5,\"value\":6,\"goal\":8}','2026-08-18 00:03:59'),(164,10,'habits.increment','habit_logs','258','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":6,\"value\":7,\"goal\":8}','2026-08-18 00:03:59'),(165,10,'habits.increment','habit_logs','258','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":7,\"value\":8,\"goal\":8}','2026-08-18 00:03:59'),(166,10,'habits.increment','habit_logs','258','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":8,\"value\":8,\"goal\":8}','2026-08-18 00:03:59'),(167,10,'habits.increment','habit_logs','258','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":8,\"value\":8,\"goal\":8}','2026-08-18 00:03:59'),(168,10,'habits.increment','habit_logs','258','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":8,\"value\":8,\"goal\":8}','2026-08-18 00:04:00'),(169,10,'habits.increment','habit_logs','258','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":8,\"value\":8,\"goal\":8}','2026-08-18 00:04:00'),(170,10,'habits.increment','habit_logs','259','{\"key\":\"nutrition\",\"date\":\"2026-08-18\",\"value\":1,\"goal\":3}','2026-08-18 00:04:02'),(171,10,'habits.increment','habit_logs','259','{\"key\":\"nutrition\",\"date\":\"2026-08-18\",\"previousValue\":1,\"value\":2,\"goal\":3}','2026-08-18 00:04:02'),(172,10,'habits.increment','habit_logs','259','{\"key\":\"nutrition\",\"date\":\"2026-08-18\",\"previousValue\":2,\"value\":3,\"goal\":3}','2026-08-18 00:04:02'),(173,10,'habits.increment','habit_logs','259','{\"key\":\"nutrition\",\"date\":\"2026-08-18\",\"previousValue\":3,\"value\":3,\"goal\":3}','2026-08-18 00:04:02'),(174,10,'habits.increment','habit_logs','259','{\"key\":\"nutrition\",\"date\":\"2026-08-18\",\"previousValue\":3,\"value\":3,\"goal\":3}','2026-08-18 00:04:03'),(175,10,'habits.increment','habit_logs','260','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"value\":1,\"goal\":10}','2026-08-18 00:04:04'),(176,10,'habits.increment','habit_logs','260','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"previousValue\":1,\"value\":2,\"goal\":10}','2026-08-18 00:04:05'),(177,10,'habits.increment','habit_logs','260','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"previousValue\":2,\"value\":3,\"goal\":10}','2026-08-18 00:04:05'),(178,10,'habits.increment','habit_logs','260','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"previousValue\":3,\"value\":4,\"goal\":10}','2026-08-18 00:04:06'),(179,10,'habits.increment','habit_logs','260','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"previousValue\":4,\"value\":5,\"goal\":10}','2026-08-18 00:04:06'),(180,10,'habits.increment','habit_logs','260','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"previousValue\":5,\"value\":6,\"goal\":10}','2026-08-18 00:04:06'),(181,10,'habits.increment','habit_logs','260','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"previousValue\":6,\"value\":7,\"goal\":10}','2026-08-18 00:04:06'),(182,10,'habits.increment','habit_logs','260','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"previousValue\":7,\"value\":8,\"goal\":10}','2026-08-18 00:05:58'),(183,10,'habits.increment','habit_logs','260','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"previousValue\":8,\"value\":9,\"goal\":10}','2026-08-18 00:05:58'),(184,10,'habits.increment','habit_logs','260','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"previousValue\":9,\"value\":10,\"goal\":10}','2026-08-18 00:05:59'),(185,10,'habits.increment','habit_logs','260','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"previousValue\":10,\"value\":10,\"goal\":10}','2026-08-18 00:05:59'),(186,10,'habits.increment','habit_logs','260','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"previousValue\":10,\"value\":10,\"goal\":10}','2026-08-18 00:05:59'),(187,10,'habits.increment','habit_logs','260','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"previousValue\":10,\"value\":10,\"goal\":10}','2026-08-18 00:05:59'),(188,10,'habits.increment','habit_logs','260','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"previousValue\":10,\"value\":10,\"goal\":10}','2026-08-18 00:06:00'),(189,10,'habits.increment','habit_logs','260','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"previousValue\":10,\"value\":10,\"goal\":10}','2026-08-18 00:06:00'),(190,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 00:10:10'),(191,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 00:18:22'),(192,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 00:29:19'),(193,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 00:34:00'),(194,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 00:34:01'),(195,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 00:51:04'),(196,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 00:51:05'),(197,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 00:51:05'),(198,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 00:51:05'),(199,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 00:51:05'),(200,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 00:51:56'),(201,2,'auth.login','users','2','{\"email\":\"maria@email.com\"}','2026-08-18 00:53:54'),(202,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 00:54:21'),(203,10,'medications.create','medications','12','{\"id\":12,\"userId\":10,\"name\":\"Aspirina\",\"dose\":\"55mg\",\"frequency\":\"Diario\",\"time\":\"08:00\",\"color\":\"#0F766E\",\"taken\":false,\"tomado\":false,\"type\":\"pastilla\"}','2026-08-18 00:56:35'),(204,2,'auth.login','users','2','{\"email\":\"maria@email.com\"}','2026-08-18 00:57:49'),(205,2,'auth.login','users','2','{\"email\":\"maria@email.com\"}','2026-08-18 01:06:11'),(206,2,'habits.increment','habit_logs','261','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"value\":5,\"goal\":30}','2026-08-18 01:06:20'),(207,2,'habits.increment','habit_logs','262','{\"key\":\"water\",\"date\":\"2026-08-18\",\"value\":0.25,\"goal\":2}','2026-08-18 01:06:23'),(208,2,'habits.increment','habit_logs','263','{\"key\":\"nutrition\",\"date\":\"2026-08-18\",\"value\":1,\"goal\":3}','2026-08-18 01:06:33'),(209,2,'habits.increment','habit_logs','263','{\"key\":\"nutrition\",\"date\":\"2026-08-18\",\"previousValue\":1,\"value\":2,\"goal\":3}','2026-08-18 01:06:33'),(210,2,'habits.increment','habit_logs','264','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"value\":5,\"goal\":10}','2026-08-18 01:06:35'),(211,2,'habits.increment','habit_logs','264','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"previousValue\":5,\"value\":10,\"goal\":10}','2026-08-18 01:06:35'),(212,2,'habits.increment','habit_logs','265','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"value\":1,\"goal\":8}','2026-08-18 01:06:37'),(213,2,'habits.increment','habit_logs','265','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":1,\"value\":2,\"goal\":8}','2026-08-18 01:06:37'),(214,2,'auth.login','users','2','{\"email\":\"maria@email.com\"}','2026-08-18 01:15:58'),(215,2,'auth.login','users','2','{\"email\":\"maria@email.com\"}','2026-08-18 01:18:26'),(216,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 01:19:05'),(217,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 01:40:12'),(218,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 01:41:43'),(219,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-18 01:43:26'),(220,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 01:44:01'),(221,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 01:47:22'),(222,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 01:50:59'),(223,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 01:58:31'),(224,10,'notifications.mark_all_read','notifications',NULL,'{\"modified\":3}','2026-08-18 01:59:03'),(225,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-18 02:01:36'),(226,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 02:03:28'),(227,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 02:08:04'),(228,10,'notifications.mark_all_read','notifications',NULL,'{\"modified\":3}','2026-08-18 02:08:14'),(229,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 02:27:49'),(230,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-18 02:28:04'),(231,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-18 02:37:52'),(232,1,'notifications.broadcast','notifications',NULL,'{\"target\":\"active\",\"recipients\":2,\"title\":\"Prueba\"}','2026-08-18 02:38:10'),(233,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 02:38:16'),(234,10,'notifications.mark_all_read','notifications',NULL,'{\"modified\":2}','2026-08-18 02:38:27'),(235,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-18 02:39:11'),(236,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 02:40:50'),(237,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 02:49:07'),(238,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 02:49:08'),(239,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 02:49:23'),(240,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 02:58:47'),(241,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 03:03:56'),(242,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 03:04:03'),(243,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-18 03:35:50'),(244,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 03:35:57'),(245,1,'notifications.broadcast','notifications',NULL,'{\"target\":\"all\",\"recipients\":9,\"title\":\"socker\"}','2026-08-18 03:36:41'),(246,1,'notifications.broadcast','notifications',NULL,'{\"target\":\"active\",\"recipients\":2,\"title\":\"hi\"}','2026-08-18 03:37:12'),(247,10,'notifications.mark_all_read','notifications',NULL,'{\"modified\":2}','2026-08-18 03:37:31'),(248,1,'notifications.broadcast','notifications',NULL,'{\"target\":\"active\",\"recipients\":2,\"title\":\"prueba 2\"}','2026-08-18 03:37:43'),(249,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 15:52:44'),(250,10,'notifications.mark_all_read','notifications',NULL,'{\"modified\":1}','2026-08-18 15:53:44'),(251,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 16:01:19'),(252,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 16:07:18'),(253,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 16:09:39'),(254,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 16:15:35'),(255,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 16:16:43'),(256,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 16:17:09'),(257,10,'medications.create','medications','13','{\"id\":13,\"userId\":10,\"name\":\"Ejemplo\",\"dose\":\"500 mg\",\"frequency\":\"Cada 8 horas\",\"time\":\"08:00\",\"color\":\"#0F766E\",\"taken\":false,\"tomado\":false,\"type\":\"jarabe\"}','2026-08-18 16:18:05'),(258,10,'medications.delete','medications','11','{}','2026-08-18 16:18:25'),(259,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-18 16:25:06'),(260,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 16:26:14'),(261,NULL,'auth.register','users','11','{\"email\":\"citllalli@gmail.com\"}','2026-08-18 18:22:43'),(262,11,'medications.create','medications','14','{\"id\":14,\"userId\":11,\"name\":\"Ejemplo\",\"dose\":\"566\",\"frequency\":\"Cada 12 horas\",\"time\":\"08:00\",\"color\":\"#0F766E\",\"taken\":false,\"tomado\":false,\"type\":\"pastilla\"}','2026-08-18 18:23:20'),(263,NULL,'auth.register','users','12','{\"email\":\"dio@hotmail.com\"}','2026-08-18 18:26:35'),(264,12,'auth.login','users','12','{\"email\":\"dio@hotmail.com\"}','2026-08-18 18:32:39'),(265,12,'auth.login','users','12','{\"email\":\"dio@hotmail.com\"}','2026-08-18 18:36:30'),(266,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-18 18:41:25'),(267,12,'auth.login','users','12','{\"email\":\"dio@hotmail.com\"}','2026-08-18 18:42:47'),(268,NULL,'auth.register','users','15','{\"email\":\"230187@utxicotepec.edu.mx\"}','2026-08-18 18:45:41'),(269,15,'habits.increment','habit_logs','266','{\"key\":\"water\",\"date\":\"2026-08-18\",\"value\":0.25,\"goal\":2}','2026-08-18 18:47:20'),(270,15,'habits.increment','habit_logs','266','{\"key\":\"water\",\"date\":\"2026-08-18\",\"previousValue\":0.25,\"value\":0.5,\"goal\":2}','2026-08-18 18:47:22'),(271,15,'habits.increment','habit_logs','266','{\"key\":\"water\",\"date\":\"2026-08-18\",\"previousValue\":0.5,\"value\":0.75,\"goal\":2}','2026-08-18 18:47:22'),(272,15,'habits.increment','habit_logs','266','{\"key\":\"water\",\"date\":\"2026-08-18\",\"previousValue\":0.75,\"value\":1,\"goal\":2}','2026-08-18 18:47:23'),(273,15,'habits.increment','habit_logs','266','{\"key\":\"water\",\"date\":\"2026-08-18\",\"previousValue\":1,\"value\":1.25,\"goal\":2}','2026-08-18 18:47:23'),(274,15,'habits.increment','habit_logs','266','{\"key\":\"water\",\"date\":\"2026-08-18\",\"previousValue\":1.25,\"value\":1.5,\"goal\":2}','2026-08-18 18:47:23'),(275,15,'habits.increment','habit_logs','266','{\"key\":\"water\",\"date\":\"2026-08-18\",\"previousValue\":1.5,\"value\":1.75,\"goal\":2}','2026-08-18 18:47:23'),(276,15,'habits.increment','habit_logs','266','{\"key\":\"water\",\"date\":\"2026-08-18\",\"previousValue\":1.75,\"value\":2,\"goal\":2}','2026-08-18 18:47:24'),(277,15,'habits.increment','habit_logs','267','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"value\":5,\"goal\":30}','2026-08-18 18:47:26'),(278,15,'habits.increment','habit_logs','267','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":5,\"value\":10,\"goal\":30}','2026-08-18 18:47:27'),(279,15,'habits.increment','habit_logs','267','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":10,\"value\":15,\"goal\":30}','2026-08-18 18:47:27'),(280,15,'habits.increment','habit_logs','267','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":15,\"value\":20,\"goal\":30}','2026-08-18 18:47:27'),(281,15,'habits.increment','habit_logs','267','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":20,\"value\":25,\"goal\":30}','2026-08-18 18:47:28'),(282,15,'habits.increment','habit_logs','267','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":25,\"value\":30,\"goal\":30}','2026-08-18 18:47:28'),(283,15,'habits.increment','habit_logs','268','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"value\":1,\"goal\":8}','2026-08-18 18:47:31'),(284,15,'habits.increment','habit_logs','268','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":1,\"value\":2,\"goal\":8}','2026-08-18 18:47:32'),(285,15,'habits.increment','habit_logs','268','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":2,\"value\":3,\"goal\":8}','2026-08-18 18:47:32'),(286,15,'habits.increment','habit_logs','268','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":3,\"value\":4,\"goal\":8}','2026-08-18 18:47:32'),(287,15,'habits.increment','habit_logs','268','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":4,\"value\":5,\"goal\":8}','2026-08-18 18:47:32'),(288,15,'habits.increment','habit_logs','268','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":5,\"value\":6,\"goal\":8}','2026-08-18 18:47:33'),(289,15,'habits.increment','habit_logs','268','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":6,\"value\":7,\"goal\":8}','2026-08-18 18:47:33'),(290,15,'habits.increment','habit_logs','268','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":7,\"value\":8,\"goal\":8}','2026-08-18 18:47:33'),(291,15,'habits.increment','habit_logs','269','{\"key\":\"nutrition\",\"date\":\"2026-08-18\",\"value\":1,\"goal\":3}','2026-08-18 18:47:37'),(292,15,'habits.increment','habit_logs','269','{\"key\":\"nutrition\",\"date\":\"2026-08-18\",\"previousValue\":1,\"value\":2,\"goal\":3}','2026-08-18 18:47:38'),(293,15,'habits.increment','habit_logs','269','{\"key\":\"nutrition\",\"date\":\"2026-08-18\",\"previousValue\":2,\"value\":3,\"goal\":3}','2026-08-18 18:47:38'),(294,15,'habits.increment','habit_logs','270','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"value\":5,\"goal\":10}','2026-08-18 18:47:42'),(295,15,'habits.increment','habit_logs','270','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"previousValue\":5,\"value\":10,\"goal\":10}','2026-08-18 18:47:43'),(296,15,'medications.create','medications','15','{\"id\":15,\"userId\":15,\"name\":\"Amoxicilina\",\"dose\":\"500g\",\"frequency\":\"Diario\",\"time\":\"13:20\",\"color\":\"#0F766E\",\"taken\":false,\"tomado\":false,\"type\":\"pastilla\"}','2026-08-18 18:50:58'),(297,12,'auth.login','users','12','{\"email\":\"dio@hotmail.com\"}','2026-08-18 19:14:41'),(298,NULL,'auth.register','users','16','{\"email\":\"luis@hotmail.com\"}','2026-08-18 19:17:18'),(299,16,'habits.increment','habit_logs','271','{\"key\":\"water\",\"date\":\"2026-08-18\",\"value\":0.25,\"goal\":2}','2026-08-18 19:22:39'),(300,16,'habits.increment','habit_logs','271','{\"key\":\"water\",\"date\":\"2026-08-18\",\"previousValue\":0.25,\"value\":0.5,\"goal\":2}','2026-08-18 19:22:40'),(301,16,'habits.increment','habit_logs','272','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"value\":5,\"goal\":30}','2026-08-18 19:22:42'),(302,16,'habits.increment','habit_logs','272','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":5,\"value\":10,\"goal\":30}','2026-08-18 19:22:44'),(303,16,'habits.increment','habit_logs','272','{\"key\":\"exercise\",\"date\":\"2026-08-18\",\"previousValue\":10,\"value\":15,\"goal\":30}','2026-08-18 19:22:45'),(304,16,'habits.increment','habit_logs','273','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"value\":1,\"goal\":8}','2026-08-18 19:22:47'),(305,16,'habits.increment','habit_logs','274','{\"key\":\"nutrition\",\"date\":\"2026-08-18\",\"value\":1,\"goal\":3}','2026-08-18 19:22:50'),(306,16,'habits.increment','habit_logs','275','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"value\":5,\"goal\":10}','2026-08-18 19:22:53'),(307,16,'habits.increment','habit_logs','274','{\"key\":\"nutrition\",\"date\":\"2026-08-18\",\"previousValue\":1,\"value\":2,\"goal\":3}','2026-08-18 19:23:36'),(308,16,'habits.increment','habit_logs','273','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":1,\"value\":2,\"goal\":8}','2026-08-18 19:24:11'),(309,16,'habits.increment','habit_logs','273','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":2,\"value\":3,\"goal\":8}','2026-08-18 19:24:13'),(310,16,'habits.increment','habit_logs','274','{\"key\":\"nutrition\",\"date\":\"2026-08-18\",\"previousValue\":2,\"value\":3,\"goal\":3}','2026-08-18 19:24:16'),(311,16,'habits.increment','habit_logs','273','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":3,\"value\":4,\"goal\":8}','2026-08-18 19:24:20'),(312,16,'habits.increment','habit_logs','273','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":4,\"value\":5,\"goal\":8}','2026-08-18 19:24:21'),(313,16,'habits.increment','habit_logs','273','{\"key\":\"sleep\",\"date\":\"2026-08-18\",\"previousValue\":5,\"value\":6,\"goal\":8}','2026-08-18 19:24:23'),(314,16,'habits.increment','habit_logs','275','{\"key\":\"meditation\",\"date\":\"2026-08-18\",\"previousValue\":5,\"value\":10,\"goal\":10}','2026-08-18 19:25:01'),(315,15,'auth.login','users','15','{\"email\":\"230187@utxicotepec.edu.mx\"}','2026-08-18 20:05:27'),(316,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-18 20:30:18'),(317,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-18 22:33:17'),(318,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-19 00:11:13'),(319,NULL,'auth.register','users','17','{\"email\":\"prueba1@gmail.com\"}','2026-08-19 00:13:29'),(320,NULL,'auth.register','users','18','{\"email\":\"jhonsondanielle5@gmail.com\"}','2026-08-19 00:27:35'),(321,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-19 18:45:09'),(322,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-19 18:49:00'),(323,NULL,'auth.register','users','19','{\"email\":\"hecvg@gmail.com\"}','2026-08-19 18:52:24'),(324,19,'medications.create','medications','16','{\"id\":16,\"userId\":19,\"name\":\"Prednisolona\",\"dose\":\"10mg\",\"frequency\":\"Diario\",\"time\":\"12:00\",\"color\":\"#0F766E\",\"taken\":false,\"tomado\":false,\"type\":\"pastilla\"}','2026-08-19 18:53:57'),(325,19,'habits.increment','habit_logs','276','{\"key\":\"water\",\"date\":\"2026-08-19\",\"value\":0.25,\"goal\":2}','2026-08-19 18:57:07'),(326,19,'habits.increment','habit_logs','277','{\"key\":\"exercise\",\"date\":\"2026-08-19\",\"value\":5,\"goal\":30}','2026-08-19 18:57:16'),(327,19,'habits.increment','habit_logs','278','{\"key\":\"sleep\",\"date\":\"2026-08-19\",\"value\":1,\"goal\":8}','2026-08-19 18:57:20'),(328,19,'habits.increment','habit_logs','279','{\"key\":\"meditation\",\"date\":\"2026-08-19\",\"value\":5,\"goal\":10}','2026-08-19 18:57:24'),(329,19,'habits.increment','habit_logs','280','{\"key\":\"nutrition\",\"date\":\"2026-08-19\",\"value\":1,\"goal\":3}','2026-08-19 18:57:57'),(330,19,'habits.increment','habit_logs','280','{\"key\":\"nutrition\",\"date\":\"2026-08-19\",\"previousValue\":1,\"value\":2,\"goal\":3}','2026-08-19 18:57:59'),(331,19,'habits.increment','habit_logs','280','{\"key\":\"nutrition\",\"date\":\"2026-08-19\",\"previousValue\":2,\"value\":3,\"goal\":3}','2026-08-19 18:58:00'),(332,19,'habits.increment','habit_logs','279','{\"key\":\"meditation\",\"date\":\"2026-08-19\",\"previousValue\":5,\"value\":10,\"goal\":10}','2026-08-19 18:58:03'),(333,19,'habits.increment','habit_logs','278','{\"key\":\"sleep\",\"date\":\"2026-08-19\",\"previousValue\":1,\"value\":2,\"goal\":8}','2026-08-19 18:58:08'),(334,19,'habits.increment','habit_logs','277','{\"key\":\"exercise\",\"date\":\"2026-08-19\",\"previousValue\":5,\"value\":10,\"goal\":30}','2026-08-19 18:58:10'),(335,19,'habits.increment','habit_logs','276','{\"key\":\"water\",\"date\":\"2026-08-19\",\"previousValue\":0.25,\"value\":0.5,\"goal\":2}','2026-08-19 18:58:12'),(336,19,'habits.increment','habit_logs','276','{\"key\":\"water\",\"date\":\"2026-08-19\",\"previousValue\":0.5,\"value\":0.75,\"goal\":2}','2026-08-19 18:58:17'),(337,19,'habits.increment','habit_logs','277','{\"key\":\"exercise\",\"date\":\"2026-08-19\",\"previousValue\":10,\"value\":15,\"goal\":30}','2026-08-19 18:58:18'),(338,19,'habits.increment','habit_logs','278','{\"key\":\"sleep\",\"date\":\"2026-08-19\",\"previousValue\":2,\"value\":3,\"goal\":8}','2026-08-19 18:58:19'),(339,19,'medical_history.create','medical_history_items','2','{\"id\":2,\"userId\":19,\"category\":\"surgeries\",\"description\":\"Ocular (2026)\"}','2026-08-19 18:59:41'),(340,19,'appointments.status','appointments','1','{\"status\":\"cancelada\"}','2026-08-19 19:00:04'),(341,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-19 19:00:39'),(342,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-19 19:01:47'),(343,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-19 19:02:51'),(344,1,'notifications.broadcast','notifications',NULL,'{\"target\":\"active\",\"recipients\":9,\"title\":\"prueba 203895\"}','2026-08-19 19:03:52'),(345,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-19 19:16:29'),(346,10,'notifications.mark_all_read','notifications',NULL,'{\"modified\":1}','2026-08-19 19:22:40'),(347,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-19 19:23:54'),(348,10,'auth.login','users','10','{\"email\":\"yazmingutierrezhernandez411@gmail.com\"}','2026-08-19 19:26:18'),(349,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-20 04:19:43'),(350,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-20 04:20:31'),(351,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-20 04:41:39'),(352,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-20 04:48:09'),(353,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-20 04:48:56'),(354,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-20 04:57:41'),(355,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-20 05:14:39'),(356,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-20 05:37:20'),(357,NULL,'auth.register','users','25','{\"email\":\"ricardo@gmail.com\"}','2026-08-20 05:40:49'),(358,NULL,'auth.register','users','26','{\"email\":\"ricrado@gmail.com\"}','2026-08-20 05:44:01'),(359,NULL,'auth.register','users','27','{\"email\":\"ricardo@gmail.com\"}','2026-08-20 05:47:23'),(360,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-20 05:52:51'),(361,NULL,'auth.register','users','28','{\"email\":\"josue@gmail.com\"}','2026-08-20 05:54:43'),(362,28,'auth.login','users','28','{\"email\":\"josue@gmail.com\"}','2026-08-20 05:58:43'),(363,NULL,'auth.register','users','29','{\"email\":\"paula@gmail.com\"}','2026-08-20 06:10:01'),(364,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-20 06:10:38'),(365,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-20 06:14:18'),(366,2,'auth.login','users','2','{\"email\":\"maria@email.com\"}','2026-08-20 06:15:01'),(367,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-20 06:58:27'),(368,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-20 07:05:42'),(369,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-20 07:29:00'),(370,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-20 07:29:18');
/*!40000 ALTER TABLE `audit_logs` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `chat_messages`
--

DROP TABLE IF EXISTS `chat_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `conversation_id` bigint unsigned NOT NULL,
  `role` enum('user','assistant') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_chat_messages_conversation_id` (`conversation_id`),
  KEY `idx_chat_messages_created_at` (`created_at`),
  CONSTRAINT `fk_chat_messages_conversation` FOREIGN KEY (`conversation_id`) REFERENCES `chat_conversations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_messages`
--

LOCK TABLES `chat_messages` WRITE;
/*!40000 ALTER TABLE `chat_messages` DISABLE KEYS */;
INSERT INTO `chat_messages` VALUES (1,1,'user','┬┐C├│mo mejorar mi sue├▒o?','2026-08-17 20:24:55'),(2,1,'assistant','Mejorar la calidad del sue├▒o es uno de los pasos m├ís efectivos para aumentar tu energ├¡a, mejorar tu estado de ├ínimo y cuidar tu salud general. El sue├▒o depende en gran medida de nuestros h├íbitos diarios y del entorno.\n\nAqu├¡ tienes algunas **acciones pr├ícticas** para lograr un descanso m├ís profundo y reparador:\n\n### 1. Mant├®n un horario constante\n* **Qu├® hacer:** Acu├®state y lev├íntate a la misma hora todos los d├¡as, incluso los fines de semana.\n* **Por qu├®:** Esto ayuda a regular tu reloj biol├│gico (ritmo circadiano), haciendo que te d├® sue├▒o de forma natural a la hora adecuada.\n\n### 2. Cuida la higiene de pantallas\n* **Qu├® hacer:** Evita el tel├®fono, la televisi├│n o la computadora al menos **30 a 60 minutos antes de dormir**.\n* **Por qu├®:** La luz azul de las pantallas frena la producci├│n de **melatonina**, la hormona que le indica a tu cuerpo que es hora de descansar.\n\n### 3. Acondiciona tu dormitorio\n* **Qu├® hacer:** Procura que tu habitaci├│n est├® **oscura, silenciosa y con una temperatura fresca** (alrededor de 18-20 ┬░C).\n* **Por qu├®:** Un ambiente fresco y sin distracciones luminosas ni sonoras facilita la transici├│n hacia un sue├▒o profundo.\n\n### 4. Atenci├│n a lo que ingieres por la noche\n* **Evita la cafe├¡na:** No consumas caf├®, t├®s estimulantes o refrescos de cola despu├®s de las 2:00 p. m. o 4:00 p. m.\n* **Cenas ligeras:** Cena al menos **2 o 3 horas antes de acostarte** para evitar indigesti├│n o reflujo.\n* **Modera el alcohol:** Aunque puede dar sensaci├│n de somnolencia, el alcohol fragmenta el sue├▒o y reduce la fase de descanso profundo.\n\n### 5. Crea una rutina de relajaci├│n\n* **Qu├® hacer:** Dedica los ├║ltimos 20-30 minutos del d├¡a a actividades tranquilas: leer un libro, escuchar m├║sica suave, hacer estiramientos ligeros o practicar respiraci├│n profunda.\n* **Por qu├®:** Env├¡a una se├▒al a tu sistema nervioso de que es seguro \"desactivarse\" del estr├®s diario.\n\n---\n\n**Nota de bienestar:** Si llevas varias semanas aplicando estos h├íbitos y contin├║as con insomnio, cansancio extremo durante el d├¡a o despertares con sensaci├│n de ahogo, es aconsejable **consultar con un profesional de la salud** para descartar alg├║n trastorno del sue├▒o. \n\n┬┐Hay alg├║n factor en particular que sientas que interrumpe tu descanso actualmente (como el estr├®s o dolores f├¡sicos)?','2026-08-17 20:25:04'),(3,1,'user','hola','2026-08-17 20:25:57'),(4,1,'assistant','┬íHola! ┬┐C├│mo est├ís hoy? \n\nCu├®ntame, ┬┐en qu├® te puedo ayudar o qu├® aspecto de tu salud y bienestar te gustar├¡a consultar hoy? Estoy aqu├¡ para apoyarte.','2026-08-17 20:25:59'),(5,1,'user','puedes agregar nuevos medicamentos','2026-08-17 20:27:05'),(6,1,'assistant','**No, como asistente virtual de bienestar no puedo recetar, agregar ni modificar medicamentos.** \n\nLa indicaci├│n, ajuste o prescripci├│n de cualquier tratamiento m├®dico debe ser realizada ├║nicamente por un **m├®dico o profesional de la salud cualificado**, ya que requiere evaluar tu historial cl├¡nico, posibles alergias e interacciones.\n\nSi est├ís considerando iniciar un nuevo tratamiento, cambiar de dosis o tienes dudas sobre lo que est├ís tomando, te recomiendo consultar directamente con tu m├®dico.\n\n**┬┐En qu├® s├¡ te puedo ayudar?**\n* Orientarte sobre h├íbitos saludables para acompa├▒ar tu bienestar.\n* Darte consejos para preparar tu cita m├®dica y saber qu├® preguntas hacerle a tu doctor.\n* Explicarte de forma general c├│mo funcionan ciertos h├íbitos o el autocuidado.\n\nSi tienes alguna duda sobre tu estilo de vida, nutrici├│n, sue├▒o o manejo del estr├®s, ┬íd├¡melo y con gusto lo revisamos!','2026-08-17 20:27:11'),(7,1,'user','┬┐C├│mo mejorar mi sue├▒o?','2026-08-17 20:48:52'),(8,1,'assistant','Como vimos al inicio de nuestra conversaci├│n, mejorar el sue├▒o depende principalmente de ajustar algunos h├íbitos diarios. \n\nTe comparto un **resumen r├ípido con las acciones m├ís efectivas** que puedes empezar a aplicar hoy mismo:\n\n* **Horarios fijos:** Acu├®state y lev├íntate a la misma hora todos los d├¡as.\n* **Sin pantallas:** Apaga el celular o televisi├│n 30-60 minutos antes de dormir para no frenar la melatonina.\n* **Ambiente fresco y oscuro:** Mant├®n tu habitaci├│n silenciosa, sin luces y a temperatura agradable.\n* **Cenas ligeras y sin cafe├¡na:** Evita el caf├® despu├®s de la tarde y cena al menos 2 horas antes de acostarte.\n* **Rutina de desconexi├│n:** Lee un libro o haz respiraciones profundas antes de apagar la luz.\n\nPara darte una recomendaci├│n m├ís personalizada sin repetir lo anterior, cu├®ntame: **┬┐cu├íl es tu mayor dificultad actualmente?** \n\n*(Por ejemplo: ┬┐te cuesta conciliar el sue├▒o al acostarte, te despiertas a mitad de la noche, o te levantas con la sensaci├│n de no haber descansado?)*','2026-08-17 20:49:00'),(9,3,'user','que es mejor react o angular','2026-08-17 20:49:23'),(10,3,'assistant','┬íHola! Como **VitalMind AI**, soy un asistente especializado en **salud, bienestar y h├íbitos saludables** (como nutrici├│n, ejercicio, sue├▒o, manejo del estr├®s y cuidado personal). \n\nPor esa raz├│n, no dispongo de informaci├│n sobre desarrollo web o herramientas de programaci├│n como React y Angular. \n\nSin embargo, si pasas mucho tiempo programando o frente a la pantalla y necesitas consejos sobre **c├│mo reducir la fatiga visual, cuidar tu postura o gestionar el estr├®s laboral**, ┬íestar├® encantado de ayudarte!','2026-08-17 20:49:36'),(11,4,'user','┬┐C├│mo mejorar mi sue├▒o?','2026-08-17 21:16:09'),(12,4,'assistant','Mejorar la calidad del sue├▒o es uno de los pilares m├ís importantes para tu salud y energ├¡a diaria. Un buen descanso no solo depende del momento de ir a la cama, sino de lo que haces a lo largo de todo el d├¡a.\n\nAqu├¡ tienes algunas **acciones pr├ícticas** que puedes empezar a aplicar hoy mismo:\n\n### 1. Cuida tus horarios (Ritmo Circadiano)\n* **Mant├®n una rutina:** Intenta acostarte y despertarte a la misma hora todos los d├¡as, incluso los fines de semana. Esto ayuda a regular tu reloj biol├│gico.\n* **Toma sol por la ma├▒ana:** Exponte a la luz natural durante los primeros 30 minutos tras despertarte. Esto le indica a tu cerebro que el d├¡a ha comenzado y optimiza la producci├│n de melatonina (la hormona del sue├▒o) por la noche.\n\n### 2. Prepara el entorno para dormir\n* **Ambiente adecuado:** Aseg├║rate de que tu habitaci├│n sea **oscura, silenciosa y fresca** (una temperatura entre 18 ┬░C y 20 ┬░C suele ser la ideal).\n* **Usa la cama solo para descansar:** Evita trabajar, comer o ver la televisi├│n en la cama para que tu cerebro asocie ese espacio ├║nicamente con el sue├▒o.\n\n### 3. Ajusta tus h├íbitos nocturnos\n* **Descon├®ctate de las pantallas:** Evita el tel├®fono, la computadora o la televisi├│n al menos **1 hora antes de dormir**. La luz azul interfiere con la liberaci├│n de melatonina.\n* **Cenas ligeras:** Cena al menos 2 o 3 horas antes de acostarte. Las comidas copiosas o muy pesadas dificultan la digesti├│n y perturban el descanso.\n* **Limita la cafe├¡na y el alcohol:** Evita el caf├®, t├®s estimulantes o bebidas energ├®ticas despu├®s de las 2:00 p.m. Aunque el alcohol puede dar somnolencia inicial, fragmenta el sue├▒o y reduce su calidad en la segunda mitad de la noche.\n\n### 4. Crea una rutina de desconexi├│n\n* Dedica los ├║ltimos 30-60 minutos del d├¡a a actividades relajantes: leer un libro f├¡sico, tomar una ducha tibia, escuchar m├║sica suave o hacer ejercicios de respiraci├│n profunda.\n\n---\n\n**Nota de bienestar:** Si notas que, a pesar de mejorar tus h├íbitos, la falta de sue├▒o persiste por varias semanas o se acompa├▒a de ronquidos fuertes, cansancio extremo de d├¡a o ansiedad elevada, es recomendable consultar con un **profesional de la salud** para una valoraci├│n m├ís detallada.','2026-08-17 21:16:43'),(13,4,'user','┬┐C├│mo mejorar mi sue├▒o?','2026-08-17 21:44:19'),(14,4,'assistant','Como comentamos hace un momento, las claves principales son **mantener horarios fijos**, **evitar pantallas 1 hora antes de dormir** y **crear un entorno oscuro y fresco**.\n\nPara ayudarte de forma m├ís espec├¡fica, **┬┐hay alg├║n problema en particular que est├®s experimentando?** Por ejemplo:\n\n1. **┬┐Te cuesta conciliar el sue├▒o al acostarte?** (Insomnio de inicio).\n2. **┬┐Te despiertas a mitad de la noche o muy temprano?** (Mantenimiento del sue├▒o).\n3. **┬┐Duermes suficientes horas pero te despiertas cansado/a?** (Calidad del sue├▒o).\n4. **┬┐El estr├®s o los pensamientos no te dejan relajar la mente?**\n\nCu├®ntame un poco m├ís sobre tu situaci├│n y te dar├® recomendaciones adaptadas a tu caso.','2026-08-17 21:44:24'),(15,5,'user','Hola , no me siento bien','2026-08-17 21:55:40'),(16,6,'user','cuantos token estoy usando al preguntarte esto','2026-08-17 22:10:08'),(17,6,'user','┬┐Qu├® puedo hacer para reducir el estr├®s?','2026-08-17 22:38:26'),(18,6,'user','┬┐Qu├® h├íbitos saludables me recomiendas?','2026-08-17 22:38:38'),(19,7,'user','┬┐C├│mo mejorar mi sue├▒o?','2026-08-17 23:18:51'),(20,7,'assistant','Mejorar la calidad de tu sue├▒o es uno de los mejores pasos para potenciar tu energ├¡a y salud general. Aqu├¡ tienes algunas acciones pr├ícticas y efectivas que puedes empezar a aplicar hoy mismo:\n\n### 1. Mant├®n un horario regular\n* **Cu├®state y lev├íntate a la misma hora** todos los d├¡as, incluso los fines de semana. Esto refuerza el reloj biol├│gico de tu cuerpo y facilita conciliar el sue├▒o de forma natural.\n\n### 2. Cuida tu entorno de descanso\n* **Oscuridad y frescura:** Mant├®n tu habitaci├│n a una temperatura agradable (entre 18 ┬░C y 21 ┬░C suele ser ideal) y lo m├ís oscura posible. \n* **Asocia la cama solo con dormir:** Evita trabajar, comer o ver la televisi├│n en la cama para que tu cerebro la asocie exclusivamente con el descanso.\n\n### 3. Prepara tu mente antes de acostarte\n* **Descon├®ctate de las pantallas:** Apoya celulares, tablets y televisi├│n al menos **45 a 60 minutos antes de dormir**. La luz azul frena la producci├│n de melatonina (la hormona del sue├▒o).\n* **Crea una rutina de relajaci├│n:** Lee un libro, escucha m├║sica suave o realiza estiramientos ligeros para indicarle a tu cuerpo que es hora de bajar el ritmo.\n\n### 4. Ajusta tus h├íbitos durante el d├¡a\n* **Limita la cafe├¡na:** Evita el caf├®, t├®s estimulantes o bebidas energ├®ticas despu├®s de las **2:00 p. m.**\n* **Cenas ligeras:** Procura cenar al menos **2 o 3 horas antes de irte a la cama**. Las comidas muy pesadas o picantes pueden causar digestiones lentas e interrumpir tu descanso.\n* **Mu├®vete:** La actividad f├¡sica regular ayuda a dormir m├ís profundamente, pero intenta no hacer ejercicio intenso justo antes de acostarte.\n\n---\n\n*Nota: Si a pesar de seguir estas recomendaciones tu falta de sue├▒o persiste durante varias semanas, genera somnolencia extrema de d├¡a o se acompa├▒a de ronquidos fuertes y pausas al respirar, es aconsejable consultar con un profesional de la salud para una evaluaci├│n personalizada.*','2026-08-17 23:19:21'),(21,7,'user','No me siento muy bien llevo 8 horas frente a la compu','2026-08-17 23:44:43'),(22,7,'user','hi','2026-08-18 00:55:52'),(23,7,'user','jjs','2026-08-18 00:56:02'),(24,7,'assistant','Es totalmente comprensible que te sientas as├¡. Pasar 8 horas seguidas frente a la pantalla genera una gran carga de **fatiga visual, tensi├│n muscular en cuello y espalda, y cansancio mental**. \n\nPara ayudarte a sentirte mejor en este momento, te recomiendo hacer una pausa inmediata y seguir estos pasos sencillos:\n\n### 1. Descon├®ctate de las pantallas ahora mismo\n* **Cierra la laptop o apaga el monitor** al menos durante 15 o 20 minutos. Deja tambi├®n el tel├®fono m├│vil de lado para que tus ojos e inclusive tu cerebro descansen de la luz directa.\n\n### 2. Alivia la fatiga visual\n* **Pesta├▒ea varias veces** o cierra los ojos suavemente durante un par de minutos. \n* Mira hacia un punto lejano (como una ventana) para ayudar a que los m├║sculos de tus ojos se relajen tras horas de enfocar a corta distancia.\n\n### 3. Cambia de postura y est├¡rate\n* **Ponte de pie** y camina un poco por tu casa o espacio de trabajo.\n* **Estira suavemente el cuello y los hombros:** Mueve la cabeza despacio de un lado a otro y haz giros suaves con los hombros hacia atr├ís para liberar la presi├│n acumulada en la parte alta de la espalda.\n\n### 4. Hidr├ítate\n* **Bebe un vaso de agua fresca.** Estar sentado tanto tiempo suele hacer que olvidemos tomar agua, y la deshidrataci├│n leve aumenta la sensaci├│n de dolor de cabeza y fatiga.\n\n### 5. Respira profundo\n* Toma 3 o 4 respiraciones lentas y profundas (inhala por la nariz, exhala por la boca). Esto ayuda a oxigenar tu cuerpo y a reducir la tensi├│n nerviosa.\n\n---\n\n Si notas que el malestar no cede con el descanso, o si sientes un **dolor de cabeza muy intenso, mareos fuertes o alteraciones en la visi├│n**, aseg├║rate de tomarte el resto del d├¡a para descansar y consulta a un m├®dico si los s├¡ntomas persisten. \n\n┬┐Sientes alguna molestia en particular en este momento, como dolor de cabeza, mareo o tensi├│n en el cuello?','2026-08-18 00:56:37'),(25,8,'user','chat gpt o gemini','2026-08-18 00:57:16'),(26,8,'assistant','Tanto **ChatGPT** (de OpenAI) como **Gemini** (de Google) son modelos de inteligencia artificial de gran nivel, y la elecci├│n entre uno u otro depende de lo que necesites:\n\n*   **ChatGPT:** Es excelente para redactar textos, resolver dudas complejas, programar y mantener conversaciones con un tono muy natural.\n*   **Gemini:** Destaca por su integraci├│n directa con el ecosistema de Google (B├║squeda, Docs, Gmail) y por ofrecer informaci├│n muy actualizada gracias a su acceso directo a la web.\n\n Ambos son herramientas generales geniales. Sin embargo, como **VitalMind AI**, mi especialidad es acompa├▒arte espec├¡ficamente en tu **salud, bienestar, h├íbitos saludables, sue├▒o y gesti├│n del estr├®s**, ofreci├®ndote un enfoque estructurado, emp├ítico y enfocado en tu autocuidado diario.\n\n┬┐Hay alg├║n tema de bienestar o salud en el que te pueda ayudar hoy?','2026-08-18 00:57:29'),(27,5,'user','┬┐C├│mo mejorar mi sue├▒o?','2026-08-18 01:07:34'),(28,8,'user','llevo como 12 horas trabajando pero ya va quedando , me estoy tomando un te de azafran','2026-08-18 03:00:02'),(29,8,'assistant','┬íMucho ├ínimo, ya est├ís en la recta final! Trabajar 12 horas es una carga enorme para tu cuerpo y tu mente, as├¡ que es completamente normal que sientas cansancio acumulado. \n\nEl **t├® de azafr├ín** es una excelente elecci├│n para este momento. El azafr├ín contiene propiedades antioxidantes que ayudan a **reducir el estr├®s, mejorar el estado de ├ínimo y favorecer la relajaci├│n**, lo cual te vendr├í de maravilla para ir \"desconectando\" el cerebro despu├®s de una jornada tan intensa.\n\nPara ayudarte a terminar bien y preparar a tu cuerpo para un descanso reparador, te sugiero estos peque├▒os pasos pr├ícticos:\n\n*   **Pauta de desconexi├│n:** En cuanto des la ├║ltima tecla, cierra la computadora o aleja el trabajo de tu vista. Esto le env├¡a una se├▒al clara a tu cerebro de que la jornada termin├│.\n*   **Estiramiento r├ípido:** Ponte de pie un minuto, estira los brazos hacia el techo y mueve el cuello suavemente. Ayudar├í a liberar la tensi├│n acumulada en hombros y espalda.\n*   **Evita pantallas al terminar:** Intenta no saltar del trabajo a mirar el tel├®fono o la televisi├│n inmediatamente. Deja que la calidez del t├® y unos minutos de silencio ayuden a tu sistema nervioso a bajar revoluciones.\n*   **Cena ligera e hidrataci├│n:** Si no has comido bien, procura cenar algo ligero y f├ícil de digerir para que tu cuerpo no trabaje de m├ís durante la noche.\n\n┬íTermina ese ├║ltimo estir├│n con calma y reg├ílate un merecido descanso en cuanto acabes! ┬┐C├│mo te sientes f├¡sicamente en este momento (dolor de cabeza, fatiga visual, tensi├│n)?','2026-08-18 03:00:35'),(30,9,'user','Esto es una prueba','2026-08-18 16:07:32'),(31,9,'assistant','¡Hola! Prueba recibida correctamente. \n\nSoy **VitalMind AI**, tu asistente inteligente de salud y bienestar. Estoy listo para ayudarte a resolver dudas o darte recomendaciones prácticas sobre:\n\n* **Sueño y descanso**\n* **Alimentación e hidratación**\n* **Ejercicio y actividad física**\n* **Gestión del estrés y bienestar emocional**\n* **Hábitos saludables y autocuidado**\n* **Molestias comunes y prevención**\n\n¿En qué te puedo acompañar o ayudar el día de hoy?','2026-08-18 16:07:51'),(32,10,'user','¿Cómo mejorar mi sueño?','2026-08-18 18:23:24'),(33,10,'assistant','Mejorar la calidad de tu sueño es uno de los pasos más importantes para cuidar tu energía, salud y bienestar general. \n\nAquí tienes las recomendaciones más efectivas para lograr un descanso profundo y reparador:\n\n### 1. Cuida tus horarios\n* **Mantén la regularidad:** Intenta acostarte y despertarte a la misma hora todos los días, incluso los fines de semana. *¿Por qué?* Esto regula tu **reloj biológico** (ritmo circadiano) y facilita que te dé sueño de forma natural.\n\n### 2. Prepara tu entorno de descanso\n* **Oscuridad, silencio y frescura:** Mantén tu habitación oscura, tranquila y a una temperatura fresca (alrededor de 18-20 °C). *¿Por qué?* El cuerpo necesita reducir ligeramente su temperatura interna para conciliar el sueño profundo.\n* **Usa la cama solo para dormir:** Evita trabajar, comer o ver televisión en la cama para que tu cerebro la asocie únicamente con el descanso.\n\n### 3. Desconéctate de las pantallas\n* **Evita dispositivos 1 hora antes de dormir:** Apaga el teléfono, la tableta y la televisión antes de acostarte. *¿Por qué?* La **luz azul** de las pantallas bloquea la producción de **melatonina**, la hormona encargada de indicarle a tu cuerpo que es hora de dormir.\n\n### 4. Atención a la alimentación y bebidas\n* **Limita la cafeína:** Evita el café, tés estimulantes o refrescos después de mediodía.\n* **Cenas ligeras:** Cena al menos **2 o 3 horas antes** de acostarte. Las digestiones pesadas interfieren con el descanso.\n* **Modera el alcohol:** Aunque puede dar sensación de somnolencia, el alcohol altera las fases profundas del sueño y provoca despertares nocturnos.\n\n### 5. Diseña una rutina de relajación\n* Dedica los últimos 30-60 minutos del día a actividades tranquilas: leer un libro, tomar un baño tibio, escuchar música suave o practicar **ejercicios de respiración profunda**. Esto ayuda a desactivar el sistema nervioso y reducir el estrés acumulado.\n\n---\n\n**Un consejo práctico para empezar hoy:** Elige solo **1 o 2 de estas acciones** para poner en práctica esta semana (por ejemplo, apagar las pantallas una hora antes y fijar una hora de despertar). La clave del éxito está en la constancia.\n\n*Nota: Si a pesar de seguir estos hábitos experimentas insomnio prolongado o fatiga extrema durante el día, es aconsejable consultar con un profesional de la salud para una valoración personalizada.*','2026-08-18 18:24:22'),(34,11,'user','Me duele mucho la cabeza, me siento muy mareada','2026-08-18 18:45:40'),(35,11,'assistant','Siento mucho que te sientas así. El dolor de cabeza fuerte acompañado de mareos es una señal de que tu cuerpo necesita parar y descansar de inmediato.\n\n**Atención a señales de alerta:**\nAntes que nada, **busca atención médica de urgencia inmediatamente** si presentas alguno de estos síntomas:\n* El dolor apareció de forma repentina y extremadamente intensa.\n* Dificultad para hablar, mover la cara o debilidad en un lado del cuerpo.\n* Pérdida de visión, visión doble o confusión.\n* Cuello rígido con fiebre o vómitos intensos.\n\n---\n\nSi no tienes estos síntomas de emergencia, te sugiero tomar las siguientes medidas de autocuidado ahora mismo:\n\n1. **Siéntate o recuéstate de inmediato:** Evita estar de pie para prevenir una caída o accidente debido al mareo.\n2. **Busca un entorno oscuro y silencioso:** La luz y el ruido pueden empeorar la migraña o el dolor de cabeza tensional.\n3. **Hidrátate poco a poco:** Toma pequeños sorbos de agua fresca. La deshidratación es una causa muy común de mareo y dolor de cabeza.\n4. **Aplica una compresa:** Coloca un paño fresco (o tibio, según sientas más alivio) sobre tu frente o la nuca.\n5. **Evita movimientos bruscos:** Al cambiar de posición, hazlo muy despacio.\n\n**¿Qué hacer después?**\nEl mareo y el dolor de cabeza pueden deberse a cansancio extremo, estrés, deshidratación, bajeza de presión o azúcar, o migraña. Si el malestar no mejora tras descansar e hidratarte, o si empeora, **es muy importante que te evalúe un médico** para determinar la causa exacta de manera segura. \n\nPor favor, tómate este momento para descansar. ¿Hay alguien contigo que pueda acompañarte o ayudarte en este momento?','2026-08-18 18:46:03'),(36,13,'user','¿Cómo mejorar mi sueño?','2026-08-19 00:13:54'),(37,13,'assistant','Mejorar la calidad del sueño es uno de los pasos más efectivos para aumentar tu energía y bienestar general. Para lograr un descanso profundo y reparador, te sugiero poner en práctica estas acciones:\n\n### 1. Cuida tu higiene de luz y pantallas\n* **Apaga las pantallas 1 hora antes de dormir:** La luz azul de teléfonos, tablets y televisores frena la producción de **melatonina**, la hormona que le indica a tu cuerpo que es hora de descansar.\n* **Busca oscuridad total:** Usa cortinas oscuras o un antifaz para evitar interrupciones en tus ciclos de sueño.\n\n### 2. Mantén la regularidad\n* **Horarios fijos:** Intenta acostarte y despertarte a la misma hora todos los días, incluso los fines de semana. Esto regula tu **ritmo circadiano** (tu reloj biológico interno).\n\n### 3. Ajusta tu alimentación y consumo\n* **Evita la cafeína por la tarde:** Limita el café, tés estimulantes o bebidas energéticas después de las 2:00 p.m.\n* **Cenas ligeras:** Cena al menos **2 a 3 horas antes** de irte a la cama. Las digestiones pesadas dificultan la conciliación del sueño.\n\n### 4. Prepara tu entorno y tu mente\n* **Temperatura fresca:** Mantén tu habitación a una temperatura agradable y ventilada (idealmente entre 18 °C y 20 °C).\n* **Rutina de desconexión:** Dedica los últimos 30 minutos del día a una actividad relajante, como leer un libro físico, hacer estiramientos suaves o practicar respiración profunda.\n\n---\n\nTe recomiendo comenzar implementando **solo uno o dos de estos cambios** durante esta semana para no abrumarte. Con la constancia, notarás una gran diferencia. \n\n¿Hay algún factor en particular que sientas que interrumpe tu descanso actualmente (como el estrés, despertares nocturnos o dificultad para conciliar el sueño)? Con gusto puedo darte consejos más específicos.','2026-08-19 00:14:01'),(38,13,'user','Hola','2026-08-19 00:14:29'),(39,13,'assistant','¡Hola! ¿Cómo estás? \n\nDime, ¿te quedó alguna duda sobre las recomendaciones para mejorar tu sueño o hay algún otro tema de salud y bienestar en el que te pueda ayudar hoy?','2026-08-19 00:14:32'),(40,13,'user','Para que sirve la paracetamol','2026-08-19 00:14:47'),(41,13,'assistant','El **paracetamol** (también conocido como acetaminofén) es un medicamento ampliamente utilizado principalmente para dos funciones:\n\n1. **Aliviar el dolor (analgésico):** Es eficaz para dolores de leves a moderados, como dolor de cabeza, dolor muscular, molestias dentales, dolores menstruales o malestares por resfriados.\n2. **Reducir la fiebre (antipirético):** Ayuda a bajar la temperatura corporal cuando hay fiebre.\n\n### ¿Cómo funciona brevemente?\nActúa principalmente a nivel del sistema nervioso central, bloqueando los mensajes químicos que le indican al cerebro que hay dolor y ayudando a regular el centro de control de temperatura del cuerpo.\n\n### Recomendaciones importantes de uso:\n* **Respeta las dosis:** Es un fármaco muy seguro en las dosis recomendadas, pero tomarlo en exceso puede causar **daños graves en el hígado**.\n* **Evita combinarlo:** Muchos medicamentos para el resfriado o la gripe ya contienen paracetamol. Revisa las etiquetas para no tomar una dosis doble sin darte cuenta.\n* **Evita el alcohol:** No es recomendable consumir alcohol mientras tomas paracetamol, ya que aumenta el riesgo de toxicidad hepática.\n\n*Recuerda que esta información es meramente educativa. Para conocer la dosis exacta adecuada para ti o si presentas un dolor persistente o fiebre alta por más de 3 días, siempre es importante consultar a un médico o farmacéutico.* \n\n¿Hay algún síntoma en particular que estés intentando aliviar?','2026-08-19 00:14:54'),(42,14,'user','Me siento muy mal, me quiero colgar del techo','2026-08-19 18:55:08'),(43,14,'assistant','Lamento mucho que estés pasando por un momento tan difícil y doloroso, pero **no estás solo y hay personas que quieren ayudarte**.\n\nPor favor, busca ayuda inmediatamente. Tu vida es muy importante.\n\n**Lo que puedes hacer ahora mismo:**\n\n1. **Llama a un servicio de emergencias:**\n   * **911** (en la mayoría de los países de América y España) para asistencia médica inmediata.\n\n2. **Llama a una línea de ayuda en crisis y prevención del suicidio:**\n   * **España:** Llama al **024** (Línea de atención a la conducta suicida) o al **717 003 717** (Teléfono de la Esperanza).\n   * **México:** Llama al **800 911 2000** (Línea de la Vida).\n   * **Colombia:** Llama al **106** o **192**.\n   * **Argentina:** Llama al **135** (Centro de Asistencia al Suicida) o al **(011) 5275-1135**.\n   * **Estados Unidos:** Llama o envía un mensaje de texto al **988** (Línea de Prevención del Suicidio y Crisis).\n   * *Si estás en otro país, por favor acude al centro de salud o hospital más cercano inmediatamente.*\n\n3. **Habla con alguien de confianza:**\n   * Llama o busca a un familiar, amigo o persona cercana y dile cómo te sientes en este momento. No te quedes solo.\n\nPor favor, ponte a salvo y permite que profesionales capacitados te acompañen en este momento. Hay apoyo disponible para ti.','2026-08-19 18:55:13'),(44,9,'user','Me quiero suicidar por dolor de cabeza porque reprobe','2026-08-19 19:22:07'),(45,9,'assistant','Lamento mucho que estés pasando por un momento tan difícil, frustrante y doloroso. Por favor, **no estás solo/a y tu vida es muy valiosa**. Reprobar un examen o sentir un dolor intenso es temporal y tiene solución, pero necesitas apoyo ahora mismo.\n\nPor favor, **busca ayuda de inmediato**:\n\n1. **Habla con alguien de confianza:** Llama o acércate a un familiar, amigo o persona cercana y cuéntale cómo te sientes en este momento.\n2. **Contacta a una línea de ayuda gratuita y confidencial:**\n   * **En México:** Llama a la **Línea de la Vida** al **800 911 2000** (disponible 24/7).\n   * **En España:** Llama al **024** (Línea de atención a la conducta suicida) o al **717 003 717** (Teléfono de la Esperanza).\n   * **En Estados Unidos:** Llama o envía un mensaje de texto al **988** (Línea de Prevención del Suicidio y Crisis).\n   * **En otros países de Latinoamérica:** Acude al centro de salud más cercano o llama a los servicios de emergencia de tu país (como el 911 o 106).\n\nSi el dolor de cabeza es insoportable o sientes que estás en peligro inminente, por favor **llama a los servicios de emergencia de tu localidad o ve a una urgencia médica inmediatamente**.\n\nUn mal resultado académico no define tu futuro ni tu valor como persona, y el dolor físico puede tratarse. Por favor, da el paso de pedir ayuda a un profesional hoy mismo. Estoy aquí si necesitas desahogarte, pero lo más importante ahora es tu seguridad.','2026-08-19 19:22:16');
/*!40000 ALTER TABLE `chat_messages` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `habit_logs`
--

DROP TABLE IF EXISTS `habit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `habit_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `habit_key` enum('water','exercise','sleep','nutrition','meditation') NOT NULL,
  `log_date` date NOT NULL,
  `value` decimal(6,2) NOT NULL DEFAULT '0.00',
  `goal` decimal(6,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_habit_user_date` (`user_id`,`habit_key`,`log_date`),
  CONSTRAINT `fk_habit_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habit_logs`
--

LOCK TABLES `habit_logs` WRITE;
/*!40000 ALTER TABLE `habit_logs` DISABLE KEYS */;
INSERT INTO `habit_logs` VALUES (1,10,'exercise','2026-07-19',30.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(2,10,'meditation','2026-07-19',10.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(3,10,'nutrition','2026-07-19',3.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(4,10,'sleep','2026-07-19',5.95,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(5,10,'water','2026-07-19',1.50,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(6,10,'exercise','2026-07-20',15.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(7,10,'meditation','2026-07-20',5.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(8,10,'nutrition','2026-07-20',2.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(9,10,'sleep','2026-07-20',5.50,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(10,10,'water','2026-07-20',1.20,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(11,10,'exercise','2026-07-21',20.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(12,10,'meditation','2026-07-21',0.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(13,10,'nutrition','2026-07-21',3.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(14,10,'sleep','2026-07-21',5.65,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(15,10,'water','2026-07-21',1.30,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(16,10,'exercise','2026-07-22',25.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(17,10,'meditation','2026-07-22',5.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(18,10,'nutrition','2026-07-22',2.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(19,10,'sleep','2026-07-22',5.80,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(20,10,'water','2026-07-22',1.40,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(21,10,'exercise','2026-07-23',30.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(22,10,'meditation','2026-07-23',10.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(23,10,'nutrition','2026-07-23',3.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(24,10,'sleep','2026-07-23',5.95,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(25,10,'water','2026-07-23',1.50,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(26,10,'exercise','2026-07-24',15.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(27,10,'meditation','2026-07-24',0.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(28,10,'nutrition','2026-07-24',2.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(29,10,'sleep','2026-07-24',5.50,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(30,10,'water','2026-07-24',1.20,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(31,10,'exercise','2026-07-25',20.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(32,10,'meditation','2026-07-25',10.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(33,10,'nutrition','2026-07-25',3.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(34,10,'sleep','2026-07-25',5.65,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(35,10,'water','2026-07-25',1.30,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(36,10,'exercise','2026-07-26',25.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(37,10,'meditation','2026-07-26',5.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(38,10,'nutrition','2026-07-26',2.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(39,10,'sleep','2026-07-26',5.80,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(40,10,'water','2026-07-26',1.40,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(41,10,'exercise','2026-07-27',35.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(42,10,'meditation','2026-07-27',0.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(43,10,'nutrition','2026-07-27',3.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(44,10,'sleep','2026-07-27',6.45,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(45,10,'water','2026-07-27',1.65,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(46,10,'exercise','2026-07-28',40.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(47,10,'meditation','2026-07-28',5.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(48,10,'nutrition','2026-07-28',3.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(49,10,'sleep','2026-07-28',6.00,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(50,10,'water','2026-07-28',1.75,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(51,10,'exercise','2026-07-29',45.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(52,10,'meditation','2026-07-29',10.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(53,10,'nutrition','2026-07-29',3.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(54,10,'sleep','2026-07-29',6.15,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(55,10,'water','2026-07-29',1.85,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(56,10,'exercise','2026-07-30',25.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(57,10,'meditation','2026-07-30',0.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(58,10,'nutrition','2026-07-30',3.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(59,10,'sleep','2026-07-30',6.30,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(60,10,'water','2026-07-30',1.45,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(61,10,'exercise','2026-07-31',30.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(62,10,'meditation','2026-07-31',10.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(63,10,'nutrition','2026-07-31',3.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(64,10,'sleep','2026-07-31',6.45,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(65,10,'water','2026-07-31',1.55,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(66,10,'exercise','2026-08-01',30.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(67,10,'meditation','2026-08-01',10.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(68,10,'nutrition','2026-08-01',3.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(69,10,'sleep','2026-08-01',6.15,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(70,10,'water','2026-08-01',1.55,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(71,10,'exercise','2026-08-02',35.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(72,10,'meditation','2026-08-02',5.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(73,10,'nutrition','2026-08-02',3.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(74,10,'sleep','2026-08-02',6.30,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(75,10,'water','2026-08-02',1.65,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(76,10,'exercise','2026-08-03',45.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(77,10,'meditation','2026-08-03',0.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(78,10,'nutrition','2026-08-03',4.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(79,10,'sleep','2026-08-03',6.95,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(80,10,'water','2026-08-03',1.95,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(81,10,'exercise','2026-08-04',30.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(82,10,'meditation','2026-08-04',5.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(83,10,'nutrition','2026-08-04',3.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(84,10,'sleep','2026-08-04',6.50,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(85,10,'water','2026-08-04',1.65,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(86,10,'exercise','2026-08-05',35.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(87,10,'meditation','2026-08-05',10.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(88,10,'nutrition','2026-08-05',4.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(89,10,'sleep','2026-08-05',6.65,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(90,10,'water','2026-08-05',1.75,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(91,10,'exercise','2026-08-06',40.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(92,10,'meditation','2026-08-06',0.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(93,10,'nutrition','2026-08-06',3.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(94,10,'sleep','2026-08-06',6.80,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(95,10,'water','2026-08-06',1.85,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(96,10,'exercise','2026-08-07',45.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(97,10,'meditation','2026-08-07',10.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(98,10,'nutrition','2026-08-07',4.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(99,10,'sleep','2026-08-07',6.95,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(100,10,'water','2026-08-07',1.95,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(101,10,'exercise','2026-08-08',30.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(102,10,'meditation','2026-08-08',5.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(103,10,'nutrition','2026-08-08',3.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(104,10,'sleep','2026-08-08',6.50,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(105,10,'water','2026-08-08',1.65,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(106,10,'exercise','2026-08-09',35.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(107,10,'meditation','2026-08-09',0.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(108,10,'nutrition','2026-08-09',4.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(109,10,'sleep','2026-08-09',6.65,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(110,10,'water','2026-08-09',1.75,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(111,10,'exercise','2026-08-10',40.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(112,10,'meditation','2026-08-10',5.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(113,10,'nutrition','2026-08-10',4.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(114,10,'sleep','2026-08-10',7.20,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(115,10,'water','2026-08-10',1.96,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(116,10,'exercise','2026-08-11',45.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(117,10,'meditation','2026-08-11',10.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(118,10,'nutrition','2026-08-11',4.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(119,10,'sleep','2026-08-11',7.35,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(120,10,'water','2026-08-11',2.04,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(121,10,'exercise','2026-08-12',50.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(122,10,'meditation','2026-08-12',0.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(123,10,'nutrition','2026-08-12',4.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(124,10,'sleep','2026-08-12',6.90,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(125,10,'water','2026-08-12',1.80,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(126,10,'exercise','2026-08-13',55.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(127,10,'meditation','2026-08-13',10.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(128,10,'nutrition','2026-08-13',4.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(129,10,'sleep','2026-08-13',7.05,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(130,10,'water','2026-08-13',1.88,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(131,10,'exercise','2026-08-14',60.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(132,10,'meditation','2026-08-14',5.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(133,10,'nutrition','2026-08-14',4.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(134,10,'sleep','2026-08-14',7.20,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(135,10,'water','2026-08-14',1.96,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(136,10,'exercise','2026-08-15',40.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(137,10,'meditation','2026-08-15',0.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(138,10,'nutrition','2026-08-15',4.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(139,10,'sleep','2026-08-15',7.35,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(140,10,'water','2026-08-15',2.04,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(141,10,'exercise','2026-08-16',45.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(142,10,'meditation','2026-08-16',5.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(143,10,'nutrition','2026-08-16',4.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(144,10,'sleep','2026-08-16',6.90,8.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(145,10,'water','2026-08-16',1.80,2.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(146,10,'exercise','2026-08-17',45.00,45.00,'2026-08-17 23:29:47','2026-08-17 23:54:53'),(147,10,'meditation','2026-08-17',10.00,10.00,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(148,10,'nutrition','2026-08-17',5.00,5.00,'2026-08-17 23:29:47','2026-08-17 23:55:04'),(149,10,'sleep','2026-08-17',8.00,8.00,'2026-08-17 23:29:47','2026-08-17 23:54:57'),(150,10,'water','2026-08-17',2.00,2.00,'2026-08-17 23:29:47','2026-08-17 23:52:55'),(256,10,'water','2026-08-18',2.00,2.00,'2026-08-18 00:03:41','2026-08-18 00:03:41'),(257,10,'exercise','2026-08-18',30.00,30.00,'2026-08-18 00:03:44','2026-08-18 00:03:51'),(258,10,'sleep','2026-08-18',8.00,8.00,'2026-08-18 00:03:57','2026-08-18 00:03:59'),(259,10,'nutrition','2026-08-18',3.00,3.00,'2026-08-18 00:04:02','2026-08-18 00:04:02'),(260,10,'meditation','2026-08-18',10.00,10.00,'2026-08-18 00:04:04','2026-08-18 00:05:58'),(261,2,'exercise','2026-08-18',5.00,30.00,'2026-08-18 01:06:20','2026-08-18 01:06:20'),(262,2,'water','2026-08-18',0.25,2.00,'2026-08-18 01:06:23','2026-08-18 01:06:23'),(263,2,'nutrition','2026-08-18',2.00,3.00,'2026-08-18 01:06:33','2026-08-18 01:06:33'),(264,2,'meditation','2026-08-18',10.00,10.00,'2026-08-18 01:06:35','2026-08-18 01:06:35'),(265,2,'sleep','2026-08-18',2.00,8.00,'2026-08-18 01:06:36','2026-08-18 01:06:37'),(266,15,'water','2026-08-18',2.00,2.00,'2026-08-18 18:47:20','2026-08-18 18:47:24'),(267,15,'exercise','2026-08-18',30.00,30.00,'2026-08-18 18:47:26','2026-08-18 18:47:28'),(268,15,'sleep','2026-08-18',8.00,8.00,'2026-08-18 18:47:31','2026-08-18 18:47:33'),(269,15,'nutrition','2026-08-18',3.00,3.00,'2026-08-18 18:47:37','2026-08-18 18:47:38'),(270,15,'meditation','2026-08-18',10.00,10.00,'2026-08-18 18:47:42','2026-08-18 18:47:43'),(271,16,'water','2026-08-18',0.50,2.00,'2026-08-18 19:22:39','2026-08-18 19:22:40'),(272,16,'exercise','2026-08-18',15.00,30.00,'2026-08-18 19:22:42','2026-08-18 19:22:45'),(273,16,'sleep','2026-08-18',6.00,8.00,'2026-08-18 19:22:47','2026-08-18 19:24:23'),(274,16,'nutrition','2026-08-18',3.00,3.00,'2026-08-18 19:22:50','2026-08-18 19:24:16'),(275,16,'meditation','2026-08-18',10.00,10.00,'2026-08-18 19:22:53','2026-08-18 19:25:01'),(276,19,'water','2026-08-19',0.75,2.00,'2026-08-19 18:57:07','2026-08-19 18:58:17'),(277,19,'exercise','2026-08-19',15.00,30.00,'2026-08-19 18:57:16','2026-08-19 18:58:18'),(278,19,'sleep','2026-08-19',3.00,8.00,'2026-08-19 18:57:20','2026-08-19 18:58:19'),(279,19,'meditation','2026-08-19',10.00,10.00,'2026-08-19 18:57:24','2026-08-19 18:58:03'),(280,19,'nutrition','2026-08-19',3.00,3.00,'2026-08-19 18:57:57','2026-08-19 18:58:00');
/*!40000 ALTER TABLE `habit_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `health_metrics`
--

DROP TABLE IF EXISTS `health_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `health_metrics` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `metric_date` date NOT NULL,
  `water_l` decimal(4,2) DEFAULT NULL,
  `steps` int DEFAULT NULL,
  `sleep_hours` decimal(4,2) DEFAULT NULL,
  `weight_kg` decimal(5,2) DEFAULT NULL,
  `wellness_score` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_metric_user_date` (`user_id`,`metric_date`),
  CONSTRAINT `fk_health_metrics_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `health_metrics`
--

LOCK TABLES `health_metrics` WRITE;
/*!40000 ALTER TABLE `health_metrics` DISABLE KEYS */;
INSERT INTO `health_metrics` VALUES (2,10,'2026-07-19',1.50,3250,6.00,50.02,49,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(3,10,'2026-07-20',1.20,3700,5.40,50.04,50,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(4,10,'2026-07-21',1.30,4150,5.55,50.06,51,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(5,10,'2026-07-22',1.40,4600,5.70,50.08,52,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(6,10,'2026-07-23',1.50,5050,5.85,50.10,53,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(7,10,'2026-07-24',1.20,2800,6.00,50.12,48,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(8,10,'2026-07-25',1.30,3250,5.40,50.14,49,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(9,10,'2026-07-26',1.40,3700,5.55,50.16,50,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(10,10,'2026-07-27',1.65,7200,6.20,50.18,58,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(11,10,'2026-07-28',1.75,4200,6.35,50.20,59,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(12,10,'2026-07-29',1.85,4700,6.50,50.22,60,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(13,10,'2026-07-30',1.45,5200,5.90,50.24,61,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(14,10,'2026-07-31',1.55,5700,6.05,50.26,62,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(15,10,'2026-08-01',1.55,4700,6.05,50.28,56,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(16,10,'2026-08-02',1.65,5200,6.20,50.30,57,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(17,10,'2026-08-03',1.95,7250,6.82,50.32,66,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(18,10,'2026-08-04',1.65,7800,6.96,50.34,67,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(19,10,'2026-08-05',1.75,8350,6.40,50.36,68,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(20,10,'2026-08-06',1.85,8900,6.54,50.38,69,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(21,10,'2026-08-07',1.95,9450,6.68,50.40,63,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(22,10,'2026-08-08',1.65,5600,6.82,50.42,64,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(23,10,'2026-08-09',1.75,6150,6.96,50.44,65,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(24,10,'2026-08-10',1.96,8150,6.80,50.46,72,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(25,10,'2026-08-11',2.04,8600,6.92,50.48,73,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(26,10,'2026-08-12',1.80,9050,7.04,50.50,74,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(27,10,'2026-08-13',1.88,9500,7.16,50.52,75,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(28,10,'2026-08-14',1.96,6800,7.28,50.54,76,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(29,10,'2026-08-15',2.04,7250,6.80,50.56,77,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(30,10,'2026-08-16',1.80,7700,6.92,50.58,70,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(31,10,'2026-08-17',1.88,8150,7.04,50.60,71,'2026-08-17 23:29:47','2026-08-17 23:29:47'),(32,10,'2026-08-18',0.00,6500,0.00,0.00,0,'2026-08-18 01:58:44','2026-08-18 01:58:47'),(33,11,'2026-08-18',0.00,1000,0.00,0.00,0,'2026-08-18 18:22:54','2026-08-18 18:22:55'),(34,15,'2026-08-18',0.00,10000,0.00,0.00,0,'2026-08-18 18:47:14','2026-08-18 18:47:17'),(35,16,'2026-08-18',0.00,2000,0.00,0.00,0,'2026-08-18 19:22:35','2026-08-18 19:22:36'),(36,19,'2026-08-19',0.00,5753,0.00,0.00,0,'2026-08-19 18:57:00','2026-08-19 18:58:16');
/*!40000 ALTER TABLE `health_metrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_history_items`
--

DROP TABLE IF EXISTS `medical_history_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medical_history_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `category` enum('diseases','allergies','medications','surgeries','consultations','vaccines','results') NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_medical_history_user` (`user_id`),
  CONSTRAINT `fk_medical_history_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_history_items`
--

LOCK TABLES `medical_history_items` WRITE;
/*!40000 ALTER TABLE `medical_history_items` DISABLE KEYS */;
INSERT INTO `medical_history_items` VALUES (2,19,'surgeries','Ocular (2026)','2026-08-19 18:59:41','2026-08-19 18:59:41');
/*!40000 ALTER TABLE `medical_history_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medication_logs`
--

DROP TABLE IF EXISTS `medication_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medication_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `medication_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `taken_date` date NOT NULL,
  `taken_time` time NOT NULL,
  `taken` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_medication_day_time` (`medication_id`,`taken_date`,`taken_time`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `medication_logs_ibfk_1` FOREIGN KEY (`medication_id`) REFERENCES `medications` (`id`) ON DELETE CASCADE,
  CONSTRAINT `medication_logs_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medication_logs`
--

LOCK TABLES `medication_logs` WRITE;
/*!40000 ALTER TABLE `medication_logs` DISABLE KEYS */;
INSERT INTO `medication_logs` VALUES (1,7,10,'2026-08-16','08:00:00',1,'2026-08-17 23:29:47'),(2,7,10,'2026-08-15','08:00:00',1,'2026-08-17 23:29:47'),(3,7,10,'2026-08-14','08:00:00',1,'2026-08-17 23:29:47'),(4,7,10,'2026-08-13','08:00:00',1,'2026-08-17 23:29:47'),(5,7,10,'2026-08-12','08:00:00',1,'2026-08-17 23:29:47'),(6,7,10,'2026-08-11','08:00:00',1,'2026-08-17 23:29:47'),(7,7,10,'2026-08-10','08:00:00',1,'2026-08-17 23:29:47'),(8,7,10,'2026-08-09','08:00:00',1,'2026-08-17 23:29:47'),(9,7,10,'2026-08-07','08:00:00',1,'2026-08-17 23:29:47'),(10,7,10,'2026-08-06','08:00:00',1,'2026-08-17 23:29:47'),(11,7,10,'2026-08-05','08:00:00',1,'2026-08-17 23:29:47'),(12,7,10,'2026-08-04','08:00:00',1,'2026-08-17 23:29:47'),(13,7,10,'2026-08-03','08:00:00',1,'2026-08-17 23:29:47'),(14,7,10,'2026-08-02','08:00:00',1,'2026-08-17 23:29:47'),(15,7,10,'2026-08-01','08:00:00',1,'2026-08-17 23:29:47'),(16,7,10,'2026-07-31','08:00:00',1,'2026-08-17 23:29:47'),(17,7,10,'2026-07-29','08:00:00',1,'2026-08-17 23:29:47'),(18,7,10,'2026-07-28','08:00:00',1,'2026-08-17 23:29:47'),(19,7,10,'2026-07-27','08:00:00',1,'2026-08-17 23:29:47'),(20,7,10,'2026-07-26','08:00:00',1,'2026-08-17 23:29:47'),(21,7,10,'2026-07-25','08:00:00',1,'2026-08-17 23:29:47'),(22,7,10,'2026-07-24','08:00:00',1,'2026-08-17 23:29:47'),(23,7,10,'2026-07-23','08:00:00',1,'2026-08-17 23:29:47'),(24,7,10,'2026-07-22','08:00:00',1,'2026-08-17 23:29:47'),(25,7,10,'2026-07-20','08:00:00',1,'2026-08-17 23:29:47'),(26,7,10,'2026-07-19','08:00:00',1,'2026-08-17 23:29:47'),(27,8,10,'2026-08-16','08:00:00',1,'2026-08-17 23:29:47'),(28,8,10,'2026-08-15','08:00:00',1,'2026-08-17 23:29:47'),(29,8,10,'2026-08-14','08:00:00',1,'2026-08-17 23:29:47'),(30,8,10,'2026-08-13','08:00:00',1,'2026-08-17 23:29:47'),(31,8,10,'2026-08-12','08:00:00',1,'2026-08-17 23:29:47'),(32,8,10,'2026-08-11','08:00:00',1,'2026-08-17 23:29:47'),(33,8,10,'2026-08-09','08:00:00',1,'2026-08-17 23:29:47'),(34,8,10,'2026-08-08','08:00:00',1,'2026-08-17 23:29:47'),(35,8,10,'2026-08-07','08:00:00',1,'2026-08-17 23:29:47'),(36,8,10,'2026-08-06','08:00:00',1,'2026-08-17 23:29:47'),(37,8,10,'2026-08-05','08:00:00',1,'2026-08-17 23:29:47'),(38,8,10,'2026-08-04','08:00:00',1,'2026-08-17 23:29:47'),(39,8,10,'2026-08-02','08:00:00',1,'2026-08-17 23:29:47'),(40,8,10,'2026-08-01','08:00:00',1,'2026-08-17 23:29:47'),(41,8,10,'2026-07-31','08:00:00',1,'2026-08-17 23:29:47'),(42,8,10,'2026-07-30','08:00:00',1,'2026-08-17 23:29:47'),(43,8,10,'2026-07-29','08:00:00',1,'2026-08-17 23:29:47'),(44,8,10,'2026-07-28','08:00:00',1,'2026-08-17 23:29:47'),(45,8,10,'2026-07-26','08:00:00',1,'2026-08-17 23:29:47'),(46,8,10,'2026-07-25','08:00:00',1,'2026-08-17 23:29:47'),(47,8,10,'2026-07-24','08:00:00',1,'2026-08-17 23:29:47'),(48,8,10,'2026-07-23','08:00:00',1,'2026-08-17 23:29:47'),(49,8,10,'2026-07-22','08:00:00',1,'2026-08-17 23:29:47'),(50,8,10,'2026-07-21','08:00:00',1,'2026-08-17 23:29:47'),(51,8,10,'2026-07-19','08:00:00',1,'2026-08-17 23:29:47'),(52,9,10,'2026-08-16','12:00:00',1,'2026-08-17 23:29:47'),(53,9,10,'2026-08-15','12:00:00',1,'2026-08-17 23:29:47'),(54,9,10,'2026-08-14','12:00:00',1,'2026-08-17 23:29:47'),(55,9,10,'2026-08-13','12:00:00',1,'2026-08-17 23:29:47'),(56,9,10,'2026-08-12','12:00:00',1,'2026-08-17 23:29:47'),(57,9,10,'2026-08-10','12:00:00',1,'2026-08-17 23:29:47'),(58,9,10,'2026-08-09','12:00:00',1,'2026-08-17 23:29:47'),(59,9,10,'2026-08-08','12:00:00',1,'2026-08-17 23:29:47'),(60,9,10,'2026-08-07','12:00:00',1,'2026-08-17 23:29:47'),(61,9,10,'2026-08-06','12:00:00',1,'2026-08-17 23:29:47'),(62,9,10,'2026-08-04','12:00:00',1,'2026-08-17 23:29:47'),(63,9,10,'2026-08-03','12:00:00',1,'2026-08-17 23:29:47'),(64,9,10,'2026-08-02','12:00:00',1,'2026-08-17 23:29:47'),(65,9,10,'2026-08-01','12:00:00',1,'2026-08-17 23:29:47'),(66,9,10,'2026-07-31','12:00:00',1,'2026-08-17 23:29:47'),(67,9,10,'2026-07-29','12:00:00',1,'2026-08-17 23:29:47'),(68,9,10,'2026-07-28','12:00:00',1,'2026-08-17 23:29:47'),(69,9,10,'2026-07-27','12:00:00',1,'2026-08-17 23:29:47'),(70,9,10,'2026-07-26','12:00:00',1,'2026-08-17 23:29:47'),(71,9,10,'2026-07-25','12:00:00',1,'2026-08-17 23:29:47'),(72,9,10,'2026-07-23','12:00:00',1,'2026-08-17 23:29:47'),(73,9,10,'2026-07-22','12:00:00',1,'2026-08-17 23:29:47'),(74,9,10,'2026-07-21','12:00:00',1,'2026-08-17 23:29:47'),(75,9,10,'2026-07-20','12:00:00',1,'2026-08-17 23:29:47'),(76,9,10,'2026-07-19','12:00:00',1,'2026-08-17 23:29:47'),(77,10,10,'2026-08-16','13:00:00',1,'2026-08-17 23:29:47'),(78,10,10,'2026-08-15','13:00:00',1,'2026-08-17 23:29:47'),(79,10,10,'2026-08-14','13:00:00',1,'2026-08-17 23:29:47'),(80,10,10,'2026-08-13','13:00:00',1,'2026-08-17 23:29:47'),(81,10,10,'2026-08-11','13:00:00',1,'2026-08-17 23:29:47'),(82,10,10,'2026-08-10','13:00:00',1,'2026-08-17 23:29:47'),(83,10,10,'2026-08-09','13:00:00',1,'2026-08-17 23:29:47'),(84,10,10,'2026-08-08','13:00:00',1,'2026-08-17 23:29:47'),(85,10,10,'2026-08-06','13:00:00',1,'2026-08-17 23:29:47'),(86,10,10,'2026-08-05','13:00:00',1,'2026-08-17 23:29:47'),(87,10,10,'2026-08-04','13:00:00',1,'2026-08-17 23:29:47'),(88,10,10,'2026-08-03','13:00:00',1,'2026-08-17 23:29:47'),(89,10,10,'2026-08-01','13:00:00',1,'2026-08-17 23:29:47'),(90,10,10,'2026-07-31','13:00:00',1,'2026-08-17 23:29:47'),(91,10,10,'2026-07-30','13:00:00',1,'2026-08-17 23:29:47'),(92,10,10,'2026-07-29','13:00:00',1,'2026-08-17 23:29:47'),(93,10,10,'2026-07-27','13:00:00',1,'2026-08-17 23:29:47'),(94,10,10,'2026-07-26','13:00:00',1,'2026-08-17 23:29:47'),(95,10,10,'2026-07-25','13:00:00',1,'2026-08-17 23:29:47'),(96,10,10,'2026-07-24','13:00:00',1,'2026-08-17 23:29:47'),(97,10,10,'2026-07-22','13:00:00',1,'2026-08-17 23:29:47'),(98,10,10,'2026-07-21','13:00:00',1,'2026-08-17 23:29:47'),(99,10,10,'2026-07-20','13:00:00',1,'2026-08-17 23:29:47'),(100,10,10,'2026-07-19','13:00:00',1,'2026-08-17 23:29:47'),(128,10,10,'2026-08-17','23:50:40',1,'2026-08-17 23:50:40'),(129,9,10,'2026-08-17','23:50:41',1,'2026-08-17 23:50:41'),(130,8,10,'2026-08-17','23:50:43',1,'2026-08-17 23:50:43'),(131,12,10,'2026-08-18','02:08:43',1,'2026-08-18 02:08:43'),(139,15,15,'2026-08-18','18:51:02',1,'2026-08-18 18:51:02'),(140,5,2,'2026-08-20','00:15:07',1,'2026-08-20 00:15:07'),(141,3,2,'2026-08-20','00:15:08',1,'2026-08-20 00:15:08'),(142,2,2,'2026-08-20','00:15:10',1,'2026-08-20 00:15:10'),(143,3,2,'2026-08-20','00:15:11',1,'2026-08-20 00:15:11'),(144,3,2,'2026-08-20','00:15:12',1,'2026-08-20 00:15:12'),(145,3,2,'2026-08-20','00:15:14',1,'2026-08-20 00:15:14'),(146,3,2,'2026-08-20','00:15:16',1,'2026-08-20 00:15:16'),(147,3,2,'2026-08-20','00:15:20',1,'2026-08-20 00:15:20');
/*!40000 ALTER TABLE `medication_logs` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `refresh_tokens`
--

DROP TABLE IF EXISTS `refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refresh_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `token_hash` varchar(255) NOT NULL,
  `expires_at` timestamp NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_refresh_tokens_user` (`user_id`),
  CONSTRAINT `fk_refresh_tokens_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refresh_tokens`
--

LOCK TABLES `refresh_tokens` WRITE;
/*!40000 ALTER TABLE `refresh_tokens` DISABLE KEYS */;
INSERT INTO `refresh_tokens` VALUES (1,1,'9d3210721b83b7f5d3f462804dd1e8ff5462d78e8367daeb195c7966ad346180','2026-08-27 04:19:44','2026-08-20 04:19:44'),(2,1,'fd3239a4b0ed748235d100bddaf5da75578b7a19e046e1ea637efd67b8c7213c','2026-08-27 04:20:31','2026-08-20 04:20:31'),(4,1,'b27758995fa0e3fcfc617ea5647764a9a5aab68a26280eeb906dc045c423d5ca','2026-08-27 04:48:09','2026-08-20 04:48:09'),(5,1,'50c972646eb8e0f70ab2c6d63eac83f62addfe2c7bb12e2dbb2c0947ad67f16f','2026-08-27 04:57:27','2026-08-20 04:57:27'),(6,1,'50c972646eb8e0f70ab2c6d63eac83f62addfe2c7bb12e2dbb2c0947ad67f16f','2026-08-27 04:57:27','2026-08-20 04:57:27'),(7,1,'50c972646eb8e0f70ab2c6d63eac83f62addfe2c7bb12e2dbb2c0947ad67f16f','2026-08-27 04:57:27','2026-08-20 04:57:27'),(8,1,'50c972646eb8e0f70ab2c6d63eac83f62addfe2c7bb12e2dbb2c0947ad67f16f','2026-08-27 04:57:27','2026-08-20 04:57:27'),(9,1,'50c972646eb8e0f70ab2c6d63eac83f62addfe2c7bb12e2dbb2c0947ad67f16f','2026-08-27 04:57:27','2026-08-20 04:57:27'),(10,1,'50c972646eb8e0f70ab2c6d63eac83f62addfe2c7bb12e2dbb2c0947ad67f16f','2026-08-27 04:57:27','2026-08-20 04:57:27'),(12,1,'13203cad2c2b0397d6f8a93996c3d5606ff4a6c69cbe87cbc0349c31ee8020a3','2026-08-27 05:13:04','2026-08-20 05:13:04'),(13,1,'13203cad2c2b0397d6f8a93996c3d5606ff4a6c69cbe87cbc0349c31ee8020a3','2026-08-27 05:13:04','2026-08-20 05:13:04'),(14,1,'13203cad2c2b0397d6f8a93996c3d5606ff4a6c69cbe87cbc0349c31ee8020a3','2026-08-27 05:13:04','2026-08-20 05:13:04'),(15,1,'13203cad2c2b0397d6f8a93996c3d5606ff4a6c69cbe87cbc0349c31ee8020a3','2026-08-27 05:13:04','2026-08-20 05:13:04'),(16,1,'13203cad2c2b0397d6f8a93996c3d5606ff4a6c69cbe87cbc0349c31ee8020a3','2026-08-27 05:13:04','2026-08-20 05:13:04'),(17,1,'13203cad2c2b0397d6f8a93996c3d5606ff4a6c69cbe87cbc0349c31ee8020a3','2026-08-27 05:13:04','2026-08-20 05:13:04'),(19,1,'c10cac45e08e1fe07863e074cc32f5dd51784b8e54c7f7fa312290130adad168','2026-08-27 05:29:49','2026-08-20 05:29:49'),(20,1,'c10cac45e08e1fe07863e074cc32f5dd51784b8e54c7f7fa312290130adad168','2026-08-27 05:29:49','2026-08-20 05:29:49'),(21,1,'c10cac45e08e1fe07863e074cc32f5dd51784b8e54c7f7fa312290130adad168','2026-08-27 05:29:49','2026-08-20 05:29:49'),(22,1,'c10cac45e08e1fe07863e074cc32f5dd51784b8e54c7f7fa312290130adad168','2026-08-27 05:29:49','2026-08-20 05:29:49'),(23,1,'c10cac45e08e1fe07863e074cc32f5dd51784b8e54c7f7fa312290130adad168','2026-08-27 05:29:49','2026-08-20 05:29:49'),(24,1,'c10cac45e08e1fe07863e074cc32f5dd51784b8e54c7f7fa312290130adad168','2026-08-27 05:29:49','2026-08-20 05:29:49'),(26,1,'11648064d4bae2358b6676c8e90476d91a701a67ad22036747642ad5ef0126e3','2026-08-27 05:52:28','2026-08-20 05:52:28'),(27,1,'11648064d4bae2358b6676c8e90476d91a701a67ad22036747642ad5ef0126e3','2026-08-27 05:52:28','2026-08-20 05:52:28'),(28,1,'11648064d4bae2358b6676c8e90476d91a701a67ad22036747642ad5ef0126e3','2026-08-27 05:52:28','2026-08-20 05:52:28'),(29,1,'11648064d4bae2358b6676c8e90476d91a701a67ad22036747642ad5ef0126e3','2026-08-27 05:52:28','2026-08-20 05:52:28'),(30,1,'11648064d4bae2358b6676c8e90476d91a701a67ad22036747642ad5ef0126e3','2026-08-27 05:52:28','2026-08-20 05:52:28'),(31,1,'11648064d4bae2358b6676c8e90476d91a701a67ad22036747642ad5ef0126e3','2026-08-27 05:52:28','2026-08-20 05:52:28'),(33,1,'e6ec9d8164515447a14ba886f74a9f90ae0e6f37e3cb431e0cc5a13f81034a3e','2026-08-27 06:08:28','2026-08-20 06:08:28'),(34,1,'e6ec9d8164515447a14ba886f74a9f90ae0e6f37e3cb431e0cc5a13f81034a3e','2026-08-27 06:08:28','2026-08-20 06:08:28'),(35,1,'e6ec9d8164515447a14ba886f74a9f90ae0e6f37e3cb431e0cc5a13f81034a3e','2026-08-27 06:08:28','2026-08-20 06:08:28'),(36,1,'e6ec9d8164515447a14ba886f74a9f90ae0e6f37e3cb431e0cc5a13f81034a3e','2026-08-27 06:08:28','2026-08-20 06:08:28'),(37,1,'e6ec9d8164515447a14ba886f74a9f90ae0e6f37e3cb431e0cc5a13f81034a3e','2026-08-27 06:08:28','2026-08-20 06:08:28'),(38,1,'e6ec9d8164515447a14ba886f74a9f90ae0e6f37e3cb431e0cc5a13f81034a3e','2026-08-27 06:08:28','2026-08-20 06:08:28'),(40,1,'4929772db45ce05572e7926b3c09dd3fedbc629d0b86c36925f8e5b39de719e0','2026-08-27 06:29:28','2026-08-20 06:29:28'),(41,1,'4929772db45ce05572e7926b3c09dd3fedbc629d0b86c36925f8e5b39de719e0','2026-08-27 06:29:28','2026-08-20 06:29:28'),(42,1,'4929772db45ce05572e7926b3c09dd3fedbc629d0b86c36925f8e5b39de719e0','2026-08-27 06:29:28','2026-08-20 06:29:28'),(43,1,'4929772db45ce05572e7926b3c09dd3fedbc629d0b86c36925f8e5b39de719e0','2026-08-27 06:29:28','2026-08-20 06:29:28'),(44,1,'4929772db45ce05572e7926b3c09dd3fedbc629d0b86c36925f8e5b39de719e0','2026-08-27 06:29:28','2026-08-20 06:29:28'),(45,1,'4929772db45ce05572e7926b3c09dd3fedbc629d0b86c36925f8e5b39de719e0','2026-08-27 06:29:28','2026-08-20 06:29:28'),(47,1,'d3d9b30241a405e3d33f550a8319cd8c8c680dd715396170fe44edd9d1d6d58d','2026-08-27 07:05:42','2026-08-20 07:05:42'),(48,1,'09a66bcc2da8694854c1f2fc27ba7cbb88e141cd9bc22d4beff5e9a72e3cc5bf','2026-08-27 07:13:28','2026-08-20 07:13:28'),(49,1,'09a66bcc2da8694854c1f2fc27ba7cbb88e141cd9bc22d4beff5e9a72e3cc5bf','2026-08-27 07:13:28','2026-08-20 07:13:28'),(50,1,'09a66bcc2da8694854c1f2fc27ba7cbb88e141cd9bc22d4beff5e9a72e3cc5bf','2026-08-27 07:13:28','2026-08-20 07:13:28'),(51,1,'09a66bcc2da8694854c1f2fc27ba7cbb88e141cd9bc22d4beff5e9a72e3cc5bf','2026-08-27 07:13:28','2026-08-20 07:13:28'),(52,1,'09a66bcc2da8694854c1f2fc27ba7cbb88e141cd9bc22d4beff5e9a72e3cc5bf','2026-08-27 07:13:28','2026-08-20 07:13:28'),(53,1,'787b1b2e6128dc228bf390f3f4716671061a928638dc64d275ec327094f9ee82','2026-08-27 07:29:00','2026-08-20 07:29:00'),(54,1,'f50ce0ff11de298d30fbfdb7bbc1a93ab2f5341102b76b98cdd28e5366b5967e','2026-08-27 07:29:18','2026-08-20 07:29:18');
/*!40000 ALTER TABLE `refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(120) NOT NULL,
  `email` varchar(160) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `age` int NOT NULL DEFAULT '0',
  `gender` enum('Masculino','Femenino') DEFAULT NULL,
  `joined_label` varchar(40) DEFAULT NULL,
  `last_active_label` varchar(40) DEFAULT NULL,
  `status` enum('active','inactive','pending') NOT NULL DEFAULT 'pending',
  `registros` int NOT NULL DEFAULT '0',
  `consultas` int NOT NULL DEFAULT '0',
  `color` varchar(20) NOT NULL DEFAULT '#0F766E',
  `role` enum('admin','patient','caregiver') NOT NULL DEFAULT 'patient',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `blood_type` varchar(5) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `weight_kg` decimal(5,1) DEFAULT NULL,
  `height_cm` decimal(5,1) DEFAULT NULL,
  `last_active_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Administrador','admin@vitalmind.com','$2a$10$EKGaL152U3Pztyw4xjEcP.x.9pEt48iIJcHdgEFuYWWV4myTVsFsG',42,'Masculino','10 jun 2025','Hace unos segundos','active',0,0,'#0F766E','admin','2026-08-11 00:56:01','2026-08-20 06:10:38',NULL,NULL,NULL,NULL,'2026-08-20 00:10:38'),(2,'Mar├¡a Garc├¡a','maria@email.com','$2a$10$x.yjfoLOneJozhKWo.iwc.qDRZW3keBzAUNJr1/KLKYCgx0b6dm0S',34,'Femenino','10 jun 2025','Hace unos segundos','active',48,23,'#0F766E','patient','2026-08-11 00:56:01','2026-08-20 06:15:01',NULL,NULL,NULL,NULL,'2026-08-20 00:15:01'),(3,'Carlos Rodr├¡guez','carlos@email.com','$2a$10$xtgDAjP7VSrOchXlKJTiPOxNOugIyroxWBHh0n9U.KgySYiZXglB.',41,'Masculino','8 jun 2025','Hace 1 h','active',31,15,'#2563EB','patient','2026-08-11 00:56:01','2026-08-20 05:53:24',NULL,NULL,NULL,NULL,NULL),(4,'Ana P├®rez','ana@email.com','$2a$10$dzUcCUEz68ZGDIaPpK0wFuD287gPgLhmPebQO4CU2QzcWapfKwrYi',28,'Femenino','5 jun 2025','Hace 2 h','active',62,40,'#8B5CF6','patient','2026-08-11 00:56:01','2026-08-20 05:50:53',NULL,NULL,NULL,NULL,NULL),(5,'Luis Mart├¡nez','luis@email.com','$2a$10$Et1WesZakmgibTsVtQZ65eCQiscgUOAOGyAqSR8t3eTm3p6NYHvse',55,'Femenino','1 jun 2025','Hace 1 d├¡a','inactive',12,5,'#F59E0B','patient','2026-08-11 00:56:01','2026-08-20 05:50:53',NULL,NULL,NULL,NULL,NULL),(6,'Sara Vega','sara@email.com','$2a$10$dqznwtlF0HWBYKENF5Ii2uxaBVMMjNFmCCTqHThBGNaZAbJc20EDG',22,'Femenino','15 may 2025','Hace 3 d├¡as','pending',0,0,'#EC4899','patient','2026-08-11 00:56:01','2026-08-20 05:50:53',NULL,NULL,NULL,NULL,NULL),(7,'Diego L├│pez','diego@email.com','$2a$10$JPC8Rhef0AkB4ckv0ZP6FO2pcnMyjd2glOIsDh0BF/knbjk5W1tQW',38,'Masculino','12 may 2025','Hace 5 h','active',27,18,'#22C55E','patient','2026-08-11 00:56:01','2026-08-20 05:50:53',NULL,NULL,NULL,NULL,NULL),(8,'Laura Torres','laura@email.com','$2a$10$ADX184RyCllSRP18Jh9ai.eGvdmnDAVmcG1UOBhuu9r0fFSxJyHRu',45,'Femenino','3 may 2025','Hace 2 d├¡as','inactive',8,3,'#F97316','patient','2026-08-11 00:56:01','2026-08-20 05:50:53',NULL,NULL,NULL,NULL,NULL),(9,'Marta Ruiz','marta@email.com','$2a$10$Tu1SAoqytCv7UjN1aLwuX.ucrcdk/9Nj9o8Bq9pxP2opxpL87UJee',30,'Femenino','28 abr 2025','Hace 10 min','active',55,32,'#14B8A6','patient','2026-08-11 00:56:01','2026-08-20 05:50:53',NULL,NULL,NULL,NULL,NULL),(10,'Yazmin','yazmingutierrezhernandez411@gmail.com','$2a$10$q3ng2fgeF/GWzkXwwENUWeL0YfZIP6YYx7B/pRUYzQE95LijGNdW2',21,'Femenino','11/8/2026','Hace unos segundos','active',0,0,'#0F766E','patient','2026-08-11 01:08:59','2026-08-20 05:50:53',NULL,NULL,NULL,NULL,'2026-08-19 19:26:18'),(11,'Citllali','citllalli@gmail.com','$2a$10$NliqyCn/76Pt9wqItnkNmenLe810xrEJ/eew9eJVEwMcxFNQA4DCG',34,'Femenino','18/8/2026','Hace unos segundos','active',0,0,'#0F766E','patient','2026-08-18 18:22:43','2026-08-20 05:50:53',NULL,NULL,NULL,NULL,'2026-08-18 18:22:43'),(12,'dionicio','dio@hotmail.com','$2a$10$vnIr/tDHblojwwRSWp0sTuVRzboXz9/jolpfIas9bmAgVC1Jk0q/W',21,'Femenino','18/8/2026','Hace unos segundos','active',0,0,'#0F766E','patient','2026-08-18 18:26:35','2026-08-20 05:50:53',NULL,NULL,NULL,NULL,'2026-08-18 19:14:41'),(15,'Carlos Daniel','230187@utxicotepec.edu.mx','$2a$10$sbyChYNaGqpn.aN5wVn31OXpIr8osSC/VZWqTOeaICv5IeY5ljdW.',23,'Masculino','18/8/2026','Hace unos segundos','active',0,0,'#0F766E','patient','2026-08-18 18:45:41','2026-08-20 05:50:53',NULL,NULL,NULL,NULL,'2026-08-18 20:05:27'),(16,'luis','luis@hotmail.com','$2a$10$is9E6CBU/iNjSAHjzP.bHujYw75PCwBe1HlnW3HhRY7ZKG4liZzxG',24,'Masculino','18/8/2026','Hace unos segundos','active',0,0,'#0F766E','patient','2026-08-18 19:17:18','2026-08-20 05:50:53',NULL,NULL,NULL,NULL,'2026-08-18 19:17:18'),(17,'Prueba1','prueba1@gmail.com','$2a$10$cwEkhkVJ/qkFhlqdJwUTwu2d1U9eBLX9/A7gV66Vx.b3AHTuA6bhu',18,'Masculino','19/8/2026','Hace unos segundos','active',0,0,'#0F766E','patient','2026-08-19 00:13:29','2026-08-20 05:50:53',NULL,NULL,NULL,NULL,'2026-08-19 00:13:29'),(18,'Daniela Guzmán ','jhonsondanielle5@gmail.com','$2a$10$VMu9hkdOx8oQ96JPWsYpL.B/24qe3EtJr67QW2mslcuHuQNSo9jYC',18,'Femenino','19/8/2026','Hace unos segundos','active',0,0,'#0F766E','patient','2026-08-19 00:27:35','2026-08-20 05:50:53',NULL,NULL,NULL,NULL,'2026-08-19 00:27:35'),(19,'Hec','hecvg@gmail.com','$2a$10$go2tJsaYpo7OhdazljPrgOvfT2MUkQWbhmjM7SYZIshvpaXJ5E3vG',40,'Masculino','19/8/2026','Hace unos segundos','active',0,0,'#0F766E','patient','2026-08-19 18:52:24','2026-08-20 05:50:53',NULL,NULL,NULL,NULL,'2026-08-19 18:52:24'),(20,'Valeria Ramírez García','valeria.ramirez.garcia.1.1787201326417449@test.vitalmind.local','$2b$10$SiZvTGLPyCT.LJYObbLvROKEi7k2SgYbgWIVTXz3po6DFicpJM0fG',28,'Femenino','Generado por API','Hace unos segundos','active',0,0,'#8B5CF6','patient','2026-08-20 04:48:46','2026-08-20 05:50:53','O+','2248101641',77.9,175.2,'2026-08-19 22:48:46'),(21,'Samantha Díaz Díaz','samantha.diaz.diaz.2.1787201326418102@test.vitalmind.local','$2b$10$SiZvTGLPyCT.LJYObbLvROKEi7k2SgYbgWIVTXz3po6DFicpJM0fG',28,'Femenino','Generado por API','Hace unos segundos','active',0,0,'#F59E0B','patient','2026-08-20 04:48:46','2026-08-20 05:50:53','O+','2214326579',102.6,191.0,'2026-08-19 22:48:46'),(22,'Ana Vargas García','ana.vargas.garcia.3.1787201326418721@test.vitalmind.local','$2b$10$SiZvTGLPyCT.LJYObbLvROKEi7k2SgYbgWIVTXz3po6DFicpJM0fG',28,'Femenino','Generado por API','Hace unos segundos','active',0,0,'#EC4899','patient','2026-08-20 04:48:46','2026-08-20 05:50:53','O+','2261310825',59.8,156.8,'2026-08-19 22:48:46'),(23,'Ana Gómez Mendoza','ana.gomez.mendoza.4.1787201326418463@test.vitalmind.local','$2b$10$SiZvTGLPyCT.LJYObbLvROKEi7k2SgYbgWIVTXz3po6DFicpJM0fG',28,'Femenino','Generado por API','Hace unos segundos','active',0,0,'#8B5CF6','patient','2026-08-20 04:48:46','2026-08-20 05:50:53','O+','2226460535',64.8,158.7,'2026-08-19 22:48:46'),(24,'Elena Pérez Rodríguez','elena.perez.rodriguez.5.1787201326418572@test.vitalmind.local','$2b$10$SiZvTGLPyCT.LJYObbLvROKEi7k2SgYbgWIVTXz3po6DFicpJM0fG',28,'Femenino','Generado por API','Hace unos segundos','active',0,0,'#8B5CF6','patient','2026-08-20 04:48:46','2026-08-20 05:50:53','O+','2232819102',100.9,172.8,'2026-08-19 22:48:46'),(27,'ricardo','ricardo@gmail.com','$2a$10$qD.9/fProXVrGDDHzaSx.O1zenILLQV66sYNlXuq.sKnhYggKMQdm',34,'Masculino','19/8/2026','Hace unos segundos','active',0,0,'#0F766E','patient','2026-08-20 05:47:23','2026-08-20 05:50:53',NULL,NULL,NULL,NULL,'2026-08-19 23:47:23'),(28,'Josue Tolentino','josue@gmail.com','$2a$10$jVKId4Zqtsy.Mn7nroBwTu/zs0XKbqz3EdeoSUBMnfwOqVRijlw/2',18,'Masculino','19/8/2026','Hace unos segundos','active',0,0,'#0F766E','patient','2026-08-20 05:54:43','2026-08-20 06:08:03',NULL,NULL,NULL,NULL,'2026-08-19 23:58:43'),(29,'Paula','paula@gmail.com','$2a$10$3LikjAEeD5yvi/l2bA2u0uD4ma/XCbO1doAnFu8vP/x3y5e/lNNse',28,'Femenino','20/8/2026','Hace unos segundos','active',0,0,'#0F766E','patient','2026-08-20 06:10:01','2026-08-20 06:10:01',NULL,NULL,NULL,NULL,'2026-08-20 00:10:01');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'vitalmind'
--

--
-- Dumping routines for database 'vitalmind'
--
/*!50003 DROP PROCEDURE IF EXISTS `vm_clean_demo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `vm_clean_demo`()
BEGIN
  DECLARE previous_safe_updates INT DEFAULT @@SQL_SAFE_UPDATES;

  SET SQL_SAFE_UPDATES = 0;
  SET FOREIGN_KEY_CHECKS = 0;

  DELETE FROM chat_messages;
  DELETE FROM chat_conversations;
  DELETE FROM audit_logs;
  DELETE FROM refresh_tokens;
  DELETE FROM medication_logs;
  DELETE FROM notifications;
  DELETE FROM medical_history_items;
  DELETE FROM emotional_logs;
  DELETE FROM symptom_logs;
  DELETE FROM habit_logs;
  DELETE FROM appointments;
  DELETE FROM medications;
  DELETE FROM users;

  ALTER TABLE chat_messages AUTO_INCREMENT = 1;
  ALTER TABLE chat_conversations AUTO_INCREMENT = 1;
  ALTER TABLE audit_logs AUTO_INCREMENT = 1;
  ALTER TABLE refresh_tokens AUTO_INCREMENT = 1;
  ALTER TABLE medication_logs AUTO_INCREMENT = 1;
  ALTER TABLE notifications AUTO_INCREMENT = 1;
  ALTER TABLE medical_history_items AUTO_INCREMENT = 1;
  ALTER TABLE emotional_logs AUTO_INCREMENT = 1;
  ALTER TABLE symptom_logs AUTO_INCREMENT = 1;
  ALTER TABLE habit_logs AUTO_INCREMENT = 1;
  ALTER TABLE appointments AUTO_INCREMENT = 1;
  ALTER TABLE medications AUTO_INCREMENT = 1;
  ALTER TABLE users AUTO_INCREMENT = 1;

  SET FOREIGN_KEY_CHECKS = 1;
  SET SQL_SAFE_UPDATES = previous_safe_updates;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `vm_seed_dashboard` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `vm_seed_dashboard`(IN p_days INT)
BEGIN
  DECLARE day_number INT DEFAULT 0;
  DECLARE admin_id BIGINT UNSIGNED;
  DECLARE caregiver_id BIGINT UNSIGNED;
  DECLARE patient_one BIGINT UNSIGNED;
  DECLARE patient_two BIGINT UNSIGNED;
  DECLARE patient_three BIGINT UNSIGNED;

  IF p_days IS NULL OR p_days < 1 OR p_days > 365 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'p_days debe estar entre 1 y 365';
  END IF;

  CALL vm_clean_demo();

  INSERT INTO users (
    full_name, email, password_hash, age, gender, status, role,
    joined_label, last_active_label, color, blood_type, phone,
    weight_kg, height_cm, last_active_at
  )
  VALUES
  (
    'Administrador VitalMind',
    'admin@vitalmind.com',
    '$2b$10$R2MAFTKHWjrgFDadfuyoJOz9wexxBSwN75QAAz/3PHsYhWv/mQQF6',
    35, 'Otro', 'active', 'admin',
    '18 ago 2026', 'Ahora', '#0F766E',
    'O+', '5550000001', 75.0, 175.0, NOW()
  ),
  (
    'Laura Gómez Cuidadora',
    'cuidadora@vitalmind.local',
    '$2b$10$Ir5/p5hYcGOjN9UwgwZft.COOZOymQxFOjkUiyquha/f9okPlzhum',
    39, 'Mujer', 'active', 'caregiver',
    '12 ago 2026', 'Hace 15 min', '#8B5CF6',
    'B+', '5550000002', 64.0, 165.0,
    DATE_SUB(NOW(), INTERVAL 15 MINUTE)
  ),
  (
    'María López García',
    'maria@email.com',
    '$2b$10$Ir5/p5hYcGOjN9UwgwZft.COOZOymQxFOjkUiyquha/f9okPlzhum',
    34, 'Mujer', 'active', 'patient',
    '10 ago 2026', 'Hace 5 min', '#2563EB',
    'A+', '5550000003', 68.5, 163.0,
    DATE_SUB(NOW(), INTERVAL 5 MINUTE)
  ),
  (
    'Carlos Ramírez Torres',
    'carlos@vitalmind.local',
    '$2b$10$Ir5/p5hYcGOjN9UwgwZft.COOZOymQxFOjkUiyquha/f9okPlzhum',
    42, 'Hombre', 'active', 'patient',
    '05 ago 2026', 'Hace 20 min', '#D9A441',
    'O+', '5550000004', 82.0, 178.0,
    DATE_SUB(NOW(), INTERVAL 20 MINUTE)
  ),
  (
    'Sofía Hernández Ruiz',
    'sofia@vitalmind.local',
    '$2b$10$Ir5/p5hYcGOjN9UwgwZft.COOZOymQxFOjkUiyquha/f9okPlzhum',
    28, 'Mujer', 'pending', 'patient',
    '01 ago 2026', 'Hace 1 h', '#E4572E',
    'AB+', '5550000005', 59.0, 160.0,
    DATE_SUB(NOW(), INTERVAL 1 HOUR)
  );

  SELECT id INTO admin_id
  FROM users
  WHERE email = 'admin@vitalmind.com';

  SELECT id INTO caregiver_id
  FROM users
  WHERE email = 'cuidadora@vitalmind.local';

  SELECT id INTO patient_one
  FROM users
  WHERE email = 'maria@email.com';

  SELECT id INTO patient_two
  FROM users
  WHERE email = 'carlos@vitalmind.local';

  SELECT id INTO patient_three
  FROM users
  WHERE email = 'sofia@vitalmind.local';

  INSERT INTO medications (
    user_id, name, dose, frequency, time_label,
    color, taken, days_duration, type
  )
  VALUES
    (patient_one, 'Metformina', '850 mg', 'Una vez al día', '08:00',
     '#0F766E', 1, 30, 'pastilla'),
    (patient_one, 'Losartán', '50 mg', 'Una vez al día', '20:00',
     '#6D5DD3', 0, 30, 'tableta'),
    (patient_one, 'Vitamina D', '1000 UI', 'Una vez al día', '09:00',
     '#D9A441', 1, 90, 'capsula'),
    (patient_two, 'Paracetamol', '500 mg', 'Cada 8 horas', '12:00',
     '#E4572E', 0, 7, 'pastilla'),
    (patient_two, 'Omega 3', '1 g', 'Una vez al día', '13:00',
     '#22C55E', 1, 60, 'capsula'),
    (patient_three, 'Salbutamol', '100 mcg', 'Según necesidad', '18:00',
     '#2563EB', 0, 30, 'inyeccion');

  WHILE day_number < p_days DO

    INSERT INTO habit_logs (
      user_id, log_date, water, exercise,
      sleep, nutrition, meditation
    )
    SELECT
      id,
      DATE_SUB(CURDATE(), INTERVAL day_number DAY),
      5 + MOD(id + day_number, 4),
      20 + MOD(id * 7 + day_number, 45),
      6 + MOD(id + day_number, 3) / 2,
      2 + MOD(id + day_number, 3),
      MOD(id * 3 + day_number, 20)
    FROM users
    WHERE role = 'patient';

    INSERT INTO symptom_logs (
      user_id, log_date, pain, temperature,
      systolic, diastolic, glucose, weight,
      heart_rate, stress_level, energy_level,
      sleep_quality, mood, notes, created_at
    )
    SELECT
      id,
      DATE_SUB(CURDATE(), INTERVAL day_number DAY),
      MOD(id + day_number, 6),
      36.4 + MOD(id + day_number, 4) / 10,
      112 + MOD(id * 3 + day_number, 18),
      72 + MOD(id + day_number, 10),
      88 + MOD(id * 5 + day_number, 35),
      weight_kg + MOD(day_number, 5) / 2,
      68 + MOD(id * 2 + day_number, 24),
      2 + MOD(id + day_number, 8),
      5 + MOD(id * 3 + day_number, 6),
      5 + MOD(id * 2 + day_number, 6),
      ELT(
        1 + MOD(id + day_number, 5),
        'Muy bien', 'Bien', 'Regular', 'Mal', 'Muy mal'
      ),
      'Registro demo para dashboard',
      DATE_SUB(NOW(), INTERVAL day_number DAY)
    FROM users
    WHERE role = 'patient';

    INSERT INTO emotional_logs (
      user_id, mood, stress_level, energy_level,
      sleep_quality, notes, log_date
    )
    SELECT
      id,
      ELT(
        1 + MOD(id + day_number, 5),
        'Muy bien', 'Bien', 'Regular', 'Mal', 'Muy mal'
      ),
      2 + MOD(id + day_number, 8),
      5 + MOD(id * 3 + day_number, 6),
      5 + MOD(id * 2 + day_number, 6),
      'Registro emocional demo',
      DATE_SUB(CURDATE(), INTERVAL day_number DAY)
    FROM users
    WHERE role = 'patient';

    INSERT INTO medication_logs (
      medication_id, user_id, taken_date, taken_time, taken
    )
    SELECT
      id,
      user_id,
      DATE_SUB(CURDATE(), INTERVAL day_number DAY),
      time_label,
      1
    FROM medications
    WHERE MOD(id + day_number, 3) <> 0;

    SET day_number = day_number + 1;
  END WHILE;

  INSERT INTO appointments (
    user_id, specialty, doctor, appointment_date,
    appointment_time, place, color, status
  )
  VALUES
    (
      patient_one, 'Cardiología', 'Dra. Ana Martínez',
      DATE_ADD(CURDATE(), INTERVAL 7 DAY),
      '10:30', 'Clínica VitalMind', '#0F766E', 'proxima'
    ),
    (
      patient_one, 'Nutrición', 'Lic. Laura Pérez',
      DATE_ADD(CURDATE(), INTERVAL 14 DAY),
      '12:00', 'Consultorio VitalMind', '#2563EB', 'proxima'
    ),
    (
      patient_two, 'Medicina general', 'Dr. Carlos Torres',
      DATE_SUB(CURDATE(), INTERVAL 10 DAY),
      '09:00', 'Hospital Central', '#D9A441', 'completada'
    ),
    (
      patient_three, 'Psicología', 'Dra. Sofía Ruiz',
      DATE_ADD(CURDATE(), INTERVAL 3 DAY),
      '16:00', 'Centro VitalMind', '#6D5DD3', 'proxima'
    );

  INSERT INTO medical_history_items (
    user_id, category, description
  )
  VALUES
    (patient_one, 'allergies', 'Alergia estacional al polen'),
    (patient_one, 'vaccines', 'Refuerzo de vacuna COVID-19'),
    (patient_two, 'diseases', 'Hipertensión arterial controlada'),
    (patient_three, 'consultations', 'Consulta preventiva inicial');

  INSERT INTO notifications (
    user_id, kind, title, body, time_label, is_read
  )
  SELECT
    id,
    'tip',
    'Consejo del día',
    'Mantén una hidratación constante durante el día.',
    'Hace 1 h',
    0
  FROM users
  WHERE role = 'patient';

  INSERT INTO notifications (
    user_id, kind, title, body, time_label, is_read
  )
  VALUES (
    NULL,
    'alert',
    'Mantenimiento programado',
    'El servicio estará en mantenimiento esta noche.',
    'Ayer',
    0
  );

  INSERT INTO chat_conversations (user_id, title)
  SELECT id, 'Seguimiento de bienestar'
  FROM users
  WHERE role = 'patient';

  INSERT INTO chat_messages (conversation_id, role, content)
  SELECT id, 'user', '¿Cómo puedo mejorar mi descanso?'
  FROM chat_conversations;

  INSERT INTO chat_messages (conversation_id, role, content)
  SELECT
    id,
    'assistant',
    'Procura mantener horarios regulares y dormir entre 7 y 9 horas.'
  FROM chat_conversations;

  INSERT INTO audit_logs (
    actor_id, action, entity, entity_id, payload
  )
  VALUES (
    admin_id,
    'demo.seed',
    'dashboard',
    NULL,
    JSON_OBJECT(
      'days', p_days,
      'patients', 3,
      'caregivers', 1
    )
  );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `vm_sync_dashboard_columns` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `vm_sync_dashboard_columns`()
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM information_schema.columns
    WHERE table_schema = DATABASE()
      AND table_name = 'symptom_logs'
      AND column_name = 'log_date'
  ) THEN
    ALTER TABLE symptom_logs
      ADD COLUMN log_date DATE NULL AFTER user_id;
  END IF;

  IF NOT EXISTS (
    SELECT 1
    FROM information_schema.columns
    WHERE table_schema = DATABASE()
      AND table_name = 'symptom_logs'
      AND column_name = 'stress_level'
  ) THEN
    ALTER TABLE symptom_logs
      ADD COLUMN stress_level TINYINT UNSIGNED NULL AFTER heart_rate;
  END IF;

  IF NOT EXISTS (
    SELECT 1
    FROM information_schema.columns
    WHERE table_schema = DATABASE()
      AND table_name = 'symptom_logs'
      AND column_name = 'energy_level'
  ) THEN
    ALTER TABLE symptom_logs
      ADD COLUMN energy_level TINYINT UNSIGNED NULL AFTER stress_level;
  END IF;

  IF NOT EXISTS (
    SELECT 1
    FROM information_schema.columns
    WHERE table_schema = DATABASE()
      AND table_name = 'symptom_logs'
      AND column_name = 'sleep_quality'
  ) THEN
    ALTER TABLE symptom_logs
      ADD COLUMN sleep_quality TINYINT UNSIGNED NULL AFTER energy_level;
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-20  1:37:56
