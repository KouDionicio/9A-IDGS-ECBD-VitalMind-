-- VitalMind: esquema completo + procedimientos de limpieza y datos demo.
-- Compatible con MySQL 8.x.
-- Ejecutar desde el cliente mysql:
--   mysql -h 127.0.0.1 -P 3307 -u root -p < database/vitalmind_setup_demo.sql
--
-- Este script crea la base, las tablas y los procedimientos. El seed queda
-- comentado para no borrar datos existentes durante una importación.

CREATE DATABASE IF NOT EXISTS vitalmind
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE vitalmind;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE IF NOT EXISTS users (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  full_name VARCHAR(120) NOT NULL,
  email VARCHAR(160) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  age INT NOT NULL DEFAULT 0,
  gender VARCHAR(20) NULL,
  joined_label VARCHAR(40) NULL,
  last_active_label VARCHAR(40) NULL,
  last_active_at DATETIME NULL,
  status ENUM('active','inactive','pending') NOT NULL DEFAULT 'pending',
  registros INT NOT NULL DEFAULT 0,
  consultas INT NOT NULL DEFAULT 0,
  color VARCHAR(20) NOT NULL DEFAULT '#0F766E',
  role ENUM('admin','patient','caregiver') NOT NULL DEFAULT 'patient',
  blood_type VARCHAR(5) NULL,
  phone VARCHAR(30) NULL,
  weight_kg DECIMAL(5,1) NULL,
  height_cm DECIMAL(5,1) NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_users_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS refresh_tokens (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NOT NULL,
  token_hash VARCHAR(255) NOT NULL,
  expires_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_refresh_tokens_user (user_id),
  CONSTRAINT fk_refresh_tokens_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS medications (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NULL,
  name VARCHAR(120) NOT NULL,
  dose VARCHAR(80) NOT NULL,
  frequency VARCHAR(80) NOT NULL,
  time_label VARCHAR(80) NOT NULL,
  color VARCHAR(20) NOT NULL DEFAULT '#0F766E',
  taken TINYINT(1) NOT NULL DEFAULT 0,
  days_duration INT NOT NULL DEFAULT 0,
  type ENUM('pastilla','capsula','jarabe','inyeccion','tableta','gota','crema','parche') NOT NULL DEFAULT 'pastilla',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_medications_user (user_id),
  CONSTRAINT fk_medications_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS medication_logs (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  medication_id BIGINT UNSIGNED NOT NULL,
  user_id BIGINT UNSIGNED NULL,
  taken_date DATE NOT NULL,
  taken_time TIME NOT NULL,
  taken TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_medication_day_time (medication_id, taken_date, taken_time),
  KEY idx_medication_logs_user (user_id),
  CONSTRAINT fk_medication_logs_medication FOREIGN KEY (medication_id) REFERENCES medications(id) ON DELETE CASCADE,
  CONSTRAINT fk_medication_logs_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS appointments (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NULL,
  specialty VARCHAR(120) NOT NULL,
  doctor VARCHAR(120) NOT NULL,
  appointment_date DATE NOT NULL,
  appointment_time VARCHAR(10) NOT NULL,
  place VARCHAR(160) NOT NULL,
  color VARCHAR(20) NOT NULL DEFAULT '#0F766E',
  status ENUM('proxima','completada','cancelada') NOT NULL DEFAULT 'proxima',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_appointments_user (user_id),
  CONSTRAINT fk_appointments_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS habit_logs (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NOT NULL,
  log_date DATE NOT NULL,
  water DECIMAL(6,2) NOT NULL DEFAULT 0.00,
  exercise DECIMAL(6,2) NOT NULL DEFAULT 0.00,
  sleep DECIMAL(6,2) NOT NULL DEFAULT 0.00,
  nutrition DECIMAL(6,2) NOT NULL DEFAULT 0.00,
  meditation DECIMAL(6,2) NOT NULL DEFAULT 0.00,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_habit_user_date (user_id, log_date),
  CONSTRAINT fk_habit_logs_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS symptom_logs (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NULL,
  log_date DATE NULL,
  pain INT NOT NULL DEFAULT 0,
  temperature DECIMAL(4,1) NULL,
  systolic INT NULL,
  diastolic INT NULL,
  glucose INT NULL,
  weight DECIMAL(5,1) NULL,
  heart_rate INT NULL,
  stress_level TINYINT UNSIGNED NULL,
  energy_level TINYINT UNSIGNED NULL,
  sleep_quality TINYINT UNSIGNED NULL,
  mood ENUM('Muy bien','Bien','Regular','Mal','Muy mal') NULL,
  notes TEXT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_symptom_user_date (user_id, log_date),
  CONSTRAINT fk_symptom_logs_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS emotional_logs (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NOT NULL,
  mood ENUM('Muy bien','Bien','Regular','Mal','Muy mal') NOT NULL,
  stress_level TINYINT UNSIGNED NOT NULL,
  energy_level TINYINT UNSIGNED NOT NULL,
  sleep_quality TINYINT UNSIGNED NOT NULL,
  notes TEXT NULL,
  log_date DATE NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_emotional_user_day (user_id, log_date),
  CONSTRAINT fk_emotional_logs_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT chk_emotional_stress CHECK (stress_level BETWEEN 1 AND 10),
  CONSTRAINT chk_emotional_energy CHECK (energy_level BETWEEN 1 AND 10),
  CONSTRAINT chk_emotional_sleep CHECK (sleep_quality BETWEEN 1 AND 10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS medical_history_items (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NOT NULL,
  category ENUM('diseases','allergies','medications','surgeries','consultations','vaccines','results') NOT NULL,
  description VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_medical_history_user (user_id),
  CONSTRAINT fk_medical_history_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS notifications (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NULL,
  kind ENUM('tip','reminder','ai','alert') NOT NULL DEFAULT 'tip',
  title VARCHAR(180) NOT NULL,
  body TEXT NOT NULL,
  time_label VARCHAR(80) NOT NULL DEFAULT 'Ahora',
  is_read TINYINT(1) NOT NULL DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_notifications_user (user_id),
  CONSTRAINT fk_notifications_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS audit_logs (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  actor_id BIGINT UNSIGNED NULL,
  action VARCHAR(120) NOT NULL,
  entity VARCHAR(120) NOT NULL,
  entity_id VARCHAR(120) NULL,
  payload LONGTEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_audit_actor (actor_id),
  CONSTRAINT fk_audit_actor FOREIGN KEY (actor_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS chat_conversations (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id BIGINT UNSIGNED NOT NULL,
  title VARCHAR(150) NOT NULL DEFAULT 'Conversación de VitalMind',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_chat_conversations_user (user_id),
  CONSTRAINT fk_chat_conversations_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS chat_messages (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  conversation_id BIGINT UNSIGNED NOT NULL,
  role ENUM('user','assistant') NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_chat_messages_conversation (conversation_id),
  KEY idx_chat_messages_created (created_at),
  CONSTRAINT fk_chat_messages_conversation FOREIGN KEY (conversation_id) REFERENCES chat_conversations(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DELIMITER $$

DROP PROCEDURE IF EXISTS vm_add_column_if_missing$$
CREATE PROCEDURE vm_add_column_if_missing(IN p_table VARCHAR(64), IN p_column VARCHAR(64), IN p_definition TEXT)
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = p_table AND COLUMN_NAME = p_column
  ) THEN
    SET @sql_add_column = CONCAT('ALTER TABLE `', p_table, '` ADD COLUMN ', p_definition);
    PREPARE stmt_add_column FROM @sql_add_column;
    EXECUTE stmt_add_column;
    DEALLOCATE PREPARE stmt_add_column;
  END IF;
END$$

CALL vm_add_column_if_missing('users', 'gender', '`gender` VARCHAR(20) NULL AFTER `age`')$$
CALL vm_add_column_if_missing('users', 'blood_type', '`blood_type` VARCHAR(5) NULL')$$
CALL vm_add_column_if_missing('users', 'phone', '`phone` VARCHAR(30) NULL')$$
CALL vm_add_column_if_missing('users', 'weight_kg', '`weight_kg` DECIMAL(5,1) NULL')$$
CALL vm_add_column_if_missing('users', 'height_cm', '`height_cm` DECIMAL(5,1) NULL')$$
CALL vm_add_column_if_missing('users', 'last_active_at', '`last_active_at` DATETIME NULL')$$
CALL vm_add_column_if_missing('medications', 'days_duration', '`days_duration` INT NOT NULL DEFAULT 0')$$
CALL vm_add_column_if_missing('symptom_logs', 'log_date', '`log_date` DATE NULL AFTER `user_id`')$$
CALL vm_add_column_if_missing('symptom_logs', 'stress_level', '`stress_level` TINYINT UNSIGNED NULL AFTER `heart_rate`')$$
CALL vm_add_column_if_missing('symptom_logs', 'energy_level', '`energy_level` TINYINT UNSIGNED NULL AFTER `stress_level`')$$
CALL vm_add_column_if_missing('symptom_logs', 'sleep_quality', '`sleep_quality` TINYINT UNSIGNED NULL AFTER `energy_level`')$$

UPDATE symptom_logs SET log_date = DATE(created_at) WHERE id > 0 AND log_date IS NULL$$
DROP PROCEDURE IF EXISTS vm_add_column_if_missing$$

DROP PROCEDURE IF EXISTS vm_clean_demo$$
CREATE PROCEDURE vm_clean_demo()
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
END$$

DROP PROCEDURE IF EXISTS vm_seed_dashboard$$
CREATE PROCEDURE vm_seed_dashboard(IN p_days INT)
BEGIN
  DECLARE d INT DEFAULT 0;
  DECLARE admin_id BIGINT UNSIGNED;
  DECLARE caregiver_id BIGINT UNSIGNED;
  DECLARE patient_one BIGINT UNSIGNED;
  DECLARE patient_two BIGINT UNSIGNED;
  DECLARE patient_three BIGINT UNSIGNED;

  IF p_days IS NULL OR p_days < 1 OR p_days > 365 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'p_days debe estar entre 1 y 365';
  END IF;

  CALL vm_clean_demo();

  INSERT INTO users
    (full_name, email, password_hash, age, gender, status, role, joined_label, last_active_label, color, blood_type, phone, weight_kg, height_cm, last_active_at)
  VALUES
    ('Administrador VitalMind', 'admin@vitalmind.com', '$2b$10$R2MAFTKHWjrgFDadfuyoJOz9wexxBSwN75QAAz/3PHsYhWv/mQQF6', 35, 'Otro', 'active', 'admin', '18 ago 2026', 'Ahora', '#0F766E', 'O+', '5550000001', 75.0, 175.0, NOW()),
    ('Laura Gómez Cuidadora', 'cuidadora@vitalmind.local', '$2b$10$Ir5/p5hYcGOjN9UwgwZft.COOZOymQxFOjkUiyquha/f9okPlzhum', 39, 'Mujer', 'active', 'caregiver', '12 ago 2026', 'Hace 15 min', '#8B5CF6', 'B+', '5550000002', 64.0, 165.0, DATE_SUB(NOW(), INTERVAL 15 MINUTE)),
    ('María López García', 'maria@email.com', '$2b$10$Ir5/p5hYcGOjN9UwgwZft.COOZOymQxFOjkUiyquha/f9okPlzhum', 34, 'Mujer', 'active', 'patient', '10 ago 2026', 'Hace 5 min', '#2563EB', 'A+', '5550000003', 68.5, 163.0, DATE_SUB(NOW(), INTERVAL 5 MINUTE)),
    ('Carlos Ramírez Torres', 'carlos@vitalmind.local', '$2b$10$Ir5/p5hYcGOjN9UwgwZft.COOZOymQxFOjkUiyquha/f9okPlzhum', 42, 'Hombre', 'active', 'patient', '05 ago 2026', 'Hace 20 min', '#D9A441', 'O+', '5550000004', 82.0, 178.0, DATE_SUB(NOW(), INTERVAL 20 MINUTE)),
    ('Sofía Hernández Ruiz', 'sofia@vitalmind.local', '$2b$10$Ir5/p5hYcGOjN9UwgwZft.COOZOymQxFOjkUiyquha/f9okPlzhum', 28, 'Mujer', 'pending', 'patient', '01 ago 2026', 'Hace 1 h', '#E4572E', 'AB+', '5550000005', 59.0, 160.0, DATE_SUB(NOW(), INTERVAL 1 HOUR));

  SELECT id INTO admin_id FROM users WHERE email = 'admin@vitalmind.com';
  SELECT id INTO caregiver_id FROM users WHERE email = 'cuidadora@vitalmind.local';
  SELECT id INTO patient_one FROM users WHERE email = 'maria@email.com';
  SELECT id INTO patient_two FROM users WHERE email = 'carlos@vitalmind.local';
  SELECT id INTO patient_three FROM users WHERE email = 'sofia@vitalmind.local';

  INSERT INTO medications (user_id, name, dose, frequency, time_label, color, taken, days_duration, type)
  VALUES
    (patient_one, 'Metformina', '850 mg', 'Una vez al día', '08:00', '#0F766E', 1, 30, 'pastilla'),
    (patient_one, 'Losartán', '50 mg', 'Una vez al día', '20:00', '#6D5DD3', 0, 30, 'tableta'),
    (patient_one, 'Vitamina D', '1000 UI', 'Una vez al día', '09:00', '#D9A441', 1, 90, 'capsula'),
    (patient_two, 'Paracetamol', '500 mg', 'Cada 8 horas', '12:00', '#E4572E', 0, 7, 'pastilla'),
    (patient_two, 'Omega 3', '1 g', 'Una vez al día', '13:00', '#22C55E', 1, 60, 'capsula'),
    (patient_three, 'Salbutamol', '100 mcg', 'Según necesidad', '18:00', '#2563EB', 0, 30, 'inyeccion');

  WHILE d < p_days DO
    INSERT INTO habit_logs (user_id, log_date, water, exercise, sleep, nutrition, meditation)
    SELECT id, DATE_SUB(CURDATE(), INTERVAL d DAY), 5 + MOD(id + d, 4), 20 + MOD(id * 7 + d, 45), 6 + MOD(id + d, 3) / 2, 2 + MOD(id + d, 3), MOD(id * 3 + d, 20)
    FROM users WHERE role = 'patient';

    INSERT INTO symptom_logs (user_id, log_date, pain, temperature, systolic, diastolic, glucose, weight, heart_rate, stress_level, energy_level, sleep_quality, mood, notes, created_at)
    SELECT id, DATE_SUB(CURDATE(), INTERVAL d DAY), MOD(id + d, 6), 36.4 + MOD(id + d, 4) / 10, 112 + MOD(id * 3 + d, 18), 72 + MOD(id + d, 10), 88 + MOD(id * 5 + d, 35), weight_kg + MOD(d, 5) / 2, 68 + MOD(id * 2 + d, 24), 2 + MOD(id + d, 8), 5 + MOD(id * 3 + d, 6), 5 + MOD(id * 2 + d, 6), ELT(1 + MOD(id + d, 5), 'Muy bien', 'Bien', 'Regular', 'Mal', 'Muy mal'), 'Registro demo para dashboard', DATE_SUB(NOW(), INTERVAL d DAY)
    FROM users WHERE role = 'patient';

    INSERT INTO emotional_logs (user_id, mood, stress_level, energy_level, sleep_quality, notes, log_date)
    SELECT id, ELT(1 + MOD(id + d, 5), 'Muy bien', 'Bien', 'Regular', 'Mal', 'Muy mal'), 2 + MOD(id + d, 8), 5 + MOD(id * 3 + d, 6), 5 + MOD(id * 2 + d, 6), 'Registro emocional demo', DATE_SUB(CURDATE(), INTERVAL d DAY)
    FROM users WHERE role = 'patient';

    INSERT INTO medication_logs (medication_id, user_id, taken_date, taken_time, taken)
    SELECT id, user_id, DATE_SUB(CURDATE(), INTERVAL d DAY), time_label, 1
    FROM medications
    WHERE MOD(id + d, 3) <> 0;

    SET d = d + 1;
  END WHILE;

  INSERT INTO appointments (user_id, specialty, doctor, appointment_date, appointment_time, place, color, status)
  VALUES
    (patient_one, 'Cardiología', 'Dra. Ana Martínez', DATE_ADD(CURDATE(), INTERVAL 7 DAY), '10:30', 'Clínica VitalMind', '#0F766E', 'proxima'),
    (patient_one, 'Nutrición', 'Lic. Laura Pérez', DATE_ADD(CURDATE(), INTERVAL 14 DAY), '12:00', 'Consultorio VitalMind', '#2563EB', 'proxima'),
    (patient_two, 'Medicina general', 'Dr. Carlos Torres', DATE_SUB(CURDATE(), INTERVAL 10 DAY), '09:00', 'Hospital Central', '#D9A441', 'completada'),
    (patient_three, 'Psicología', 'Dra. Sofía Ruiz', DATE_ADD(CURDATE(), INTERVAL 3 DAY), '16:00', 'Centro VitalMind', '#6D5DD3', 'proxima');

  INSERT INTO medical_history_items (user_id, category, description)
  VALUES
    (patient_one, 'allergies', 'Alergia estacional al polen'),
    (patient_one, 'vaccines', 'Refuerzo de vacuna COVID-19'),
    (patient_two, 'diseases', 'Hipertensión arterial controlada'),
    (patient_three, 'consultations', 'Consulta preventiva inicial');

  INSERT INTO notifications (user_id, kind, title, body, time_label, is_read)
  SELECT id, 'tip', 'Consejo del día', 'Mantén una hidratación constante durante el día.', 'Hace 1 h', 0
  FROM users WHERE role = 'patient';

  INSERT INTO notifications (user_id, kind, title, body, time_label, is_read)
  VALUES (NULL, 'alert', 'Mantenimiento programado', 'El servicio estará en mantenimiento esta noche.', 'Ayer', 0);

  INSERT INTO chat_conversations (user_id, title)
  SELECT id, 'Seguimiento de bienestar' FROM users WHERE role = 'patient';

  INSERT INTO chat_messages (conversation_id, role, content)
  SELECT id, 'user', '¿Cómo puedo mejorar mi descanso?'
  FROM chat_conversations;

  INSERT INTO chat_messages (conversation_id, role, content)
  SELECT id, 'assistant', 'Procura mantener horarios regulares y dormir entre 7 y 9 horas.'
  FROM chat_conversations;

  INSERT INTO audit_logs (actor_id, action, entity, entity_id, payload)
  VALUES (admin_id, 'demo.seed', 'dashboard', NULL, JSON_OBJECT('days', p_days, 'patients', 3, 'caregivers', 1));
END$$

DROP PROCEDURE IF EXISTS vm_seed_demo$$
CREATE PROCEDURE vm_seed_demo()
BEGIN
  CALL vm_seed_dashboard(30);
END$$

DELIMITER ;

SET FOREIGN_KEY_CHECKS = 1;

-- Seed inicial opcional. Para generar datos demo o regenerarlos:
--   CALL vm_clean_demo();
--   CALL vm_seed_dashboard(30);
-- CALL vm_seed_dashboard(30);

SELECT 'VitalMind listo: esquema y procedimientos creados' AS message;
SELECT id, full_name, email, role FROM users ORDER BY id;