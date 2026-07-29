const { body, param } = require('express-validator');

const MOODS = ['Muy bien', 'Bien', 'Regular', 'Mal', 'Muy mal'];

const idParamRule = [param('id').isInt({ min: 1 }).withMessage('ID inválido')];

const createRules = [
  body('pain').optional().isInt({ min: 0, max: 10 }).withMessage('El dolor debe ser un entero de 0 a 10'),
  body('temperature').optional().isFloat({ min: 30, max: 45 }).withMessage('Temperatura fuera de rango'),
  body('systolic').optional().isInt({ min: 50, max: 250 }),
  body('diastolic').optional().isInt({ min: 30, max: 150 }),
  body('glucose').optional().isInt({ min: 20, max: 600 }),
  body('weight').optional().isFloat({ min: 0, max: 400 }),
  body('heartRate').optional().isInt({ min: 20, max: 250 }),
  body('stressLevel').optional().isInt({ min: 1, max: 10 }).withMessage('stressLevel debe ser de 1 a 10'),
  body('energyLevel').optional().isInt({ min: 1, max: 10 }).withMessage('energyLevel debe ser de 1 a 10'),
  body('sleepQuality').optional().isInt({ min: 1, max: 10 }).withMessage('sleepQuality debe ser de 1 a 10'),
  body('mood').optional().isIn(MOODS).withMessage(`Estado de ánimo inválido, use: ${MOODS.join(', ')}`),
  body('notes').optional().isString().isLength({ max: 2000 }),
];

const updateRules = [...idParamRule, ...createRules.map((r) => r.optional())];

module.exports = { idParamRule, createRules, updateRules, MOODS };
