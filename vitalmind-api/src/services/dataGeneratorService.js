const bcrypt = require('bcrypt');
const { pool } = require('../config/db');
const ApiError = require('../utils/ApiError');
const {
  COLORS, BLOOD_TYPES, MOODS, SPECIALTIES, DOCTORS, PLACES,
  randomItem, randomInt, randomFloat, randomBool, randomName, randomEmail,
  randomPhone, randomAge, randomMood, addDays, randomTime, randomMedication,
  randomSpecialty, randomDoctor, randomPlace, randomHistory, habitValue, habitGoal,
} = require('../utils/dataGenerator');

const MAX_QUANTITY = 10000;
const BATCH_SIZE = 500;
const VALID_ROLES = ['admin', 'patient', 'caregiver'];
const VALID_STATUSES = ['active', 'inactive', 'pending'];
const VALID_HABITS = ['water', 'exercise', 'sleep', 'nutrition', 'meditation'];
const VALID_MOODS = MOODS;
const VALID_APPOINTMENT_STATUSES = ['proxima', 'completada', 'cancelada'];
const VALID_HISTORY_CATEGORIES = ['diseases', 'allergies', 'medications', 'surgeries', 'consultations', 'vaccines', 'results'];

function asPositiveInt(value, fallback = 1, max = MAX_QUANTITY) {
  const n = Number(value ?? fallback);
  if (!Number.isInteger(n) || n < 1 || n > max) {
    throw ApiError.badRequest(`El valor debe ser un entero entre 1 y ${max}`);
  }
  return n;
}

function validateUserId(userId) {
  if (userId === undefined || userId === null) throw ApiError.badRequest('userId es obligatorio');
  const id = Number(userId);
  if (!Number.isInteger(id) || id < 1) throw ApiError.badRequest('userId debe ser un entero positivo');
  return id;
}

function validateEnum(value, values, field) {
  if (value !== undefined && !values.includes(value)) {
    throw ApiError.badRequest(`${field} inválido. Valores permitidos: ${values.join(', ')}`);
  }
}

function normalizeDate(value, field = 'date') {
  if (!value) return null;
  if (!/^\d{4}-\d{2}-\d{2}$/.test(value)) throw ApiError.badRequest(`${field} debe tener formato YYYY-MM-DD`);
  const date = new Date(`${value}T12:00:00`);
  if (Number.isNaN(date.getTime())) throw ApiError.badRequest(`${field} no es una fecha válida`);
  return value;
}

function getAgeFilter(filters = {}) {
  if (filters.age === undefined) return null;
  if (Number.isInteger(Number(filters.age))) return Number(filters.age);
  if (typeof filters.age === 'object' && filters.age) {
    const min = Number(filters.age.min);
    const max = Number(filters.age.max);
    if (!Number.isInteger(min) || !Number.isInteger(max) || min < 0 || max < min) {
      throw ApiError.badRequest('filters.age debe ser un número o { min, max } válido');
    }
    return { min, max };
  }
  throw ApiError.badRequest('filters.age debe ser un número o un rango');
}

async function getToday(conn) {
  const [rows] = await conn.query('SELECT CURDATE() AS today');
  return rows[0].today;
}

async function assertUser(conn, userId) {
  const [rows] = await conn.query('SELECT id FROM users WHERE id = ? LIMIT 1', [userId]);
  if (!rows.length) throw ApiError.notFound(`El usuario ${userId} no existe`);
}

async function assertUsers(conn, userIds) {
  const uniqueIds = [...new Set(userIds.map(Number))];
  if (!uniqueIds.length) throw ApiError.badRequest('No hay usuarios válidos para generar datos');
  const placeholders = uniqueIds.map(() => '?').join(',');
  const [rows] = await conn.query(`SELECT id FROM users WHERE id IN (${placeholders})`, uniqueIds);
  const existing = new Set(rows.map(row => Number(row.id)));
  const missing = uniqueIds.filter(id => !existing.has(id));
  if (missing.length) throw ApiError.notFound(`Usuarios inexistentes: ${missing.join(', ')}`);
  return uniqueIds;
}

