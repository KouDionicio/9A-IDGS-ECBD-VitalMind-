const ApiError = require('../utils/ApiError');
const { mlService } = require('../config/env');
const userRepository = require('../repositories/userRepository');
const habitLogRepository = require('../repositories/habitLogRepository');
const symptomLogRepository = require('../repositories/symptomLogRepository');
const auditLogRepository = require('../repositories/auditLogRepository');
const emotionalLogRepository = require(
  '../repositories/emotionalLogRepository'
);
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
async function buildFeatures(
  userId,
  analysisDate
) {
  const user = await userRepository.findById(
    userId
  );

  if (!user) {
    throw ApiError.notFound(
      'Usuario no encontrado'
    );
  }

  const targetDate =
    analysisDate
    || new Date()
      .toISOString()
      .slice(0, 10);

  let habit = await (
    habitLogRepository
      .findByUserAndDate(
        userId,
        targetDate
      )
  );

  if (!habit) {
    habit = await (
      habitLogRepository
        .findClosestByUserAndDate(
          userId,
          targetDate
        )
    );
  }

  let symptom = await (
    symptomLogRepository
      .findByUserAndDate(
        userId,
        targetDate
      )
  );

  if (!symptom) {
    symptom = await (
      symptomLogRepository
        .findClosestByUserAndDate(
          userId,
          targetDate
        )
    );
  }

  let emotional = await (
    emotionalLogRepository
      .findByUserAndDate(
        userId,
        targetDate
      )
  );

  if (!emotional) {
    emotional = await (
      emotionalLogRepository
        .findClosestByUserAndDate(
          userId,
          targetDate
        )
    );
  }

  const historicalWeight =
    symptom?.weight !== undefined
    && symptom?.weight !== null
      ? Number(symptom.weight)
      : null;

  const profileWeight =
    user.weight_kg !== undefined
    && user.weight_kg !== null
      ? Number(user.weight_kg)
      : null;

  return {
    age:
      user.age ?? null,

    height_cm:
      user.height_cm !== undefined
      && user.height_cm !== null
        ? Number(user.height_cm)
        : null,

    weight_kg:
      historicalWeight
      ?? profileWeight,

    water_glasses:
      habit?.water !== undefined
      && habit?.water !== null
        ? Number(habit.water)
        : null,

    exercise_minutes:
      habit?.exercise !== undefined
      && habit?.exercise !== null
        ? Number(habit.exercise)
        : null,

    sleep_hours:
      habit?.sleep !== undefined
      && habit?.sleep !== null
        ? Number(habit.sleep)
        : null,

    healthy_meals_count:
      habit?.nutrition !== undefined
      && habit?.nutrition !== null
        ? Number(habit.nutrition)
        : null,

    meditation_minutes:
      habit?.meditation !== undefined
      && habit?.meditation !== null
        ? Number(habit.meditation)
        : null,

    pain:
      symptom?.pain !== undefined
      && symptom?.pain !== null
        ? Number(symptom.pain)
        : null,

    temperature_c:
      symptom?.temperature !== undefined
      && symptom?.temperature !== null
        ? Number(symptom.temperature)
        : null,

    systolic_mmhg:
      symptom?.systolic !== undefined
      && symptom?.systolic !== null
        ? Number(symptom.systolic)
        : null,

    diastolic_mmhg:
      symptom?.diastolic !== undefined
      && symptom?.diastolic !== null
        ? Number(symptom.diastolic)
        : null,

    glucose_mg_dl:
      symptom?.glucose !== undefined
      && symptom?.glucose !== null
        ? Number(symptom.glucose)
        : null,

    heart_rate_bpm:
      symptom?.heart_rate !== undefined
      && symptom?.heart_rate !== null
        ? Number(symptom.heart_rate)
        : null,

    mood:
      emotional
        ? normalizeMood(
            emotional.mood
          )
        : null,

    stress_level:
      emotional?.stress_level !== undefined &&
      emotional?.stress_level !== null
        ? Number(emotional.stress_level)
        : null,

    energy_level:
      emotional?.energy_level !== undefined &&
      emotional?.energy_level !== null
        ? Number(emotional.energy_level)
        : null,

    sleep_quality:
      emotional?.sleep_quality !== undefined &&
      emotional?.sleep_quality !== null
        ? Number(emotional.sleep_quality)
        : null,
  };
}

/**
 * Llama al microservicio ML (POST {ML_SERVICE_URL}/api/v1/analyze) con
 * timeout y traduce sus respuestas de error (422/500) a ApiError, sin
 * exponer detalles internos del microservicio (sección 14 del contrato).
 */


