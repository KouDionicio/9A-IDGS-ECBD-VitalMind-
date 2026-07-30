const asyncHandler = require('../utils/asyncHandler');
const dashboardService = require('../dashboard/dashboardService');

const statistics = asyncHandler(async (req, res) => {
  const data = await dashboardService.statistics();
  res.json({ success: true, data });
});

const usersByRole = asyncHandler(async (req, res) => {
  res.json({ success: true, data: await dashboardService.usersByRole() });
});

const usersByStatus = asyncHandler(async (req, res) => {
  res.json({ success: true, data: await dashboardService.usersByStatus() });
});

const usersByAge = asyncHandler(async (req, res) => {
  res.json({ success: true, data: await dashboardService.usersByAge() });
});

const usersByGender = asyncHandler(async (req, res) => {
  res.json({ success: true, data: await dashboardService.usersByGender() });
});

const medicationsByType = asyncHandler(async (req, res) => {
  res.json({ success: true, data: await dashboardService.medicationsByType() });
});

const medicationsTakenByDay = asyncHandler(async (req, res) => {
  const days = req.query.days ? parseInt(req.query.days, 10) : 14;
  res.json({ success: true, data: await dashboardService.medicationsTakenByDay({ days }) });
});

const appointmentsBySpecialty = asyncHandler(async (req, res) => {
  res.json({ success: true, data: await dashboardService.appointmentsBySpecialty() });
});

const appointmentsStatus = asyncHandler(async (req, res) => {
  res.json({ success: true, data: await dashboardService.appointmentsStatus() });
});

const moodStatistics = asyncHandler(async (req, res) => {
  res.json({ success: true, data: await dashboardService.moodStatistics() });
});

const painStatistics = asyncHandler(async (req, res) => {
  const days = req.query.days ? parseInt(req.query.days, 10) : 30;
  res.json({ success: true, data: await dashboardService.painStatistics({ days }) });
});

const glucoseHistory = asyncHandler(async (req, res) => {
  const days = req.query.days ? parseInt(req.query.days, 10) : 30;
  const userId = req.user.role === 'admin' ? req.query.userId : req.user.id;
  res.json({ success: true, data: await dashboardService.glucoseHistory({ userId, days }) });
});

const bloodPressure = asyncHandler(async (req, res) => {
  const days = req.query.days ? parseInt(req.query.days, 10) : 30;
  const userId = req.user.role === 'admin' ? req.query.userId : req.user.id;
  res.json({ success: true, data: await dashboardService.bloodPressureHistory({ userId, days }) });
});

const temperatureHistory = asyncHandler(async (req, res) => {
  const days = req.query.days ? parseInt(req.query.days, 10) : 30;
  const userId = req.user.role === 'admin' ? req.query.userId : req.user.id;
  res.json({ success: true, data: await dashboardService.temperatureHistory({ userId, days }) });
});

const waterConsumption = asyncHandler(async (req, res) => {
  const days = req.query.days ? parseInt(req.query.days, 10) : 7;
  res.json({ success: true, data: await dashboardService.waterConsumption({ days }) });
});

const sleepHistory = asyncHandler(async (req, res) => {
  const days = req.query.days ? parseInt(req.query.days, 10) : 7;
  res.json({ success: true, data: await dashboardService.sleepHistory({ days }) });
});

const physicalActivity = asyncHandler(async (req, res) => {
  const days = req.query.days ? parseInt(req.query.days, 10) : 7;
  res.json({ success: true, data: await dashboardService.physicalActivity({ days }) });
});

const habitWeeklyAverages = asyncHandler(async (req, res) => {
  const days = req.query.days ? parseInt(req.query.days, 10) : 7;
  res.json({ success: true, data: await dashboardService.habitWeeklyAverages({ days }) });
});

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
  bloodPressure,
  temperatureHistory,
  waterConsumption,
  sleepHistory,
  physicalActivity,
  habitWeeklyAverages,
};
