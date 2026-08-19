const { Router } = require('express');
const controller = require('../controllers/dataGeneratorController');
const { commonRules } = require('../validations/dataGeneratorValidation');
const validateRequest = require('../middleware/validateRequest');

const router = Router();

// Esta ruta se monta después de authenticate + authorize('admin') en routes/index.js.
// Todos los generadores están protegidos para evitar que un paciente pueda crear miles de datos.
router.post('/users', commonRules, validateRequest, controller.users);
router.post('/medications', commonRules, validateRequest, controller.medications);
router.post('/medication-logs', commonRules, validateRequest, controller.medicationLogs);
router.post('/habits', commonRules, validateRequest, controller.habits);
router.post('/symptoms', commonRules, validateRequest, controller.symptoms);
router.post('/emotional-logs', commonRules, validateRequest, controller.emotionalLogs);
router.post('/appointments', commonRules, validateRequest, controller.appointments);
router.post('/health-metrics', commonRules, validateRequest, controller.healthMetrics);
router.post('/medical-history', commonRules, validateRequest, controller.medicalHistory);
router.post('/notifications', commonRules, validateRequest, controller.notifications);

module.exports = router;
