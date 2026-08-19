const { body } = require('express-validator');

const quantity = body('quantity')
  .optional()
  .isInt({ min: 1, max: 10000 })
  .withMessage('quantity debe ser un entero entre 1 y 10000')
  .toInt();

const days = body('days')
  .optional()
  .isInt({ min: 1, max: 3650 })
  .withMessage('days debe ser un entero entre 1 y 3650')
  .toInt();

const userId = body('userId')
  .optional()
  .isInt({ min: 1 })
  .withMessage('userId debe ser un entero positivo')
  .toInt();

const commonRules = [quantity];

module.exports = {
  commonRules,
  userRules: [quantity],
  userChildRules: [userId, quantity, days],
};
