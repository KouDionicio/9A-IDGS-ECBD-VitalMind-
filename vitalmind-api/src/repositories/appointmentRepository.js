const { pool } = require('../config/db');

async function findAll({ userId, status, specialty, fromDate, toDate, limit = 100, offset = 0 } = {}) {
  const conditions = [];
  const params = { limit, offset };
  if (userId) { conditions.push('user_id = :userId'); params.userId = userId; }
  if (status) { conditions.push('status = :status'); params.status = status; }
  if (specialty) { conditions.push('specialty = :specialty'); params.specialty = specialty; }
  if (fromDate) { conditions.push('appointment_date >= :fromDate'); params.fromDate = fromDate; }
  if (toDate) { conditions.push('appointment_date <= :toDate'); params.toDate = toDate; }
  const where = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';
  const [rows] = await pool.query(
    `SELECT * FROM appointments ${where} ORDER BY appointment_date DESC LIMIT :limit OFFSET :offset`,
    params
  );
  const [countRows] = await pool.query(`SELECT COUNT(*) as total FROM appointments ${where}`, params);
  return { rows, total: countRows[0].total };
}

async function findById(id) {
  const [rows] = await pool.query('SELECT * FROM appointments WHERE id = :id LIMIT 1', { id });
  return rows[0] || null;
}

async function create({ userId, specialty, doctor, appointmentDate, appointmentTime, place, color }) {
  const [result] = await pool.query(
    `INSERT INTO appointments (user_id, specialty, doctor, appointment_date, appointment_time, place, color, status)
     VALUES (:userId, :specialty, :doctor, :appointmentDate, :appointmentTime, :place, :color, 'proxima')`,
    { userId, specialty, doctor, appointmentDate, appointmentTime, place, color: color || '#0F766E' }
  );
  return findById(result.insertId);
}

async function update(id, fields) {
  const allowed = ['specialty', 'doctor', 'appointment_date', 'appointment_time', 'place', 'color', 'status'];
  const setClauses = [];
  const params = { id };
  for (const [key, value] of Object.entries(fields)) {
    if (allowed.includes(key) && value !== undefined) {
      setClauses.push(`${key} = :${key}`);
      params[key] = value;
    }
  }
  if (!setClauses.length) return findById(id);
  await pool.query(`UPDATE appointments SET ${setClauses.join(', ')} WHERE id = :id`, params);
  return findById(id);
}

async function remove(id) {
  const [result] = await pool.query('DELETE FROM appointments WHERE id = :id', { id });
  return result.affectedRows > 0;
}

async function countUpcoming() {
  const [rows] = await pool.query(
    `SELECT COUNT(*) as total FROM appointments WHERE status = 'proxima' AND appointment_date >= CURDATE()`
  );
  return rows[0].total;
}

async function countByStatus() {
  const [rows] = await pool.query('SELECT status, COUNT(*) as total FROM appointments GROUP BY status');
  return rows;
}

async function countBySpecialty() {
  const [rows] = await pool.query('SELECT specialty, COUNT(*) as total FROM appointments GROUP BY specialty ORDER BY total DESC');
  return rows;
}

module.exports = { findAll, findById, create, update, remove, countUpcoming, countByStatus, countBySpecialty };
