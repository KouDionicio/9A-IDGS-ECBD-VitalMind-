const ApiError = require('../utils/ApiError');
const medicalHistoryRepository = require('../repositories/medicalHistoryRepository');
const auditLogRepository = require('../repositories/auditLogRepository');

async function list({ userId, category, page = 1, pageSize = 50 } = {}) {
  const limit = Math.min(parseInt(pageSize, 10) || 50, 200);
  const offset = (Math.max(parseInt(page, 10) || 1, 1) - 1) * limit;
  const { rows, total } = await medicalHistoryRepository.findAll({ userId, category, limit, offset });
  return {
    items: rows,
    pagination: { page: Number(page), pageSize: limit, total, totalPages: Math.ceil(total / limit) },
  };
}

async function getById(id) {
  const item = await medicalHistoryRepository.findById(id);
  if (!item) throw ApiError.notFound('Registro de historial médico no encontrado');
  return item;
}

async function create(actorId, data) {
  const item = await medicalHistoryRepository.create(data);
  await auditLogRepository.log({
    actorId, action: 'medical_history.create', entity: 'medical_history_items', entityId: item.id, payload: data,
  });
  return item;
}

async function update(id, actorId, fields) {
  const existing = await medicalHistoryRepository.findById(id);
  if (!existing) throw ApiError.notFound('Registro de historial médico no encontrado');
  const updated = await medicalHistoryRepository.update(id, fields);
  await auditLogRepository.log({
    actorId, action: 'medical_history.update', entity: 'medical_history_items', entityId: id, payload: fields,
  });
  return updated;
}

async function remove(id, actorId) {
  const existing = await medicalHistoryRepository.findById(id);
  if (!existing) throw ApiError.notFound('Registro de historial médico no encontrado');
  await medicalHistoryRepository.remove(id);
  await auditLogRepository.log({
    actorId, action: 'medical_history.delete', entity: 'medical_history_items', entityId: id, payload: {},
  });
}

module.exports = { list, getById, create, update, remove };
