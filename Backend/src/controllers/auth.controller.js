import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import { z } from "zod";
import { env } from "../config/env.js";
import { getMySqlPool } from "../config/databases.js";
import { logAudit } from "../services/audit.service.js";

const registerSchema = z.object({
  name: z.string().min(2),
  email: z.string().email(),
  password: z.string().min(6),
  age: z.coerce.number().int().nonnegative().optional(),
  role: z.enum(["admin", "patient", "caregiver"]).optional(),
});

const loginSchema = z.object({
  email: z.string().email(),
  password: z.string().min(1),
});

function buildToken(user) {
  return jwt.sign({ sub: user.id, email: user.email, role: user.role, name: user.full_name || user.name }, env.JWT_SECRET, { expiresIn: env.JWT_EXPIRES_IN });
}

export async function register(req, res, next) {
  try {
    const body = registerSchema.parse(req.body);
    const pool = getMySqlPool();
    const [existing] = await pool.query("SELECT id FROM users WHERE email = ? LIMIT 1", [body.email]);

    if (existing.length) {
      return res.status(409).json({ error: "Conflict", message: "Ya existe una cuenta con ese email" });
    }

    const passwordHash = await bcrypt.hash(body.password, 10);
    const [result] = await pool.query(
      `INSERT INTO users (full_name, email, password_hash, age, joined_label, last_active_label, status, registros, consultas, color, role)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [body.name, body.email, passwordHash, body.age || 0, new Date().toLocaleDateString("es-ES"), "Hace unos segundos", "pending", 0, 0, "#0F766E", body.role || "patient"]
    );

    const user = { id: Number(result.insertId), full_name: body.name, email: body.email, role: body.role || "patient" };
    await logAudit(null, "auth.register", "users", String(user.id), { email: user.email });

    return res.status(201).json({ token: buildToken(user), user });
  } catch (error) {
    return next(error);
  }
}

export async function login(req, res, next) {
  try {
    const body = loginSchema.parse(req.body);
    const pool = getMySqlPool();
    const [rows] = await pool.query("SELECT * FROM users WHERE email = ? LIMIT 1", [body.email]);
    const user = rows[0];

    if (!user) {
      return res.status(401).json({ error: "Unauthorized", message: "Credenciales inválidas" });
    }

    const valid = await bcrypt.compare(body.password, user.password_hash);
    if (!valid) {
      return res.status(401).json({ error: "Unauthorized", message: "Credenciales inválidas" });
    }

    await pool.query("UPDATE users SET last_active_label = ? WHERE id = ?", ["Hace unos segundos", user.id]);
    await logAudit(user.id, "auth.login", "users", String(user.id), { email: user.email });

    return res.json({ token: buildToken(user), user: { id: Number(user.id), name: user.full_name, email: user.email, role: user.role } });
  } catch (error) {
    return next(error);
  }
}

export async function me(req, res, next) {
  try {
    const pool = getMySqlPool();
    const [rows] = await pool.query(
      "SELECT id, full_name AS name, email, age, joined_label AS joined, last_active_label AS lastActive, status, registros, consultas, color, role FROM users WHERE id = ? LIMIT 1",
      [req.user.sub]
    );

    if (!rows.length) {
      return res.status(404).json({ error: "Not Found", message: "Usuario no encontrado" });
    }

    return res.json(rows[0]);
  } catch (error) {
    return next(error);
  }
}