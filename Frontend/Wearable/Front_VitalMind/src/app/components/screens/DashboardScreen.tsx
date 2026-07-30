import { useEffect, useState } from "react";
import { useNavigate } from "react-router";
import {
  Bell, Droplets, Heart, Moon, Activity, ChevronRight, Sparkles, Zap, Apple,
  TrendingUp, Plus, Pill, Calendar, Check, Wind,
} from "lucide-react";
import { motion } from "motion/react";
import { PieChart, Pie, Cell, ResponsiveContainer, LineChart, Line } from "recharts";
import { ImageWithFallback } from "@/components/figma/ImageWithFallback";
import vitalMindLogo from "../../../imports/Captura_de_pantalla_2026-07-07_185523-removebg-preview.png";
import { toast } from "sonner";
import { useTheme } from "../ThemeContext";
import { apiRequest } from "../../lib/api";
import type { AirQuality, DashboardSummary, HealthRecord } from "../../lib/types";

const wellnessData = [
  { name: "Bienestar", value: 78, color: "#14B8A6" },
  { name: "Resto", value: 22, color: "rgba(255,255,255,0.15)" },
];

const weeklyLine = [
  { d: "L", v: 70 }, { d: "M", v: 78 }, { d: "X", v: 65 },
  { d: "J", v: 82 }, { d: "V", v: 75 }, { d: "S", v: 88 }, { d: "D", v: 80 },
];

const metrics = [
  { icon: Droplets, label: "Agua", value: "1.6L", target: "2L", pct: 80, color: "#2563EB", sub: "+0.4L pendiente" },
  { icon: Activity, label: "Pasos", value: "6,240", target: "10k", pct: 62, color: "#22C55E", sub: "3,760 restantes" },
  { icon: Moon, label: "Sueño", value: "7.5h", target: "8h", pct: 94, color: "#8B5CF6", sub: "Muy bueno" },
  { icon: Heart, label: "Frec. cardiaca", value: "72 bpm", target: "Normal", pct: 85, color: "#EF4444", sub: "En rango" },
];

const moods = [
  { label: "Excelente", color: "#22C55E", emoji: "😄" },
  { label: "Bien", color: "#14B8A6", emoji: "🙂" },
  { label: "Regular", color: "#F59E0B", emoji: "😐" },
  { label: "Mal", color: "#EF4444", emoji: "😔" },
];

const aiTips = [
  { icon: Apple, text: "Tu fibra está baja. Añade espinacas o legumbres hoy.", color: "#22C55E", tag: "Nutrición" },
  { icon: Droplets, text: "Te faltan 400ml para tu meta de hidratación.", color: "#2563EB", tag: "Agua" },
  { icon: Zap, text: "Sueño mejorado +12% esta semana. ¡Excelente ritmo!", color: "#F59E0B", tag: "Sueño" },
];

const quickActions = [
  { label: "Registrar síntoma", path: "/registro", emoji: "🩺", color: "#EF4444" },
  { label: "Medicamentos", path: "/medicamentos", emoji: "💊", color: "#0F766E" },
  { label: "Mis citas", path: "/citas", emoji: "📅", color: "#2563EB" },
  { label: "Chatbot IA", path: "/chatbot", emoji: "🤖", color: "#8B5CF6" },
  { label: "Mis hábitos", path: "/habitos", emoji: "💪", color: "#22C55E" },
  { label: "Historial médico", path: "/medical-history", emoji: "📋", color: "#F59E0B" },
];

