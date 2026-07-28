import { useNavigate } from "react-router";
import {
  AlertCircle,
  Bell,
  Calendar,
  CheckCircle2,
  ChevronRight,
  CircleDashed,
  HeartPulse,
  LineChart as LineChartIcon,
  Pill,
  ShieldCheck,
  Sparkles,
  Stethoscope,
  SunMedium,
  TrendingUp,
  Users,
  Brain,
  Activity,
} from "lucide-react";
import { PieChart, Pie, Cell, ResponsiveContainer, LineChart, Line, CartesianGrid, XAxis, YAxis, Tooltip, BarChart, Bar, Legend } from "recharts";
import { ImageWithFallback } from "@/components/figma/ImageWithFallback";
import vitalMindLogo from "../../../imports/Captura_de_pantalla_2026-07-07_185523-removebg-preview.png";
import { useTheme } from "../ThemeContext";

const weeklyTrend = [
  { day: "Lun", bienestar: 68, sueno: 6.8, animo: 72, actividad: 54 },
  { day: "Mar", bienestar: 72, sueno: 7.1, animo: 74, actividad: 61 },
  { day: "Mié", bienestar: 70, sueno: 6.4, animo: 68, actividad: 57 },
  { day: "Jue", bienestar: 76, sueno: 7.6, animo: 80, actividad: 66 },
  { day: "Vie", bienestar: 78, sueno: 7.8, animo: 83, actividad: 71 },
  { day: "Sáb", bienestar: 82, sueno: 8.0, animo: 85, actividad: 76 },
  { day: "Dom", bienestar: 80, sueno: 7.4, animo: 84, actividad: 73 },
];

const adherenceByModule = [
  { module: "Medic.", actual: 92, goal: 95 },
  { module: "Hábitos", actual: 79, goal: 85 },
  { module: "Síntomas", actual: 88, goal: 90 },
  { module: "Citas", actual: 100, goal: 100 },
  { module: "IA", actual: 84, goal: 88 },
];

const riskDistribution = [
  { name: "Bajo", value: 48, color: "#14B8A6" },
  { name: "Moderado", value: 29, color: "#2563EB" },
  { name: "Alto", value: 15, color: "#F59E0B" },
  { name: "Crítico", value: 8, color: "#EF4444" },
];

const careSnapshot = [
  { icon: Pill, label: "Medicamentos", value: "92%", hint: "adherencia del día" },
  { icon: Activity, label: "Actividad", value: "8,420", hint: "pasos registrados" },
  { icon: SunMedium, label: "Sueño", value: "7.8h", hint: "promedio nocturno" },
  { icon: HeartPulse, label: "Frecuencia", value: "72 bpm", hint: "rango estable" },
];

const alerts = [
  { title: "Recordatorio de medicamento", desc: "Tomar metformina a las 8:00 p. m.", tone: "#0F766E" },
  { title: "Monitoreo de hábitos", desc: "Faltan 20 min para completar la meta de caminata.", tone: "#2563EB" },
  { title: "Seguimiento de salud", desc: "Registrar estado emocional antes de dormir.", tone: "#8B5CF6" },
];

const nextAppointments = [
  { time: "10:30", title: "Control general", place: "Consulta externa" },
  { time: "13:00", title: "Revisión de laboratorio", place: "Área clínica" },
  { time: "18:15", title: "Recordatorio IA", place: "Rutina nocturna" },
];

const quickStats = [
  { icon: Users, label: "Pacientes", value: "1,248" },
  { icon: ShieldCheck, label: "Alertas atendidas", value: "97%" },
  { icon: Stethoscope, label: "Seguimientos", value: "312" },
  { icon: Brain, label: "Sugerencias IA", value: "46" },
];

