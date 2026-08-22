import test from "node:test";
import assert from "node:assert/strict";
import { createServer } from "node:http";
import jwt from "jsonwebtoken";
import { io as createClient } from "socket.io-client";

process.env.JWT_SECRET = "back-socket-test-secret-at-least-32-characters";
process.env.CORS_ORIGIN = "*";

const {
  initializeSocket,
  closeSocket,
  emitMeasurementEvent,
} = await import("../src/socket.js");

function waitForConnect(socket) {
  return new Promise((resolve, reject) => {
    socket.once("connect", resolve);
    socket.once("connect_error", reject);
  });
}

test("el backend autentica y mantiene aisladas las salas", async (t) => {
  const server = createServer();
  initializeSocket(server);
  await new Promise((resolve) => server.listen(0, "127.0.0.1", resolve));

  t.after(async () => {
    closeSocket();
    if (server.listening) {
      await new Promise((resolve) => server.close(resolve));
    }
  });

  const { port } = server.address();
  const url = `http://127.0.0.1:${port}`;
  const tokenA = jwt.sign({ sub: 11, role: "patient" }, process.env.JWT_SECRET);
  const tokenB = jwt.sign({ sub: 22, role: "patient" }, process.env.JWT_SECRET);
  const clientA = createClient(url, { auth: { token: tokenA }, reconnection: false });
  const clientB = createClient(url, { auth: { token: tokenB }, reconnection: false });

  t.after(() => {
    clientA.close();
    clientB.close();
  });

  await Promise.all([waitForConnect(clientA), waitForConnect(clientB)]);

  let leaked = false;
  clientB.on("measurement:created", () => {
    leaked = true;
  });

  const received = new Promise((resolve) => clientA.once("measurement:created", resolve));
  emitMeasurementEvent(11, "created", {
    recordId: 91,
    resource: "health_metrics",
    changed: { steps: 500 },
  });

  const payload = await received;
  await new Promise((resolve) => setTimeout(resolve, 100));

  assert.equal(payload.recordId, 91);
  assert.equal(payload.userId, 11);
  assert.equal(payload.type, "measurement:created");
  assert.equal(leaked, false);
});
