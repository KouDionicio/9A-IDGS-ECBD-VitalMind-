const { Router } = require('express');
const symptomController = require('../controllers/symptomController');
const { authenticate } = require('../middleware/authMiddleware');
const validateRequest = require('../middleware/validateRequest');
const {
  idParamRule,
  createRules,
  updateRules,
} = require('../validations/symptomValidation');

const router = Router();
router.use(authenticate);

router.get('/', symptomController.list);
router.get('/:id', idParamRule, validateRequest, symptomController.getById);

router.post('/', createRules, validateRequest, symptomController.create);
router.put('/:id', updateRules, validateRequest, symptomController.update);
router.delete('/:id', idParamRule, validateRequest, symptomController.remove);

module.exports = router;
