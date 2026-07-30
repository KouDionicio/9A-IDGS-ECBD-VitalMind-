const { Router } = require('express');
const notificationController = require('../controllers/notificationController');
const { authenticate } = require('../middleware/authMiddleware');
const { authorize } = require('../middleware/roleMiddleware');
const validateRequest = require('../middleware/validateRequest');
const { idParamRule, createRules } = require('../validations/notificationValidation');

const router = Router();
router.use(authenticate);

router.get('/', notificationController.list);
router.get('/unread-count', notificationController.countUnread);

router.post('/', authorize('admin'), createRules, validateRequest, notificationController.create);
router.patch('/:id/read', idParamRule, validateRequest, notificationController.markRead);
router.delete('/:id', idParamRule, validateRequest, notificationController.remove);

module.exports = router;
