const { Router } = require('express');
const medicalHistoryController = require('../controllers/medicalHistoryController');
const { authenticate } = require('../middleware/authMiddleware');
const validateRequest = require('../middleware/validateRequest');
const {
  idParamRule,
  createRules,
  updateRules,
} = require('../validations/medicalHistoryValidation');

const router = Router();
router.use(authenticate);

router.get('/', medicalHistoryController.list);
router.get('/:id', idParamRule, validateRequest, medicalHistoryController.getById);

router.post('/', createRules, validateRequest, medicalHistoryController.create);
router.put('/:id', updateRules, validateRequest, medicalHistoryController.update);
router.delete('/:id', idParamRule, validateRequest, medicalHistoryController.remove);

module.exports = router;
