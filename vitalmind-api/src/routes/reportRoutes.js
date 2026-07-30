const { Router } = require('express');
const { param } = require('express-validator');
const reportController = require('../controllers/reportController');
const { authenticate } = require('../middleware/authMiddleware');
const { authorize } = require('../middleware/roleMiddleware');
const validateRequest = require('../middleware/validateRequest');

const entityParamRule = [
  param('entity').isIn(['users', 'medications', 'appointments', 'symptoms', 'medicalHistory']),
];

const router = Router();
router.use(authenticate, authorize('admin', 'caregiver'));

router.get('/:entity/csv', entityParamRule, validateRequest, reportController.exportCsv);
router.get('/:entity/excel', entityParamRule, validateRequest, reportController.exportExcel);
router.get('/:entity/pdf', entityParamRule, validateRequest, reportController.exportPdf);

module.exports = router;
