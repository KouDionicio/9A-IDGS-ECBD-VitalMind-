const fs = require('node:fs/promises');
const path = require('node:path');
const mysql = require('mysql2/promise');
const { db } = require('../src/config/env');

function splitSql(sql) {
  const statements = [];
  let delimiter = ';';
  let buffer = '';

  for (const line of sql.split(/\r?\n/)) {
    const delimiterMatch = line.trim().match(/^DELIMITER\s+(.+)$/i);
    if (delimiterMatch) {
      delimiter = delimiterMatch[1].trim();
      continue;
    }

    buffer += `${line}\n`;
    if (buffer.trimEnd().endsWith(delimiter)) {
      statements.push(buffer.trimEnd().slice(0, -delimiter.length).trim());
      buffer = '';
    }
  }

  if (buffer.trim()) statements.push(buffer.trim());
  return statements.filter((statement) => statement && !statement.startsWith('--'));
}

async function main() {
  const fileName = process.argv[2] || 'database/vitalmind_setup_demo.sql';
  const targetDatabase = process.argv[3] || db.database;
  const filePath = path.resolve(process.cwd(), fileName);
  let sql = await fs.readFile(filePath, 'utf8');
  sql = sql.replace(/(CREATE DATABASE IF NOT EXISTS|USE)\s+vitalmind\b/gi, `$1 ${targetDatabase}`);

  const connection = await mysql.createConnection({
    host: db.host,
    port: db.port,
    user: db.user,
    password: db.password,
    multipleStatements: false,
  });

  try {
    await connection.query(
      `CREATE DATABASE IF NOT EXISTS \`${targetDatabase}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci`,
    );

    for (const statement of splitSql(sql)) {
      await connection.query(statement);
    }
    console.log(`SQL ejecutado correctamente: ${fileName} -> ${targetDatabase}`);
  } finally {
    await connection.end();
  }
}

main().catch((error) => {
  console.error(`No se pudo ejecutar el SQL: ${error.message}`);
  process.exitCode = 1;
});