const API_BASE = (import.meta.env.VITE_API_URL || "http://localhost:4000/api").replace(/\/$/, "");

type ApiEnvelope<T> = {
  success: boolean;
  message: string;
  data: T;
  meta?: Record<string, unknown>;
  code?: string;
  errors?: Array<{ path?: string; message: string }>;
};

type RequestOptions = RequestInit & { token?: string | null; timeoutMs?: number };

export class ApiError extends Error {
  status: number;
  code?: string;
  errors: Array<{ path?: string; message: string }>;

  constructor(message: string, status: number, code?: string, errors: Array<{ path?: string; message: string }> = []) {
    super(message);
    this.name = "ApiError";
    this.status = status;
    this.code = code;
    this.errors = errors;
  }
}

export async function apiRequest<T>(path: string, options: RequestOptions = {}): Promise<T> {
  const headers = new Headers(options.headers || {});
  if (options.body && !(options.body instanceof FormData)) headers.set("Content-Type", "application/json");
  headers.set("Accept", "application/json");

  const token = options.token ?? localStorage.getItem("authToken");
  if (token) headers.set("Authorization", `Bearer ${token}`);

  const controller = new AbortController();
  const timeout = window.setTimeout(() => controller.abort(), options.timeoutMs ?? 15_000);

  try {
    const response = await fetch(`${API_BASE}${path}`, { ...options, headers, signal: options.signal ?? controller.signal });
    const isJson = response.headers.get("content-type")?.includes("application/json");
    const payload = isJson ? await response.json() as ApiEnvelope<T> : null;

    if (!response.ok) {
      if (response.status === 401) {
        clearSession();
        window.dispatchEvent(new CustomEvent("vitalmind:session-expired"));
      }
      throw new ApiError(payload?.message || "No fue posible completar la solicitud", response.status, payload?.code, payload?.errors || []);
    }

    if (payload && typeof payload === "object" && "success" in payload && "data" in payload) return payload.data;
    return payload as T;
  } catch (error) {
    if (error instanceof ApiError) throw error;
    if (error instanceof DOMException && error.name === "AbortError") throw new ApiError("La solicitud tardó demasiado", 408, "REQUEST_TIMEOUT");
    throw new ApiError("No se pudo conectar con el servidor. Verifica que el backend esté iniciado.", 0, "NETWORK_ERROR");
  } finally {
    window.clearTimeout(timeout);
  }
}

export function setSession(token: string, userName: string, role: string = "patient") {
  localStorage.setItem("authToken", token);
  localStorage.setItem("isAuthenticated", "true");
  localStorage.setItem("userName", userName);
  localStorage.setItem("userRole", role);
}

export function clearSession() {
  ["authToken", "isAuthenticated", "userName", "userRole", "isAdmin"].forEach((key) => localStorage.removeItem(key));
}

export function isAuthenticated() {
  return Boolean(localStorage.getItem("authToken") && localStorage.getItem("isAuthenticated") === "true");
}

export function getSessionRole() {
  return localStorage.getItem("userRole");
}

export function hasRole(role: string) {
  return isAuthenticated() && getSessionRole() === role;
}

export function getApiBase() {
  return API_BASE;
}
