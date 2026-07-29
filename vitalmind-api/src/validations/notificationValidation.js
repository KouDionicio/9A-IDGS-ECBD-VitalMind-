const { body, param } = require('express-validator');

const idParamRule = [param('id').isInt({ min: 1 }).withMessage('ID inválido')];

const createRules = [
  body('kind').optional().isIn(['tip', 'reminder', 'ai', 'alert']),
  body('title').trim().notEmpty().withMessage('El título es obligatorio').isLength({ max: 180 }),
  body('body').trim().notEmpty().withMessage('El cuerpo del mensaje es obligatorio'),
  body('userId').optional().isInt({ min: 1 }),
];

module.exports = { idParamRule, createRules };
