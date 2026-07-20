import { z } from "zod";
import { getMySqlPool } from "../config/databases.js";
import { logAudit } from "../services/audit.service.js";

const medicationSchema = z.object({
  userId: z.coerce.number().int().positive().optional().nullable(),
  name: z.string().min(2),
  dose: z.string().min(1),
  frequency: z.string().min(1),
  time_label: z.string().min(1),
  color: z.string().optional(),
  taken: z.coerce.boolean().optional(),
  type: z.enum(["pastilla", "capsula", "jarabe", "inyeccion"]).optional(),
});

export async function listMedications(req, res, next) {
  try {
    const { search = "", taken = "" } = req.query;
    const pool = getMySqlPool();
    const clauses = [];
    const params = [];

    if (search) {
      clauses.push("(name LIKE ? OR dose LIKE ? OR frequency LIKE ?)");
      params.push(`%${search}%`, `%${search}%`, `%${search}%`);
    }
    if (taken === "true" || taken === "false") {
      clauses.push("taken = ?");
      params.push(taken === "true" ? 1 : 0);
    }

    const where = clauses.length ? `WHERE ${clauses.join(" AND ")}` : "";
    const [rows] = await pool.query(
      `SELECT id, user_id AS userId, name, dose, frequency, time_label AS time, color, taken, type FROM medications ${where} ORDER BY id DESC`,
      params
    );

    return res.json(rows.map((item) => ({ ...item, tomado: Boolean(item.taken) })));
  } catch (error) {
    return next(error);
  }
}

export async function getMedicationById(req, res, next) {
  try {
    const pool = getMySqlPool();
    const [rows] = await pool.query(
      "SELECT id, user_id AS userId, name, dose, frequency, time_label AS time, color, taken, type FROM medications WHERE id = ? LIMIT 1",
      [req.params.id]
    );

    if (!rows.length) {
      return res.status(404).json({ error: "Not Found", message: "Medicamento no encontrado" });
    }

    return res.json({ ...rows[0], tomado: Boolean(rows[0].taken) });
  } catch (error) {
    return next(error);
  }
}

export async function createMedication(req, res, next) {
  try {
    const body = medicationSchema.parse(req.body);
    const pool = getMySqlPool();
    const [result] = await pool.query(
      `INSERT INTO medications (user_id, name, dose, frequency, time_label, color, taken, type)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
      [ req.user.sub, body.name, body.dose, body.frequency, body.time_label, body.color || "#0F766E", body.taken ? 1 : 0, body.type || "pastilla"]
    );

    await logAudit(req.user?.sub || null, "medications.create", "medications", String(result.insertId), body);
    return res.status(201).json({ id: Number(result.insertId), ...body, tomado: Boolean(body.taken) });
  } catch (error) {
    return next(error);
  }
}

export async function updateMedication(req, res, next) {
  try {
    const body = medicationSchema.partial().parse(req.body);
    const pool = getMySqlPool();
    const [rows] = await pool.query("SELECT * FROM medications WHERE id = ? LIMIT 1", [req.params.id]);

    if (!rows.length) {
      return res.status(404).json({ error: "Not Found", message: "Medicamento no encontrado" });
    }

    const current = rows[0];
    const nextMedication = {
      userId: body.userId ?? current.user_id,
      name: body.name || current.name,
      dose: body.dose || current.dose,
      frequency: body.frequency || current.frequency,
      time_label: body.time_label || current.time_label,
      color: body.color || current.color,
      taken: typeof body.taken === "boolean" ? body.taken : Boolean(current.taken),
      type: body.type || current.type,
    };

    await pool.query(
      `UPDATE medications SET user_id = ?, name = ?, dose = ?, frequency = ?, time_label = ?, color = ?, taken = ?, type = ? WHERE id = ?`,
      [nextMedication.userId, nextMedication.name, nextMedication.dose, nextMedication.frequency, nextMedication.time_label, nextMedication.color, nextMedication.taken ? 1 : 0, nextMedication.type, req.params.id]
    );

    await logAudit(req.user?.sub || null, "medications.update", "medications", String(req.params.id), nextMedication);
    return res.json({ id: Number(req.params.id), ...nextMedication, tomado: Boolean(nextMedication.taken) });
  } catch (error) {
    return next(error);
  }
}

export async function updateMedicationTaken(req, res, next) {
  try {
    const pool = getMySqlPool();
    const rawTaken = req.body?.taken;
    const taken = typeof rawTaken === "boolean"
      ? rawTaken
      : String(rawTaken).toLowerCase() === "true";
    const [result] = await pool.query("UPDATE medications SET taken = ? WHERE id = ?", [taken ? 1 : 0, req.params.id]);

    if (!result.affectedRows) {
      return res.status(404).json({ error: "Not Found", message: "Medicamento no encontrado" });
    }

    await logAudit(req.user?.sub || null, "medications.taken", "medications", String(req.params.id), { taken: Boolean(taken) });
    return res.json({ id: Number(req.params.id), taken: Boolean(taken), tomado: Boolean(taken) });
  } catch (error) {
    return next(error);
  }
}

export async function deleteMedication(req, res, next) {
  try {
    const pool = getMySqlPool();
    const [result] = await pool.query("DELETE FROM medications WHERE id = ?", [req.params.id]);

    if (!result.affectedRows) {
      return res.status(404).json({ error: "Not Found", message: "Medicamento no encontrado" });
    }

    await logAudit(req.user?.sub || null, "medications.delete", "medications", String(req.params.id), {});
    return res.json({ deleted: true, id: Number(req.params.id) });
  } catch (error) {
    return next(error);
  }
}