export function DashboardScreen() {
  const navigate = useNavigate();
  const { dark } = useTheme();

  const bg = dark ? "#0F172A" : "#F4F7FB";
  const panel = dark ? "#111C31" : "#FFFFFF";
  const panelSoft = dark ? "#0B1426" : "#F8FAFC";
  const border = dark ? "rgba(255,255,255,0.08)" : "#E2E8F0";
  const mainText = dark ? "#F8FAFC" : "#0F172A";
  const muted = dark ? "#94A3B8" : "#64748B";

  const kpis = [
    { title: "Bienestar general", value: "78/100", delta: "+6 esta semana", icon: Sparkles, color: "#0F766E" },
    { title: "Adherencia", value: "92%", delta: "+3% vs. ayer", icon: CheckCircle2, color: "#2563EB" },
    { title: "Riesgo actual", value: "Bajo", delta: "sin alertas críticas", icon: CircleDashed, color: "#14B8A6" },
    { title: "Citas próximas", value: "3", delta: "2 hoy · 1 mañana", icon: Calendar, color: "#8B5CF6" },
  ];

  return (
    <div className="min-h-full w-full" style={{ background: bg, color: mainText }}>
      <div className="px-4 sm:px-6 lg:px-8 py-6 lg:py-8 space-y-6">
        <section
          className="rounded-[28px] overflow-hidden border shadow-sm"
          style={{
            background: `linear-gradient(135deg, ${dark ? "#0E7490" : "#0F766E"} 0%, ${dark ? "#1D4ED8" : "#2563EB"} 100%)`,
            borderColor: dark ? "rgba(255,255,255,0.10)" : "transparent",
          }}
        >
          <div className="p-6 lg:p-8 xl:p-10 grid gap-6 xl:grid-cols-[1.5fr_1fr] items-center">
            <div className="space-y-4">
              <div className="flex items-center gap-3">
                <ImageWithFallback
                  src={vitalMindLogo}
                  alt="VitalMind AI"
                  className="h-11 w-auto object-contain"
                  style={{ filter: "brightness(0) invert(1)" }}
                />
                <span className="inline-flex items-center gap-2 px-3 py-1 rounded-full text-xs font-semibold text-white/90 bg-white/10 border border-white/15">
                  <LineChartIcon size={14} />
                  Panel demo
                </span>
              </div>

              <div>
                <p className="text-white/75 text-sm">Hola, Yazmín</p>
                <h1 className="text-3xl lg:text-4xl font-bold text-white leading-tight mt-2">
                  Dashboard ejecutivo de salud inteligente
                </h1>
                <p className="text-white/75 text-sm lg:text-base mt-3 max-w-2xl">
                  Esta vista es una maqueta funcional del panel final. Aquí después se conectarán los datos reales de hábitos, medicamentos, citas, síntomas y recomendaciones de IA.
                </p>
              </div>

              <div className="flex flex-wrap gap-2">
                {["Historial médico", "Adherencia", "IA personalizada", "Seguimiento 24/7"].map((tag) => (
                  <span key={tag} className="px-3 py-1 rounded-full text-xs font-medium bg-white/10 text-white border border-white/15">
                    {tag}
                  </span>
                ))}
              </div>
            </div>

            <div className="grid grid-cols-2 gap-3">
              {quickStats.map((item) => {
                const Icon = item.icon;
                return (
                  <div key={item.label} className="rounded-[22px] bg-white/10 border border-white/15 p-4 backdrop-blur-sm">
                    <div className="w-10 h-10 rounded-2xl bg-white/12 flex items-center justify-center mb-4">
                      <Icon size={18} className="text-white" />
                    </div>
                    <p className="text-white/70 text-xs">{item.label}</p>
                    <p className="text-white font-bold text-xl mt-1">{item.value}</p>
                  </div>
                );
              })}
            </div>
          </div>
        </section>

        <section className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4">
          {kpis.map((kpi) => {
            const Icon = kpi.icon;
            return (
              <article
                key={kpi.title}
                className="rounded-[24px] border p-5 shadow-sm"
                style={{ backgroundColor: panel, borderColor: border }}
              >
                <div className="flex items-start justify-between gap-4">
                  <div>
                    <p className="text-sm font-medium" style={{ color: muted }}>{kpi.title}</p>
                    <p className="text-2xl font-bold mt-2" style={{ color: mainText }}>{kpi.value}</p>
                    <p className="text-xs mt-2" style={{ color: muted }}>{kpi.delta}</p>
                  </div>
                  <div className="w-11 h-11 rounded-2xl flex items-center justify-center" style={{ backgroundColor: `${kpi.color}18`, color: kpi.color }}>
                    <Icon size={20} />
                  </div>
                </div>
              </article>
            );
          })}
        </section>

        <section className="grid grid-cols-1 xl:grid-cols-12 gap-4 lg:gap-5">
          <article
            className="xl:col-span-8 rounded-[28px] border p-5 lg:p-6 shadow-sm"
            style={{ backgroundColor: panel, borderColor: border }}
          >
            <div className="flex items-center justify-between gap-4 mb-5">
              <div>
                <h2 className="text-lg font-bold" style={{ color: mainText }}>Evolución semanal</h2>
                <p className="text-sm mt-1" style={{ color: muted }}>Bienestar, ánimo, sueño y actividad para mostrar la tendencia del usuario.</p>
              </div>
              <button className="text-sm font-semibold text-[#0F766E] flex items-center gap-1" onClick={() => navigate("/graficas")}>
                Ver detalle <ChevronRight size={16} />
              </button>
            </div>
            <div className="h-[340px]">
              <ResponsiveContainer width="100%" height="100%">
                <LineChart data={weeklyTrend}>
                  <CartesianGrid strokeDasharray="3 3" stroke={dark ? "rgba(255,255,255,0.08)" : "#E2E8F0"} />
                  <XAxis dataKey="day" stroke={muted} />
                  <YAxis stroke={muted} />
                  <Tooltip
                    contentStyle={{
                      background: dark ? "#0B1426" : "#FFFFFF",
                      border: `1px solid ${border}`,
                      borderRadius: 16,
                      color: mainText,
                    }}
                  />
                  <Legend />
                  <Line type="monotone" dataKey="bienestar" name="Bienestar" stroke="#0F766E" strokeWidth={3} dot={{ r: 4 }} />
                  <Line type="monotone" dataKey="animo" name="Ánimo" stroke="#2563EB" strokeWidth={3} dot={{ r: 4 }} />
                  <Line type="monotone" dataKey="actividad" name="Actividad" stroke="#8B5CF6" strokeWidth={3} dot={{ r: 4 }} />
                </LineChart>
              </ResponsiveContainer>
            </div>
          </article>

          <aside
            className="xl:col-span-4 rounded-[28px] border p-5 lg:p-6 shadow-sm"
            style={{ backgroundColor: panel, borderColor: border }}
          >
            <div className="flex items-center justify-between gap-4 mb-4">
              <div>
                <h2 className="text-lg font-bold" style={{ color: mainText }}>Distribución de riesgo</h2>
                <p className="text-sm mt-1" style={{ color: muted }}>Vista preliminar para cuando existan datos reales.</p>
              </div>
              <Sparkles size={18} style={{ color: "#0F766E" }} />
            </div>

            <div className="h-[220px]">
              <ResponsiveContainer width="100%" height="100%">
                <PieChart>
                  <Pie data={riskDistribution} dataKey="value" nameKey="name" cx="50%" cy="50%" innerRadius={62} outerRadius={90} paddingAngle={3}>
                    {riskDistribution.map((entry) => (
                      <Cell key={entry.name} fill={entry.color} />
                    ))}
                  </Pie>
                  <Tooltip
                    contentStyle={{
                      background: dark ? "#0B1426" : "#FFFFFF",
                      border: `1px solid ${border}`,
                      borderRadius: 16,
                      color: mainText,
                    }}
                  />
                </PieChart>
              </ResponsiveContainer>
            </div>

            <div className="space-y-3 mt-2">
              {riskDistribution.map((item) => (
                <div key={item.name} className="flex items-center gap-3">
                  <span className="w-3 h-3 rounded-full" style={{ backgroundColor: item.color }} />
                  <span className="text-sm flex-1" style={{ color: mainText }}>{item.name}</span>
                  <span className="text-sm font-semibold" style={{ color: muted }}>{item.value}%</span>
                </div>
              ))}
            </div>
          </aside>
        </section>

        <section className="grid grid-cols-1 xl:grid-cols-12 gap-4 lg:gap-5">
          <article
            className="xl:col-span-7 rounded-[28px] border p-5 lg:p-6 shadow-sm"
            style={{ backgroundColor: panel, borderColor: border }}
          >
            <div className="flex items-center justify-between gap-4 mb-5">
              <div>
                <h2 className="text-lg font-bold" style={{ color: mainText }}>Adherencia por módulo</h2>
                <p className="text-sm mt-1" style={{ color: muted }}>Barras comparativas para medicamentos, hábitos, síntomas, citas e IA.</p>
              </div>
              <TrendingUp size={18} style={{ color: "#2563EB" }} />
            </div>
            <div className="h-[320px]">
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={adherenceByModule}>
                  <CartesianGrid strokeDasharray="3 3" stroke={dark ? "rgba(255,255,255,0.08)" : "#E2E8F0"} />
                  <XAxis dataKey="module" stroke={muted} />
                  <YAxis stroke={muted} />
                  <Tooltip
                    contentStyle={{
                      background: dark ? "#0B1426" : "#FFFFFF",
                      border: `1px solid ${border}`,
                      borderRadius: 16,
                      color: mainText,
                    }}
                  />
                  <Legend />
                  <Bar dataKey="actual" name="Actual" fill="#0F766E" radius={[10, 10, 0, 0]} />
                  <Bar dataKey="goal" name="Meta" fill="#2563EB" radius={[10, 10, 0, 0]} />
                </BarChart>
              </ResponsiveContainer>
            </div>
          </article>

          <article
            className="xl:col-span-5 rounded-[28px] border p-5 lg:p-6 shadow-sm"
            style={{ backgroundColor: panel, borderColor: border }}
          >
            <div className="flex items-center justify-between gap-4 mb-5">
              <div>
                <h2 className="text-lg font-bold" style={{ color: mainText }}>Alertas y agenda</h2>
                <p className="text-sm mt-1" style={{ color: muted }}>Esto después se alimentará con datos reales y recordatorios.</p>
              </div>
              <Bell size={18} style={{ color: "#0F766E" }} />
            </div>

            <div className="space-y-3">
              {alerts.map((item) => (
                <div key={item.title} className="rounded-[22px] border p-4" style={{ backgroundColor: panelSoft, borderColor: border }}>
                  <div className="flex items-start gap-3">
                    <div className="w-10 h-10 rounded-2xl flex items-center justify-center shrink-0" style={{ backgroundColor: `${item.tone}18`, color: item.tone }}>
                      <AlertCircle size={18} />
                    </div>
                    <div className="flex-1">
                      <p className="text-sm font-semibold" style={{ color: mainText }}>{item.title}</p>
                      <p className="text-xs mt-1" style={{ color: muted }}>{item.desc}</p>
                    </div>
                  </div>
                </div>
              ))}
            </div>

            <div className="mt-5 rounded-[24px] border p-4" style={{ backgroundColor: panelSoft, borderColor: border }}>
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-semibold" style={{ color: mainText }}>Próximas citas</p>
                  <p className="text-xs mt-1" style={{ color: muted }}>Vista resumida del calendario</p>
                </div>
                <Calendar size={18} style={{ color: "#2563EB" }} />
              </div>

              <div className="mt-4 space-y-3">
                {nextAppointments.map((item) => (
                  <div key={item.time} className="flex items-center gap-3">
                    <div className="w-14 text-sm font-bold" style={{ color: mainText }}>{item.time}</div>
                    <div className="flex-1 rounded-2xl border px-4 py-3" style={{ backgroundColor: panel, borderColor: border }}>
                      <p className="text-sm font-semibold" style={{ color: mainText }}>{item.title}</p>
                      <p className="text-xs mt-1" style={{ color: muted }}>{item.place}</p>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </article>
        </section>

        <section className="grid grid-cols-1 lg:grid-cols-3 gap-4 lg:gap-5">
          {careSnapshot.map((item) => {
            const Icon = item.icon;
            return (
              <article
                key={item.label}
                className="rounded-[26px] border p-5 shadow-sm"
                style={{ backgroundColor: panel, borderColor: border }}
              >
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium" style={{ color: muted }}>{item.label}</p>
                    <p className="text-2xl font-bold mt-2" style={{ color: mainText }}>{item.value}</p>
                    <p className="text-xs mt-2" style={{ color: muted }}>{item.hint}</p>
                  </div>
                  <div className="w-12 h-12 rounded-2xl flex items-center justify-center" style={{ backgroundColor: `${"#0F766E"}18`, color: "#0F766E" }}>
                    <Icon size={20} />
                  </div>
                </div>
              </article>
            );
          })}
        </section>
      </div>
    </div>
  );
}
