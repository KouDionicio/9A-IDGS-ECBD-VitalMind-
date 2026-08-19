const { pool } = require('../config/db');
const userRepository = require('../repositories/userRepository');
const medicationRepository = require('../repositories/medicationRepository');
const appointmentRepository = require('../repositories/appointmentRepository');
const symptomLogRepository = require('../repositories/symptomLogRepository');
const habitLogRepository = require('../repositories/habitLogRepository');
const medicalHistoryRepository = require('../repositories/medicalHistoryRepository');
const notificationRepository = require('../repositories/notificationRepository');

/** KPIs agregados para las tarjetas de estadísticas del dashboard. */
async function statistics() {
  const [
    usersByStatus,
    activeMedications,
    takenToday,
    upcomingAppointments,
    habitsTotal,
    symptomsTotal,
    medicalHistoryTotal,
    notificationsTotal,
  ] = await Promise.all([
    userRepository.countByStatus(),
    pool.query('SELECT COUNT(*) as total FROM medications').then(([r]) => r[0].total),
    medicationRepository.countTakenToday(),
    appointmentRepository.countUpcoming(),
    habitLogRepository.countTotal(),
    symptomLogRepository.countTotal(),
    medicalHistoryRepository.countTotal(),
    notificationRepository.countTotal(),
  ]);

  const totalUsers = usersByStatus.reduce((sum, r) => sum + Number(r.total), 0);
  const activeUsers = Number(usersByStatus.find((r) => r.status === 'active')?.total || 0);

  return {
    totalUsers,
    activeUsers,
    activeMedications: Number(activeMedications),
    medicationsTakenToday: Number(takenToday),
    upcomingAppointments: Number(upcomingAppointments),
    symptomsRegistered: Number(symptomsTotal),
    medicalHistoryRecords: Number(medicalHistoryTotal),
    notifications: Number(notificationsTotal),
    habitsRegistered: Number(habitsTotal),
  };
}

async function usersByRole() {
  return userRepository.countByRole();
}

async function usersByStatus() {
  return userRepository.countByStatus();
}

async function usersByAge() {
  return userRepository.countByAgeGroup();
}

async function usersByGender() {
  return userRepository.countByGender();
}

async function medicationsByType() {
  return medicationRepository.countByType();
}

async function medicationsTakenByDay({ days = 14 } = {}) {
  return medicationRepository.takenByDay({ days });
}

async function appointmentsBySpecialty() {
  return appointmentRepository.countBySpecialty();
}

async function appointmentsStatus() {
  return appointmentRepository.countByStatus();
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

/** Devuelve las 5 series de hábitos (agua, ejercicio, sueño, nutrición, meditación) por día. */
async function habitWeeklyAverages({ days = 7 } = {}) {
  return habitLogRepository.weeklyAverages({ days });
}

async function waterConsumption({ days = 7 } = {}) {
  const rows = await habitLogRepository.weeklyAverages({ days });
  return rows.map((r) => ({ date: r.log_date, water: Number(r.water) }));
}

async function sleepHistory({ days = 7 } = {}) {
  const rows = await habitLogRepository.weeklyAverages({ days });
  return rows.map((r) => ({ date: r.log_date, sleep: Number(r.sleep) }));
}

async function physicalActivity({ days = 7 } = {}) {
  const rows = await habitLogRepository.weeklyAverages({ days });
  return rows.map((r) => ({ date: r.log_date, exercise: Number(r.exercise) }));
}
async function usersByRole({ role, status } = {}) {
  return userRepository.countByRole({ role, status });
}

async function usersByStatus({ role } = {}) {
  return userRepository.countByStatus({ role });
}

async function usersByAge({ role, status } = {}) {
  return userRepository.countByAgeGroup({ role, status });
}

async function usersByGender({ role, status } = {}) {
  return userRepository.countByGender({ role, status });
}

async function appointmentsBySpecialty({
  status,
  fromDate,
  toDate,
  userId,
} = {}) {
  return appointmentRepository.countBySpecialty({
    status,
    fromDate,
    toDate,
    userId,
  });
}

async function appointmentsStatus({
  fromDate,
  toDate,
  specialty,
  userId,
} = {}) {
  return appointmentRepository.countByStatus({
    fromDate,
    toDate,
    specialty,
    userId,
  });
}

async function appointmentsByDoctor({
  status,
  specialty,
  fromDate,
  toDate,
  userId,
} = {}) {
  return appointmentRepository.countByDoctor({
    status,
    specialty,
    fromDate,
    toDate,
    userId,
  });
}

async function appointmentsByPlace({
  status,
  specialty,
  fromDate,
  toDate,
  userId,
} = {}) {
  return appointmentRepository.countByPlace({
    status,
    specialty,
    fromDate,
    toDate,
    userId,
  });
}

module.exports = {
  statistics,
  usersByRole,
  usersByStatus,
  usersByAge,
  usersByGender,
  medicationsByType,
  medicationsTakenByDay,
  appointmentsBySpecialty,
  appointmentsStatus,
  moodStatistics,
  painStatistics,
  glucoseHistory,
  bloodPressureHistory,
  temperatureHistory,
  habitWeeklyAverages,
  waterConsumption,
  sleepHistory,
  physicalActivity,
  appointmentsByDoctor,
  appointmentsByPlace,
};
