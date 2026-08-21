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
END