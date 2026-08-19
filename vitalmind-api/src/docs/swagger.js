const swaggerJsdoc = require('swagger-jsdoc');
const { apiPrefix, port } = require('../config/env');

const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'VitalMind API',
      version: '1.0.0',
      description:
        'API REST para VitalMind IA. Inicia sesión como administrador en Auth > login y usa Authorize para enviar el JWT. Todos los módulos de negocio requieren rol admin.',
    },
    servers: [{ url: `http://localhost:${port}${apiPrefix}` }],
    tags: [
      { name: 'Auth', description: 'Login y gestión de tokens' },
      { name: 'Users', description: 'Administración de usuarios' },
      { name: 'Medications', description: 'Administración de medicamentos' },
      { name: 'Appointments', description: 'Administración de citas' },
      { name: 'Medical History', description: 'Historial médico' },
      { name: 'Habits', description: 'Hábitos y registros diarios' },
      { name: 'Symptoms', description: 'Síntomas y signos vitales' },
      { name: 'Notifications', description: 'Notificaciones' },
      { name: 'Dashboard', description: 'Indicadores y estadísticas' },
      { name: 'Reports', description: 'Exportación de reportes' },
      { name: 'ML Integration', description: 'Integración con el servicio ML' },
      { name: 'Mechanisms', description: 'Catálogo de mecanismos ML' },
      { name: 'Data Generator', description: 'Generación masiva de datos sintéticos para pruebas, ETL y ML' },
    ],
    security: [{ bearerAuth: [] }],
    components: {
      securitySchemes: {
        bearerAuth: {
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT',
        },
      },
    },
  },
  apis: ['./src/routes/*.js'],
};

const spec = swaggerJsdoc(options);

