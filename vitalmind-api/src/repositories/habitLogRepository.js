const { pool } = require('../config/db');

async function findLatestByUser(userId) {
  const [rows] = await pool.query(
    'SELECT * FROM habit_logs WHERE user_id = :userId ORDER BY log_date DESC LIMIT 1',
    { userId }
  );
  return rows[0] || null;
}

async function findByUserAndDate(userId, logDate) {
  const [rows] = await pool.query(
    'SELECT * FROM habit_logs WHERE user_id = :userId AND log_date = :logDate LIMIT 1',
    { userId, logDate }
  );
  return rows[0] || null;
}

async function findRange(userId, fromDate, toDate) {
  const [rows] = await pool.query(
    `SELECT * FROM habit_logs WHERE user_id = :userId AND log_date BETWEEN :fromDate AND :toDate
     ORDER BY log_date ASC`,
    { userId, fromDate, toDate }
  );
  return rows;
}

/** Upsert: crea el registro del día si no existe, o actualiza los campos enviados. */
async function upsert(userId, logDate, fields) {
  const existing = await findByUserAndDate(userId, logDate);
  const allowed = ['water', 'exercise', 'sleep', 'nutrition', 'meditation'];

  if (!existing) {
    const values = { userId, logDate, water: 0, exercise: 0, sleep: 0, nutrition: 0, meditation: 0 };
    for (const key of allowed) {
      if (fields[key] !== undefined) values[key] = fields[key];
    }
    const [result] = await pool.query(
      `INSERT INTO habit_logs (user_id, log_date, water, exercise, sleep, nutrition, meditation)
       VALUES (:userId, :logDate, :water, :exercise, :sleep, :nutrition, :meditation)`,
      values
    );
    return findByUserAndDate(userId, logDate);
  }

  const setClauses = [];
  const params = { userId, logDate };
  for (const key of allowed) {
    if (fields[key] !== undefined) {
      setClauses.push(`${key} = :${key}`);
      params[key] = fields[key];
    }
  }
  if (!setClauses.length) return existing;
  await pool.query(
    `UPDATE habit_logs SET ${setClauses.join(', ')} WHERE user_id = :userId AND log_date = :logDate`,
    params
  );
  return findByUserAndDate(userId, logDate);
}

/** Incrementa un solo hábito (agua, ejercicio, etc.) para el día actual o uno dado. */
async function increment(userId, logDate, habitField, amount = 1) {
  const allowed = ['water', 'exercise', 'sleep', 'nutrition', 'meditation'];
  if (!allowed.includes(habitField)) throw new Error(`Hábito inválido: ${habitField}`);

  const existing = await findByUserAndDate(userId, logDate);
  if (!existing) {
    return upsert(userId, logDate, { [habitField]: amount });
  }
  await pool.query(
    `UPDATE habit_logs SET ${habitField} = ${habitField} + :amount WHERE user_id = :userId AND log_date = :logDate`,
    { amount, userId, logDate }
  );
  return findByUserAndDate(userId, logDate);
}

async function remove(userId, logDate) {
  const [result] = await pool.query(
    'DELETE FROM habit_logs WHERE user_id = :userId AND log_date = :logDate',
    { userId, logDate }
  );
  return result.affectedRows > 0;
}

async function countTotal() {
  const [rows] = await pool.query('SELECT COUNT(*) as total FROM habit_logs');
  return rows[0].total;
}

async function weeklyAverages({ days = 7 } = {}) {
  const [rows] = await pool.query(
    `SELECT log_date, AVG(water) as water, AVG(exercise) as exercise, AVG(sleep) as sleep,
            AVG(nutrition) as nutrition, AVG(meditation) as meditation, GROUP_CONCAT(id) as log_ids
     FROM habit_logs
     WHERE log_date >= DATE_SUB(CURDATE(), INTERVAL :days DAY)
     GROUP BY log_date ORDER BY log_date ASC`,
    { days }
  );
  return rows;
}

module.exports = {
  findByUserAndDate, findRange, upsert, increment, remove, countTotal, weeklyAverages, findLatestByUser,
};