export function DashboardScreen() {
  const navigate = useNavigate();
  const { dark } = useTheme();
  const [selectedMood, setSelectedMood] = useState<number | null>(null);
  const [userName, setUserName] = useState(localStorage.getItem("userName") || "Usuario");
  const [summary, setSummary] = useState<DashboardSummary | null>(null);
  const [airQuality, setAirQuality] = useState<AirQuality | null>(null);
  const [savingMood, setSavingMood] = useState(false);

  useEffect(() => {
    apiRequest<DashboardSummary>("/dashboard/summary")
      .then(setSummary)
      .catch(() => null);

    apiRequest<{ name: string }>("/auth/me")
      .then((profile) => setUserName(profile.name))
      .catch(() => null);

    apiRequest<AirQuality>("/external/air-quality?latitude=20.27&longitude=-97.96")
      .then(setAirQuality)
      .catch(() => null);
  }, []);

  const hour = new Date().getHours();
  const greeting = hour < 12 ? "Buenos días" : hour < 18 ? "Buenas tardes" : "Buenas noches";
  const greetingEmoji = hour < 12 ? "☀️" : hour < 18 ? "👋" : "🌙";

  const bg = dark ? "#0F172A" : "#F4F6FB";
  const cardBg = dark ? "#1E293B" : "#FFFFFF";
  const cardBorder = dark ? "rgba(255,255,255,0.07)" : "rgba(226,232,240,1)";
  const textMain = dark ? "#F1F5F9" : "#0F172A";
  const textMuted = dark ? "#64748B" : "#94A3B8";

  const latest = summary?.latestHealthRecord;
  const waterLiters = latest?.waterGlasses == null ? 0 : Number(latest.waterGlasses) * 0.25;
  const steps = Number(latest?.steps ?? 0);
  const sleep = Number(latest?.sleepHours ?? 0);
  const heartRate = Number(latest?.heartRate ?? 0);
  const metrics = [
    { icon: Droplets, label: "Agua", value: `${waterLiters.toFixed(1)}L`, target: "2L", pct: Math.min(100, Math.round((waterLiters / 2) * 100)), color: "#2563EB", sub: latest ? `${latest.waterGlasses ?? 0} vasos registrados` : "Sin registro de hoy" },
    { icon: Activity, label: "Pasos", value: steps.toLocaleString("es-MX"), target: "10k", pct: Math.min(100, Math.round((steps / 10000) * 100)), color: "#22C55E", sub: latest ? `${Math.max(0, 10000 - steps).toLocaleString("es-MX")} restantes` : "Sin registro de hoy" },
    { icon: Moon, label: "Sueño", value: `${sleep.toFixed(1)}h`, target: "8h", pct: Math.min(100, Math.round((sleep / 8) * 100)), color: "#8B5CF6", sub: latest ? (sleep >= 7 ? "Dentro de la meta" : "Puedes mejorar el descanso") : "Sin registro de hoy" },
    { icon: Heart, label: "Frec. cardiaca", value: heartRate ? `${heartRate} bpm` : "—", target: "Orientativo", pct: heartRate ? Math.min(100, Math.round((heartRate / 100) * 100)) : 0, color: "#EF4444", sub: latest ? "Último registro" : "Sin registro de hoy" },
  ];

  const handleMood = async (i: number) => {
    if (savingMood) return;
    const moodMap: HealthRecord["mood"][] = ["muy_bien", "bien", "neutral", "mal"];
    const today = new Date().toISOString().slice(0, 10);
    setSavingMood(true);
    try {
      const records = await apiRequest<HealthRecord[]>(`/health-records?from=${today}&to=${today}&limit=1`);
      if (records[0]) {
        await apiRequest(`/health-records/${records[0].id}`, { method: "PATCH", body: JSON.stringify({ mood: moodMap[i] }) });
      } else {
        await apiRequest("/health-records", { method: "POST", body: JSON.stringify({ recordDate: today, mood: moodMap[i] }) });
      }
      setSelectedMood(i);
      toast.success(`Estado "${moods[i].label}" registrado`);
    } catch (error) {
      toast.error(error instanceof Error ? error.message : "No se pudo registrar el estado");
    } finally {
      setSavingMood(false);
    }
  };

  return (
    <div className="h-full overflow-y-auto transition-colors" style={{ backgroundColor: bg }}>
      {/* ── Header ── */}
      <div
        className="relative px-5 pt-12 pb-6 overflow-hidden"
        style={{ background: "linear-gradient(140deg, #0D6B64 0%, #0F766E 50%, #1D4ED8 100%)", borderRadius: 0 }}
      >
        <div className="absolute top-[-40px] right-[-40px] w-40 h-40 rounded-full bg-white/5 pointer-events-none" />
        <div className="absolute bottom-[-20px] left-20 w-24 h-24 rounded-full bg-white/5 pointer-events-none" />

        {/* Top bar */}
        <div className="flex items-center justify-between mb-5 relative">
          <ImageWithFallback
            src={vitalMindLogo}
            alt="VitalMind AI"
            className="h-9 w-auto object-contain"
            style={{ filter: "brightness(0) invert(1)" }}
          />
          <button
            onClick={() => navigate("/notificaciones")}
            className="w-10 h-10 bg-white/15 rounded-full flex items-center justify-center relative border border-white/25"
          >
            <Bell size={18} className="text-white" />
            <span className="absolute top-1.5 right-1.5 w-2 h-2 bg-[#F59E0B] rounded-full ring-1 ring-white/30" />
          </button>
        </div>

        {/* Greeting */}
        <p className="text-white/60 text-sm mb-0.5">{greeting} {greetingEmoji}</p>
        <h1 className="text-2xl font-bold text-white capitalize mb-5">{userName}</h1>

        {/* Wellness card */}
        <div className="bg-white/12 backdrop-blur-sm rounded-[24px] p-4 border border-white/20 flex items-center gap-4">
          <div className="relative w-[88px] h-[88px] flex-shrink-0">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie data={wellnessData} cx="50%" cy="50%" innerRadius={30} outerRadius={42} dataKey="value" startAngle={90} endAngle={-270} strokeWidth={0}>
                  {wellnessData.map((e) => <Cell key={`dash-${e.name}`} fill={e.color} />)}
                </Pie>
              </PieChart>
            </ResponsiveContainer>
            <div className="absolute inset-0 flex flex-col items-center justify-center">
              <span className="text-xl font-bold text-white leading-none">{summary?.wellnessScore ?? 78}</span>
              <span className="text-white/50 text-[9px] font-medium">pts</span>
            </div>
          </div>
          <div className="flex-1">
            <p className="text-white/60 text-xs mb-0.5">Bienestar general</p>
            <p className="text-white font-bold text-lg leading-tight mb-1">Excelente estado</p>
            <div className="flex items-center gap-1.5">
              <TrendingUp size={12} className="text-[#4ADE80]" />
              <span className="text-[#4ADE80] text-xs font-semibold">+{summary ? 5 : 0}% vs. semana pasada</span>
            </div>
          </div>
          <div className="w-20 h-10 flex-shrink-0 opacity-70">
            <ResponsiveContainer width="100%" height="100%">
              <LineChart data={weeklyLine}>
                <Line type="monotone" dataKey="v" stroke="#4ADE80" strokeWidth={2} dot={false} />
              </LineChart>
            </ResponsiveContainer>
          </div>
        </div>
      </div>

      <div className="px-5 mt-5 space-y-5 pb-6">
        {/* ── Metrics 2×2 ── */}
        <section>
          <div className="flex items-center justify-between mb-3">
            <h2 className="text-base font-bold" style={{ color: textMain }}>Resumen de hoy</h2>
            <button onClick={() => navigate("/graficas")} className="text-[#0F766E] text-xs font-semibold flex items-center gap-0.5">
              Gráficas <ChevronRight size={14} />
            </button>
          </div>
          <div className="grid grid-cols-2 gap-3">
            {metrics.map((m) => {
              const Icon = m.icon;
              return (
                <motion.div
                  key={m.label}
                  whileTap={{ scale: 0.97 }}
                  className="rounded-[20px] p-4 shadow-sm border"
                  style={{ backgroundColor: cardBg, borderColor: cardBorder }}
                >
                  <div className="flex items-start justify-between mb-2">
                    <div className="w-9 h-9 rounded-xl flex items-center justify-center" style={{ backgroundColor: m.color + "18" }}>
                      <Icon size={18} style={{ color: m.color }} />
                    </div>
                    <span className="text-[10px] font-medium px-2 py-0.5 rounded-full" style={{ color: textMuted, backgroundColor: dark ? "rgba(255,255,255,0.05)" : "#F1F5F9" }}>{m.target}</span>
                  </div>
                  <p className="text-lg font-bold leading-tight" style={{ color: textMain }}>{m.value}</p>
                  <p className="text-[11px] mt-0.5 mb-2" style={{ color: textMuted }}>{m.label}</p>
                  <div className="h-1.5 rounded-full overflow-hidden" style={{ backgroundColor: dark ? "rgba(255,255,255,0.08)" : "#F1F5F9" }}>
                    <motion.div
                      initial={{ width: 0 }}
                      animate={{ width: `${m.pct}%` }}
                      transition={{ duration: 1, delay: 0.2 }}
                      className="h-full rounded-full"
                      style={{ backgroundColor: m.color }}
                    />
                  </div>
                  <p className="text-[10px] mt-1.5" style={{ color: m.color }}>{m.sub}</p>
                </motion.div>
              );
            })}
          </div>
        </section>

        {/* ── Medicamentos + Citas mini cards ── */}
        <section className="grid grid-cols-2 gap-3">
          {/* Medicamentos de hoy */}
          <button
            onClick={() => navigate("/medicamentos")}
            className="rounded-[20px] p-4 shadow-sm border flex flex-col gap-2 text-left active:scale-95 transition-all"
            style={{ backgroundColor: cardBg, borderColor: cardBorder }}
          >
            <div className="w-10 h-10 rounded-[12px] flex items-center justify-center" style={{ backgroundColor: "#0F766E18" }}>
              <Pill size={20} style={{ color: "#0F766E" }} />
            </div>
            <div>
              <p className="text-[11px] font-medium" style={{ color: textMuted }}>Medicamentos</p>
              <p className="text-base font-bold leading-tight" style={{ color: textMain }}>2 de 5</p>
                <p className="text-[10px]" style={{ color: "#0F766E" }}>{summary ? `${summary.medications.taken} de ${summary.medications.total}` : "tomados hoy"}</p>
            </div>
            <div className="h-1.5 rounded-full overflow-hidden w-full" style={{ backgroundColor: dark ? "rgba(255,255,255,0.08)" : "#F1F5F9" }}>
                <div className="h-full rounded-full bg-[#0F766E]" style={{ width: `${summary ? summary.medications.adherence : 40}%` }} />
            </div>
          </button>

          {/* Próxima cita */}
          <button
            onClick={() => navigate("/citas")}
            className="rounded-[20px] p-4 shadow-sm border flex flex-col gap-2 text-left active:scale-95 transition-all"
            style={{ backgroundColor: cardBg, borderColor: cardBorder }}
          >
            <div className="w-10 h-10 rounded-[12px] flex items-center justify-center" style={{ backgroundColor: "#2563EB18" }}>
              <Calendar size={20} style={{ color: "#2563EB" }} />
            </div>
            <div>
              <p className="text-[11px] font-medium" style={{ color: textMuted }}>Próxima cita</p>
              <p className="text-base font-bold leading-tight" style={{ color: textMain }}>{summary ? String(summary.appointments.upcoming) : "15 jul"}</p>
              <p className="text-[10px]" style={{ color: "#2563EB" }}>{summary ? `${summary.appointments.upcoming} próximas` : "Cardiología 10:30"}</p>
            </div>
            <div className="flex items-center gap-1">
              <Check size={11} style={{ color: "#22C55E" }} />
              <span className="text-[10px]" style={{ color: "#22C55E" }}>Confirmada</span>
            </div>
          </button>
        </section>

        {/* ── Calidad del aire externa ── */}
        <section
          className="rounded-[20px] p-5 shadow-sm border"
          style={{ backgroundColor: cardBg, borderColor: cardBorder }}
        >
          <div className="flex items-start gap-3">
            <div className="w-11 h-11 rounded-2xl flex items-center justify-center bg-sky-500/10 text-sky-600">
              <Wind size={22} />
            </div>
            <div className="flex-1">
              <div className="flex items-center justify-between gap-2">
                <h3 className="text-sm font-bold" style={{ color: textMain }}>Calidad del aire</h3>
                <button onClick={() => navigate("/servicios")} className="text-xs font-semibold text-[#0F766E]">Ver servicios</button>
              </div>
              {airQuality ? (
                <>
                  <p className="mt-1 text-xl font-bold" style={{ color: textMain }}>AQI {airQuality.aqi} · {airQuality.category}</p>
                  <p className="mt-1 text-xs" style={{ color: textMuted }}>PM2.5: {airQuality.pollutants.pm25 ?? "—"} · PM10: {airQuality.pollutants.pm10 ?? "—"}</p>
                </>
              ) : (
                <p className="mt-2 text-xs" style={{ color: textMuted }}>No fue posible cargar el servicio en este momento.</p>
              )}
              <p className="mt-2 text-[10px]" style={{ color: textMuted }}>Ubicación de referencia: Xicotepec. Información orientativa.</p>
            </div>
          </div>
        </section>

        {/* ── Mood ── */}
        <section className="rounded-[20px] p-5 shadow-sm border" style={{ backgroundColor: cardBg, borderColor: cardBorder }}>
          <h3 className="text-sm font-bold mb-1" style={{ color: textMain }}>¿Cómo te sientes hoy?</h3>
          <p className="text-xs mb-4" style={{ color: textMuted }}>Toca para registrar tu estado emocional</p>
          <div className="flex gap-2">
            {moods.map((m, i) => (
              <button
                key={m.label}
                onClick={() => handleMood(i)}
                disabled={savingMood}
                className="flex-1 disabled:opacity-60 flex flex-col items-center gap-1.5 py-3 rounded-[16px] border-2 transition-all active:scale-95"
                style={{
                  borderColor: selectedMood === i ? m.color : dark ? "rgba(255,255,255,0.08)" : "#F1F5F9",
                  backgroundColor: selectedMood === i ? m.color + "18" : dark ? "rgba(255,255,255,0.03)" : "#F8FAFC",
                }}
              >
                <span className="text-xl">{m.emoji}</span>
                <span className="text-[9px] font-semibold" style={{ color: selectedMood === i ? m.color : textMuted }}>
                  {m.label}
                </span>
              </button>
            ))}
          </div>
        </section>

        {/* ── AI Tips ── */}
        <section>
          <div className="flex items-center gap-2 mb-3">
            <div className="w-5 h-5 bg-[#F59E0B] rounded-lg flex items-center justify-center">
              <Sparkles size={12} className="text-white" />
            </div>
            <h2 className="text-base font-bold flex-1" style={{ color: textMain }}>Consejos IA para hoy</h2>
            <button onClick={() => navigate("/ia")} className="text-[#0F766E] text-xs font-semibold flex items-center gap-0.5">
              Ver todos <ChevronRight size={14} />
            </button>
          </div>
          <div className="space-y-2.5">
            {aiTips.map((tip, i) => {
              const Icon = tip.icon;
              return (
                <motion.div
                  key={i}
                  initial={{ opacity: 0, x: -8 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ delay: i * 0.08 }}
                  className="rounded-[18px] p-3.5 shadow-sm border flex gap-3 items-start"
                  style={{ backgroundColor: cardBg, borderColor: cardBorder }}
                >
                  <div className="w-8 h-8 rounded-xl flex items-center justify-center flex-shrink-0" style={{ backgroundColor: tip.color + "18" }}>
                    <Icon size={16} style={{ color: tip.color }} />
                  </div>
                  <div className="flex-1">
                    <span className="text-[10px] font-bold px-2 py-0.5 rounded-full mr-2" style={{ backgroundColor: tip.color + "15", color: tip.color }}>
                      {tip.tag}
                    </span>
                    <p className="text-sm leading-relaxed mt-1" style={{ color: textMuted }}>{tip.text}</p>
                  </div>
                </motion.div>
              );
            })}
          </div>
        </section>

        {/* ── Quick actions ── */}
        <section>
          <h2 className="text-base font-bold mb-3" style={{ color: textMain }}>Acceso rápido</h2>
          <div className="grid grid-cols-3 gap-2">
            {quickActions.map((a) => (
              <button
                key={a.path}
                onClick={() => navigate(a.path)}
                className="flex flex-col items-center gap-2 rounded-[16px] py-3.5 px-1 shadow-sm border active:scale-95 transition-all"
                style={{ backgroundColor: cardBg, borderColor: cardBorder }}
              >
                <div className="w-10 h-10 rounded-[12px] flex items-center justify-center text-xl" style={{ backgroundColor: a.color + "15" }}>
                  {a.emoji}
                </div>
                <p className="text-[9px] font-semibold text-center leading-tight" style={{ color: textMuted }}>{a.label}</p>
              </button>
            ))}
          </div>
        </section>
      </div>

      {/* FAB */}
      <button
        onClick={() => navigate("/registro")}
        className="fixed z-50 bottom-24 right-5 w-14 h-14 rounded-full flex items-center justify-center shadow-xl active:scale-95 transition-all"
        style={{ background: "linear-gradient(135deg, #0F766E, #2563EB)", boxShadow: "0 8px 24px rgba(15,118,110,0.4)" }}
      >
        <Plus size={24} className="text-white" />
      </button>
    </div>
  );
}
