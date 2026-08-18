const { body } = require('express-validator');

const registerRules = [
  body('fullName')
    .trim()
    .notEmpty().withMessage('El nombre completo es obligatorio')
    .isLength({ min: 3, max: 120 }).withMessage('El nombre debe tener entre 3 y 120 caracteres'),
  body('email')
    .trim()
    .isEmail().withMessage('Correo electrónico inválido')
    .normalizeEmail(),
  body('password')
    .isLength({ min: 8 }).withMessage('La contraseña debe tener al menos 8 caracteres')
    .matches(/\d/).withMessage('La contraseña debe incluir al menos un número'),
  body('age')
    .optional()
    .isInt({ min: 0, max: 120 }).withMessage('Edad inválida'),
  body('role')
    .optional()
    .isIn(['admin', 'patient', 'caregiver']).withMessage('Rol inválido'),
];

const loginRules = [
  body('email').trim().isEmail().withMessage('Correo electrónico inválido').normalizeEmail(),
  body('password').notEmpty().withMessage('La contraseña es obligatoria'),
];

const refreshRules = [
  body('refreshToken').notEmpty().withMessage('El refresh token es obligatorio'),
];

module.exports = { registerRules, loginRules, refreshRules };
