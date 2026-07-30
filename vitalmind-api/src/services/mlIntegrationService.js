const ApiError = require('../utils/ApiError');
const { mlService } = require('../config/env');
const userRepository = require('../repositories/userRepository');
const habitLogRepository = require('../repositories/habitLogRepository');
const symptomLogRepository = require('../repositories/symptomLogRepository');
const auditLogRepository = require('../repositories/auditLogRepository');

/** Genera un request_id único y trazable: REQ-YYYYMMDD-XXXXXX */
function generateRequestId() {
  const date = new Date().toISOString().slice(0, 10).replace(/-/g, '');
  const suffix = Math.random().toString(36).slice(2, 8).toUpperCase();
  return `REQ-${date}-${suffix}`;
}

/**
 * Normaliza el mood almacenado en DB ('Muy bien', 'Bien', ...) al formato
 * que exige el contrato (sección 7): español, minúsculas, sin espacios extra.
 */
function normalizeMood(dbMood) {
  if (!dbMood) return null;
  return String(dbMood).trim().toLowerCase();
}

/**
 * Reúne datos de `users`, `habit_logs` (registro más reciente) y
 * `symptom_logs` (registro más reciente) para construir el objeto
 * `features` exigido por el contrato (sección 4/6). Esta es responsabilidad
 * exclusiva del Backend principal según la sección 18.2 del contrato — el
 * microservicio ML nunca consulta la base de datos directamente.
 */
async function buildFeatures(userId) {
  const [user, latestHabit, latestSymptom] = await Promise.all([
    userRepository.findById(userId),
    habitLogRepository.findLatestByUser(userId),
    symptomLogRepository.findLatestByUser(userId),
  ]);

  if (!user) throw ApiError.notFound('Usuario no encontrado');

  return {
    age: user.age ?? null,
    height_cm: user.height_cm !== undefined ? Number(user.height_cm) : null,
    weight_kg: user.weight_kg !== undefined ? Number(user.weight_kg) : null,
    water_glasses: latestHabit ? Number(latestHabit.water) : null,
    exercise_minutes: latestHabit ? Number(latestHabit.exercise) : null,
    sleep_hours: latestHabit ? Number(latestHabit.sleep) : null,
    healthy_meals_count: latestHabit ? Number(latestHabit.nutrition) : null,
    meditation_minutes: latestHabit ? Number(latestHabit.meditation) : null,
    pain: latestSymptom ? Number(latestSymptom.pain) : null,
    temperature_c: latestSymptom?.temperature !== undefined && latestSymptom?.temperature !== null
      ? Number(latestSymptom.temperature) : null,
    systolic_mmhg: latestSymptom?.systolic ?? null,
    diastolic_mmhg: latestSymptom?.diastolic ?? null,
    glucose_mg_dl: latestSymptom?.glucose ?? null,
    heart_rate_bpm: latestSymptom?.heart_rate ?? null,
    mood: latestSymptom ? normalizeMood(latestSymptom.mood) : null,
    stress_level: latestSymptom?.stress_level ?? null,
    energy_level: latestSymptom?.energy_level ?? null,
    sleep_quality: latestSymptom?.sleep_quality ?? null,
  };
}

/**
 * Llama al microservicio ML (POST {ML_SERVICE_URL}/api/v1/analyze) con
 * timeout y traduce sus respuestas de error (422/500) a ApiError, sin
 * exponer detalles internos del microservicio (sección 14 del contrato).
 */
async function callMlService(payload) {
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), mlService.timeoutMs);

  let response;
  try {
    response = await fetch(`${mlService.baseUrl}/api/v1/analyze`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload),
      signal: controller.signal,
    });
  } catch (err) {
    if (err.name === 'AbortError') {
      throw ApiError.internal('El microservicio ML no respondió a tiempo (timeout)');
    }
    throw ApiError.internal('No fue posible conectar con el microservicio ML');
  } finally {
    clearTimeout(timeout);
  }

  const body = await response.json().catch(() => ({}));

  if (response.status === 422) {
    // Reenvía el mismo missing_data_report que exige el contrato (sección 13)
    throw ApiError.badRequest(
      body.message || 'Faltan campos indispensables para ejecutar la inferencia',
      body.missing_data_report || null
    );
  }

  if (!response.ok) {
    throw ApiError.internal(body.message || 'No fue posible ejecutar la inferencia en el microservicio ML');
  }

  return body;
}

/**
 * Orquesta el flujo completo: arma el request_id/features desde la BD,
 * llama al microservicio, y registra un resumen en audit_logs.
 */
async function analyze(userId, actorId, { analysisDate } = {}) {
  const requestId = generateRequestId();
  const features = await buildFeatures(userId);

  const payload = {
    request_id: requestId,
    user_id: String(userId),
    analysis_date: analysisDate || new Date().toISOString().slice(0, 10),
    features,
  };

  const result = await callMlService(payload);

  await auditLogRepository.log({
    actorId,
    action: 'ml.analyze',
    entity: 'symptom_logs',
    entityId: userId,
    payload: {
      request_id: requestId,
      risk_level: result?.results?.risk_classification?.risk_level,
      wellbeing_score: result?.results?.wellbeing?.score,
      model_versions: result?.model_versions,
    },
  });

  return result;
}

async function health() {
  try {
    const res = await fetch(`${mlService.baseUrl}/health`, { signal: AbortSignal.timeout(3000) });
    if (!res.ok) return { status: 'unreachable' };
    return res.json();
  } catch {
    return { status: 'unreachable' };
  }
}

async function modelsInfo() {
  const res = await fetch(`${mlService.baseUrl}/api/v1/models/info`, { signal: AbortSignal.timeout(3000) });
  if (!res.ok) throw ApiError.internal('No fue posible obtener la información de los modelos');
  return res.json();
}

module.exports = { analyze, buildFeatures, health, modelsInfo };
