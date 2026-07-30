const mysql = require('mysql2/promise');
const { db } = require('./env');

/**
 * Pool único de conexiones. Se reutiliza en todos los repositories.
 * dateStrings evita que MySQL2 devuelva objetos Date con desfases de
 * zona horaria para columnas DATE (appointment_date, log_date, etc.).
 */
const pool = mysql.createPool({
  host: db.host,
  port: db.port,
  user: db.user,
  password: db.password,
  database: db.database,
  waitForConnections: true,
  connectionLimit: db.connectionLimit,
  queueLimit: 0,
  dateStrings: true,
  namedPlaceholders: true,
});

async function testConnection() {
  const conn = await pool.getConnection();
  try {
    await conn.ping();
    return true;
  } finally {
    conn.release();
  }
}

module.exports = { pool, testConnection };
