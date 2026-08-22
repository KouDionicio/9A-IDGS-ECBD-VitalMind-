import { Router } from "express";
import { checkDatabaseHealth } from "../config/databases.js";

export const healthRouter = Router();

healthRouter.get("/", async (_req, res) => {
  const mysql = await checkDatabaseHealth();

  res.status(mysql.connected ? 200 : 503).json({
    ok: mysql.connected,
    service: "vitalmind-api",
    status: { mysql },
    timestamp: new Date().toISOString(),
  });
});