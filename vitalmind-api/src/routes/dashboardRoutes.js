const { Router } = require('express');
const dashboardController = require('../controllers/dashboardController');
const { authenticate } = require('../middleware/authMiddleware');

const router = Router();
router.use(authenticate);

router.get('/statistics', dashboardController.statistics);
router.get('/users-by-role', dashboardController.usersByRole);
router.get('/users-by-status', dashboardController.usersByStatus);
router.get('/users-by-age', dashboardController.usersByAge);
router.get('/users-by-gender', dashboardController.usersByGender);
router.get('/medications-by-type', dashboardController.medicationsByType);
router.get('/medications-taken-by-day', dashboardController.medicationsTakenByDay);
router.get('/appointments-by-specialty', dashboardController.appointmentsBySpecialty);
router.get('/appointments-status', dashboardController.appointmentsStatus);
router.get('/mood-statistics', dashboardController.moodStatistics);
router.get('/pain-statistics', dashboardController.painStatistics);
router.get('/glucose-history', dashboardController.glucoseHistory);
router.get('/blood-pressure', dashboardController.bloodPressure);
router.get('/temperature-history', dashboardController.temperatureHistory);
router.get('/water-consumption', dashboardController.waterConsumption);
router.get('/sleep-history', dashboardController.sleepHistory);
router.get('/physical-activity', dashboardController.physicalActivity);
router.get('/habits-weekly', dashboardController.habitWeeklyAverages);

module.exports = router;
