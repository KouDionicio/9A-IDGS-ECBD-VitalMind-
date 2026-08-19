const mysql = require('mysql2/promise');

async function main() {
  const database = process.argv[2] || 'vitalmind_demo_test';
  const days = Number(process.argv[3] || 10);
  const db = await mysql.createConnection({
    host: '127.0.0.1',
    port: 3307,
    user: 'root',
    password: '1234',
    database,
  });

  await db.query('CALL vm_seed_dashboard(?)', [days]);

  const tables = [
    'users',
    'medications',
    'medication_logs',
    'appointments',
    'habit_logs',
    'symptom_logs',
    'emotional_logs',
    'medical_history_items',
    'notifications',
    'chat_conversations',
    'chat_messages',
    'audit_logs',
  ];

  const counts = {};
  for (const table of tables) {
    const [rows] = await db.query(`SELECT COUNT(1) AS total FROM ${table}`);
    counts[table] = rows[0].total;
  }

  const [roles] = await db.query('SELECT role, COUNT(1) AS total FROM users GROUP BY role');
  console.log(JSON.stringify({ days, counts, roles }, null, 2));
  await db.end();
}

main().catch((error) => {
  console.error(error.message);
  process.exitCode = 1;
});