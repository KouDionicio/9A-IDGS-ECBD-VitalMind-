import { randomUUID } from "node:crypto";
import { Server } from "socket.io";
import jwt from "jsonwebtoken";
import { env } from "./config/env.js";

let io = null;

const ALLOWED_SERVER_EVENTS = new Set([
  "measurement:created",
  "measurement:updated",
  "measurement:deleted",
  "supervised:completed",
  "unsupervised:completed",
  "anomaly:detected",
  "history:updated",
  "dashboard:updated",
  "notification:new",
]);

function allowedOrigins() {
  if (env.CORS_ORIGIN === "*") {
    return true;
  }

  return env.CORS_ORIGIN
    .split(",")
    .map((value) => value.trim())
    .filter(Boolean);
}

function normalizeUserId(value) {
  const userId = Number(value);
  return Number.isInteger(userId) && userId > 0
    ? userId
    : null;
}

function buildEventPayload(event, userId, payload = {}) {
  const { userId: _ignoredUserId, ...safePayload } = payload;

  return {
    eventId: randomUUID(),
    type: event,
    timestamp: new Date().toISOString(),
    userId,
    ...safePayload,
  };
}

export function initializeSocket(httpServer) {
  io = new Server(httpServer, {
    cors: {
      origin: allowedOrigins(),
      credentials: true,
    },
    transports: ["websocket", "polling"],
  });

  io.use((socket, next) => {
    try {
      const token = socket.handshake.auth?.token;

      if (!token || typeof token !== "string") {
        return next(new Error("No autorizado"));
      }

      const decoded = jwt.verify(token, env.JWT_SECRET);
      const userId = normalizeUserId(decoded?.sub ?? decoded?.id);

      if (!userId) {
        return next(new Error("Token sin usuario válido"));
      }

      socket.user = {
        id: userId,
        role: decoded?.role,
      };

      return next();
    } catch {
      return next(new Error("Token inválido"));
    }
  });

  io.on("connection", (socket) => {
    const userId = socket.user.id;
    socket.join(`user:${userId}`);

    console.info(`Socket conectado: usuario ${userId}`);

    socket.on("disconnect", (reason) => {
      console.info(`Socket desconectado: usuario ${userId} (${reason})`);
    });
  });

  return io;
}

export function getIO() {
  if (!io) {
    throw new Error("Socket.IO no ha sido inicializado.");
  }

  return io;
}

export function closeSocket() {
  if (io) {
    io.close();
    io = null;
  }
}

export function emitToUser(userIdValue, event, payload = {}) {
  if (!io) {
    console.warn(`Socket.IO no inicializado; se omitió ${event}.`);
    return null;
  }

  if (!ALLOWED_SERVER_EVENTS.has(event)) {
    throw new Error(`Evento Socket.IO no permitido: ${event}`);
  }

  const userId = normalizeUserId(userIdValue);

  if (!userId) {
    console.warn(`Se omitió ${event}: usuario destino inválido.`);
    return null;
  }

  const eventPayload = buildEventPayload(event, userId, payload);
  io.to(`user:${userId}`).emit(event, eventPayload);
  return eventPayload;
}

export function emitMeasurementEvent(userId, action, payload = {}) {
  const event = `measurement:${action}`;
  const emitted = emitToUser(userId, event, payload);

  if (!emitted) {
    return null;
  }

  emitToUser(userId, "history:updated", {
    sourceEventId: emitted.eventId,
    recordId: payload.recordId ?? null,
    resource: payload.resource ?? "health_metrics",
    action,
  });

  emitToUser(userId, "dashboard:updated", {
    sourceEventId: emitted.eventId,
    recordId: payload.recordId ?? null,
    resource: payload.resource ?? "health_metrics",
    action,
  });

  return emitted;
}

export function emitDashboardUpdate(data = {}) {
  const { userId, ...payload } = data;
  return emitToUser(userId, "dashboard:updated", payload);
}

export function emitNotification(userId, notification) {
  return emitToUser(userId, "notification:new", {
    recordId: notification?.id ?? null,
    changed: notification,
  });
}
