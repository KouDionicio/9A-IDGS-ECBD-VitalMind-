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
) ENGINE=InnoDB AUTO_INCREMENT=379 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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

-- Dump completed on 2026-08-21  9:51:21
