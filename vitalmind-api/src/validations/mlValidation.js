const { body } = require('express-validator');

const analyzeRules = [
  body('userId').optional().isInt({ min: 1 }),
  body('analysisDate').optional().isISO8601().withMessage('analysisDate debe tener formato YYYY-MM-DD'),
];

module.exports = { analyzeRules };
