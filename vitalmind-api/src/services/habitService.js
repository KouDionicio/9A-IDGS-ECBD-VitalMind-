const ApiError = require('../utils/ApiError');
const habitLogRepository = require('../repositories/habitLogRepository');
const auditLogRepository = require('../repositories/auditLogRepository');

const VALID_HABITS = ['water', 'exercise', 'sleep', 'nutrition', 'meditation'];

async function getRange(userId, fromDate, toDate) {
  return habitLogRepository.findRange(userId, fromDate, toDate);
}

async function getByDate(userId, logDate) {
  const log = await habitLogRepository.findByUserAndDate(userId, logDate);
  if (!log) throw ApiError.notFound('No hay registro de hábitos para esa fecha');
  return log;
}

async function upsert(userId, actorId, logDate, fields) {
  const invalidKeys = Object.keys(fields).filter((k) => !VALID_HABITS.includes(k));
  if (invalidKeys.length) {
    throw ApiError.badRequest(`Hábitos inválidos: ${invalidKeys.join(', ')}`);
  }
  const result = await habitLogRepository.upsert(userId, logDate, fields);
  await auditLogRepository.log({
    actorId, action: 'habits.upsert', entity: 'habit_logs', entityId: `${userId}:${logDate}`, payload: fields,
  });
  return result;
}

async function increment(userId, actorId, logDate, habitField, amount = 1) {
  if (!VALID_HABITS.includes(habitField)) {
    throw ApiError.badRequest(`Hábito inválido: ${habitField}. Use uno de: ${VALID_HABITS.join(', ')}`);
  }
  const result = await habitLogRepository.increment(userId, logDate, habitField, amount);
  await auditLogRepository.log({
    actorId, action: 'habits.increment', entity: 'habit_logs', entityId: habitField, payload: { date: logDate, value: amount },
  });
  return result;
}

async function remove(userId, actorId, logDate) {
  await habitLogRepository.remove(userId, logDate);
  await auditLogRepository.log({
    actorId, action: 'habits.delete', entity: 'habit_logs', entityId: `${userId}:${logDate}`, payload: {},
  });
}

module.exports = { getRange, getByDate, upsert, increment, remove, VALID_HABITS };
