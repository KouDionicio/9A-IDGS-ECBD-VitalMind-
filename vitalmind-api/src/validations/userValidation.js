const { body, param } = require('express-validator');

const idParamRule = [param('id').isInt({ min: 1 }).withMessage('ID inválido')];

const updateProfileRules = [
  ...idParamRule,
  body('full_name').optional().trim().isLength({ min: 3, max: 120 }),
  body('age').optional().isInt({ min: 0, max: 120 }),
  body('blood_type').optional().isString().isLength({ max: 5 }),
  body('phone').optional().isString().isLength({ max: 30 }),
  body('weight_kg').optional().isFloat({ min: 0, max: 999.9 }),
  body('height_cm').optional().isFloat({ min: 0, max: 999.9 }),
  body('status').optional().isIn(['active', 'inactive', 'pending']),
  body('role').optional().isIn(['admin', 'patient', 'caregiver']),
  body('email').optional().isEmail(),
];

const changePasswordRules = [
  body('currentPassword').notEmpty().withMessage('La contraseña actual es obligatoria'),
  body('newPassword')
    .isLength({ min: 8 }).withMessage('La nueva contraseña debe tener al menos 8 caracteres')
    .matches(/\d/).withMessage('La nueva contraseña debe incluir al menos un número'),
];

module.exports = { idParamRule, updateProfileRules, changePasswordRules };
