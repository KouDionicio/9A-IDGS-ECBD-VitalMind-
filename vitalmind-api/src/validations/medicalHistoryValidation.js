const { body, param } = require('express-validator');

const CATEGORIES = ['diseases', 'allergies', 'medications', 'surgeries', 'consultations', 'vaccines', 'results'];

const idParamRule = [param('id').isInt({ min: 1 }).withMessage('ID inválido')];

const createRules = [
  body('category').isIn(CATEGORIES).withMessage(`Categoría inválida, use: ${CATEGORIES.join(', ')}`),
  body('description').trim().notEmpty().withMessage('La descripción es obligatoria').isLength({ max: 255 }),
];

const updateRules = [
  ...idParamRule,
  body('category').optional().isIn(CATEGORIES),
  body('description').optional().trim().isLength({ max: 255 }),
];

module.exports = { idParamRule, createRules, updateRules, CATEGORIES };
