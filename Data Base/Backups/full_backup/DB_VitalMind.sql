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
  `specialty` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `doctor` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `place` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#0F766E',
  `status` enum('proxima','completada','cancelada') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'proxima',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_appointments_user` (`user_id`),
  CONSTRAINT `fk_appointments_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (1,2,'Cardiología','Dr. Martínez López','2025-07-15','10:30','Clínica San Rafael','#EF4444','proxima','2026-08-02 01:10:14','2026-08-02 01:10:14'),(2,2,'Endocrinología','Dra. García Ruiz','2025-07-22','09:00','Hospital Central','#8B5CF6','proxima','2026-08-02 01:10:14','2026-08-02 01:10:14'),(3,2,'Médico general','Dr. Sánchez Vega','2025-06-10','11:00','Centro de Salud Norte','#0F766E','completada','2026-08-02 01:10:14','2026-08-02 01:10:14'),(4,2,'Oftalmología','Dra. Torres Ramos','2025-06-01','15:30','Óptica Visión Salud','#2563EB','completada','2026-08-02 01:10:14','2026-08-02 01:10:14');
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
  `action` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_id` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_audit_logs_actor` (`actor_id`),
  CONSTRAINT `fk_audit_logs_actor` FOREIGN KEY (`actor_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_logs`
--

LOCK TABLES `audit_logs` WRITE;
/*!40000 ALTER TABLE `audit_logs` DISABLE KEYS */;
INSERT INTO `audit_logs` VALUES (1,2,'medications.create','medications','6','{\"name\":\"Aspirina\",\"dose\":\"500g\",\"frequency\":\"Diario\",\"time_label\":\"08:00\",\"color\":\"#0F766E\",\"taken\":false,\"type\":\"pastilla\"}','2026-08-02 02:02:35'),(2,2,'medications.update','medications','6','{\"userId\":2,\"name\":\"Aspirina\",\"dose\":\"500g\",\"frequency\":\"Diario\",\"time_label\":\"08:00\",\"color\":\"#0F766E\",\"taken\":true,\"days_duration\":5,\"type\":\"pastilla\"}','2026-08-02 02:08:45'),(3,2,'medications.create','medications','7','{\"name\":\"wqf\",\"dose\":\"235g\",\"frequency\":\"Diario\",\"time_label\":\"08:00\",\"color\":\"#0F766E\",\"taken\":false,\"type\":\"pastilla\"}','2026-08-02 02:22:27'),(4,2,'medications.delete','medications','7','{}','2026-08-02 02:22:35'),(5,2,'medications.create','medications','8','{\"name\":\"Fagsfa\",\"dose\":\"600ml\",\"frequency\":\"Diario\",\"time_label\":\"08:00\",\"color\":\"#0F766E\",\"taken\":false,\"days_duration\":1,\"type\":\"jarabe\"}','2026-08-02 02:26:27'),(6,2,'medications.update','medications','8','{\"userId\":2,\"name\":\"Fagsfa\",\"dose\":\"600ml\",\"frequency\":\"Diario\",\"time_label\":\"08:00\",\"color\":\"#0F766E\",\"taken\":false,\"days_duration\":4,\"type\":\"jarabe\"}','2026-08-02 02:26:39'),(7,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-01\",\"value\":1}','2026-08-02 02:27:34'),(8,2,'habits.increment','habit_logs','nutrition','{\"date\":\"2026-08-01\",\"value\":1}','2026-08-02 02:27:34'),(9,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-01\",\"value\":1}','2026-08-02 02:27:35'),(10,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":1}','2026-08-02 02:27:37'),(11,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-01\",\"value\":1}','2026-08-02 02:27:38'),(12,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":2}','2026-08-02 02:27:40'),(13,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":3}','2026-08-02 02:27:41'),(14,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":4}','2026-08-02 02:27:41'),(15,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":5}','2026-08-02 02:27:41'),(16,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":6}','2026-08-02 02:27:41'),(17,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":7}','2026-08-02 02:27:41'),(18,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":8}','2026-08-02 02:27:41'),(19,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":9}','2026-08-02 02:27:42'),(20,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":10}','2026-08-02 02:27:42'),(21,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":11}','2026-08-02 02:27:42'),(22,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":12}','2026-08-02 02:27:42'),(23,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":13}','2026-08-02 02:27:42'),(24,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":14}','2026-08-02 02:27:42'),(25,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":15}','2026-08-02 02:27:42'),(26,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":16}','2026-08-02 02:27:42'),(27,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":17}','2026-08-02 02:27:43'),(28,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":18}','2026-08-02 02:27:43'),(29,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":19}','2026-08-02 02:27:43'),(30,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":20}','2026-08-02 02:27:43'),(31,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":21}','2026-08-02 02:27:43'),(32,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":22}','2026-08-02 02:27:43'),(33,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":23}','2026-08-02 02:27:44'),(34,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":24}','2026-08-02 02:27:44'),(35,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":25}','2026-08-02 02:27:44'),(36,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":26}','2026-08-02 02:27:44'),(37,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":27}','2026-08-02 02:27:44'),(38,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":28}','2026-08-02 02:27:44'),(39,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":29}','2026-08-02 02:27:44'),(40,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":30}','2026-08-02 02:27:45'),(41,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":30}','2026-08-02 02:27:45'),(42,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":30}','2026-08-02 02:27:45'),(43,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":30}','2026-08-02 02:27:45'),(44,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":30}','2026-08-02 02:27:45'),(45,2,'habits.increment','habit_logs','exercise','{\"date\":\"2026-08-01\",\"value\":30}','2026-08-02 02:27:45'),(46,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-01\",\"value\":2}','2026-08-02 02:27:46'),(47,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-01\",\"value\":3}','2026-08-02 02:27:46'),(48,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-01\",\"value\":4}','2026-08-02 02:27:46'),(49,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-01\",\"value\":5}','2026-08-02 02:27:46'),(50,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-01\",\"value\":6}','2026-08-02 02:27:46'),(51,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-01\",\"value\":7}','2026-08-02 02:27:47'),(52,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-01\",\"value\":8}','2026-08-02 02:27:47'),(53,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-01\",\"value\":8}','2026-08-02 02:27:47'),(54,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-01\",\"value\":8}','2026-08-02 02:27:47'),(55,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-01\",\"value\":8}','2026-08-02 02:27:47'),(56,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-01\",\"value\":8}','2026-08-02 02:27:47'),(57,2,'habits.increment','habit_logs','nutrition','{\"date\":\"2026-08-01\",\"value\":2}','2026-08-02 02:27:48'),(58,2,'habits.increment','habit_logs','nutrition','{\"date\":\"2026-08-01\",\"value\":3}','2026-08-02 02:27:48'),(59,2,'habits.increment','habit_logs','nutrition','{\"date\":\"2026-08-01\",\"value\":3}','2026-08-02 02:27:49'),(60,2,'habits.increment','habit_logs','nutrition','{\"date\":\"2026-08-01\",\"value\":3}','2026-08-02 02:27:49'),(61,2,'habits.increment','habit_logs','nutrition','{\"date\":\"2026-08-01\",\"value\":3}','2026-08-02 02:27:49'),(62,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-01\",\"value\":2}','2026-08-02 02:27:50'),(63,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-01\",\"value\":3}','2026-08-02 02:27:51'),(64,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-01\",\"value\":4}','2026-08-02 02:27:51'),(65,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-01\",\"value\":5}','2026-08-02 02:27:51'),(66,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-01\",\"value\":6}','2026-08-02 02:27:51'),(67,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-01\",\"value\":7}','2026-08-02 02:27:51'),(68,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-01\",\"value\":8}','2026-08-02 02:27:51'),(69,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-01\",\"value\":9}','2026-08-02 02:27:51'),(70,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-01\",\"value\":10}','2026-08-02 02:27:51'),(71,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-01\",\"value\":10}','2026-08-02 02:27:52'),(72,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-01\",\"value\":10}','2026-08-02 02:27:52'),(73,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-01\",\"value\":10}','2026-08-02 02:27:52'),(74,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-01\",\"value\":10}','2026-08-02 02:27:52'),(75,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-01\",\"value\":2}','2026-08-02 02:27:53'),(76,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-01\",\"value\":3}','2026-08-02 02:27:53'),(77,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-01\",\"value\":4}','2026-08-02 02:27:53'),(78,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-01\",\"value\":5}','2026-08-02 02:27:54'),(79,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-01\",\"value\":6}','2026-08-02 02:27:54'),(80,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-01\",\"value\":7}','2026-08-02 02:27:54'),(81,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-01\",\"value\":8}','2026-08-02 02:27:54'),(82,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-01\",\"value\":8}','2026-08-02 02:27:54'),(83,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-01\",\"value\":8}','2026-08-02 02:27:54'),(84,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-01\",\"value\":8}','2026-08-02 02:27:54'),(85,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-01\",\"value\":8}','2026-08-02 02:27:55'),(86,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-01\",\"value\":8}','2026-08-02 02:27:55'),(87,2,'auth.updateMe','users','2','{\"name\":\"María García\",\"email\":\"maria@email.com\",\"age\":34,\"bloodType\":null,\"phone\":null,\"weightKg\":64,\"heightCm\":null}','2026-08-02 18:25:44'),(88,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-02\",\"value\":1}','2026-08-02 18:26:12'),(89,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-02\",\"value\":2}','2026-08-02 18:26:12'),(90,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-02\",\"value\":3}','2026-08-02 18:26:12'),(91,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-02\",\"value\":4}','2026-08-02 18:26:13'),(92,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-02\",\"value\":1}','2026-08-02 18:26:18'),(93,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-02\",\"value\":2}','2026-08-02 18:26:18'),(94,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-02\",\"value\":3}','2026-08-02 18:26:19'),(95,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-02\",\"value\":4}','2026-08-02 18:26:19'),(96,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-02\",\"value\":5}','2026-08-02 18:26:19'),(97,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-02\",\"value\":6}','2026-08-02 18:26:19'),(98,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-02\",\"value\":7}','2026-08-02 18:26:19'),(99,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-02\",\"value\":8}','2026-08-02 18:26:19'),(100,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-02\",\"value\":8}','2026-08-02 18:26:19'),(101,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-02\",\"value\":8}','2026-08-02 18:26:19'),(102,2,'habits.increment','habit_logs','sleep','{\"date\":\"2026-08-02\",\"value\":8}','2026-08-02 18:26:20'),(103,2,'habits.increment','habit_logs','nutrition','{\"date\":\"2026-08-02\",\"value\":1}','2026-08-02 18:26:21'),(104,2,'habits.increment','habit_logs','nutrition','{\"date\":\"2026-08-02\",\"value\":2}','2026-08-02 18:26:22'),(105,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-02\",\"value\":1}','2026-08-02 18:26:24'),(106,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-02\",\"value\":2}','2026-08-02 18:26:24'),(107,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-02\",\"value\":3}','2026-08-02 18:26:24'),(108,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-02\",\"value\":4}','2026-08-02 18:26:24'),(109,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-02\",\"value\":5}','2026-08-02 18:26:24'),(110,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-02\",\"value\":6}','2026-08-02 18:26:25'),(111,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-02\",\"value\":7}','2026-08-02 18:26:25'),(112,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-02\",\"value\":8}','2026-08-02 18:26:25'),(113,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-02\",\"value\":9}','2026-08-02 18:26:25'),(114,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-02\",\"value\":10}','2026-08-02 18:26:25'),(115,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-02\",\"value\":10}','2026-08-02 18:26:25'),(116,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-02\",\"value\":10}','2026-08-02 18:26:25'),(117,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-02\",\"value\":10}','2026-08-02 18:26:25'),(118,2,'habits.increment','habit_logs','meditation','{\"date\":\"2026-08-02\",\"value\":10}','2026-08-02 18:26:26'),(119,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-02\",\"value\":5}','2026-08-02 18:26:33'),(120,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-02\",\"value\":6}','2026-08-02 18:26:34'),(121,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-02\",\"value\":7}','2026-08-02 18:26:34'),(122,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-02\",\"value\":8}','2026-08-02 18:26:34'),(123,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-02\",\"value\":8}','2026-08-02 18:26:34'),(124,2,'habits.increment','habit_logs','water','{\"date\":\"2026-08-02\",\"value\":8}','2026-08-02 18:26:34'),(125,2,'medical_history.create','medical_history_items','1','{\"id\":1,\"userId\":2,\"category\":\"diseases\",\"description\":\"Hipertensión arterial\"}','2026-08-03 00:54:28'),(126,2,'medical_history.create','medical_history_items','2','{\"id\":2,\"userId\":2,\"category\":\"allergies\",\"description\":\"Polen\"}','2026-08-03 00:54:54'),(127,2,'medical_history.create','medical_history_items','3','{\"id\":3,\"userId\":2,\"category\":\"medications\",\"description\":\"Naproxeno 500g\"}','2026-08-03 00:55:32'),(128,2,'medical_history.create','medical_history_items','4','{\"id\":4,\"userId\":2,\"category\":\"surgeries\",\"description\":\"Apendicectomía (2018)\"}','2026-08-03 00:56:06'),(129,2,'medical_history.create','medical_history_items','5','{\"id\":5,\"userId\":2,\"category\":\"consultations\",\"description\":\"Dentista (Mayo 2021)\"}','2026-08-03 00:56:28'),(130,2,'medical_history.create','medical_history_items','6','{\"id\":6,\"userId\":2,\"category\":\"vaccines\",\"description\":\"Influencia\"}','2026-08-03 00:56:38'),(131,2,'medical_history.create','medical_history_items','7','{\"id\":7,\"userId\":2,\"category\":\"results\",\"description\":\"Hemoglobina Junio 2015 - 12.5\"}','2026-08-03 00:58:15'),(132,2,'medical_history.create','medical_history_items','8','{\"id\":8,\"userId\":2,\"category\":\"diseases\",\"description\":\"Gastritis\"}','2026-08-03 00:59:11'),(133,1,'auth.login','users','1','{\"email\":\"admin@vitalmind.com\"}','2026-08-03 00:59:27');
/*!40000 ALTER TABLE `audit_logs` ENABLE KEYS */;
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
  `log_date` date NOT NULL,
  `water` decimal(6,2) NOT NULL DEFAULT '0.00',
  `exercise` decimal(6,2) NOT NULL DEFAULT '0.00',
  `sleep` decimal(6,2) NOT NULL DEFAULT '0.00',
  `nutrition` decimal(6,2) NOT NULL DEFAULT '0.00',
  `meditation` decimal(6,2) NOT NULL DEFAULT '0.00',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_habit_user_date` (`user_id`,`log_date`),
  CONSTRAINT `fk_habit_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habit_logs`
--

LOCK TABLES `habit_logs` WRITE;
/*!40000 ALTER TABLE `habit_logs` DISABLE KEYS */;
INSERT INTO `habit_logs` VALUES (1,2,'2026-07-27',6.00,30.00,8.00,3.00,10.00,'2026-07-27 20:27:34','2026-08-01 20:31:54'),(2,2,'2026-07-28',8.00,30.00,8.00,3.00,8.00,'2026-07-28 20:27:34','2026-08-01 20:31:54'),(3,2,'2026-07-29',8.00,25.00,8.00,3.00,10.00,'2026-07-29 20:27:34','2026-08-01 20:31:54'),(4,2,'2026-07-30',8.00,30.00,8.00,2.00,10.00,'2026-07-30 20:27:34','2026-08-01 20:31:23'),(5,2,'2026-07-31',8.00,30.00,7.00,3.00,10.00,'2026-07-31 20:27:34','2026-08-01 20:31:23'),(6,2,'2026-08-01',7.00,30.00,8.00,3.00,8.00,'2026-08-01 20:27:34','2026-08-01 20:32:19'),(13,2,'2026-08-02',8.00,0.00,8.00,2.00,10.00,'2026-08-02 12:26:12','2026-08-02 12:26:34');
/*!40000 ALTER TABLE `habit_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_history_items`
--

DROP TABLE IF EXISTS `medical_history_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medical_history_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `category` enum('diseases','allergies','medications','surgeries','consultations','vaccines','results') COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_medical_history_user` (`user_id`),
  CONSTRAINT `fk_medical_history_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_history_items`
--

LOCK TABLES `medical_history_items` WRITE;
/*!40000 ALTER TABLE `medical_history_items` DISABLE KEYS */;
INSERT INTO `medical_history_items` VALUES (1,2,'diseases','Hipertensión arterial','2026-08-03 00:54:28'),(2,2,'allergies','Polen','2026-08-03 00:54:54'),(3,2,'medications','Naproxeno 500g','2026-08-03 00:55:32'),(4,2,'surgeries','Apendicectomía (2018)','2026-08-03 00:56:06'),(5,2,'consultations','Dentista (Mayo 2021)','2026-08-03 00:56:28'),(6,2,'vaccines','Influencia','2026-08-03 00:56:38'),(7,2,'results','Hemoglobina Junio 2015 - 12.5','2026-08-03 00:58:15'),(8,2,'diseases','Gastritis','2026-08-03 00:59:11');
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
  `taken` tinyint(1) NOT NULL DEFAULT '0',
  `taken_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_medication_logs_medication` (`medication_id`),
  KEY `fk_medication_logs_user` (`user_id`),
  CONSTRAINT `fk_medication_logs_medication` FOREIGN KEY (`medication_id`) REFERENCES `medications` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_medication_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medication_logs`
--

LOCK TABLES `medication_logs` WRITE;
/*!40000 ALTER TABLE `medication_logs` DISABLE KEYS */;
INSERT INTO `medication_logs` VALUES (1,6,2,1,'2026-08-01 20:08:11'),(2,8,2,1,'2026-08-01 20:26:45');
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
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dose` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `frequency` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time_label` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#0F766E',
  `taken` tinyint(1) NOT NULL DEFAULT '0',
  `type` enum('pastilla','capsula','jarabe','inyeccion','tableta','gota','crema','parche') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pastilla',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `days_duration` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_medications_user` (`user_id`),
  CONSTRAINT `fk_medications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medications`
--

LOCK TABLES `medications` WRITE;
/*!40000 ALTER TABLE `medications` DISABLE KEYS */;
INSERT INTO `medications` VALUES (1,2,'Metformina','850mg','Diario','08:00','#0F766E',1,'pastilla','2026-08-02 01:10:14','2026-08-02 01:10:14',0),(2,2,'Losartán','50mg','Diario','08:00','#2563EB',0,'pastilla','2026-08-02 01:10:14','2026-08-02 01:10:14',0),(3,2,'Salbutamol','100mcg','PRN','Según necesidad','#8B5CF6',0,'inyeccion','2026-08-02 01:10:14','2026-08-02 01:10:14',0),(4,2,'Vitamina D','1000UI','Diario','12:00','#F59E0B',1,'capsula','2026-08-02 01:10:14','2026-08-02 01:10:14',0),(5,2,'Omega 3','1g','Diario','13:00','#22C55E',0,'capsula','2026-08-02 01:10:14','2026-08-02 01:10:14',0),(6,2,'Aspirina','500g','Diario','08:00','#0F766E',1,'pastilla','2026-08-02 02:02:35','2026-08-02 02:08:45',5),(8,2,'Fagsfa','600ml','Diario','08:00','#0F766E',1,'jarabe','2026-08-02 02:26:27','2026-08-02 02:26:45',4);
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
  `kind` enum('tip','reminder','ai','alert') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'tip',
  `title` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `time_label` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Ahora',
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_notifications_user` (`user_id`),
  CONSTRAINT `fk_notifications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,NULL,'ai','Insight de IA','Tu bienestar aumentó un 5% esta semana. ¡Excelente progreso!','Hace 10 min',0,'2026-08-02 01:10:14','2026-08-02 01:10:14'),(2,NULL,'alert','Alerta de salud','Tu glucosa estuvo elevada el martes. Considera consultar con tu médico.','Hace 2 h',0,'2026-08-02 01:10:14','2026-08-02 01:10:14'),(3,NULL,'reminder','Recordatorio de agua','Recuerda beber agua. Te faltan 2 vasos para tu meta diaria.','Hace 3 h',0,'2026-08-02 01:10:14','2026-08-02 01:10:14'),(4,NULL,'tip','Consejo de bienestar','30 minutos de caminata al día reducen significativamente el riesgo cardiovascular.','Hace 5 h',1,'2026-08-02 01:10:14','2026-08-02 01:10:14'),(5,NULL,'reminder','Registro pendiente','No registraste tus síntomas ayer. ¡Hazlo ahora para mantener tu historial al día!','Hace 1 día',1,'2026-08-02 01:10:14','2026-08-02 01:10:14'),(6,NULL,'ai','Recomendación personalizada','Basado en tus datos, te recomendamos mejorar tu rutina de sueño esta semana.','Hace 1 día',1,'2026-08-02 01:10:14','2026-08-02 01:10:14'),(7,NULL,'tip','Hábito saludable','Incluye 5 porciones de frutas y verduras hoy para optimizar tu nutrición.','Hace 2 días',1,'2026-08-02 01:10:14','2026-08-02 01:10:14'),(8,NULL,'alert','Meta de pasos','Ayer no alcanzaste tu meta de 10,000 pasos. ¡Hoy es un nuevo día!','Hace 2 días',1,'2026-08-02 01:10:14','2026-08-02 01:10:14');
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
  `token_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` timestamp NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_refresh_tokens_user` (`user_id`),
  CONSTRAINT `fk_refresh_tokens_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refresh_tokens`
--

LOCK TABLES `refresh_tokens` WRITE;
/*!40000 ALTER TABLE `refresh_tokens` DISABLE KEYS */;
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
  `mood` enum('Muy bien','Bien','Regular','Mal','Muy mal') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_symptom_logs_user` (`user_id`),
  CONSTRAINT `fk_symptom_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `symptom_logs`
--

LOCK TABLES `symptom_logs` WRITE;
/*!40000 ALTER TABLE `symptom_logs` DISABLE KEYS */;
INSERT INTO `symptom_logs` VALUES (1,2,0,36.0,120,80,90,62.0,72,'Bien','no tengo ningun malestar','2026-08-02 19:34:57'),(2,2,6,36.0,123,81,91,63.0,72,'Muy bien','hoy me siento con muche energia :)','2026-08-02 19:38:04'),(3,2,4,339.0,126,80,94,65.0,80,'Mal','Dolor de cabeza y temperatura alta','2026-08-02 19:39:56'),(4,2,2,39.0,125,80,89,63.0,77,'Mal','La temeperatura no para','2026-08-02 19:42:21'),(5,2,1,36.0,120,80,90,64.0,72,'Mal','Un poco de estres por el trabajo','2026-08-02 19:47:19'),(6,2,0,33.0,120,80,80,65.0,72,'Bien','Estoy muy feliz hoy es mi cumpleaños','2026-08-02 20:35:41'),(9,2,2,36.0,120,80,90,64.0,72,'Bien','Solo tengo resaca\n','2026-08-02 21:22:23'),(10,2,0,36.0,120,80,90,64.0,NULL,'Regular','Amaneci con dolor de cabeza','2026-08-02 22:02:27');
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
  `full_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` int NOT NULL DEFAULT '0',
  `joined_label` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_active_label` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive','pending') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `registros` int NOT NULL DEFAULT '0',
  `consultas` int NOT NULL DEFAULT '0',
  `color` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#0F766E',
  `role` enum('admin','patient','caregiver') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'patient',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `blood_type` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weight_kg` decimal(5,1) DEFAULT NULL,
  `height_cm` decimal(5,1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Administrador','admin@vitalmind.com','$2a$10$uCdqDCRbeXZtqzmcOzqz7.PunMxfTUq55r5vhBKAluHkrkIAoQ8DS',42,'10 jun 2025','Hace unos segundos','active',0,0,'#0F766E','admin','2026-08-02 01:10:14','2026-08-03 00:59:27',NULL,NULL,NULL,NULL),(2,'María García','maria@email.com','$2a$10$mkEKIfzzdsvxJNnQUlpN.uIbQX2nujwohmbP3z7imxOPP2rB8.vUS',34,'10 jun 2025','Hace 5 min','active',48,23,'#0F766E','patient','2026-08-02 01:10:14','2026-08-02 18:25:44',NULL,NULL,64.0,NULL),(3,'Carlos Rodríguez','carlos@email.com','$2a$10$wgZfAiYJeRHOfyIcrayUaOYsd.sgC0QAvFLpGxgF7igFgBxarfiom',41,'8 jun 2025','Hace 1 h','active',31,15,'#2563EB','patient','2026-08-02 01:10:14','2026-08-02 01:10:14',NULL,NULL,NULL,NULL),(4,'Ana Pérez','ana@email.com','$2a$10$DmHdVcmS9CID7Bnsv3ynpeP5kF4jgC3nEyx4QjIOA4bkBKFmAnFSa',28,'5 jun 2025','Hace 2 h','active',62,40,'#8B5CF6','patient','2026-08-02 01:10:14','2026-08-02 01:10:14',NULL,NULL,NULL,NULL),(5,'Luis Martínez','luis@email.com','$2a$10$0weXCFUywfKUbJzM2EmPce.5q3jQxAkLv1PksPTwVRTQFzEWSk9yC',55,'1 jun 2025','Hace 1 día','inactive',12,5,'#F59E0B','patient','2026-08-02 01:10:14','2026-08-02 01:10:14',NULL,NULL,NULL,NULL),(6,'Sara Vega','sara@email.com','$2a$10$oN6bGT2Vic3riyQijZWErePdo4t2b8uTMsfPLUOOvNULuDNB9Y/Qy',22,'15 may 2025','Hace 3 días','pending',0,0,'#EC4899','patient','2026-08-02 01:10:14','2026-08-02 01:10:14',NULL,NULL,NULL,NULL),(7,'Diego López','diego@email.com','$2a$10$RpSDUiB1VLxGBOxmV2QONubHOVAkwFbd1wchaVIVeXBUnSG/ryZHy',38,'12 may 2025','Hace 5 h','active',27,18,'#22C55E','patient','2026-08-02 01:10:14','2026-08-02 01:10:14',NULL,NULL,NULL,NULL),(8,'Laura Torres','laura@email.com','$2a$10$8c0.TvAkWerfe9ZXcNBMwOhTs781X.rJZbrgdJFuF2RfQQhd8JVgm',45,'3 may 2025','Hace 2 días','inactive',8,3,'#F97316','patient','2026-08-02 01:10:14','2026-08-02 01:10:14',NULL,NULL,NULL,NULL),(9,'Marta Ruiz','marta@email.com','$2a$10$CzAiSDUwuAvqsV4LkSdwJuLHcQY5CDDFnKkKsRbKQMIBW0Xp8ctCW',30,'28 abr 2025','Hace 10 min','active',55,32,'#14B8A6','patient','2026-08-02 01:10:14','2026-08-02 01:10:14',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'vitalmind'
--

--
-- Dumping routines for database 'vitalmind'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-02 19:02:24
