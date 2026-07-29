const { pool } = require('../config/db');

async function findAll({ userId, isRead, kind, limit = 50, offset = 0 } = {}) {
  const conditions = [];
  const params = { limit, offset };
  // Las notificaciones con user_id NULL son globales y se muestran a todos
  if (userId) { conditions.push('(user_id = :userId OR user_id IS NULL)'); params.userId = userId; }
  if (isRead !== undefined) { conditions.push('is_read = :isRead'); params.isRead = isRead ? 1 : 0; }
  if (kind) { conditions.push('kind = :kind'); params.kind = kind; }
  const where = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';
  const [rows] = await pool.query(
    `SELECT * FROM notifications ${where} ORDER BY created_at DESC LIMIT :limit OFFSET :offset`,
    params
  );
  const [countRows] = await pool.query(`SELECT COUNT(*) as total FROM notifications ${where}`, params);
  return { rows, total: countRows[0].total };
}

async function findById(id) {
  const [rows] = await pool.query('SELECT * FROM notifications WHERE id = :id LIMIT 1', { id });
  return rows[0] || null;
}

async function create({ userId, kind, title, body, timeLabel }) {
  const [result] = await pool.query(
    `INSERT INTO notifications (user_id, kind, title, body, time_label)
     VALUES (:userId, :kind, :title, :body, :timeLabel)`,
    { userId: userId ?? null, kind: kind || 'tip', title, body, timeLabel: timeLabel || 'Ahora' }
  );
  return findById(result.insertId);
}

async function markRead(id) {
  await pool.query('UPDATE notifications SET is_read = 1 WHERE id = :id', { id });
  return findById(id);
}

async function remove(id) {
  const [result] = await pool.query('DELETE FROM notifications WHERE id = :id', { id });
  return result.affectedRows > 0;
}

async function countUnread(userId) {
  const params = {};
  let userFilter = '';
  if (userId) { userFilter = 'AND (user_id = :userId OR user_id IS NULL)'; params.userId = userId; }
  const [rows] = await pool.query(
    `SELECT COUNT(*) as total FROM notifications WHERE is_read = 0 ${userFilter}`,
    params
  );
  return rows[0].total;
}

async function countTotal() {
  const [rows] = await pool.query('SELECT COUNT(*) as total FROM notifications');
  return rows[0].total;
}

module.exports = { findAll, findById, create, markRead, remove, countUnread, countTotal };
