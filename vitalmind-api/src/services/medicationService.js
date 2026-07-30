const ApiError = require('../utils/ApiError');
const medicationRepository = require('../repositories/medicationRepository');
const auditLogRepository = require('../repositories/auditLogRepository');

async function list({ userId, type, taken, page = 1, pageSize = 20 } = {}) {
  const limit = Math.min(parseInt(pageSize, 10) || 20, 100);
  const offset = (Math.max(parseInt(page, 10) || 1, 1) - 1) * limit;
  const { rows, total } = await medicationRepository.findAll({ userId, type, taken, limit, offset });
  return {
    items: rows,
    pagination: { page: Number(page), pageSize: limit, total, totalPages: Math.ceil(total / limit) },
  };
}

async function getById(id) {
  const med = await medicationRepository.findById(id);
  if (!med) throw ApiError.notFound('Medicamento no encontrado');
  return med;
}

async function create(actorId, data) {
  const med = await medicationRepository.create(data);
  await auditLogRepository.log({
    actorId,
    action: 'medications.create',
    entity: 'medications',
    entityId: med.id,
    payload: data,
  });
  return med;
}

/** Traduce nombres camelCase del body a las columnas snake_case reales de la tabla. */
function toDbFields(fields) {
  const map = { timeLabel: 'time_label', daysDuration: 'days_duration' };
  const out = {};
  for (const [key, value] of Object.entries(fields)) {
    if (value === undefined) continue;
    out[map[key] || key] = value;
  }
  return out;
}

async function update(id, actorId, fields) {
  const existing = await medicationRepository.findById(id);
  if (!existing) throw ApiError.notFound('Medicamento no encontrado');
  const updated = await medicationRepository.update(id, toDbFields(fields));
  await auditLogRepository.log({
    actorId,
    action: 'medications.update',
    entity: 'medications',
    entityId: id,
    payload: fields,
  });
  return updated;
}

async function remove(id, actorId) {
  const existing = await medicationRepository.findById(id);
  if (!existing) throw ApiError.notFound('Medicamento no encontrado');
  await medicationRepository.remove(id);
  await auditLogRepository.log({
    actorId,
    action: 'medications.delete',
    entity: 'medications',
    entityId: id,
    payload: {},
  });
}

async function markTaken(id, actorId, userId, taken = true) {
  const existing = await medicationRepository.findById(id);
  if (!existing) throw ApiError.notFound('Medicamento no encontrado');
  const result = await medicationRepository.markTaken(id, userId, taken);
  await auditLogRepository.log({
    actorId,
    action: taken ? 'medications.markTaken' : 'medications.unmarkTaken',
    entity: 'medications',
    entityId: id,
    payload: { taken },
  });
  return result;
}

async function getLogs({ medicationId, userId, page = 1, pageSize = 20 } = {}) {
  const limit = Math.min(parseInt(pageSize, 10) || 20, 100);
  const offset = (Math.max(parseInt(page, 10) || 1, 1) - 1) * limit;
  return medicationRepository.getLogs({ medicationId, userId, limit, offset });
}

module.exports = { list, getById, create, update, remove, markTaken, getLogs };
