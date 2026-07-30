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
const mechanismsRoutes = require('./mechanismsRoutes');
const mlRoutes = require('./mlRoutes');

const router = Router();

router.use('/auth', authRoutes);
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

router.get('/health', (req, res) => {
  res.json({ success: true, message: 'VitalMind API operativa', timestamp: new Date().toISOString() });
});

module.exports = router;
