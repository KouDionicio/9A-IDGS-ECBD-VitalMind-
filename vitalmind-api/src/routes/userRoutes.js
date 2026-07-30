const { Router } = require('express');
const userController = require('../controllers/userController');
const { authenticate } = require('../middleware/authMiddleware');
const { authorize } = require('../middleware/roleMiddleware');
const validateRequest = require('../middleware/validateRequest');
const {
  idParamRule,
  updateProfileRules,
  changePasswordRules,
} = require('../validations/userValidation');

const router = Router();

router.use(authenticate);

// Listado y detalle: solo admin/caregiver pueden ver la lista completa
router.get('/', authorize('admin', 'caregiver'), userController.list);
router.get('/:id', idParamRule, validateRequest, userController.getById);

router.put('/:id', updateProfileRules, validateRequest, userController.updateProfile);
router.patch('/:id', updateProfileRules, validateRequest, userController.updateProfile);

router.post('/me/change-password', changePasswordRules, validateRequest, userController.changePassword);

router.delete('/:id', authorize('admin'), idParamRule, validateRequest, userController.remove);

module.exports = router;
