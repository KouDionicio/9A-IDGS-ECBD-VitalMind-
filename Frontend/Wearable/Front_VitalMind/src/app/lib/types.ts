export type UserRole = "admin" | "patient" | "caregiver";
export type UserStatus = "active" | "inactive" | "pending";

export type User = {
  id: number;
  name: string;
  email: string;
  age: number;
  status: UserStatus;
  role: UserRole;
  joined?: string | null;
  lastActive?: string | null;
  color?: string;
  registros?: number;
  consultas?: number;
};

export type Session = { token: string; user: User };

export type DashboardSummary = {
  medications: { total: number; taken: number; pending: number; adherence: number };
  appointments: { total: number; upcoming: number; completed: number; canceled: number };
  notifications: { unread: number };
  wellnessScore: number;
  latestHealthRecord?: HealthRecord | null;
  weeklyTrend?: Array<Partial<HealthRecord> & { date: string }>;
};

export type Medication = {
  id: number;
  userId?: number;
  name: string;
  nombre: string;
  dose: string;
  dosis: string;
  frequency: string;
  frecuencia: string;
  time: string;
  hora: string;
  color: string;
  taken: boolean;
  tomado: boolean;
  type: "pastilla" | "capsula" | "jarabe" | "inyeccion";
  tipo: "pastilla" | "capsula" | "jarabe" | "inyeccion";
};

export type Appointment = {
  id: number;
  userId?: number;
  specialty: string;
  especialidad: string;
  doctor: string;
  appointmentDate: string;
  fecha: string;
  appointmentTime: string;
  hora: string;
  place: string;
  lugar: string;
  color: string;
  status: "proxima" | "completada" | "cancelada";
  estado: "proxima" | "completada" | "cancelada";
};

export type NotificationItem = {
  id: string;
  userId: number;
  kind: "tip" | "reminder" | "ai" | "alert";
  title: string;
  body: string;
  time: string;
  read: boolean;
  createdAt?: string;
};

export type Mood = "muy_mal" | "mal" | "neutral" | "bien" | "muy_bien";

export type HealthRecord = {
  id: number;
  userId: number;
  recordDate: string;
  symptoms: string | null;
  mood: Mood | null;
  painLevel: number | null;
  temperature: number | null;
  weight: number | null;
  heartRate: number | null;
  systolicPressure: number | null;
  diastolicPressure: number | null;
  oxygenSaturation: number | null;
  sleepHours: number | null;
  waterGlasses: number | null;
  steps: number | null;
  exerciseMinutes: number | null;
  notes: string | null;
  createdAt?: string;
  updatedAt?: string;
};

export type OpenFdaMedication = {
  id: string | null;
  brandName: string | null;
  genericName: string | null;
  manufacturer: string | null;
  purpose: string | null;
  warnings: string | null;
  adverseReactions: string | null;
  activeIngredient: string | null;
  source: "openFDA";
};

export type AirQuality = {
  latitude: number;
  longitude: number;
  timezone: string;
  measuredAt: string;
  aqi: number;
  category: string;
  pollutants: { pm10?: number; pm25?: number; nitrogenDioxide?: number; ozone?: number; carbonMonoxide?: number };
  units: Record<string, string>;
  source: string;
  disclaimer: string;
};

export type Exercise = {
  id: number | string;
  name: string;
  description: string;
  category: string | null;
  muscles: string[];
  equipment: string[];
  source: "wger";
};
