const FIRST_NAMES = [
  'Alejandro', 'Andrea', 'Ana', 'Carlos', 'Daniel', 'Daniela', 'Diego', 'Elena',
  'Fernanda', 'Gabriel', 'Hector', 'Javier', 'José', 'Laura', 'Luis', 'María',
  'Marta', 'Miguel', 'Natalia', 'Paola', 'Ricardo', 'Samantha', 'Sara', 'Sofía',
  'Valeria', 'Victoria', 'Ximena', 'Yazmín', 'Brenda', 'Emiliano',
];

const LAST_NAMES = [
  'García', 'Rodríguez', 'Martínez', 'López', 'Hernández', 'González', 'Pérez',
  'Sánchez', 'Ramírez', 'Torres', 'Flores', 'Rivera', 'Gómez', 'Díaz', 'Vega',
  'Ruiz', 'Morales', 'Mendoza', 'Castillo', 'Vargas',
];

const BLOOD_TYPES = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
const COLORS = ['#0F766E', '#2563EB', '#8B5CF6', '#F59E0B', '#22C55E', '#EC4899', '#F97316'];
const MOODS = ['Muy bien', 'Bien', 'Regular', 'Mal', 'Muy mal'];
const MEDICATIONS = [
  ['Paracetamol', '500mg', 'Cada 8 horas', '08:00', 'pastilla'],
  ['Ibuprofeno', '400mg', 'Cada 12 horas', '08:00', 'pastilla'],
  ['Metformina', '850mg', 'Diario', '08:00', 'pastilla'],
  ['Losartán', '50mg', 'Diario', '08:00', 'pastilla'],
  ['Omeprazol', '20mg', 'Diario', '07:00', 'capsula'],
  ['Amoxicilina', '500mg', 'Cada 8 horas', '08:00', 'capsula'],
  ['Vitamina D', '1000UI', 'Diario', '12:00', 'capsula'],
  ['Omega 3', '1g', 'Diario', '13:00', 'capsula'],
  ['Loratadina', '10mg', 'Diario', '20:00', 'pastilla'],
  ['Salbutamol', '100mcg', 'Según necesidad', 'PRN', 'inyeccion'],
];

const SPECIALTIES = ['Cardiología', 'Endocrinología', 'Medicina general', 'Oftalmología', 'Dermatología', 'Nutrición', 'Neurología'];
const DOCTORS = ['Dr. Martínez López', 'Dra. García Ruiz', 'Dr. Sánchez Vega', 'Dra. Torres Ramos', 'Dr. Hernández Díaz', 'Dra. Morales Pérez'];
const PLACES = ['Clínica San Rafael', 'Hospital Central', 'Centro de Salud Norte', 'Clínica VitalMind', 'Hospital Regional'];
const HISTORY = {
  diseases: ['Hipertensión arterial', 'Diabetes tipo 2', 'Asma', 'Gastritis', 'Migraña'],
  allergies: ['Penicilina', 'Polvo', 'Polen', 'Ninguna conocida'],
  medications: ['Tratamiento antihipertensivo', 'Suplementos vitamínicos', 'Tratamiento temporal'],
  surgeries: ['Apendicectomía', 'Cirugía ocular', 'Sin cirugías previas'],
  consultations: ['Consulta general', 'Consulta de seguimiento', 'Valoración preventiva'],
  vaccines: ['Influenza', 'COVID-19', 'Tétanos', 'Hepatitis B'],
  results: ['Biometría hemática normal', 'Glucosa dentro de rango', 'Perfil lipídico de control'],
};

function randomItem(array) { return array[Math.floor(Math.random() * array.length)]; }
function randomInt(min, max) { return Math.floor(Math.random() * (max - min + 1)) + min; }
function randomFloat(min, max, decimals = 2) {
  const value = Math.random() * (max - min) + min;
  return Number(value.toFixed(decimals));
}
function randomBool(probability = 0.5) { return Math.random() < probability ? 1 : 0; }
function randomName() { return `${randomItem(FIRST_NAMES)} ${randomItem(LAST_NAMES)} ${randomItem(LAST_NAMES)}`; }
function slug(value) { return value.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase().replace(/[^a-z0-9]+/g, '.').replace(/^\.|\.$/g, ''); }
function randomEmail(name, suffix) { return `${slug(name)}.${suffix}.${Date.now()}${randomInt(100, 999)}@test.vitalmind.local`; }
function randomPhone() { return `22${randomInt(10000000, 99999999)}`; }
function randomAge() { return randomInt(18, 75); }
function randomMood() { return randomItem(MOODS); }
function randomDateFrom(baseDate, daysBack = 30) {
  const d = new Date(`${baseDate}T12:00:00`);
  d.setDate(d.getDate() - randomInt(0, daysBack));
  return d.toISOString().slice(0, 10);
}
function addDays(dateString, delta) {
  const d = new Date(`${dateString}T12:00:00`);
  d.setDate(d.getDate() + delta);
  return d.toISOString().slice(0, 10);
}
function randomTime() {
  return `${String(randomInt(7, 19)).padStart(2, '0')}:${randomItem([0, 15, 30, 45]).toString().padStart(2, '0')}`;
}
function randomMedication() { return randomItem(MEDICATIONS); }
function randomSpecialty() { return randomItem(SPECIALTIES); }
function randomDoctor() { return randomItem(DOCTORS); }
function randomPlace() { return randomItem(PLACES); }
function randomHistory(category) { return randomItem(HISTORY[category]); }

function habitValue(habitKey) {
  switch (habitKey) {
    case 'water': return randomFloat(0.5, 3.0, 2);
    case 'exercise': return randomFloat(0, 90, 0);
    case 'sleep': return randomFloat(4.5, 9.0, 2);
    case 'nutrition': return randomInt(1, 5);
    case 'meditation': return randomInt(0, 20);
    default: return 0;
  }
}

function habitGoal(habitKey) {
  return { water: 2, exercise: 45, sleep: 8, nutrition: 5, meditation: 10 }[habitKey] ?? 0;
}

module.exports = {
  COLORS,
  BLOOD_TYPES,
  MOODS,
  SPECIALTIES,
  DOCTORS,
  PLACES,
  HISTORY,
  MEDICATIONS,
  randomItem,
  randomInt,
  randomFloat,
  randomBool,
  randomName,
  randomEmail,
  randomPhone,
  randomAge,
  randomMood,
  randomDateFrom,
  addDays,
  randomTime,
  randomMedication,
  randomSpecialty,
  randomDoctor,
  randomPlace,
  randomHistory,
  habitValue,
  habitGoal,
};
