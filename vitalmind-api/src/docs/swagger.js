const swaggerJsdoc = require('swagger-jsdoc');
const { apiPrefix, port } = require('../config/env');

const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'VitalMind API',
      version: '1.0.0',
      description:
        'API REST para VitalMind IA: salud digital, hábitos, síntomas, citas y dashboard analítico.',
    },
    servers: [{ url: `http://localhost:${port}${apiPrefix}` }],
    components: {
      securitySchemes: {
        bearerAuth: {
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT',
        },
      },
    },
  },
  apis: ['./src/routes/*.js'],
};

module.exports = swaggerJsdoc(options);
