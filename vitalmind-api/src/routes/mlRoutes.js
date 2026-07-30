const { Router } = require('express');
const mlController = require('../controllers/mlController');
const { authenticate } = require('../middleware/authMiddleware');
const validateRequest = require('../middleware/validateRequest');
const { analyzeRules } = require('../validations/mlValidation');

const router = Router();
router.use(authenticate);

/**
 * @swagger
 * /ml/analyze:
 *   post:
 *     summary: Ejecuta el análisis de riesgo y bienestar vía el microservicio ML (contrato POST /api/v1/analyze)
 *     tags: [ML Integration]
 *     requestBody:
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               userId: { type: integer, description: "Solo admin/caregiver pueden especificar otro usuario" }
 *               analysisDate: { type: string, example: "2026-08-03" }
 */
router.post('/analyze', analyzeRules, validateRequest, mlController.analyze);

router.get('/health', mlController.health);
router.get('/models/info', mlController.modelsInfo);

module.exports = router;