async function getPatientOrAllUserIds(conn, filters = {}) {
  const conditions = [];
  const params = [];
  if (filters.role) { validateEnum(filters.role, VALID_ROLES, 'filters.role'); conditions.push('role = ?'); params.push(filters.role); }
  if (filters.status) { validateEnum(filters.status, VALID_STATUSES, 'filters.status'); conditions.push('status = ?'); params.push(filters.status); }
  const age = getAgeFilter(filters);
  if (typeof age === 'number') { conditions.push('age = ?'); params.push(age); }
  if (age && typeof age === 'object') { conditions.push('age BETWEEN ? AND ?'); params.push(age.min, age.max); }
  const where = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';
  const [rows] = await conn.query(`SELECT id FROM users ${where} ORDER BY id`, params);
  if (!rows.length) throw ApiError.notFound('No existen usuarios que cumplan los filtros indicados');
  return rows.map(row => Number(row.id));
}

async function insertMany(conn, table, columns, rows, options = {}) {
  if (!rows.length) return 0;
  let inserted = 0;
  const columnSql = columns.join(', ');
  for (let start = 0; start < rows.length; start += BATCH_SIZE) {
    const chunk = rows.slice(start, start + BATCH_SIZE);
    const placeholders = chunk.map(() => `(${columns.map(() => '?').join(', ')})`).join(', ');
    const values = chunk.flatMap(row => columns.map(column => row[column]));
    const insertVerb = options.ignoreDuplicates ? 'INSERT IGNORE' : 'INSERT';
    const [result] = await conn.query(`${insertVerb} INTO ${table} (${columnSql}) VALUES ${placeholders}`, values);
    inserted += result.affectedRows;
  }
  return inserted;
}

async function generateUsers(conn, body = {}) {
  const quantity = asPositiveInt(body.quantity, 1);
  const filters = body.filters || {};
  const overrides = body.overrides || {};
  validateEnum(filters.role, VALID_ROLES, 'filters.role');
  validateEnum(filters.status, VALID_STATUSES, 'filters.status');
  const ageFilter = getAgeFilter(filters);

  const passwordHash = await bcrypt.hash(String(body.defaultPassword || 'Test1234!'), 10);
  const rows = [];
  for (let i = 0; i < quantity; i += 1) {
    const fullName = overrides.full_name || randomName();
    const age = ageFilter !== null
      ? (typeof ageFilter === 'number' ? ageFilter : randomInt(ageFilter.min, ageFilter.max))
      : (overrides.age ?? randomAge());
    rows.push({
      full_name: fullName,
      email: overrides.email && quantity === 1 ? overrides.email : randomEmail(fullName, i + 1),
      password_hash: passwordHash,
      age,
      joined_label: overrides.joined_label || 'Generado por API',
      last_active_label: overrides.last_active_label || 'Hace unos segundos',
      status: filters.status || overrides.status || 'active',
      registros: Number(overrides.registros ?? 0),
      consultas: Number(overrides.consultas ?? 0),
      color: overrides.color || randomItem(COLORS),
      role: filters.role || overrides.role || 'patient',
      blood_type: overrides.blood_type || randomItem(BLOOD_TYPES),
      phone: overrides.phone || randomPhone(),
      weight_kg: overrides.weight_kg ?? randomFloat(50, 110, 1),
      height_cm: overrides.height_cm ?? randomFloat(150, 195, 1),
      last_active_at: overrides.last_active_at || new Date(),
    });
  }
  const inserted = await insertMany(conn, 'users', [
    'full_name', 'email', 'password_hash', 'age', 'joined_label', 'last_active_label',
    'status', 'registros', 'consultas', 'color', 'role', 'blood_type', 'phone',
    'weight_kg', 'height_cm', 'last_active_at',
  ], rows);
  return { requested: quantity, inserted, defaultPassword: body.defaultPassword || 'Test1234!' };
}

async function generateMedications(conn, body = {}) {
  const userId = validateUserId(body.userId);
  const quantity = asPositiveInt(body.quantity, 1);
  await assertUser(conn, userId);
  const filters = body.filters || {};
  const overrides = body.overrides || {};
  validateEnum(filters.type, ['pastilla', 'capsula', 'jarabe', 'inyeccion'], 'filters.type');
  const rows = [];
  for (let i = 0; i < quantity; i += 1) {
    const med = randomMedication();
    rows.push({
      user_id: userId,
      name: overrides.name || filters.name || med[0],
      dose: overrides.dose || med[1],
      frequency: overrides.frequency || filters.frequency || med[2],
      time_label: overrides.time_label || med[3],
      color: overrides.color || randomItem(COLORS),
      taken: overrides.taken !== undefined ? Number(overrides.taken) : randomBool(0.5),
      type: filters.type || overrides.type || med[4],
    });
  }
  const inserted = await insertMany(conn, 'medications', [
    'user_id', 'name', 'dose', 'frequency', 'time_label', 'color', 'taken', 'type',
  ], rows);
  return { requested: quantity, inserted, userId };
}

