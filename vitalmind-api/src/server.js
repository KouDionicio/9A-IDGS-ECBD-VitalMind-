const app = require('./app');
const { port, apiPrefix } = require('./config/env');
const { testConnection } = require('./config/db');

async function start() {
  try {
    await testConnection();
    console.log('✅ Conexión a MySQL (vitalmind) establecida correctamente');

    app.listen(port, () => {
      console.log(`🚀 VitalMind API corriendo en http://localhost:${port}${apiPrefix}`);
      console.log(`📄 Documentación Swagger en http://localhost:${port}${apiPrefix}/docs`);
      console.log(`📊 Dashboard visual en http://localhost:${port}/dashboard`);
    });
  } catch (err) {
    console.error('❌ No se pudo conectar a la base de datos:', err.message);
    process.exit(1);
  }
}

start();
