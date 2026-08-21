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
END