async function generateHabits(conn, body = {}) {
  const userId = validateUserId(body.userId);
  const days = asPositiveInt(body.days, 1, 3650);
  await assertUser(conn, userId);
  const today = await getToday(conn);
  const fromDate = normalizeDate(body.fromDate, 'fromDate') || addDays(today, -(days - 1));
  const habitKeys = body.habitKeys || VALID_HABITS;
  if (!Array.isArray(habitKeys) || !habitKeys.length) throw ApiError.badRequest('habitKeys debe ser un arreglo no vacío');
  habitKeys.forEach(key => validateEnum(key, VALID_HABITS, 'habitKeys'));
  const values = body.values || {};
  const goals = body.goals || {};
  const rows = [];
  for (let day = 0; day < days; day += 1) {
    const date = addDays(fromDate, day);
    for (const habitKey of habitKeys) {
      rows.push({
        user_id: userId,
        habit_key: habitKey,
        log_date: date,
        value: values[habitKey] !== undefined ? Number(values[habitKey]) : habitValue(habitKey),
        goal: goals[habitKey] !== undefined ? Number(goals[habitKey]) : habitGoal(habitKey),
      });
    }
  }
  const inserted = await insertMany(conn, 'habit_logs', ['user_id', 'habit_key', 'log_date', 'value', 'goal'], rows, { ignoreDuplicates: true });
  return { requestedDays: days, requestedRows: rows.length, inserted, userId, fromDate, toDate: addDays(fromDate, days - 1) };
}

async function generateSymptoms(conn, body = {}) {
  const userId = validateUserId(body.userId);
  const days = asPositiveInt(body.days, 1, 3650);
  await assertUser(conn, userId);
  const today = await getToday(conn);
  const fromDate = normalizeDate(body.fromDate, 'fromDate') || addDays(today, -(days - 1));
  const overrides = body.overrides || {};
  const rows = [];
  for (let i = 0; i < days; i += 1) {
    const date = addDays(fromDate, i);
    const pain = overrides.pain !== undefined ? Number(overrides.pain) : randomInt(0, 7);
    rows.push({
      user_id: userId,
      log_date: date,
      pain,
      temperature: overrides.temperature !== undefined ? Number(overrides.temperature) : randomFloat(36.2, 37.8, 1),
      systolic: overrides.systolic !== undefined ? Number(overrides.systolic) : randomInt(105, 135),
      diastolic: overrides.diastolic !== undefined ? Number(overrides.diastolic) : randomInt(65, 88),
      glucose: overrides.glucose !== undefined ? Number(overrides.glucose) : randomInt(75, 125),
      weight: overrides.weight !== undefined ? Number(overrides.weight) : randomFloat(50, 100, 1),
      heart_rate: overrides.heart_rate !== undefined ? Number(overrides.heart_rate) : randomInt(60, 95),
      stress_level: overrides.stress_level !== undefined ? Number(overrides.stress_level) : randomInt(1, 10),
      energy_level: overrides.energy_level !== undefined ? Number(overrides.energy_level) : randomInt(1, 10),
      sleep_quality: overrides.sleep_quality !== undefined ? Number(overrides.sleep_quality) : randomInt(1, 10),
      mood: overrides.mood || randomMood(),
      notes: overrides.notes || 'Registro generado automáticamente para pruebas.',
    });
  }
  validateEnum(overrides.mood, VALID_MOODS, 'overrides.mood');
  const inserted = await insertMany(conn, 'symptom_logs', [
    'user_id', 'log_date', 'pain', 'temperature', 'systolic', 'diastolic', 'glucose', 'weight',
    'heart_rate', 'stress_level', 'energy_level', 'sleep_quality', 'mood', 'notes',
  ], rows, { ignoreDuplicates: true });
  return { requestedDays: days, inserted, userId, fromDate, toDate: addDays(fromDate, days - 1) };
}

