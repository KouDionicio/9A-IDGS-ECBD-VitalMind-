const { pool } = require('../config/db');


async function findByUserAndDate(
  userId,
  logDate
) {
  const [rows] = await pool.query(
    `
    SELECT *
    FROM emotional_logs
    WHERE user_id = :userId
      AND log_date = :logDate
    ORDER BY id DESC
    LIMIT 1
    `,
    {
      userId,
      logDate,
    }
  );

  return rows[0] || null;
}


async function findLatestByUser(
  userId
) {
  const [rows] = await pool.query(
    `
    SELECT *
    FROM emotional_logs
    WHERE user_id = ?
    ORDER BY log_date DESC, id DESC
    LIMIT 1
    `,
    {
      userId,
    }
  );

  return rows[0] || null;
}


async function findClosestByUserAndDate(
  userId,
  logDate
) {
  const [rows] = await pool.query(
    `
    SELECT *
    FROM emotional_logs
    WHERE user_id = :userId
    ORDER BY
      ABS(DATEDIFF(log_date, :logDate)) ASC,
      log_date DESC,
      id DESC
    LIMIT 1
    `,
    {
      userId,
      logDate,
    }
  );

  return rows[0] || null;
}


async function create({
  userId,
  mood,
  stressLevel,
  energyLevel,
  sleepQuality,
  notes = null,
  logDate,
}) {
  const [result] = await pool.query(
    `
    INSERT INTO emotional_logs (
      user_id,
      mood,
      stress_level,
      energy_level,
      sleep_quality,
      notes,
      log_date
    )
    VALUES (
      ?,?,?,?,?,?,?
    )
    `,
    {
      userId,
      mood,
      stressLevel,
      energyLevel,
      sleepQuality,
      notes,
      logDate,
    }
  );

  const [rows] = await pool.query(
    `
    SELECT *
    FROM emotional_logs
    WHERE id = ?
    LIMIT 1
    `,
    [
      result.insertId,
    ]
  );

  return rows[0] || null;
}


module.exports = {
  findByUserAndDate,
  findLatestByUser,
  findClosestByUserAndDate,
  create,
};