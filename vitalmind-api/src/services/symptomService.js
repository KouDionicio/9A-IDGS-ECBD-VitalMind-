const ApiError = require('../utils/ApiError');
const symptomLogRepository = require('../repositories/symptomLogRepository');
const auditLogRepository = require('../repositories/auditLogRepository');

async function list({ userId, page = 1, pageSize = 30 } = {}) {
  const limit = Math.min(parseInt(pageSize, 10) || 30, 100);
  const offset = (Math.max(parseInt(page, 10) || 1, 1) - 1) * limit;
  const { rows, total } = await symptomLogRepository.findAll({ userId, limit, offset });
  return {
    items: rows.map(withPriorityScore),
    pagination: { page: Number(page), pageSize: limit, total, totalPages: Math.ceil(total / limit) },
  };
}

async function getById(id) {
  const log = await symptomLogRepository.findById(id);
  if (!log) throw ApiError.notFound('Registro de síntomas no encontrado');
  return withPriorityScore(log);
}

async function create(actorId, data) {
  const log = await symptomLogRepository.create(data);
  await auditLogRepository.log({
    actorId, action: 'symptoms.create', entity: 'symptom_logs', entityId: log.id, payload: data,
  });
  return withPriorityScore(log);
}

/** Traduce nombres camelCase del body a las columnas snake_case reales de la tabla. */
function toDbFields(fields) {
  const map = { heartRate: 'heart_rate', stressLevel: 'stress_level', energyLevel: 'energy_level', sleepQuality: 'sleep_quality' };
  const out = {};
  for (const [key, value] of Object.entries(fields)) {
    if (value === undefined) continue;
    out[map[key] || key] = value;
  }
  return out;
}

async function update(id, actorId, fields) {
  const existing = await symptomLogRepository.findById(id);
  if (!existing) throw ApiError.notFound('Registro de síntomas no encontrado');
  const updated = await symptomLogRepository.update(id, toDbFields(fields));
  await auditLogRepository.log({
    actorId, action: 'symptoms.update', entity: 'symptom_logs', entityId: id, payload: fields,
  });
  return withPriorityScore(updated);
}

async function remove(id, actorId) {
  const existing = await symptomLogRepository.findById(id);
  if (!existing) throw ApiError.notFound('Registro de síntomas no encontrado');
  await symptomLogRepository.remove(id);
  await auditLogRepository.log({
    actorId, action: 'symptoms.delete', entity: 'symptom_logs', entityId: id, payload: {},
  });
}

/**
 * Heurística de "Clasificación preventiva del nivel de prioridad de síntomas"
 * (mecanismo #1 del catálogo). Es un SCORE PONDERADO simple (no un modelo
 * entrenado de árboles de decisión/Random Forest como propone el documento
 * académico), pensado para dar una señal útil en tiempo real desde la API
 * sin requerir un pipeline de entrenamiento en Python.
 *
 * score = w1*dolor_norm + w2*temp_excedente + w3*fc_excedente
 * Umbrales: score < 0.34 -> baja | < 0.67 -> media | >= 0.67 -> alta
 */
function withPriorityScore(log) {
  if (!log) return log;
  const pain = Number(log.pain || 0); // 0-10
  const temp = Number(log.temperature || 36.5);
  const heartRate = Number(log.heart_rate || 72);

  const painNorm = Math.min(pain / 10, 1);
  const tempExcess = Math.max(0, (temp - 37.5) / 3); // >37.5°C empieza a sumar
  const hrExcess = Math.max(0, (heartRate - 100) / 60); // >100bpm empieza a sumar

  const score = Math.min(1, 0.5 * painNorm + 0.3 * Math.min(tempExcess, 1) + 0.2 * Math.min(hrExcess, 1));

  let priority = 'baja';
  if (score >= 0.67) priority = 'alta';
  else if (score >= 0.34) priority = 'media';

  return { ...log, priorityScore: Number(score.toFixed(2)), priorityLevel: priority };
}

async function moodStatistics() {
  return symptomLogRepository.moodStatistics();
}

async function painStatistics({ days = 30 } = {}) {
  return symptomLogRepository.painStatistics({ days });
}

async function glucoseHistory({ userId, days = 30 } = {}) {
  return symptomLogRepository.glucoseHistory({ userId, days });
}

async function bloodPressureHistory({ userId, days = 30 } = {}) {
  return symptomLogRepository.bloodPressureHistory({ userId, days });
}

async function temperatureHistory({ userId, days = 30 } = {}) {
  return symptomLogRepository.temperatureHistory({ userId, days });
}
async function execute(input) {
  const pain = Number(input.pain || 0);
  const temperature = Number(input.temperature || 36.5);
  const heartRate = Number(input.heartRate || 72);

  const painNorm = Math.min(pain / 10, 1);

  const tempExcess = Math.max(
    0,
    (temperature - 37.5) / 3
  );

  const hrExcess = Math.max(
    0,
    (heartRate - 100) / 60
  );

  const score = Math.min(
    1,
    0.5 * painNorm +
    0.3 * Math.min(tempExcess, 1) +
    0.2 * Math.min(hrExcess, 1)
  );

  let priority = 'baja';

  if (score >= 0.67) {
    priority = 'alta';
  } else if (score >= 0.34) {
    priority = 'media';
  }

  return {
    mechanism: 'symptom-priority',
    type: 'supervised',

    input: {
      pain,
      temperature,
      heartRate,
    },

    result: {
      score: Number(score.toFixed(2)),
      priority,
    },
  };
}
module.exports = {
  list, getById, create, update, remove,
  moodStatistics, painStatistics, glucoseHistory, bloodPressureHistory, temperatureHistory,
  execute
};
