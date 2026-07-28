import { useNavigate } from "react-router";
import { useState } from "react";
import { motion } from "motion/react";
import { ChevronRight, ClipboardList, Brain, Activity, Check } from "lucide-react";
import { ImageWithFallback } from "@/components/figma/ImageWithFallback";
import vitalMindLogo from "../../../imports/Captura_de_pantalla_2026-07-07_185523-removebg-preview.png";

const steps = [
  {
    accent: "#2563EB",
    accentLight: "#EFF6FF",
    Icon: ClipboardList,
    title: "Toda tu salud\nen un solo lugar",
    desc: "Guarda enfermedades, alergias, medicamentos, cirugías y vacunas. Accede a tu información cuando la necesites.",
    visual: "history",
    items: [
      { label: "Enfermedades crónicas", pct: 70, color: "#2563EB" },
      { label: "Alergias registradas",  pct: 45, color: "#F59E0B" },
      { label: "Medicamentos activos",  pct: 90, color: "#0F766E" },
    ],
  },
  {
    accent: "#0F766E",
    accentLight: "#F0FDFA",
    Icon: Brain,
    title: "Tu asistente\npersonal de salud",
    desc: "Recibe consejos personalizados con IA. Alimentación, actividad y bienestar emocional adaptados a ti.",
    visual: "chat",
    chat: [
      { text: "¿Cómo me encuentro hoy?", user: true },
      { text: "Tu bienestar está excelente 🎉 Te recomiendo 8 vasos de agua y 30 min de caminata.", user: false },
      { text: "Gracias, lo haré 💪", user: true },
    ],
  },
  {
    accent: "#0F766E",
    accentLight: "#F0FDFA",
    Icon: Activity,
    title: "Monitorea tu\nprogreso diario",
    desc: "Registra síntomas, hábitos y métricas de salud. Visualiza tu evolución con gráficas inteligentes.",
    visual: "chart",
    bars: [55, 72, 63, 88, 74, 95, 80],
    days: ["L", "M", "X", "J", "V", "S", "D"],
  },
];