function requestExample(tag, path) {

  // ============================================================
  // MECHANISMS ML
  // ============================================================

  if (tag === 'Mechanisms') {

    // ---------------- SUPERVISADOS ----------------

    if (path.includes('symptom-priority')) {
      return {
        symptoms: [
          {
            type: 'dolor_cabeza',
            severity: 8,
            duration_days: 3,
            frequency: 4
          },
          {
            type: 'fatiga',
            severity: 6,
            duration_days: 5,
            frequency: 3
          }
        ],
        age: 35,
        medical_history: [
          'hipertension'
        ]
      };
    }

    if (path.includes('symptom-recurrence')) {
      return {
        symptoms: [
          {
            type: 'dolor_cabeza',
            date: '2026-08-18',
            severity: 7
          },
          {
            type: 'dolor_cabeza',
            date: '2026-08-15',
            severity: 6
          },
          {
            type: 'dolor_cabeza',
            date: '2026-08-10',
            severity: 5
          }
        ],
        analysis_period_days: 30
      };
    }

    if (path.includes('habit-adherence')) {
      return {
        habits: [
          {
            habit: 'water',
            goal: 8,
            completed: 6
          },
          {
            habit: 'exercise',
            goal: 30,
            completed: 20
          },
          {
            habit: 'sleep',
            goal: 8,
            completed: 7
          },
          {
            habit: 'meditation',
            goal: 15,
            completed: 10
          }
        ],
        period_days: 7
      };
    }

    if (path.includes('emotional-state')) {
      return {
        mood: 'Regular',
        stress_level: 7,
        energy_level: 4,
        sleep_quality: 5,
        recent_moods: [
          'Regular',
          'Mal',
          'Regular',
          'Bien'
        ]
      };
    }

    if (path.includes('habit-recommendation')) {
      return {
        user_profile: {
          age: 35,
          activity_level: 'bajo'
        },
        habits: {
          water: 4,
          exercise: 10,
          sleep: 5.5,
          nutrition: 2,
          meditation: 0
        },
        goals: [
          'mejorar_sueño',
          'aumentar_actividad'
        ]
      };
    }

    if (path.includes('preventive-alert')) {
      return {
        age: 58,
        symptoms: [
          {
            type: 'dolor_pecho',
            severity: 8
          },
          {
            type: 'fatiga',
            severity: 7
          }
        ],
        vital_signs: {
          systolic: 155,
          diastolic: 95,
          heart_rate: 102,
          glucose: 145
        },
        medical_history: [
          'hipertension'
        ]
      };
    }

    if (path.includes('app-abandonment')) {
      return {
        user_activity: {
          days_since_last_login: 12,
          logins_last_30_days: 3,
          habits_logged_last_30_days: 2,
          medications_logged_last_30_days: 1,
          notifications_opened: 2
        }
      };
    }

    if (path.includes('sleep-quality')) {
      return {
        sleep_history: [
          {
            date: '2026-08-18',
            hours: 5.5,
            awakenings: 3
          },
          {
            date: '2026-08-17',
            hours: 6,
            awakenings: 2
          },
          {
            date: '2026-08-16',
            hours: 7,
            awakenings: 1
          }
        ],
        stress_level: 6,
        exercise_minutes: 20
      };
    }

    if (path.includes('sedentary-risk')) {
      return {
        activity_history: {
          exercise_minutes_week: 45,
          sedentary_hours_day: 9,
          walking_minutes_day: 15
        },
        age: 42,
        bmi: 28.4
      };
    }

    if (path.includes('chatbot-sensitive')) {
      return {
        message: "He tenido dolor fuerte en el pecho y dificultad para respirar.",
        conversation_history: [
          "Me siento mal desde esta mañana.",
          "Ahora el dolor es más fuerte."
        ]
      };
    }

    // ---------------- NO SUPERVISADOS ----------------

    if (path.includes('health-habits-segmentation')) {
      return {
        users: [
          {
            user_id: 1,
            water: 8,
            exercise: 45,
            sleep: 8,
            nutrition: 4,
            meditation: 20
          },
          {
            user_id: 2,
            water: 3,
            exercise: 10,
            sleep: 5,
            nutrition: 1,
            meditation: 0
          },
          {
            user_id: 3,
            water: 6,
            exercise: 30,
            sleep: 7,
            nutrition: 3,
            meditation: 10
          }
        ]
      };
    }

    if (path.includes('symptom-patterns')) {
      return {
        symptoms: [
          {
            user_id: 1,
            symptom: 'dolor_cabeza',
            severity: 7
          },
          {
            user_id: 1,
            symptom: 'fatiga',
            severity: 6
          },
          {
            user_id: 2,
            symptom: 'dolor_cabeza',
            severity: 5
          },
          {
            user_id: 2,
            symptom: 'nauseas',
            severity: 6
          }
        ]
      };
    }

    if (path.includes('emotional-profiles')) {
      return {
        users: [
          {
            user_id: 1,
            stress_level: 8,
            energy_level: 3,
            sleep_quality: 4,
            mood: 'Mal'
          },
          {
            user_id: 2,
            stress_level: 3,
            energy_level: 8,
            sleep_quality: 8,
            mood: 'Bien'
          },
          {
            user_id: 3,
            stress_level: 5,
            energy_level: 5,
            sleep_quality: 6,
            mood: 'Regular'
          }
        ]
      };
    }

    if (path.includes('health-anomalies')) {
      return {
        health_metrics: [
          {
            user_id: 1,
            glucose: 95,
            systolic: 120,
            diastolic: 80,
            heart_rate: 72
          },
          {
            user_id: 1,
            glucose: 260,
            systolic: 175,
            diastolic: 105,
            heart_rate: 110
          },
          {
            user_id: 2,
            glucose: 100,
            systolic: 118,
            diastolic: 78,
            heart_rate: 70
          }
        ]
      };
    }

    if (path.includes('habit-symptom-association')) {
      return {
        records: [
          {
            water: 3,
            exercise: 10,
            sleep: 5,
            symptom_severity: 8
          },
          {
            water: 7,
            exercise: 30,
            sleep: 7,
            symptom_severity: 4
          },
          {
            water: 8,
            exercise: 45,
            sleep: 8,
            symptom_severity: 2
          }
        ]
      };
    }

    if (path.includes('app-behavior-segmentation')) {
      return {
        users: [
          {
            user_id: 1,
            logins: 30,
            sessions: 45,
            notifications_opened: 40,
            habits_logged: 25
          },
          {
            user_id: 2,
            logins: 5,
            sessions: 7,
            notifications_opened: 2,
            habits_logged: 1
          },
          {
            user_id: 3,
            logins: 15,
            sessions: 20,
            notifications_opened: 12,
            habits_logged: 10
          }
        ]
      };
    }

    if (path.includes('chatbot-topics')) {
      return {
        messages: [
          "Tengo problemas para dormir.",
          "Me duele mucho la cabeza.",
          "¿Qué puedo hacer para mejorar mi alimentación?",
          "Estoy preocupado por mi nivel de glucosa.",
          "No puedo dormir bien durante la noche."
        ]
      };
    }

    if (path.includes('wellness-map')) {
      return {
        users: [
          {
            user_id: 1,
            latitude: 20.123,
            longitude: -98.456,
            wellness_score: 82
          },
          {
            user_id: 2,
            latitude: 20.130,
            longitude: -98.450,
            wellness_score: 61
          }
        ]
      };
    }

    if (path.includes('wellness-routines')) {
      return {
        routines: [
          {
            user_id: 1,
            time: '07:00',
            activity: 'exercise',
            duration_minutes: 30
          },
          {
            user_id: 1,
            time: '22:00',
            activity: 'sleep',
            duration_minutes: 480
          }
        ]
      };
    }

    if (path.includes('preventive-profiles')) {
      return {
        users: [
          {
            user_id: 1,
            age: 55,
            bmi: 29.2,
            glucose: 130,
            systolic: 145,
            exercise_minutes_week: 40
          },
          {
            user_id: 2,
            age: 28,
            bmi: 22.1,
            glucose: 92,
            systolic: 118,
            exercise_minutes_week: 180
          }
        ]
      };
    }

    return {
      data: []
    };
  }

  // ============================================================
  // RESTO DE LOS ENDPOINTS EXISTENTES
  // ============================================================

  if (tag === 'Users' && path.includes('change-password')) {
    return {
      currentPassword: 'Admin123!',
      newPassword: 'NuevaClave2026!'
    };
  }

  if (tag === 'Users') {
    return {
      full_name: 'María López García',
      email: 'maria.lopez@vitalmind.local',
      age: 34,
      blood_type: 'O+',
      phone: '5551234567',
      status: 'active'
    };
  }

  if (tag === 'Medications') {
    return {
      name: 'Vitamina D',
      dose: '1000 UI',
      frequency: 'Una vez al día',
      timeLabel: '08:00',
      type: 'tableta',
      taken: false
    };
  }

  if (tag === 'Appointments') {
    return {
      specialty: 'Medicina general',
      doctor: 'Dra. Ana Martínez',
      appointment_date: '2026-09-15',
      appointment_time: '10:30',
      place: 'Clínica VitalMind',
      status: 'proxima'
    };
  }

  if (tag === 'Medical History') {
    return {
      category: 'allergies',
      title: 'Alergia estacional',
      description: 'Alergia al polen durante primavera',
      recorded_at: '2026-08-18'
    };
  }

  if (tag === 'Habits') {
    return {
      log_date: '2026-08-18',
      water_liters: 1.8,
      sleep_hours: 7.5,
      exercise_minutes: 30,
      meditation_minutes: 10
    };
  }

  if (tag === 'Symptoms') {
    return {
      symptom_date: '2026-08-18',
      symptom_type: 'Dolor de cabeza',
      severity: 3,
      notes: 'Molestia leve durante la tarde'
    };
  }

  if (tag === 'Notifications') {
    return {
      title: 'Recordatorio de cita',
      message: 'Tienes una cita médica mañana a las 10:30.',
      type: 'appointment'
    };
  }

  if (tag === 'ML Integration') {
    return {
      message: 'Me he sentido cansado durante los últimos días.',
      analysisDate: '2026-08-18'
    };
  }

  return {
    notes: 'Ejemplo de información para VitalMind'
  };
}

