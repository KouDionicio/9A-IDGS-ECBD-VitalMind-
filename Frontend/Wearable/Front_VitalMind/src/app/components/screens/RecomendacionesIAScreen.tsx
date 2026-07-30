import { useEffect, useMemo, useState } from "react";
import { useNavigate } from "react-router";
import { Activity, AlertTriangle, Brain, ChevronRight, Dumbbell, Loader2, MessageSquare, Moon, Sparkles } from "lucide-react";
import { apiRequest } from "../../lib/api";
import type { DashboardSummary, Exercise } from "../../lib/types";

export function RecomendacionesIAScreen() {
  const navigate = useNavigate();
  const [summary, setSummary] = useState<DashboardSummary | null>(null);
  const [exercises, setExercises] = useState<Exercise[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    Promise.all([
      apiRequest<DashboardSummary>("/dashboard/summary"),
      apiRequest<Exercise[]>("/external/exercises?search=&limit=4"),
    ])
      .then(([dashboard, rows]) => { setSummary(dashboard); setExercises(rows); })
      .catch((reason) => setError(reason instanceof Error ? reason.message : "No se pudieron cargar las recomendaciones"))
      .finally(() => setLoading(false));
  }, []);

  const recommendations = useMemo(() => {
    const latest = summary?.latestHealthRecord;
    const items: Array<{ title: string; text: string; icon: typeof Activity; color: string }> = [];
    if (!latest) {
      items.push({ title: "Completa tu registro", text: "Agrega síntomas, signos vitales y hábitos para obtener sugerencias basadas en tus propios datos.", icon: Activity, color: "#0F766E" });
      return items;
    }
    if ((latest.sleepHours ?? 0) < 7) items.push({ title: "Descanso", text: "Tu último registro muestra menos de 7 horas de sueño. Intenta mantener un horario regular.", icon: Moon, color: "#8B5CF6" });
    if ((latest.waterGlasses ?? 0) < 8) items.push({ title: "Hidratación", text: "Tu registro está por debajo de 8 vasos. Ajusta la meta según las indicaciones de un profesional.", icon: Activity, color: "#2563EB" });
    if ((latest.exerciseMinutes ?? 0) < 30) items.push({ title: "Actividad", text: "Considera actividad ligera y progresiva si tu condición física lo permite.", icon: Dumbbell, color: "#22C55E" });
    if (!items.length) items.push({ title: "Buen progreso", text: "Tus últimos hábitos registrados se encuentran cerca de las metas generales de la aplicación.", icon: Sparkles, color: "#F59E0B" });
    return items;
  }, [summary]);

  return (
    <div className="min-h-full overflow-y-auto bg-slate-50 pb-8">
      <header className="bg-gradient-to-br from-[#0D6B64] via-[#0F766E] to-[#1D4ED8] px-6 pb-8 pt-12 text-white">
        <div className="flex items-center gap-3">
          <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-white/20"><Brain size={27} /></div>
          <div><h1 className="text-2xl font-bold">Recomendaciones orientativas</h1><p className="text-sm text-white/70">Basadas en tus registros y servicios externos</p></div>
        </div>
        <div className="mt-4 flex items-center gap-3 rounded-2xl border border-white/20 bg-white/15 p-4">
          <Sparkles className="text-amber-300" />
          <div className="flex-1"><p className="font-semibold">Bienestar: {summary?.wellnessScore ?? "—"} puntos</p><p className="text-xs text-white/70">No sustituye evaluación médica.</p></div>
          <button onClick={() => navigate("/medical-history")}><ChevronRight /></button>
        </div>
      </header>

      <main className="space-y-5 px-5 pt-5">
        {loading && <div className="flex justify-center py-16"><Loader2 className="animate-spin text-teal-700" /></div>}
        {error && <div className="flex gap-2 rounded-2xl border border-red-200 bg-red-50 p-4 text-sm text-red-700"><AlertTriangle className="shrink-0" size={18} />{error}</div>}

        {!loading && !error && (
          <>
            <section className="space-y-3">
              <h2 className="font-bold text-slate-800">Sugerencias según tu último registro</h2>
              {recommendations.map((item) => {
                const Icon = item.icon;
                return <article key={item.title} className="rounded-2xl border border-slate-200 bg-white p-4 shadow-sm"><div className="flex gap-3"><div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl" style={{ backgroundColor: `${item.color}18`, color: item.color }}><Icon size={20} /></div><div><h3 className="font-bold text-slate-800">{item.title}</h3><p className="mt-1 text-sm leading-relaxed text-slate-600">{item.text}</p></div></div></article>;
              })}
            </section>

            <section className="rounded-2xl border border-slate-200 bg-white p-4 shadow-sm">
              <div className="mb-3 flex items-center justify-between"><div><h2 className="font-bold text-slate-800">Ejercicios desde wger</h2><p className="text-xs text-slate-400">Opciones generales, no tratamientos.</p></div><Dumbbell className="text-blue-600" /></div>
              <div className="space-y-3">{exercises.length ? exercises.map((exercise) => <div key={exercise.id} className="rounded-xl bg-slate-50 p-3"><p className="font-semibold text-slate-700">{exercise.name || "Ejercicio"}</p><p className="mt-1 text-xs text-slate-500">{exercise.category || "Actividad general"}{exercise.muscles.length ? ` · ${exercise.muscles.join(", ")}` : ""}</p></div>) : <p className="text-sm text-slate-500">No hubo resultados del servicio externo.</p>}</div>
              <button onClick={() => navigate("/servicios")} className="mt-4 w-full rounded-xl border border-teal-200 py-2.5 text-sm font-semibold text-teal-700">Explorar servicios externos</button>
            </section>

            <button onClick={() => navigate("/chatbot")} className="flex w-full items-center gap-4 rounded-2xl bg-gradient-to-r from-[#0F766E] to-[#14B8A6] p-5 text-white shadow-lg"><div className="flex h-11 w-11 items-center justify-center rounded-xl bg-white/20"><MessageSquare /></div><div className="flex-1 text-left"><p className="font-bold">Chatbot informativo</p><p className="text-sm text-white/70">Consulta orientación general</p></div><ChevronRight /></button>
          </>
        )}
      </main>
    </div>
  );
}
