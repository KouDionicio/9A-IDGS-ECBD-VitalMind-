-- Migración: columnas requeridas por el "Contrato de integración del microservicio ML"
-- (sección 6 y 9.1: stress_level, energy_level y sleep_quality son campos indispensables).
-- Es una migración ADITIVA: no borra ni renombra nada existente, todas las columnas
-- nuevas son NULL-ables, así que no rompe datos ni queries actuales.

ALTER TABLE symptom_logs
  ADD COLUMN stress_level TINYINT UNSIGNED NULL COMMENT 'Escala 1-10, requerido por el contrato ML' AFTER heart_rate,
  ADD COLUMN energy_level TINYINT UNSIGNED NULL COMMENT 'Escala 1-10, requerido por el contrato ML' AFTER stress_level,
  ADD COLUMN sleep_quality TINYINT UNSIGNED NULL COMMENT 'Escala 1-10, requerido por el contrato ML' AFTER energy_level;
