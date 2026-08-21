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

-- Dump completed on 2026-08-21  9:27:39
