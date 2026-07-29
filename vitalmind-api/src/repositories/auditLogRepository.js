const { pool } = require('../config/db');

/**
 * Registra una acción de auditoría. Se usa desde los services de cada módulo
 * (auth.login, medications.create, habits.increment, etc.) igual que ya
 * lo hacía tu proyecto original según los datos existentes en el dump.
 */
async function log({ actorId = null, action, entity, entityId = null, payload = {} }) {
  await pool.query(
    `INSERT INTO audit_logs (actor_id, action, entity, entity_id, payload)
     VALUES (:actorId, :action, :entity, :entityId, :payload)`,
    {
      actorId,
      action,
      entity,
      entityId: entityId !== null ? String(entityId) : null,
      payload: JSON.stringify(payload),
    }
  );
}

async function findAll({ limit = 50, offset = 0, actorId, entity } = {}) {
  const conditions = [];
  const params = { limit, offset };

  if (actorId) {
    conditions.push('actor_id = :actorId');
    params.actorId = actorId;
  }
  if (entity) {
    conditions.push('entity = :entity');
    params.entity = entity;
  }

  const whereClause = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';

  const [rows] = await pool.query(
    `SELECT * FROM audit_logs ${whereClause}
     ORDER BY created_at DESC LIMIT :limit OFFSET :offset`,
    params
  );
  return rows;
}

module.exports = { log, findAll };
