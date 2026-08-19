const { body, param } = require('express-validator');

const TYPES = ['pastilla', 'capsula', 'jarabe', 'inyeccion', 'tableta', 'gota', 'crema', 'parche'];

const idParamRule = [param('id').isInt({ min: 1 }).withMessage('ID inválido')];

const createRules = [
  body('name').trim().notEmpty().withMessage('El nombre es obligatorio').isLength({ max: 120 }),
  body('dose').trim().notEmpty().withMessage('La dosis es obligatoria').isLength({ max: 80 }),
  body('frequency').trim().notEmpty().withMessage('La frecuencia es obligatoria').isLength({ max: 80 }),
  body('timeLabel').optional().trim().isLength({ max: 80 }),
  body('time_label').optional().trim().isLength({ max: 80 }),
  body('time').optional().trim().isLength({ max: 80 }),
  body().custom((value) => {
    if (!value.timeLabel && !value.time_label && !value.time) {
      throw new Error('El horario es obligatorio (timeLabel)');
    }
    return true;
  }),
  body('type').optional().isIn(TYPES).withMessage(`Tipo inválido, use: ${TYPES.join(', ')}`),
  body('color').optional().isHexColor().withMessage('Color inválido, use formato hexadecimal'),
  body('daysDuration').optional().isInt({ min: 0 }),
];

const updateRules = [...idParamRule, ...createRules.map((r) => r.optional())];

const markTakenRules = [...idParamRule, body('taken').optional().isBoolean()];

module.exports = { idParamRule, createRules, updateRules, markTakenRules, TYPES };
