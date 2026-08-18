const path = require('path');
const express = require('express');
const helmet = require('helmet');
const cors = require('cors');
const morgan = require('morgan');
const cookieParser = require('cookie-parser');
const swaggerUi = require('swagger-ui-express');

const { apiPrefix, cors: corsConfig, env } = require('./config/env');
const routes = require('./routes');
const swaggerSpec = require('./docs/swagger');
const notFound = require('./middleware/notFound');
const errorHandler = require('./middleware/errorHandler');

const app = express();

// --- Seguridad y utilidades base ---
app.use(helmet({ contentSecurityPolicy: false })); // CSP desactivado solo para permitir Chart.js/fonts por CDN en /dashboard
app.use(
  cors({
    origin: corsConfig.origin,
    credentials: true,
  })
);
app.use(express.json({ limit: '2mb' }));
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());
app.use(morgan(env === 'production' ? 'combined' : 'dev'));

// --- Documentación ---
app.use(`${apiPrefix}/docs`, swaggerUi.serve, swaggerUi.setup(swaggerSpec));

// --- Dashboard visual (Fase 12): archivo estático servido en /dashboard ---
app.use('/dashboard', express.static(path.join(__dirname, '..', 'dashboard')));

// --- Rutas de la API ---
app.use(apiPrefix, routes);

// --- 404 y manejo centralizado de errores ---
app.use(notFound);
app.use(errorHandler);

module.exports = app;
