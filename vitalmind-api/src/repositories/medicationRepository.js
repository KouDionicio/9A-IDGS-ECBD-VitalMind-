const { pool } = require('../config/db');

async function findAll({ userId, type, taken, limit = 100, offset = 0 } = {}) {
  const conditions = [];
  const params = { limit, offset };
  if (userId) { conditions.push('user_id = :userId'); params.userId = userId; }
  if (type) { conditions.push('type = :type'); params.type = type; }
  if (taken !== undefined) { conditions.push('taken = :taken'); params.taken = taken ? 1 : 0; }
  const where = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';
  const [rows] = await pool.query(
    `SELECT * FROM medications ${where} ORDER BY created_at DESC LIMIT :limit OFFSET :offset`,
    params
  );
  const [countRows] = await pool.query(`SELECT COUNT(*) as total FROM medications ${where}`, params);
  return { rows, total: countRows[0].total };
}

async function findById(id) {
  const [rows] = await pool.query('SELECT * FROM medications WHERE id = :id LIMIT 1', { id });
  return rows[0] || null;
}

async function create({ userId, name, dose, frequency, timeLabel, color, type, daysDuration }) {
  const [result] = await pool.query(
    `INSERT INTO medications (user_id, name, dose, frequency, time_label, color, type, days_duration)
     VALUES (:userId, :name, :dose, :frequency, :timeLabel, :color, :type, :daysDuration)`,
    { userId, name, dose, frequency, timeLabel, color: color || '#0F766E', type: type || 'pastilla', daysDuration: daysDuration || 0 }
  );
  return findById(result.insertId);
}

async function update(id, fields) {
  const allowed = ['name', 'dose', 'frequency', 'time_label', 'color', 'type', 'taken', 'days_duration'];
  const setClauses = [];
  const params = { id };
  for (const [key, value] of Object.entries(fields)) {
    if (allowed.includes(key) && value !== undefined) {
      setClauses.push(`${key} = :${key}`);
      params[key] = value;
    }
  }
  if (!setClauses.length) return findById(id);
  await pool.query(`UPDATE medications SET ${setClauses.join(', ')} WHERE id = :id`, params);
  return findById(id);
}

async function remove(id) {
  const [result] = await pool.query('DELETE FROM medications WHERE id = :id', { id });
  return result.affectedRows > 0;
}

async function markTaken(medicationId, userId, taken = true) {
  await pool.query('UPDATE medications SET taken = :taken WHERE id = :id', { id: medicationId, taken: taken ? 1 : 0 });
  const [result] = await pool.query(
    `INSERT INTO medication_logs (medication_id, user_id, taken, taken_at) VALUES (:medicationId, :userId, :taken, NOW())`,
    { medicationId, userId, taken: taken ? 1 : 0 }
  );
  return result.insertId;
}

async function getLogs({ medicationId, userId, limit = 50, offset = 0 } = {}) {
  const conditions = [];
  const params = { limit, offset };
  if (medicationId) { conditions.push('medication_id = :medicationId'); params.medicationId = medicationId; }
  if (userId) { conditions.push('user_id = :userId'); params.userId = userId; }
  const where = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';
  const [rows] = await pool.query(
    `SELECT * FROM medication_logs ${where} ORDER BY taken_at DESC LIMIT :limit OFFSET :offset`,
    params
  );
  return rows;
}

async function countByType() {
  const [rows] = await pool.query('SELECT type, COUNT(*) as total FROM medications GROUP BY type');
  return rows;
}

async function countTakenToday() {
  const [rows] = await pool.query(
    `SELECT COUNT(*) as total FROM medication_logs WHERE DATE(taken_at) = CURDATE() AND taken = 1`
  );
  return rows[0].total;
}

async function takenByDay({ days = 14 } = {}) {
  const [rows] = await pool.query(
    `SELECT DATE(taken_at) as day, COUNT(*) as total, GROUP_CONCAT(id) as log_ids
     FROM medication_logs
     WHERE taken = 1 AND taken_at >= DATE_SUB(CURDATE(), INTERVAL :days DAY)
     GROUP BY DATE(taken_at) ORDER BY day ASC`,
    { days }
  );
  return rows;
}

module.exports = {
  findAll, findById, create, update, remove, markTaken, getLogs,
  countByType, countTakenToday, takenByDay,
};
