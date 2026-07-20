import mysql from "mysql2/promise";
import { env } from "./env.js";
import { seedInitialData } from "../seeds/seedInitialData.js";

let mysqlPool = null;

export async function connectDatabases() {
  if (!mysqlPool) {
    const adminConnection = await mysql.createConnection({
      host: env.MYSQL_HOST,
      port: env.MYSQL_PORT,
      user: env.MYSQL_USER,
      password: env.MYSQL_PASSWORD,
      connectTimeout: env.MYSQL_CONNECT_TIMEOUT_MS,
    });

    await adminConnection.query(`CREATE DATABASE IF NOT EXISTS \`${env.MYSQL_DATABASE}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci`);
    await adminConnection.end();

    mysqlPool = mysql.createPool({
      host: env.MYSQL_HOST,
      port: env.MYSQL_PORT,
      user: env.MYSQL_USER,
      password: env.MYSQL_PASSWORD,
      database: env.MYSQL_DATABASE,
      waitForConnections: true,
      connectionLimit: 10,
      namedPlaceholders: true,
      decimalNumbers: true,
      connectTimeout: env.MYSQL_CONNECT_TIMEOUT_MS,
    });

    await mysqlPool.query("SELECT 1");
    await mysqlPool.query(`
      CREATE TABLE IF NOT EXISTS users (
        id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
        full_name VARCHAR(120) NOT NULL,
        email VARCHAR(160) NOT NULL UNIQUE,
        password_hash VARCHAR(255) NOT NULL,
        age INT NOT NULL DEFAULT 0,
        joined_label VARCHAR(40) NULL,
        last_active_label VARCHAR(40) NULL,
        status ENUM('active','inactive','pending') NOT NULL DEFAULT 'pending',
        registros INT NOT NULL DEFAULT 0,
        consultas INT NOT NULL DEFAULT 0,
        color VARCHAR(20) NOT NULL DEFAULT '#0F766E',
        role ENUM('admin','patient','caregiver') NOT NULL DEFAULT 'patient',
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (id)
      )
    `);
    await mysqlPool.query(`
      CREATE TABLE IF NOT EXISTS medications (
        id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
        user_id BIGINT UNSIGNED NULL,
        name VARCHAR(120) NOT NULL,
        dose VARCHAR(80) NOT NULL,
        frequency VARCHAR(80) NOT NULL,
        time_label VARCHAR(80) NOT NULL,
        color VARCHAR(20) NOT NULL DEFAULT '#0F766E',
        taken TINYINT(1) NOT NULL DEFAULT 0,
        type ENUM('pastilla','capsula','jarabe','inyeccion') NOT NULL DEFAULT 'pastilla',
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
        CONSTRAINT fk_medications_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
      )
    `);
    await mysqlPool.query(`
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
        CONSTRAINT fk_appointments_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
      )
    `);
    await mysqlPool.query(`
      CREATE TABLE IF NOT EXISTS refresh_tokens (
        id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
        user_id BIGINT UNSIGNED NOT NULL,
        token_hash VARCHAR(255) NOT NULL,
        expires_at TIMESTAMP NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
        CONSTRAINT fk_refresh_tokens_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
      )
    `);
    await mysqlPool.query(`
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
        CONSTRAINT fk_notifications_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
      )
    `);
    await mysqlPool.query(`
      CREATE TABLE IF NOT EXISTS audit_logs (
        id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
        actor_id BIGINT UNSIGNED NULL,
        action VARCHAR(120) NOT NULL,
        entity VARCHAR(120) NOT NULL,
        entity_id VARCHAR(120) NULL,
        payload LONGTEXT NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
        CONSTRAINT fk_audit_logs_actor FOREIGN KEY (actor_id) REFERENCES users(id) ON DELETE SET NULL
      )
    `);
  }

  await seedInitialData();
}

export function getMySqlPool() {
  if (!mysqlPool) {
    throw new Error("MySQL pool is not initialized");
  }
  return mysqlPool;
}

export function getDatabaseStatus() {
  return { mysql: { connected: Boolean(mysqlPool) } };
}
