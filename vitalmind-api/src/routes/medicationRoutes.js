const { Router } = require('express');
const medicationController = require('../controllers/medicationController');
const { authenticate } = require('../middleware/authMiddleware');
const validateRequest = require('../middleware/validateRequest');
const {
  idParamRule,
  createRules,
  updateRules,
  markTakenRules,
} = require('../validations/medicationValidation');

const router = Router();
router.use(authenticate);

router.get('/', medicationController.list);
router.get('/:id', idParamRule, validateRequest, medicationController.getById);
router.get('/:id/logs', idParamRule, validateRequest, medicationController.getLogs);

router.post('/', createRules, validateRequest, medicationController.create);
router.put('/:id', updateRules, validateRequest, medicationController.update);
router.patch('/:id/taken', markTakenRules, validateRequest, medicationController.markTaken);

router.delete('/:id', idParamRule, validateRequest, medicationController.remove);

module.exports = router;
