const { body, param, query } = require('express-validator');

const idParamRule = [param('id').isInt({ min: 1 }).withMessage('ID inválido')];

const createRules = [
  body('specialty').trim().notEmpty().withMessage('La especialidad es obligatoria').isLength({ max: 120 }),
  body('doctor').trim().notEmpty().withMessage('El nombre del doctor es obligatorio').isLength({ max: 120 }),
  body('appointmentDate').isISO8601().withMessage('Fecha inválida, use formato YYYY-MM-DD'),
  body('appointmentTime').trim().notEmpty().withMessage('La hora es obligatoria'),
  body('place').trim().notEmpty().withMessage('El lugar es obligatorio').isLength({ max: 160 }),
  body('color').optional().isHexColor(),
];

const updateRules = [
  ...idParamRule,
  body('specialty').optional().trim().isLength({ max: 120 }),
  body('doctor').optional().trim().isLength({ max: 120 }),
  body('appointmentDate').optional().isISO8601(),
  body('appointmentTime').optional().trim(),
  body('place').optional().trim().isLength({ max: 160 }),
  body('status').optional().isIn(['proxima', 'completada', 'cancelada']),
  body('color').optional().isHexColor(),
];

const listQueryRules = [
  query('status').optional().isIn(['proxima', 'completada', 'cancelada']),
  query('fromDate').optional().isISO8601(),
  query('toDate').optional().isISO8601(),
];

module.exports = { idParamRule, createRules, updateRules, listQueryRules };