async function generateEmotionalLogs(conn, body = {}) {
  const userId = validateUserId(body.userId);
  const days = asPositiveInt(body.days, 1, 3650);
  await assertUser(conn, userId);
  const today = await getToday(conn);
  const fromDate = normalizeDate(body.fromDate, 'fromDate') || addDays(today, -(days - 1));
  const overrides = body.overrides || {};
  validateEnum(overrides.mood, VALID_MOODS, 'overrides.mood');
  const rows = [];
  for (let i = 0; i < days; i += 1) {
    rows.push({
      user_id: userId,
      mood: overrides.mood || randomMood(),
      stress_level: overrides.stress_level !== undefined ? Number(overrides.stress_level) : randomInt(1, 10),
      energy_level: overrides.energy_level !== undefined ? Number(overrides.energy_level) : randomInt(1, 10),
      sleep_quality: overrides.sleep_quality !== undefined ? Number(overrides.sleep_quality) : randomInt(1, 10),
      notes: overrides.notes || 'Registro emocional generado automáticamente para pruebas.',
      log_date: addDays(fromDate, i),
    });
  }
  const inserted = await insertMany(conn, 'emotional_logs', [
    'user_id', 'mood', 'stress_level', 'energy_level', 'sleep_quality', 'notes', 'log_date',
  ], rows, { ignoreDuplicates: true });
  return { requestedDays: days, inserted, userId, fromDate, toDate: addDays(fromDate, days - 1) };
}

async function generateAppointments(conn, body = {}) {
  const quantity = asPositiveInt(body.quantity, 1);
  const filters = body.filters || {};
  const overrides = body.overrides || {};
  validateEnum(filters.status, VALID_APPOINTMENT_STATUSES, 'filters.status');
  let userIds;
  if (body.userId !== undefined) {
    userIds = [validateUserId(body.userId)];
    await assertUser(conn, userIds[0]);
  } else if (Array.isArray(body.userIds) && body.userIds.length) {
    userIds = await assertUsers(conn, body.userIds);
  } else {
    userIds = await getPatientOrAllUserIds(conn, body.userFilters || { role: 'patient' });
  }
  const today = await getToday(conn);
  const rows = [];
  for (let i = 0; i < quantity; i += 1) {
    rows.push({
      user_id: randomItem(userIds),
      specialty: overrides.specialty || filters.specialty || randomSpecialty(),
      doctor: overrides.doctor || randomDoctor(),
      appointment_date: overrides.appointment_date || addDays(today, randomInt(-60, 90)),
      appointment_time: overrides.appointment_time || randomTime(),
      place: overrides.place || randomPlace(),
      color: overrides.color || randomItem(COLORS),
      status: filters.status || overrides.status || randomItem(VALID_APPOINTMENT_STATUSES),
    });
  }
  const inserted = await insertMany(conn, 'appointments', [
    'user_id', 'specialty', 'doctor', 'appointment_date', 'appointment_time', 'place', 'color', 'status',
  ], rows);
  return { requested: quantity, inserted, assignedFromUsers: userIds.length };
}

async function generateHealthMetrics(conn, body = {}) {
  const userId = validateUserId(body.userId);
  const days = asPositiveInt(body.days, 1, 3650);
  await assertUser(conn, userId);
  const today = await getToday(conn);
  const fromDate = normalizeDate(body.fromDate, 'fromDate') || addDays(today, -(days - 1));
  const overrides = body.overrides || {};
  const rows = [];
  for (let i = 0; i < days; i += 1) {
    rows.push({
      user_id: userId,
      metric_date: addDays(fromDate, i),
      water_l: overrides.water_l !== undefined ? Number(overrides.water_l) : randomFloat(0.5, 3.0, 2),
      steps: overrides.steps !== undefined ? Number(overrides.steps) : randomInt(1000, 12000),
      sleep_hours: overrides.sleep_hours !== undefined ? Number(overrides.sleep_hours) : randomFloat(4.5, 9, 2),
      weight_kg: overrides.weight_kg !== undefined ? Number(overrides.weight_kg) : randomFloat(50, 100, 2),
      wellness_score: overrides.wellness_score !== undefined ? Number(overrides.wellness_score) : randomInt(40, 95),
    });
  }
  const inserted = await insertMany(conn, 'health_metrics', [
    'user_id', 'metric_date', 'water_l', 'steps', 'sleep_hours', 'weight_kg', 'wellness_score',
  ], rows, { ignoreDuplicates: true });
  return { requestedDays: days, inserted, userId, fromDate, toDate: addDays(fromDate, days - 1) };
}

