const { Router } = require('express');
const habitController = require('../controllers/habitController');
const { authenticate } = require('../middleware/authMiddleware');
const validateRequest = require('../middleware/validateRequest');
const {
  dateParamRule,
  upsertRules,
  incrementRules,
} = require('../validations/habitValidation');

const router = Router();
router.use(authenticate);

router.get('/', habitController.getRange);
router.get('/:date', dateParamRule, validateRequest, habitController.getByDate);

router.post('/', upsertRules, validateRequest, habitController.upsert);
router.post('/increment', incrementRules, validateRequest, habitController.increment);

router.delete('/:date', dateParamRule, validateRequest, habitController.remove);

module.exports = router;