export function OnboardingFlow() {
  const navigate = useNavigate();
  const [step, setStep] = useState(0);
  const current = steps[step];
  const Icon = current.Icon;
  const isLast = step === steps.length - 1;

  const goNext = () => {
    if (!isLast) {
      setStep((s) => s + 1);
    } else {
      localStorage.setItem("hasOnboarded", "true");
      navigate("/auth");
    }
  };

  return (
    <div className="h-full flex flex-col bg-white overflow-hidden relative">
      {/* Decorative circles — same style as splash */}
      <div className="absolute top-[-100px] right-[-70px] w-72 h-72 rounded-full pointer-events-none" style={{ backgroundColor: "#0F766E0A" }} />
      <div className="absolute top-[15%] left-[-50px] w-44 h-44 rounded-full pointer-events-none" style={{ backgroundColor: "#2563EB07" }} />
      <div className="absolute bottom-[22%] right-[-30px] w-32 h-32 rounded-full pointer-events-none" style={{ backgroundColor: "#14B8A608" }} />
      <div className="absolute bottom-[8%] left-[-20px] w-24 h-24 rounded-full pointer-events-none" style={{ backgroundColor: "#0F766E06" }} />

      {/* Soft top wash */}
      <div
        className="absolute top-0 left-0 right-0 h-[38%] pointer-events-none"
        style={{ background: `linear-gradient(180deg, ${current.accentLight} 0%, white 100%)` }}
      />

      {/* Top bar */}
      <div className="relative z-10 flex items-center justify-between px-6 pt-14 pb-2">
        <ImageWithFallback src={vitalMindLogo} alt="VitalMind AI" className="h-7 w-auto object-contain" />
        <button
          onClick={() => { localStorage.setItem("hasOnboarded", "true"); navigate("/auth"); }}
          className="text-slate-400 text-sm font-medium"
        >
          Omitir
        </button>
      </div>

      {/* Main content */}
      <motion.div
        key={step}
        initial={{ opacity: 0, x: 40 }}
        animate={{ opacity: 1, x: 0 }}
        transition={{ duration: 0.35, ease: [0.22, 1, 0.36, 1] }}
        className="relative z-10 flex-1 flex flex-col px-6 pt-5 pb-2"
      >
        {/* Icon */}
        <div
          className="w-16 h-16 rounded-2xl flex items-center justify-center mb-6 shadow-sm"
          style={{ backgroundColor: current.accentLight }}
        >
          <Icon size={30} style={{ color: current.accent }} strokeWidth={1.5} />
        </div>

        {/* Title + desc */}
        <h2 className="text-[28px] font-bold text-slate-800 leading-tight mb-3" style={{ whiteSpace: "pre-line" }}>
          {current.title}
        </h2>
        <p className="text-slate-400 text-sm leading-relaxed mb-7">
          {current.desc}
        </p>

        {/* Visual */}
        <div className="flex-1 flex flex-col justify-center">

          {/* History bars */}
          {current.visual === "history" && current.items && (
            <div className="bg-white rounded-2xl p-5 border border-slate-100 shadow-sm space-y-4">
              {current.items.map((item, i) => (
                <div key={i}>
                  <div className="flex justify-between mb-1.5">
                    <span className="text-slate-600 text-sm font-medium">{item.label}</span>
                    <span className="text-sm font-bold" style={{ color: item.color }}>{item.pct}%</span>
                  </div>
                  <div className="h-2 bg-slate-100 rounded-full overflow-hidden">
                    <motion.div
                      initial={{ width: 0 }}
                      animate={{ width: `${item.pct}%` }}
                      transition={{ duration: 0.9, delay: 0.15 + i * 0.1 }}
                      className="h-full rounded-full"
                      style={{ backgroundColor: item.color }}
                    />
                  </div>
                </div>
              ))}
            </div>
          )}

          {/* AI Chat */}
          {current.visual === "chat" && current.chat && (
            <div className="bg-white rounded-2xl p-5 border border-slate-100 shadow-sm space-y-3">
              {current.chat.map((msg, i) => (
                <motion.div
                  key={i}
                  initial={{ opacity: 0, y: 8 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: 0.15 + i * 0.22 }}
                  className={`flex ${msg.user ? "justify-end" : "justify-start"}`}
                >
                  {!msg.user && (
                    <div
                      className="w-7 h-7 rounded-full flex items-center justify-center mr-2 flex-shrink-0 self-end"
                      style={{ backgroundColor: current.accentLight }}
                    >
                      <Brain size={14} style={{ color: current.accent }} />
                    </div>
                  )}
                  <div
                    className="rounded-2xl px-4 py-2.5 text-sm max-w-[80%] leading-relaxed"
                    style={msg.user
                      ? { backgroundColor: current.accent, color: "white" }
                      : { backgroundColor: "#F8FAFC", color: "#475569", border: "1px solid #E2E8F0" }
                    }
                  >
                    {msg.text}
                  </div>
                </motion.div>
              ))}
            </div>
          )}

          {/* Habits chart */}
          {current.visual === "chart" && current.bars && (
            <div className="bg-white rounded-2xl p-5 border border-slate-100 shadow-sm">
              <p className="text-slate-500 text-sm font-semibold mb-4">Bienestar semanal</p>
              <div className="flex items-end gap-2 h-24">
                {current.bars.map((val, i) => (
                  <div key={i} className="flex-1 flex flex-col items-center gap-1">
                    <motion.div
                      initial={{ height: 0 }}
                      animate={{ height: `${val}%` }}
                      transition={{ duration: 0.6, delay: i * 0.07 }}
                      className="w-full rounded-t-lg"
                      style={{
                        backgroundColor: i === 5 ? current.accent : current.accent + "28",
                        minHeight: 4,
                      }}
                    />
                    <span className="text-[9px] text-slate-400">{current.days?.[i]}</span>
                  </div>
                ))}
              </div>
              <div className="mt-4 flex gap-2">
                {[
                  { label: "Mejor día", val: "Sáb · 95pts" },
                  { label: "Promedio",  val: "75 pts" },
                  { label: "Racha",     val: "7 días 🔥" },
                ].map((s) => (
                  <div key={s.label} className="flex-1 text-center rounded-xl py-2 border border-slate-100">
                    <p className="text-[9px] text-slate-400 mb-0.5">{s.label}</p>
                    <p className="text-xs font-bold text-slate-700">{s.val}</p>
                  </div>
                ))}
              </div>
            </div>
          )}

        </div>
      </motion.div>

      {/* Bottom */}
      <div className="relative z-10 px-6 pb-10 pt-4">
        {/* Dots */}
        <div className="flex justify-center gap-2 mb-5">
          {steps.map((_, i) => (
            <motion.button
              key={i}
              onClick={() => setStep(i)}
              animate={{ width: i === step ? 28 : 8 }}
              transition={{ duration: 0.3 }}
              className="h-2 rounded-full"
              style={{ backgroundColor: i === step ? current.accent : "#E2E8F0" }}
            />
          ))}
        </div>

        <div className="flex gap-3">
          {step > 0 && (
            <button
              onClick={() => setStep((s) => s - 1)}
              className="w-14 h-14 rounded-xl flex items-center justify-center border border-slate-200 bg-white active:scale-95 transition-all"
            >
              <ChevronRight size={20} className="text-slate-400 rotate-180" />
            </button>
          )}
          <button
            onClick={goNext}
            className="flex-1 h-14 rounded-xl flex items-center justify-center gap-2 font-semibold text-base text-white active:scale-95 transition-all"
            style={{
              background: "linear-gradient(135deg, #0F766E 0%, #2563EB 100%)",
              boxShadow: "0 8px 24px rgba(15,118,110,0.3)",
            }}
          >
            {isLast ? <><Check size={20} />Comenzar ahora</> : <>Continuar<ChevronRight size={20} /></>}
          </button>
        </div>
      </div>
    </div>
  );
}
