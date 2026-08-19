const { Router } = require('express');

const authRoutes = require('./authRoutes');
const userRoutes = require('./userRoutes');
const medicationRoutes = require('./medicationRoutes');
const appointmentRoutes = require('./appointmentRoutes');
const medicalHistoryRoutes = require('./medicalHistoryRoutes');
const habitRoutes = require('./habitRoutes');
const symptomRoutes = require('./symptomRoutes');
const notificationRoutes = require('./notificationRoutes');
const dashboardRoutes = require('./dashboardRoutes');
const reportRoutes = require('./reportRoutes');
const mechanismsRoutes = require('./mechanisms.routes');
const mlRoutes = require('./mlRoutes');
const dataGeneratorRoutes = require('./dataGeneratorRoutes');
const { authenticate } = require('../middleware/authMiddleware');
const { authorize } = require('../middleware/roleMiddleware');

const router = Router();

router.use('/auth', authRoutes);

/**
 * @swagger
 * /health:
 *   get:
 *     tags: [Auth]
 *     summary: Estado de la API
 *     security: []
 *     responses:
 *       200: { description: API operativa }
 */
router.get('/health', (req, res) => {
  res.json({ success: true, message: 'VitalMind API operativa', timestamp: new Date().toISOString() });
});

router.use(authenticate, authorize('admin'));

router.use('/users', userRoutes);
router.use('/medications', medicationRoutes);
router.use('/appointments', appointmentRoutes);
router.use('/medical-history', medicalHistoryRoutes);
router.use('/habits', habitRoutes);
router.use('/symptoms', symptomRoutes);
router.use('/notifications', notificationRoutes);
router.use('/dashboard', dashboardRoutes);
router.use('/reports', reportRoutes);
router.use('/mechanisms', mechanismsRoutes);
router.use('/ml', mlRoutes);
router.use('/data-generator', dataGeneratorRoutes);

module.exports = router;
