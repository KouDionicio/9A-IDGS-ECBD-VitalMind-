const { Router } = require('express');
const asyncHandler = require('../utils/asyncHandler');
const mechanismsCatalog = require('../dashboard/mechanismsCatalog');
const { authenticate } = require('../middleware/authMiddleware');
const ApiError = require('../utils/ApiError');

const router = Router();
router.use(authenticate);

/**
 * @swagger
 * /mechanisms:
 *   get:
 *     summary: Catálogo de los 20 mecanismos de ML (supervisados y no supervisados) del proyecto VitalMind IA
 *     tags: [Mechanisms]
 */
router.get('/', asyncHandler(async (req, res) => {
  res.json({ success: true, data: mechanismsCatalog.getAll() });
}));

router.get('/:id', asyncHandler(async (req, res) => {
  const mechanism = mechanismsCatalog.getById(req.params.id);
  if (!mechanism) throw ApiError.notFound('Mecanismo no encontrado (usa un ID del 1 al 20)');
  res.json({ success: true, data: mechanism });
}));

module.exports = router;