async function callMlService(payload) {
  const controller = new AbortController();

  const timeout = setTimeout(
    () => controller.abort(),
    mlService.timeoutMs
  );

  let response;

  try {
    response = await fetch(
      `${mlService.baseUrl}/api/v1/analyze`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload),
        signal: controller.signal,
      }
    );
  } catch (err) {
    if (err.name === 'AbortError') {
      throw ApiError.internal(
        'El servicio ML no respondió a tiempo'
      );
    }

    throw ApiError.internal(
      'No fue posible conectar con el servicio ML'
    );
  } finally {
    clearTimeout(timeout);
  }

  const body = await response
    .json()
    .catch(() => ({}));

  if (response.status === 422) {
    const missingDataReport =
      body.missing_data_report ||
      body.detail?.missing_data_report ||
      {
        required_missing: [],
        imputed_fields: [],
        warnings: [],
      };

    const error = ApiError.badRequest(
      body.message ||
      body.detail?.message ||
      'La solicitud contiene datos faltantes, inválidos o fuera de los rangos permitidos.'
    );

    error.details = missingDataReport;

    throw error;
  }

  if (response.status === 503) {
    throw ApiError.internal(
      body?.detail?.message ||
      'El servicio ML no está disponible temporalmente'
    );
  }

  if (!response.ok) {
    throw ApiError.internal(
      body.message ||
      body.detail?.message ||
      'No fue posible completar el análisis ML'
    );
  }

  return body;
}


async function callMlChatAnalyze(payload) {
  const controller = new AbortController();

  const timeout = setTimeout(
    () => controller.abort(),
    mlService.timeoutMs
  );

  let response;

  try {
    response = await fetch(
      `${mlService.baseUrl}/api/v1/chat/analyze`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload),
        signal: controller.signal,
      }
    );
  } catch (err) {
    if (err.name === 'AbortError') {
      throw ApiError.internal(
        'El análisis conversacional no respondió a tiempo'
      );
    }

    throw ApiError.internal(
      'No fue posible conectar con el servicio de análisis conversacional'
    );
  } finally {
    clearTimeout(timeout);
  }

  const body = await response
    .json()
    .catch(() => ({}));

  if (response.status === 422) {
    throw ApiError.badRequest(
      body.message ||
      body.detail ||
      'Los datos enviados al análisis conversacional son inválidos'
    );
  }

  if (response.status === 503) {
    throw ApiError.internal(
      body?.detail?.message ||
      'El chatbot no está disponible temporalmente'
    );
  }

  if (!response.ok) {
    throw ApiError.internal(
      body.message ||
      'No fue posible completar el análisis conversacional'
    );
  }

  return body;
}

/**
 * Orquesta el flujo completo: arma el request_id/features desde la BD,
 * llama al microservicio, y registra un resumen en audit_logs.
 */
async function analyze(userId, actorId, { analysisDate } = {}) {
  const requestId = generateRequestId();
  const targetDate =
    analysisDate
    || new Date()
      .toISOString()
      .slice(0, 10);

  const features = await buildFeatures(
    userId,
    targetDate
  );

  const payload = {
    request_id: requestId,
    user_id: String(userId),
    analysis_date: targetDate,
    features,
  };
  console.log(
  '\n========== PAYLOAD ENVIADO A ML =========='
);

console.log(
  JSON.stringify(
    payload,
    null,
    2
  )
);

console.log(
  '==========================================\n'
);


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
  try {
    const res = await fetch(`${mlService.baseUrl}/api/v1/models/info`, { signal: AbortSignal.timeout(3000) });
    if (!res.ok) {
      throw new Error(`ML respondió con HTTP ${res.status}`);
    }
    return res.json();
  } catch {
    throw new ApiError(503, 'El servicio de modelos ML no está disponible');
  }
}

async function chat({
  userId,
  analysisDate,
  message,
  context,
}) {
  if (!message || !message.trim()) {
    throw ApiError.badRequest(
      'El mensaje del chatbot es obligatorio'
    );
  }

  const requestId = generateRequestId();

  const targetDate =
    analysisDate ||
    new Date().toISOString().slice(0, 10);

  const payload = {
    request_id: requestId,
    user_id: String(userId),
    analysis_date: targetDate,
    message: message.trim(),
    context,
  };

  const result = await callMlChat(payload);

  return result;
}
async function chatAnalyze({
  userId,
  analysisDate,
  message,
}) {
  if (!message || !message.trim()) {
    throw ApiError.badRequest(
      'El mensaje del chatbot es obligatorio'
    );
  }

  const requestId = generateRequestId();

  const targetDate =
    analysisDate ||
    new Date().toISOString().slice(0, 10);

  const features = await buildFeatures(
    userId,
    targetDate
  );

  const payload = {
    request_id: requestId,
    user_id: String(userId),
    analysis_date: targetDate,
    message: message.trim(),
    features,
  };

  console.log(
    '\n========== PAYLOAD CHAT + ML =========='
  );

  console.log(
    JSON.stringify(
      payload,
      null,
      2
    )
  );

  console.log(
    '=======================================\n'
  );

  const result = await callMlChatAnalyze(
    payload
  );

  return result;
}
module.exports = {chat, chatAnalyze, analyze, buildFeatures, health, modelsInfo };
