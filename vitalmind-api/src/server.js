const app = require('./app');
const { port, apiPrefix } = require('./config/env');
const { testConnection } = require('./config/db');

async function start() {
  try {
    await testConnection();
    console.log('✅ Conexión a MySQL (vitalmind) establecida correctamente');

    const server = app.listen(port, () => {
      console.log(`🚀 VitalMind API corriendo en http://localhost:${port}${apiPrefix}`);
      console.log(`📄 Documentación Swagger en http://localhost:${port}${apiPrefix}/docs`);
      console.log(`📊 Dashboard visual en http://localhost:${port}/dashboard`);
    });

    server.on('error', (err) => {
      if (err.code === 'EADDRINUSE') {
        console.error(`❌ El puerto ${port} ya está en uso. Cambia PORT en .env o detén el proceso que lo ocupa.`);
      } else {
        console.error('❌ No se pudo iniciar el servidor:', err.message);
      }
      process.exit(1);
    });
  } catch (err) {
    console.error('❌ No se pudo conectar a la base de datos:', err.message);
    process.exit(1);
  }
}

start();
