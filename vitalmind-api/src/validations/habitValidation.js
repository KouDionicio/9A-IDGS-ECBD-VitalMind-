const { body, param } = require('express-validator');

const dateParamRule = [param('date').isISO8601().withMessage('Fecha inválida, use formato YYYY-MM-DD')];

const upsertRules = [
  body('logDate').isISO8601().withMessage('logDate inválido, use formato YYYY-MM-DD'),
  body('water').optional().isFloat({ min: 0 }),
  body('exercise').optional().isFloat({ min: 0 }),
  body('sleep').optional().isFloat({ min: 0, max: 24 }),
  body('nutrition').optional().isFloat({ min: 0 }),
  body('meditation').optional().isFloat({ min: 0 }),
];

const incrementRules = [
  body('logDate').isISO8601().withMessage('logDate inválido, use formato YYYY-MM-DD'),
  body('habit').isIn(['water', 'exercise', 'sleep', 'nutrition', 'meditation']).withMessage('Hábito inválido'),
  body('amount').optional().isFloat({ min: 0 }),
];

module.exports = { dateParamRule, upsertRules, incrementRules };
