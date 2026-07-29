const { pool } = require('../config/db');

const VALID_CATEGORIES = ['diseases', 'allergies', 'medications', 'surgeries', 'consultations', 'vaccines', 'results'];

async function findAll({ userId, category, limit = 100, offset = 0 } = {}) {
  const conditions = [];
  const params = { limit, offset };
  if (userId) { conditions.push('user_id = :userId'); params.userId = userId; }
  if (category) { conditions.push('category = :category'); params.category = category; }
  const where = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';
  const [rows] = await pool.query(
    `SELECT * FROM medical_history_items ${where} ORDER BY created_at DESC LIMIT :limit OFFSET :offset`,
    params
  );
  const [countRows] = await pool.query(`SELECT COUNT(*) as total FROM medical_history_items ${where}`, params);
  return { rows, total: countRows[0].total };
}

async function findById(id) {
  const [rows] = await pool.query('SELECT * FROM medical_history_items WHERE id = :id LIMIT 1', { id });
  return rows[0] || null;
}

async function create({ userId, category, description }) {
  const [result] = await pool.query(
    `INSERT INTO medical_history_items (user_id, category, description) VALUES (:userId, :category, :description)`,
    { userId, category, description }
  );
  return findById(result.insertId);
}

async function update(id, fields) {
  const allowed = ['category', 'description'];
  const setClauses = [];
  const params = { id };
  for (const [key, value] of Object.entries(fields)) {
    if (allowed.includes(key) && value !== undefined) {
      setClauses.push(`${key} = :${key}`);
      params[key] = value;
    }
  }
  if (!setClauses.length) return findById(id);
  await pool.query(`UPDATE medical_history_items SET ${setClauses.join(', ')} WHERE id = :id`, params);
  return findById(id);
}

async function remove(id) {
  const [result] = await pool.query('DELETE FROM medical_history_items WHERE id = :id', { id });
  return result.affectedRows > 0;
}

async function countTotal() {
  const [rows] = await pool.query('SELECT COUNT(*) as total FROM medical_history_items');
  return rows[0].total;
}

module.exports = { VALID_CATEGORIES, findAll, findById, create, update, remove, countTotal };
