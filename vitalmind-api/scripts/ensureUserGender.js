const mysql = require('mysql2/promise');
const { db } = require('../src/config/env');

async function ensureUserGender() {
  const connection = await mysql.createConnection({
    host: db.host,
    port: db.port,
    user: db.user,
    password: db.password,
    database: db.database,
  });

  try {
    const [columns] = await connection.query(
      `SELECT COUNT(*) AS total
       FROM information_schema.COLUMNS
       WHERE TABLE_SCHEMA = DATABASE()
         AND TABLE_NAME = 'users'
         AND COLUMN_NAME = 'gender'`,
    );

    if (!columns[0].total) {
      await connection.query(
        "ALTER TABLE users ADD COLUMN gender VARCHAR(20) NULL AFTER age",
      );
      console.log('Columna users.gender agregada.');
    } else {
      console.log('Columna users.gender ya existe.');
    }
  } finally {
    await connection.end();
  }
}

ensureUserGender().catch((error) => {
  console.error('No se pudo actualizar users.gender:', error.message);
  process.exitCode = 1;
});