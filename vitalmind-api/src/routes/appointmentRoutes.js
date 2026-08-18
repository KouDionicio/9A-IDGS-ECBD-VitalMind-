const { Router } = require('express');
const appointmentController = require('../controllers/appointmentController');
const { authenticate } = require('../middleware/authMiddleware');
const validateRequest = require('../middleware/validateRequest');
const {
  idParamRule,
  createRules,
  updateRules,
  listQueryRules,
} = require('../validations/appointmentValidation');

const router = Router();
router.use(authenticate);

router.get('/', listQueryRules, validateRequest, appointmentController.list);
router.get('/:id', idParamRule, validateRequest, appointmentController.getById);

router.post('/', createRules, validateRequest, appointmentController.create);
router.put('/:id', updateRules, validateRequest, appointmentController.update);
router.delete('/:id', idParamRule, validateRequest, appointmentController.remove);

module.exports = router;
