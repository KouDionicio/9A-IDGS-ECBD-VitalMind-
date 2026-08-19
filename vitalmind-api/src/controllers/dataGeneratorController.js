const asyncHandler = require('../utils/asyncHandler');
const dataGeneratorService = require('../services/dataGeneratorService');

function respond(res, message, data) {
  res.status(201).json({ success: true, message, data });
}

const users = asyncHandler(async (req, res) => {
  const data = await dataGeneratorService.generateUsers(req.body);
  respond(res, 'Usuarios generados correctamente', data);
});

const medications = asyncHandler(async (req, res) => {
  const data = await dataGeneratorService.generateMedications(req.body);
  respond(res, 'Medicamentos generados correctamente', data);
});

const medicationLogs = asyncHandler(async (req, res) => {
  const data = await dataGeneratorService.generateMedicationLogs(req.body);
  respond(res, 'Registros de medicamentos generados correctamente', data);
});

const habits = asyncHandler(async (req, res) => {
  const data = await dataGeneratorService.generateHabits(req.body);
  respond(res, 'Hábitos generados correctamente', data);
});

const symptoms = asyncHandler(async (req, res) => {
  const data = await dataGeneratorService.generateSymptoms(req.body);
  respond(res, 'Síntomas generados correctamente', data);
});

const emotionalLogs = asyncHandler(async (req, res) => {
  const data = await dataGeneratorService.generateEmotionalLogs(req.body);
  respond(res, 'Registros emocionales generados correctamente', data);
});

const appointments = asyncHandler(async (req, res) => {
  const data = await dataGeneratorService.generateAppointments(req.body);
  respond(res, 'Citas generadas correctamente', data);
});

const healthMetrics = asyncHandler(async (req, res) => {
  const data = await dataGeneratorService.generateHealthMetrics(req.body);
  respond(res, 'Métricas de salud generadas correctamente', data);
});

const medicalHistory = asyncHandler(async (req, res) => {
  const data = await dataGeneratorService.generateMedicalHistory(req.body);
  respond(res, 'Antecedentes médicos generados correctamente', data);
});

const notifications = asyncHandler(async (req, res) => {
  const data = await dataGeneratorService.generateNotifications(req.body);
  respond(res, 'Notificaciones generadas correctamente', data);
});

module.exports = {
  users,
  medications,
  medicationLogs,
  habits,
  symptoms,
  emotionalLogs,
  appointments,
  healthMetrics,
  medicalHistory,
  notifications,
};
