const { Router } = require('express');
const authController = require('../controllers/authController');
const { authenticate } = require('../middleware/authMiddleware');
const validateRequest = require('../middleware/validateRequest');
const { registerRules, loginRules, refreshRules } = require('../validations/authValidation');

const router = Router();

/**
 * @swagger
 * /auth/register:
 *   post:
 *     summary: Registrar un nuevo usuario
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [fullName, email, password]
 *             properties:
 *               fullName: { type: string, example: "María López García" }
 *               email: { type: string, example: "maria.lopez@vitalmind.local" }
 *               password: { type: string, example: "Salud2026!" }
 *               age: { type: integer, example: 34 }
 *     responses:
 *       201: { description: Usuario registrado, incluye accessToken y refreshToken }
 *     security: []
 */
router.post('/register', registerRules, validateRequest, authController.register);

/**
 * @swagger
 * /auth/login:
 *   post:
 *     summary: Iniciar sesión
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [email, password]
 *             properties:
 *               email: { type: string, example: "admin@vitalmind.com" }
 *               password: { type: string, example: "Admin123!" }
 *     responses:
 *       200: { description: Login exitoso, incluye accessToken y refreshToken }
 *     security: []
 */
router.post('/login', loginRules, validateRequest, authController.login);

/**
 * @swagger
 * /auth/refresh:
 *   post:
 *     summary: Renovar el access token usando un refresh token válido
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [refreshToken]
 *             properties:
 *               refreshToken: { type: string }
 *     security: []
 */
router.post('/refresh', refreshRules, validateRequest, authController.refresh);

/**
 * @swagger
 * /auth/logout:
 *   post:
 *     summary: Cerrar sesión (revoca el refresh token)
 *     tags: [Auth]
 *     requestBody:
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               refreshToken: { type: string }
 *     security: []
 */
router.post('/logout', authController.logout);

/**
 * @swagger
 * /auth/me:
 *   get:
 *     summary: Obtener el perfil del usuario autenticado
 *     tags: [Auth]
 *     security: [{ bearerAuth: [] }]
 */
router.get('/me', authenticate, authController.me);

module.exports = router;
