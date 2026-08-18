const ApiError = require('../utils/ApiError');
const appointmentRepository = require('../repositories/appointmentRepository');
const auditLogRepository = require('../repositories/auditLogRepository');

async function list({ userId, status, specialty, fromDate, toDate, page = 1, pageSize = 20 } = {}) {
  const limit = Math.min(parseInt(pageSize, 10) || 20, 100);
  const offset = (Math.max(parseInt(page, 10) || 1, 1) - 1) * limit;
  const { rows, total } = await appointmentRepository.findAll({
    userId, status, specialty, fromDate, toDate, limit, offset,
  });
  return {
    items: rows,
    pagination: { page: Number(page), pageSize: limit, total, totalPages: Math.ceil(total / limit) },
  };
}

async function getById(id) {
  const appt = await appointmentRepository.findById(id);
  if (!appt) throw ApiError.notFound('Cita no encontrada');
  return appt;
}

async function create(actorId, data) {
  const appt = await appointmentRepository.create(data);
  await auditLogRepository.log({
    actorId, action: 'appointments.create', entity: 'appointments', entityId: appt.id, payload: data,
  });
  return appt;
}

/** Traduce nombres camelCase del body a las columnas snake_case reales de la tabla. */
function toDbFields(fields) {
  const map = { appointmentDate: 'appointment_date', appointmentTime: 'appointment_time' };
  const out = {};
  for (const [key, value] of Object.entries(fields)) {
    if (value === undefined) continue;
    out[map[key] || key] = value;
  }
  return out;
}

async function update(id, actorId, fields) {
  const existing = await appointmentRepository.findById(id);
  if (!existing) throw ApiError.notFound('Cita no encontrada');
  const updated = await appointmentRepository.update(id, toDbFields(fields));
  await auditLogRepository.log({
    actorId, action: 'appointments.update', entity: 'appointments', entityId: id, payload: fields,
  });
  return updated;
}

async function remove(id, actorId) {
  const existing = await appointmentRepository.findById(id);
  if (!existing) throw ApiError.notFound('Cita no encontrada');
  await appointmentRepository.remove(id);
  await auditLogRepository.log({
    actorId, action: 'appointments.delete', entity: 'appointments', entityId: id, payload: {},
  });
}

module.exports = { list, getById, create, update, remove };