function parameterExample(name) {
  if (name === 'date') return '2026-08-18';
  if (name === 'entity') return 'users';
  return 1;
}

// Mantiene visibles en Swagger las rutas que no tienen un bloque JSDoc propio.
const endpointCatalog = {
  Users: {
    '/users': ['get'],
    '/users/{id}': ['get', 'put', 'patch', 'delete'],
    '/users/me/change-password': ['post'],
  },
  Medications: {
    '/medications': ['get', 'post'],
    '/medications/{id}': ['get', 'put', 'delete'],
    '/medications/{id}/logs': ['get'],
    '/medications/{id}/taken': ['patch'],
  },
  Appointments: {
    '/appointments': ['get', 'post'],
    '/appointments/{id}': ['get', 'put', 'delete'],
  },
  'Medical History': {
    '/medical-history': ['get', 'post'],
    '/medical-history/{id}': ['get', 'put', 'delete'],
  },
  Habits: {
    '/habits': ['get', 'post'],
    '/habits/{date}': ['get', 'delete'],
    '/habits/increment': ['post'],
  },
  Symptoms: {
    '/symptoms': ['get', 'post'],
    '/symptoms/{id}': ['get', 'put', 'delete'],
  },
  Notifications: {
    '/notifications': ['get', 'post'],
    '/notifications/unread-count': ['get'],
    '/notifications/{id}/read': ['patch'],
    '/notifications/{id}': ['delete'],
  },
  Dashboard: {
    '/dashboard/statistics': ['get'],
    '/dashboard/users-by-role': ['get'],
    '/dashboard/users-by-status': ['get'],
    '/dashboard/users-by-age': ['get'],
    '/dashboard/users-by-gender': ['get'],
    '/dashboard/medications-by-type': ['get'],
    '/dashboard/medications-taken-by-day': ['get'],
    '/dashboard/appointments-by-specialty': ['get'],
    '/dashboard/appointments-status': ['get'],
    '/dashboard/mood-statistics': ['get'],
    '/dashboard/pain-statistics': ['get'],
    '/dashboard/glucose-history': ['get'],
    '/dashboard/blood-pressure': ['get'],
    '/dashboard/temperature-history': ['get'],
    '/dashboard/water-consumption': ['get'],
    '/dashboard/sleep-history': ['get'],
    '/dashboard/physical-activity': ['get'],
    '/dashboard/habits-weekly': ['get'],
  },
  Reports: {
    '/reports/{entity}/csv': ['get'],
    '/reports/{entity}/excel': ['get'],
    '/reports/{entity}/pdf': ['get'],
  },
  'ML Integration': {
    '/ml/health': ['get'],
    '/ml/models/info': ['get'],
    '/ml/chat': ['post'],
    '/ml/chat/analyze': ['post'],
  },
  Mechanisms: {
    '/mechanisms': ['get'],

    // Supervisados
    '/mechanisms/supervised/symptom-priority': ['post'],
    '/mechanisms/supervised/symptom-recurrence': ['post'],
    '/mechanisms/supervised/habit-adherence': ['post'],
    '/mechanisms/supervised/emotional-state': ['post'],
    '/mechanisms/supervised/habit-recommendation': ['post'],
    '/mechanisms/supervised/preventive-alert': ['post'],
    '/mechanisms/supervised/app-abandonment': ['post'],
    '/mechanisms/supervised/sleep-quality': ['post'],
    '/mechanisms/supervised/sedentary-risk': ['post'],
    '/mechanisms/supervised/chatbot-sensitive': ['post'],

    // No supervisados
    '/mechanisms/unsupervised/health-habits-segmentation': ['post'],
    '/mechanisms/unsupervised/symptom-patterns': ['post'],
    '/mechanisms/unsupervised/emotional-profiles': ['post'],
    '/mechanisms/unsupervised/health-anomalies': ['post'],
    '/mechanisms/unsupervised/habit-symptom-association': ['post'],
    '/mechanisms/unsupervised/app-behavior-segmentation': ['post'],
    '/mechanisms/unsupervised/chatbot-topics': ['post'],
    '/mechanisms/unsupervised/wellness-map': ['post'],
    '/mechanisms/unsupervised/wellness-routines': ['post'],
    '/mechanisms/unsupervised/preventive-profiles': ['post'],
  },
    'Data Generator': {
    '/data-generator/users': ['post'],
    '/data-generator/medications': ['post'],
    '/data-generator/medication-logs': ['post'],
    '/data-generator/habits': ['post'],
    '/data-generator/symptoms': ['post'],
    '/data-generator/emotional-logs': ['post'],
    '/data-generator/appointments': ['post'],
    '/data-generator/health-metrics': ['post'],
    '/data-generator/medical-history': ['post'],
    '/data-generator/notifications': ['post'],
  },
};

