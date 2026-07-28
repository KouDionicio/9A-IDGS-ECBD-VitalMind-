import { useEffect, useState } from "react";
import { useNavigate } from "react-router";
import { Activity, ChevronLeft, CloudSun, Dumbbell, Loader2, Pill, Search } from "lucide-react";
import { apiRequest } from "../../lib/api";
import type { AirQuality, Exercise, OpenFdaMedication } from "../../lib/types";

export function ServiciosExternosScreen() {
  const navigate = useNavigate();
  const [drugQuery, setDrugQuery] = useState("aspirin");
  const [drugs, setDrugs] = useState<OpenFdaMedication[]>([]);
  const [exerciseQuery, setExerciseQuery] = useState("squat");
  const [exercises, setExercises] = useState<Exercise[]>([]);
  const [air, setAir] = useState<AirQuality | null>(null);
  const [loading, setLoading] = useState<string | null>(null);
  const [error, setError] = useState("");

  const run = async (key: string, task: () => Promise<void>) => {
    setLoading(key);
    setError("");
    try { await task(); } catch (e) { setError(e instanceof Error ? e.message : "Ocurrió un error"); }
    finally { setLoading(null); }
  };

  const searchDrugs = () => run("drugs", async () => {
    setDrugs(await apiRequest<OpenFdaMedication[]>(`/external/medications/search?query=${encodeURIComponent(drugQuery)}`));
  });

  const searchExercises = () => run("exercises", async () => {
    setExercises(await apiRequest<Exercise[]>(`/external/exercises?search=${encodeURIComponent(exerciseQuery)}`));
  });

  const loadAir = () => run("air", async () => {
    const fallback = { latitude: 20.269, longitude: -97.961 };
    const position = await new Promise<GeolocationPosition | null>((resolve) => {
      if (!navigator.geolocation) return resolve(null);
      navigator.geolocation.getCurrentPosition(resolve, () => resolve(null), { timeout: 5000 });
    });
    const latitude = position?.coords.latitude ?? fallback.latitude;
    const longitude = position?.coords.longitude ?? fallback.longitude;
    setAir(await apiRequest<AirQuality>(`/external/air-quality?latitude=${latitude}&longitude=${longitude}`));
  });

  useEffect(() => { loadAir(); }, []);

  return (
    <div className="min-h-full bg-[#F8FAFC] pb-8">
      <header className="px-6 pt-10 pb-7 text-white" style={{ background: "linear-gradient(135deg,#0F766E,#1D4ED8)" }}>
        <div className="flex items-center gap-3">
          <button onClick={() => navigate(-1)} className="w-9 h-9 rounded-full bg-white/20 flex items-center justify-center"><ChevronLeft size={20}/></button>
          <div><h1 className="text-2xl font-bold">Servicios externos</h1><p className="text-white/75 text-sm">OpenFDA, Open-Meteo y wger</p></div>
        </div>
      </header>

      <main className="px-5 mt-5 space-y-5">
        {error && <div className="rounded-2xl bg-red-50 border border-red-200 p-4 text-sm text-red-700">{error}</div>}

        <section className="bg-white rounded-[22px] border border-slate-200 p-5 shadow-sm">
          <div className="flex items-center gap-3 mb-4"><div className="w-10 h-10 rounded-xl bg-emerald-50 text-emerald-700 flex items-center justify-center"><Pill size={20}/></div><div><h2 className="font-bold text-slate-800">Información de medicamentos</h2><p className="text-xs text-slate-500">Fuente: openFDA</p></div></div>
          <div className="flex gap-2"><input value={drugQuery} onChange={(e)=>setDrugQuery(e.target.value)} className="flex-1 border border-slate-200 rounded-xl px-3 py-2 text-sm" placeholder="Ej. aspirin"/><button disabled={loading!==null || drugQuery.trim().length<2} onClick={searchDrugs} className="px-4 rounded-xl bg-[#0F766E] text-white disabled:opacity-50">{loading==="drugs"?<Loader2 className="animate-spin" size={18}/>:<Search size={18}/>}</button></div>
          <div className="mt-4 space-y-3">
            {drugs.map((drug, index)=><article key={drug.id || index} className="rounded-xl bg-slate-50 p-3"><p className="font-semibold text-slate-800">{drug.brandName || drug.genericName || "Medicamento"}</p><p className="text-xs text-slate-500">{drug.genericName}</p>{drug.purpose&&<p className="text-sm text-slate-600 mt-2 line-clamp-3">{drug.purpose}</p>}{drug.warnings&&<p className="text-xs text-amber-700 mt-2"><b>Advertencia:</b> {drug.warnings.slice(0,240)}...</p>}</article>)}
            {!drugs.length && <p className="text-sm text-slate-400">Realiza una búsqueda para consultar etiquetas públicas.</p>}
          </div>
        </section>

        <section className="bg-white rounded-[22px] border border-slate-200 p-5 shadow-sm">
          <div className="flex items-center gap-3 mb-4"><div className="w-10 h-10 rounded-xl bg-blue-50 text-blue-700 flex items-center justify-center"><CloudSun size={20}/></div><div><h2 className="font-bold text-slate-800">Calidad del aire</h2><p className="text-xs text-slate-500">Fuente: Open-Meteo Air Quality</p></div></div>
          {loading==="air" && <div className="flex items-center gap-2 text-sm text-slate-500"><Loader2 size={17} className="animate-spin"/>Consultando ubicación…</div>}
          {air && <div className="grid grid-cols-2 gap-3"><div className="rounded-xl bg-blue-50 p-4"><p className="text-xs text-blue-600">US AQI</p><p className="text-3xl font-bold text-blue-800">{air.aqi}</p><p className="text-sm text-blue-700">{air.category}</p></div><div className="rounded-xl bg-slate-50 p-4 text-sm text-slate-600"><p>PM2.5: <b>{air.pollutants.pm25 ?? "—"}</b></p><p>PM10: <b>{air.pollutants.pm10 ?? "—"}</b></p><p>Ozono: <b>{air.pollutants.ozone ?? "—"}</b></p></div><p className="col-span-2 text-xs text-slate-400">{air.disclaimer}</p></div>}
          <button onClick={loadAir} disabled={loading!==null} className="mt-3 text-sm font-medium text-blue-700 flex items-center gap-2"><Activity size={16}/>Actualizar</button>
        </section>

        <section className="bg-white rounded-[22px] border border-slate-200 p-5 shadow-sm">
          <div className="flex items-center gap-3 mb-4"><div className="w-10 h-10 rounded-xl bg-violet-50 text-violet-700 flex items-center justify-center"><Dumbbell size={20}/></div><div><h2 className="font-bold text-slate-800">Ejercicios</h2><p className="text-xs text-slate-500">Fuente: wger</p></div></div>
          <div className="flex gap-2"><input value={exerciseQuery} onChange={(e)=>setExerciseQuery(e.target.value)} className="flex-1 border border-slate-200 rounded-xl px-3 py-2 text-sm" placeholder="Ej. squat"/><button disabled={loading!==null} onClick={searchExercises} className="px-4 rounded-xl bg-violet-600 text-white disabled:opacity-50">{loading==="exercises"?<Loader2 className="animate-spin" size={18}/>:<Search size={18}/>}</button></div>
          <div className="mt-4 space-y-3">{exercises.map((item)=><article key={item.id} className="rounded-xl bg-slate-50 p-3"><p className="font-semibold text-slate-800">{item.name}</p><p className="text-xs text-violet-700">{item.category || "Actividad física"}</p><p className="text-sm text-slate-600 mt-2">{item.description || "Sin descripción disponible."}</p></article>)}{!exercises.length&&<p className="text-sm text-slate-400">Busca ejercicios por nombre o categoría.</p>}</div>
          <p className="mt-3 text-xs text-slate-400">Las sugerencias son generales y no constituyen tratamiento médico.</p>
        </section>
      </main>
    </div>
  );
}
