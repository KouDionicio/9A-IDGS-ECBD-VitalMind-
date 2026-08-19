const { pool } = require('../config/db');

/**
 * Capa de acceso a datos pura: solo SQL, sin lógica de negocio.
 * Refleja exactamente las columnas de la tabla `users` del dump existente.
 */

const PUBLIC_COLUMNS = `
  id, full_name, email, age, gender, joined_label, last_active_label, status,
  registros, consultas, color, role, created_at, updated_at,
  blood_type, phone, weight_kg, height_cm
`;

async function findByEmail(email) {
  const [rows] = await pool.query(
    'SELECT * FROM users WHERE email = :email LIMIT 1',
    { email }
  );
  return rows[0] || null;
}

async function findById(id) {
  const [rows] = await pool.query(
    `SELECT ${PUBLIC_COLUMNS} FROM users WHERE id = :id LIMIT 1`,
    { id }
  );
  return rows[0] || null;
}

async function existsByEmail(email) {
  const [rows] = await pool.query(
    'SELECT id FROM users WHERE email = :email LIMIT 1',
    { email }
  );
  return rows.length > 0;
}

async function create({ fullName, email, passwordHash, age = 0, role = 'patient' }) {
  const [result] = await pool.query(
    `INSERT INTO users (full_name, email, password_hash, age, status, role, joined_label)
     VALUES (:fullName, :email, :passwordHash, :age, 'pending', :role, :joinedLabel)`,
    {
      fullName,
      email,
      passwordHash,
      age,
      role,
      joinedLabel: new Date().toLocaleDateString('es-MX', {
        day: '2-digit',
        month: 'short',
        year: 'numeric',
      }),
    }
  );
  return findById(result.insertId);
}

async function findAll({ limit = 50, offset = 0, role, status, search } = {}) {
  const conditions = [];
  const params = { limit, offset };

  if (role) {
    conditions.push('role = :role');
    params.role = role;
  }
  if (status) {
    conditions.push('status = :status');
    params.status = status;
  }
  if (search) {
    conditions.push('(full_name LIKE :search OR email LIKE :search)');
    params.search = `%${search}%`;
  }

  const whereClause = conditions.length ? `WHERE ${conditions.join(' AND ')}` : '';

  const [rows] = await pool.query(
    `SELECT ${PUBLIC_COLUMNS} FROM users ${whereClause}
     ORDER BY created_at DESC LIMIT :limit OFFSET :offset`,
    params
  );
  const [countRows] = await pool.query(
    `SELECT COUNT(*) as total FROM users ${whereClause}`,
    params
  );
  return { rows, total: countRows[0].total };
}

async function update(id, fields) {
  const allowed = [
    'full_name', 'email', 'age', 'status', 'color', 'role',
    'blood_type', 'phone', 'weight_kg', 'height_cm', 'gender',
  ];
  const setClauses = [];
  const params = { id };

  for (const [key, value] of Object.entries(fields)) {
    if (allowed.includes(key) && value !== undefined) {
      setClauses.push(`${key} = :${key}`);
      params[key] = value;
    }
  }

  if (setClauses.length === 0) return findById(id);

  await pool.query(
    `UPDATE users SET ${setClauses.join(', ')} WHERE id = :id`,
    params
  );
  return findById(id);
}

async function updatePassword(id, passwordHash) {
  await pool.query(
    'UPDATE users SET password_hash = :passwordHash WHERE id = :id',
    { id, passwordHash }
  );
}

async function updateLastActive(id, label = 'Hace unos segundos') {
  await pool.query(
    'UPDATE users SET last_active_label = :label WHERE id = :id',
    { id, label }
  );
}

async function remove(id) {
  const [result] = await pool.query('DELETE FROM users WHERE id = :id', { id });
  return result.affectedRows > 0;
}

async function countByRole({ status, gender } = {}) {
  const conditions = [];
  const params = {};

  if (status) {
    conditions.push('status = :status');
    params.status = status;
  }

  if (gender) {
    conditions.push('gender = :gender');
    params.gender = gender;
  }

  const where = conditions.length
    ? `WHERE ${conditions.join(' AND ')}`
    : '';

  const [rows] = await pool.query(
    `
    SELECT role, COUNT(*) AS total
    FROM users
    ${where}
    GROUP BY role
    ORDER BY total DESC
    `,
    params
  );

  return rows;
}


async function countByStatus({ role, gender } = {}) {
  const conditions = [];
  const params = {};

  if (role) {
    conditions.push('role = :role');
    params.role = role;
  }

  if (gender) {
    conditions.push('gender = :gender');
    params.gender = gender;
  }

  const where = conditions.length
    ? `WHERE ${conditions.join(' AND ')}`
    : '';

  const [rows] = await pool.query(
    `
    SELECT status, COUNT(*) AS total
    FROM users
    ${where}
    GROUP BY status
    ORDER BY total DESC
    `,
    params
  );

  return rows;
}


async function countByAgeGroup({ role, status, gender } = {}) {
  const conditions = [];
  const params = {};

  if (role) {
    conditions.push('role = :role');
    params.role = role;
  }

  if (status) {
    conditions.push('status = :status');
    params.status = status;
  }

  if (gender) {
    conditions.push('gender = :gender');
    params.gender = gender;
  }

  const where = conditions.length
    ? `WHERE ${conditions.join(' AND ')}`
    : '';

  const [rows] = await pool.query(
    `
    SELECT
      CASE
        WHEN age BETWEEN 0 AND 17 THEN '0-17'
        WHEN age BETWEEN 18 AND 24 THEN '18-24'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        WHEN age BETWEEN 55 AND 64 THEN '55-64'
        WHEN age >= 65 THEN '65+'
        ELSE 'Sin dato'
      END AS ageGroup,
      COUNT(*) AS total
    FROM users
    ${where}
    GROUP BY ageGroup
    ORDER BY MIN(age)
    `,
    params
  );

  return rows;
}


async function countByGender({ role, status } = {}) {
  const conditions = [];
  const params = {};

  if (role) {
    conditions.push('role = :role');
    params.role = role;
  }

  if (status) {
    conditions.push('status = :status');
    params.status = status;
  }

  const where = conditions.length
    ? `WHERE ${conditions.join(' AND ')}`
    : '';

  const [rows] = await pool.query(
    `
    SELECT
      COALESCE(gender, 'Sin dato') AS gender,
      COUNT(*) AS total
    FROM users
    ${where}
    GROUP BY gender
    ORDER BY total DESC
    `,
    params
  );

  return rows;
}

module.exports = {
  findByEmail,
  findById,
  existsByEmail,
  create,
  findAll,
  update,
  updatePassword,
  updateLastActive,
  remove,
  countByRole,
  countByStatus,
  countByAgeGroup,
  countByGender,
};
