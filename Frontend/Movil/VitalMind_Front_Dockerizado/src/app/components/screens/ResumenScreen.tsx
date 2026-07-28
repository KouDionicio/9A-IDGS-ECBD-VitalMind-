import { useNavigate } from "react-router";
import { ChevronRight, TrendingUp, AlertCircle, Sparkles } from "lucide-react";
import { motion } from "motion/react";
import { PieChart, Pie, Cell, ResponsiveContainer, BarChart, Bar, XAxis, YAxis, Tooltip } from "recharts";

const wellnessData = [
  { name: "Bienestar", value: 78, color: "#0F766E" },
  { name: "Resto", value: 22, color: "#F1F5F9" },
];

const weeklyActivity = [
  { day: "L", value: 70 },
  { day: "M", value: 85 },
  { day: "X", value: 60 },
  { day: "J", value: 90 },
  { day: "V", value: 75 },
  { day: "S", value: 95 },
  { day: "D", value: 80 },
];

const symptoms = [
  { label: "Dolor de cabeza", count: 2, color: "#EF4444" },
  { label: "Cansancio", count: 5, color: "#F59E0B" },
  { label: "Estrés", count: 3, color: "#8B5CF6" },
];

const habits = [
  { label: "Agua", pct: 80, color: "#2563EB" },
  { label: "Ejercicio", pct: 60, color: "#22C55E" },
  { label: "Sueño", pct: 93, color: "#8B5CF6" },
  { label: "Meditación", pct: 40, color: "#F59E0B" },
];

const aiInsights = [
  "Tu frecuencia cardiaca promedio bajó 4 bpm. ¡Excelente progreso cardiovascular!",
  "Dormiste 7.5h en promedio. Intenta mantener rutinas de sueño constantes.",
  "Tu hidratación mejoró un 18% esta semana. Sigue así.",
];

export function ResumenScreen() {
  const navigate = useNavigate();

  return (
    <div className="h-full bg-[#F8FAFC] overflow-y-auto">
      {/* Header */}
      <div className="px-5 pt-12 pb-8" style={{ background: "linear-gradient(140deg, #0D6B64 0%, #0F766E 45%, #1D4ED8 100%)" }}>
        <h1 className="text-2xl font-bold text-white mb-1">Mi Resumen</h1>
        <p className="text-white/70 text-sm">Semana del 24 – 30 junio</p>

        {/* Wellness indicator */}
        <div className="mt-5 bg-white/15 backdrop-blur-md rounded-[24px] p-5 border border-white/20 flex items-center gap-4">
          <div className="w-28 h-28 flex-shrink-0 relative">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie data={wellnessData} cx="50%" cy="50%" innerRadius={34} outerRadius={48} dataKey="value" startAngle={90} endAngle={-270} isAnimationActive={false}>
                  {wellnessData.map((e) => <Cell key={`w-${e.name}`} fill={e.color} />)}
                </Pie>
              </PieChart>
            </ResponsiveContainer>
            <div className="absolute inset-0 flex flex-col items-center justify-center">
              <span className="text-2xl font-bold text-white">78</span>
              <span className="text-white/60 text-xs">pts</span>
            </div>
          </div>
          <div className="flex-1">
            <p className="text-white/70 text-xs mb-1">Nivel de bienestar</p>
            <p className="text-xl font-bold text-white mb-1">Excelente</p>
            <div className="flex items-center gap-1 text-[#4ADE80] text-sm font-medium">
              <TrendingUp className="w-4 h-4" />
              <span>+5% vs. semana anterior</span>
            </div>
          </div>
        </div>
      </div>

      <div className="px-5 mt-6 space-y-6 pb-4">
        {/* Weekly activity chart */}
        <div className="bg-white rounded-[20px] p-5 border border-[#E2E8F0] shadow-sm">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-base font-bold text-slate-800">Actividad semanal</h2>
            <button onClick={() => navigate("/graficas")} className="text-[#0F766E] text-xs font-medium flex items-center gap-0.5">
              Ver gráficas <ChevronRight className="w-3 h-3" />
            </button>
          </div>
          <div className="h-36">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={weeklyActivity} barSize={20}>
                <XAxis dataKey="day" axisLine={false} tickLine={false} tick={{ fontSize: 12, fill: "#94A3B8" }} />
                <YAxis hide />
                <Tooltip
                  contentStyle={{ backgroundColor: "white", border: "1px solid #E2E8F0", borderRadius: 12, fontSize: 12 }}
                  cursor={{ fill: "#F1F5F9", radius: 8 }}
                />
                <Bar dataKey="value" radius={[8, 8, 0, 0]} isAnimationActive={false}>
                  {weeklyActivity.map((entry, i) => (
                    <Cell key={`bar-${entry.day}`} fill={i === 5 ? "#0F766E" : "#14B8A6"} fillOpacity={i === 5 ? 1 : 0.5} />
                  ))}
                </Bar>
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>

        {/* Symptoms registered */}
        <div className="bg-white rounded-[20px] p-5 border border-[#E2E8F0] shadow-sm">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-base font-bold text-slate-800">Síntomas registrados</h2>
            <button onClick={() => navigate("/registro")} className="text-[#0F766E] text-xs font-medium">
              Registrar
            </button>
          </div>
          <div className="space-y-3">
            {symptoms.map((s) => (
              <div key={s.label} className="flex items-center gap-3">
                <AlertCircle className="w-4 h-4 flex-shrink-0" style={{ color: s.color }} />
                <span className="text-sm text-slate-600 flex-1">{s.label}</span>
                <span className="text-xs font-semibold px-2.5 py-1 rounded-full" style={{ backgroundColor: s.color + "15", color: s.color }}>
                  {s.count}x
                </span>
              </div>
            ))}
          </div>
        </div>

        {/* Healthy habits */}
        <div className="bg-white rounded-[20px] p-5 border border-[#E2E8F0] shadow-sm">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-base font-bold text-slate-800">Hábitos saludables</h2>
            <button onClick={() => navigate("/habitos")} className="text-[#0F766E] text-xs font-medium flex items-center gap-0.5">
              Ver todos <ChevronRight className="w-3 h-3" />
            </button>
          </div>
          <div className="space-y-4">
            {habits.map((h) => (
              <div key={h.label}>
                <div className="flex justify-between mb-1.5">
                  <span className="text-sm text-slate-600 font-medium">{h.label}</span>
                  <span className="text-sm font-bold" style={{ color: h.color }}>{h.pct}%</span>
                </div>
                <div className="h-2 bg-[#F1F5F9] rounded-full overflow-hidden">
                  <motion.div
                    initial={{ width: 0 }}
                    animate={{ width: `${h.pct}%` }}
                    transition={{ duration: 0.8 }}
                    className="h-full rounded-full"
                    style={{ backgroundColor: h.color }}
                  />
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* AI Insights */}
        <div>
          <div className="flex items-center gap-2 mb-3">
            <Sparkles className="w-5 h-5 text-[#F59E0B]" />
            <h2 className="text-base font-bold text-slate-800">Insights generados por IA</h2>
          </div>
          <div className="space-y-3">
            {aiInsights.map((insight, i) => (
              <motion.div
                key={i}
                initial={{ opacity: 0, y: 8 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: i * 0.1 }}
                className="bg-gradient-to-r from-[#0F766E]/5 to-[#14B8A6]/5 border border-[#0F766E]/15 rounded-[20px] p-4 flex gap-3"
              >
                <div className="w-2 h-2 mt-1.5 bg-[#0F766E] rounded-full flex-shrink-0" />
                <p className="text-sm text-slate-600 leading-relaxed">{insight}</p>
              </motion.div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
