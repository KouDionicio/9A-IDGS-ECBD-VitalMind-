const { pool } = require('../config/db');

/**
 * Los refresh tokens se guardan como hash (nunca el token real) para que,
 * si la tabla se filtra, no se puedan reutilizar directamente.
 */

async function store({ userId, tokenHash, expiresAt }) {
  await pool.query(
    `INSERT INTO refresh_tokens (user_id, token_hash, expires_at)
     VALUES (:userId, :tokenHash, :expiresAt)`,
    { userId, tokenHash, expiresAt }
  );
}

async function findValidByHash(tokenHash) {
  const [rows] = await pool.query(
    `SELECT * FROM refresh_tokens
     WHERE token_hash = :tokenHash AND expires_at > NOW()
     LIMIT 1`,
    { tokenHash }
  );
  return rows[0] || null;
}

async function deleteByHash(tokenHash) {
  await pool.query('DELETE FROM refresh_tokens WHERE token_hash = :tokenHash', {
    tokenHash,
  });
}

async function deleteAllForUser(userId) {
  await pool.query('DELETE FROM refresh_tokens WHERE user_id = :userId', { userId });
}

async function deleteExpired() {
  await pool.query('DELETE FROM refresh_tokens WHERE expires_at <= NOW()');
}

module.exports = {
  store,
  findValidByHash,
  deleteByHash,
  deleteAllForUser,
  deleteExpired,
};
