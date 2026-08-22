import {
  connectDatabases,
  getDatabaseStatus,
} from "../config/databases.js";

try {
  await connectDatabases();
  const status = getDatabaseStatus();
  console.log(
    `Base de datos inicializada: ${status.mysql.host}:${status.mysql.port}/${status.mysql.database}`,
  );
  process.exit(0);
} catch (error) {
  console.error(`No se pudo inicializar la base de datos: ${error.message}`);
  process.exit(1);
}
