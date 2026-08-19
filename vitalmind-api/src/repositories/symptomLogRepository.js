const { pool } = require('../config/db');

async function findAll({ userId, limit = 100, offset = 0 } = {}) {
  const conditions = [];
  const params = { limit, offset };
  if (userId) { conditions.push('user_id = :userId'); params.userId = userId; }
  const where = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';
  const [rows] = await pool.query(
    `SELECT * FROM symptom_logs ${where} ORDER BY created_at DESC LIMIT :limit OFFSET :offset`,
    params
  );
  const [countRows] = await pool.query(`SELECT COUNT(*) as total FROM symptom_logs ${where}`, params);
  return { rows, total: countRows[0].total };
}

async function findById(id) {
  const [rows] = await pool.query('SELECT * FROM symptom_logs WHERE id = :id LIMIT 1', { id });
  return rows[0] || null;
}

async function create(fields) {
  const {
    userId, pain = 0, temperature, systolic, diastolic, glucose, weight, heartRate, mood, notes,
    stressLevel, energyLevel, sleepQuality,
  } = fields;
  const [result] = await pool.query(
    `INSERT INTO symptom_logs
      (user_id, pain, temperature, systolic, diastolic, glucose, weight, heart_rate, stress_level, energy_level, sleep_quality, mood, notes)
     VALUES (:userId, :pain, :temperature, :systolic, :diastolic, :glucose, :weight, :heartRate, :stressLevel, :energyLevel, :sleepQuality, :mood, :notes)`,
    {
      userId, pain,
      temperature: temperature ?? null, systolic: systolic ?? null, diastolic: diastolic ?? null,
      glucose: glucose ?? null, weight: weight ?? null, heartRate: heartRate ?? null,
      stressLevel: stressLevel ?? null, energyLevel: energyLevel ?? null, sleepQuality: sleepQuality ?? null,
      mood: mood ?? null, notes: notes ?? null,
    }
  );
  return findById(result.insertId);
}

async function update(id, fields) {
  const allowed = ['pain', 'temperature', 'systolic', 'diastolic', 'glucose', 'weight', 'heart_rate', 'stress_level', 'energy_level', 'sleep_quality', 'mood', 'notes'];
  const setClauses = [];
  const params = { id };
  for (const [key, value] of Object.entries(fields)) {
    if (allowed.includes(key) && value !== undefined) {
      setClauses.push(`${key} = :${key}`);
      params[key] = value;
    }
  }
  if (!setClauses.length) return findById(id);
  await pool.query(`UPDATE symptom_logs SET ${setClauses.join(', ')} WHERE id = :id`, params);
  return findById(id);
}

async function findLatestByUser(
  userId
) {
  const [rows] = await pool.query(
    `
    SELECT *
    FROM symptom_logs
    WHERE user_id = :userId
    ORDER BY log_date DESC, id DESC
    LIMIT 1
    `,
    {
      userId,
    }
  );

  return rows[0] || null;
}

async function remove(id) {
  const [result] = await pool.query('DELETE FROM symptom_logs WHERE id = :id', { id });
  return result.affectedRows > 0;
}

async function countTotal() {
  const [rows] = await pool.query('SELECT COUNT(*) as total FROM symptom_logs');
  return rows[0].total;
}

async function moodStatistics() {
  const [rows] = await pool.query(
    `SELECT mood, COUNT(*) as total FROM symptom_logs WHERE mood IS NOT NULL GROUP BY mood`
  );
  return rows;
}

async function painStatistics({ days = 30 } = {}) {
  const [rows] = await pool.query(
    `SELECT DATE(created_at) as day, AVG(pain) as avg_pain, MAX(pain) as max_pain, GROUP_CONCAT(id) as record_ids
     FROM symptom_logs
     WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL :days DAY)
     GROUP BY DATE(created_at) ORDER BY day ASC`,
    { days }
  );
  return rows;
}

async function glucoseHistory({ userId, days = 30 } = {}) {
  const params = { days };
  let userFilter = '';
  if (userId) { userFilter = 'AND user_id = :userId'; params.userId = userId; }
  const [rows] = await pool.query(
    `SELECT id, user_id, created_at, glucose FROM symptom_logs
     WHERE glucose IS NOT NULL ${userFilter} AND created_at >= DATE_SUB(CURDATE(), INTERVAL :days DAY)
     ORDER BY created_at ASC`,
    params
  );
  return rows;
}

async function bloodPressureHistory({ userId, days = 30 } = {}) {
  const params = { days };
  let userFilter = '';
  if (userId) { userFilter = 'AND user_id = :userId'; params.userId = userId; }
  const [rows] = await pool.query(
    `SELECT id, user_id, created_at, systolic, diastolic FROM symptom_logs
     WHERE systolic IS NOT NULL ${userFilter} AND created_at >= DATE_SUB(CURDATE(), INTERVAL :days DAY)
     ORDER BY created_at ASC`,
    params
  );
  return rows;
}

async function temperatureHistory({ userId, days = 30 } = {}) {
  const params = { days };
  let userFilter = '';
  if (userId) { userFilter = 'AND user_id = :userId'; params.userId = userId; }
  const [rows] = await pool.query(
    `SELECT id, user_id, created_at, temperature FROM symptom_logs
     WHERE temperature IS NOT NULL ${userFilter} AND created_at >= DATE_SUB(CURDATE(), INTERVAL :days DAY)
     ORDER BY created_at ASC`,
    params
  );
  return rows;
}

async function findByUserAndDate(
  userId,
  logDate
) {
  const [rows] = await pool.query(
    `
    SELECT *
    FROM symptom_logs
    WHERE user_id = :userId
      AND log_date = :logDate
    ORDER BY id DESC
    LIMIT 1
    `,
    {
      userId,
      logDate,
    }
  );

  return rows[0] || null;
}


async function findClosestByUserAndDate(
  userId,
  logDate
) {
  const [rows] = await pool.query(
    `
    SELECT *
    FROM symptom_logs
    WHERE user_id = :userId
    ORDER BY
      ABS(DATEDIFF(log_date, :logDate)) ASC,
      log_date DESC,
      id DESC
    LIMIT 1
    `,
    {
      userId,
      logDate,
    }
  );

  return rows[0] || null;
}



module.exports = {
  findAll, findById, create, update, remove, countTotal, findLatestByUser, findByUserAndDate, findClosestByUserAndDate,
  moodStatistics, painStatistics, glucoseHistory, bloodPressureHistory, temperatureHistory,
};