for (const [tag, paths] of Object.entries(endpointCatalog)) {
  for (const [path, methods] of Object.entries(paths)) {
    spec.paths[path] ||= {};

    for (const method of methods) {
      if (spec.paths[path][method]) continue;

      const parameters = path.includes('{')
        ? [{
            name: path.match(/{([^}]+)}/)[1],
            in: 'path',
            required: true,
            schema: { type: path.includes('{id}') ? 'integer' : 'string' },
            example: parameterExample(path.match(/{([^}]+)}/)[1]),
          }]
        : undefined;

      spec.paths[path][method] = {
        tags: [tag],
        summary: `${method.toUpperCase()} ${path}`,
        ...(parameters ? { parameters } : {}),
        responses: {
          200: { description: 'Operación exitosa' },
          401: { description: 'Token requerido' },
          403: { description: 'Se requiere rol admin' },
        },
      };
    }
  }
}

for (const [path, operations] of Object.entries(spec.paths)) {
  for (const [method, operation] of Object.entries(operations)) {
    if (!operation || typeof operation !== 'object' || !operation.tags) continue;

    const tag = operation.tags[0];
    if (!['/health', '/auth/register', '/auth/login', '/auth/refresh', '/auth/logout'].includes(path)) {
      operation.security = [{ bearerAuth: [] }];
    }

    if (['post', 'put', 'patch'].includes(method) && !operation.requestBody) {
      operation.requestBody = {
        required: true,
        content: {
          'application/json': {
            schema: { type: 'object' },
            example: requestExample(tag, path),
          },
        },
      };
    }
  }
}

module.exports = spec;
