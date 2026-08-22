import dotenv from "dotenv";

dotenv.config();

const required = (value, fallback) =>
  value && String(value).trim()
    ? String(value).trim()
    : fallback;

const must = (name) => {
  const value = process.env[name];
  if (!value || !String(value).trim()) {
    throw new Error(`Falta la variable de entorno requerida: ${name}`);
  }
  return String(value).trim();
};

export const env = {
  NODE_ENV: required(process.env.NODE_ENV, "development"),
  PORT: Number(required(process.env.PORT, "4000")),
  CORS_ORIGIN: required(process.env.CORS_ORIGIN, "*"),

  JWT_SECRET: must("JWT_SECRET"),

  JWT_EXPIRES_IN: required(
    process.env.JWT_EXPIRES_IN,
    "7d"
  ),

  MYSQL_HOST: required(
    process.env.MYSQL_HOST,
    "127.0.0.1"
  ),

  MYSQL_PORT: Number(
    required(process.env.MYSQL_PORT, "3306")
  ),

  MYSQL_USER: required(
    process.env.MYSQL_USER,
    "root"
  ),

  MYSQL_PASSWORD: process.env.MYSQL_PASSWORD || "",

  MYSQL_DATABASE: required(
    process.env.MYSQL_DATABASE,
    "vitalmind"
  ),

  MYSQL_SKIP_CREATE_DATABASE:
    String(process.env.MYSQL_SKIP_CREATE_DATABASE || "false").toLowerCase() === "true",

  MYSQL_CONNECT_TIMEOUT_MS: Number(
    required(process.env.MYSQL_CONNECT_TIMEOUT_MS, "5000")
  ),

  GEMINI_API_KEY: process.env.GEMINI_API_KEY
    ? String(process.env.GEMINI_API_KEY).trim()
    : "",
};