async function generateMedicalHistory(conn, body = {}) {
  const userId = validateUserId(body.userId);
  const quantity = asPositiveInt(body.quantity, 1);
  await assertUser(conn, userId);
  const category = body.category || randomItem(VALID_HISTORY_CATEGORIES);
  validateEnum(category, VALID_HISTORY_CATEGORIES, 'category');
  const rows = [];
  for (let i = 0; i < quantity; i += 1) {
    rows.push({
      user_id: userId,
      category,
      description: body.description || randomHistory(category),
    });
  }
  const inserted = await insertMany(conn, 'medical_history_items', ['user_id', 'category', 'description'], rows);
  return { requested: quantity, inserted, userId, category };
}

async function generateNotifications(conn, body = {}) {
  const quantity = asPositiveInt(body.quantity, 1);
  const userId = body.userId !== undefined ? validateUserId(body.userId) : null;
  if (userId) await assertUser(conn, userId);
  const kind = body.kind || randomItem(['tip', 'reminder', 'ai', 'alert']);
  validateEnum(kind, ['tip', 'reminder', 'ai', 'alert'], 'kind');
  const rows = [];
  for (let i = 0; i < quantity; i += 1) {
    rows.push({
      user_id: userId,
      kind,
      title: body.title || randomItem(['Recordatorio', 'Consejo de salud', 'Actualización VitalMind', 'Alerta de seguimiento']),
      body: body.body || 'Notificación generada automáticamente para pruebas.',
      time_label: body.time_label || 'Ahora',
      is_read: body.is_read !== undefined ? Number(body.is_read) : randomBool(0.3),
    });
  }
  const inserted = await insertMany(conn, 'notifications', ['user_id', 'kind', 'title', 'body', 'time_label', 'is_read'], rows);
  return { requested: quantity, inserted, userId };
}

async function generateMedicationLogs(conn, body = {}) {
  const days = asPositiveInt(body.days, 1, 3650);
  let medicationIds;
  if (body.medicationId !== undefined) {
    const medicationId = Number(body.medicationId);
    if (!Number.isInteger(medicationId) || medicationId < 1) throw ApiError.badRequest('medicationId inválido');
    const [rows] = await conn.query('SELECT id, user_id, time_label FROM medications WHERE id = ? LIMIT 1', [medicationId]);
    if (!rows.length) throw ApiError.notFound(`El medicamento ${medicationId} no existe`);
    medicationIds = rows;
  } else {
    const userId = validateUserId(body.userId);
    await assertUser(conn, userId);
    const [rows] = await conn.query('SELECT id, user_id, time_label FROM medications WHERE user_id = ? ORDER BY id', [userId]);
    if (!rows.length) throw ApiError.notFound(`El usuario ${userId} no tiene medicamentos`);
    medicationIds = rows;
  }
  const today = await getToday(conn);
  const rows = [];
  for (const med of medicationIds) {
    for (let i = 0; i < days; i += 1) {
      rows.push({
        medication_id: med.id,
        user_id: med.user_id,
        taken_date: addDays(today, -i),
        taken_time: body.takenTime || (med.time_label && /^\d{2}:\d{2}/.test(med.time_label) ? `${med.time_label}:00` : '08:00:00'),
        taken: body.taken !== undefined ? Number(body.taken) : randomBool(0.85),
      });
    }
  }
  const inserted = await insertMany(conn, 'medication_logs', ['medication_id', 'user_id', 'taken_date', 'taken_time', 'taken'], rows, { ignoreDuplicates: true });
  return { requestedRows: rows.length, inserted, medications: medicationIds.map(m => m.id), days };
}

async function withTransaction(work) {
  const conn = await pool.getConnection();
  try {
    await conn.beginTransaction();
    const result = await work(conn);
    await conn.commit();
    return result;
  } catch (error) {
    await conn.rollback();
    throw error;
  } finally {
    conn.release();
  }
}

module.exports = {
  generateUsers: body => withTransaction(conn => generateUsers(conn, body)),
  generateMedications: body => withTransaction(conn => generateMedications(conn, body)),
  generateHabits: body => withTransaction(conn => generateHabits(conn, body)),
  generateSymptoms: body => withTransaction(conn => generateSymptoms(conn, body)),
  generateEmotionalLogs: body => withTransaction(conn => generateEmotionalLogs(conn, body)),
  generateAppointments: body => withTransaction(conn => generateAppointments(conn, body)),
  generateHealthMetrics: body => withTransaction(conn => generateHealthMetrics(conn, body)),
  generateMedicalHistory: body => withTransaction(conn => generateMedicalHistory(conn, body)),
  generateNotifications: body => withTransaction(conn => generateNotifications(conn, body)),
  generateMedicationLogs: body => withTransaction(conn => generateMedicationLogs(conn, body)),
};
