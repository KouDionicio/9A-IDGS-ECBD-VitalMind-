import { FormEvent, useState } from "react";
import { useNavigate } from "react-router";
import { ChevronLeft, Loader2, Save } from "lucide-react";
import { toast } from "sonner";
import { apiRequest } from "../../lib/api";
import type { HealthRecord, Mood } from "../../lib/types";

const initial = {
  recordDate: new Date().toISOString().slice(0, 10), symptoms: "", mood: "neutral" as Mood, painLevel: "0",
  temperature: "", weight: "", heartRate: "", systolicPressure: "", diastolicPressure: "",
  oxygenSaturation: "", sleepHours: "", waterGlasses: "", steps: "", exerciseMinutes: "", notes: "",
};

const moods: Array<{ value: Mood; label: string; emoji: string }> = [
  { value: "muy_mal", label: "Muy mal", emoji: "😞" }, { value: "mal", label: "Mal", emoji: "🙁" },
  { value: "neutral", label: "Neutral", emoji: "😐" }, { value: "bien", label: "Bien", emoji: "🙂" },
  { value: "muy_bien", label: "Muy bien", emoji: "😄" },
];

export function RegistroScreen() {
  const navigate = useNavigate();
  const [form, setForm] = useState(initial);
  const [saving, setSaving] = useState(false);
  const set = (name: keyof typeof form, value: string) => setForm((current) => ({ ...current, [name]: value }));
  const optionalNumber = (value: string) => value === "" ? null : Number(value);

  const submit = async (event: FormEvent) => {
    event.preventDefault(); setSaving(true);
    try {
      await apiRequest<HealthRecord>("/health-records", { method: "POST", body: JSON.stringify({
        recordDate: form.recordDate, symptoms: form.symptoms || null, mood: form.mood, painLevel: optionalNumber(form.painLevel),
        temperature: optionalNumber(form.temperature), weight: optionalNumber(form.weight), heartRate: optionalNumber(form.heartRate),
        systolicPressure: optionalNumber(form.systolicPressure), diastolicPressure: optionalNumber(form.diastolicPressure),
        oxygenSaturation: optionalNumber(form.oxygenSaturation), sleepHours: optionalNumber(form.sleepHours),
        waterGlasses: optionalNumber(form.waterGlasses), steps: optionalNumber(form.steps), exerciseMinutes: optionalNumber(form.exerciseMinutes), notes: form.notes || null,
      }) });
      toast.success("Registro guardado correctamente"); navigate("/medical-history");
    } catch (error) { toast.error(error instanceof Error ? error.message : "No se pudo guardar"); }
    finally { setSaving(false); }
  };

  const input = "w-full rounded-xl border border-slate-200 bg-white px-3 py-2.5 text-sm outline-none focus:border-[#0F766E]";
  return <div className="min-h-full bg-slate-50 pb-8">
    <header className="px-5 pt-10 pb-7 text-white bg-gradient-to-br from-[#0F766E] to-[#1D4ED8]">
      <div className="flex items-center gap-3"><button onClick={()=>navigate(-1)} className="w-9 h-9 rounded-full bg-white/20 flex items-center justify-center"><ChevronLeft size={20}/></button><div><h1 className="text-2xl font-bold">Registro de salud</h1><p className="text-white/75 text-sm">Guarda síntomas, signos vitales y hábitos</p></div></div>
    </header>
    <form onSubmit={submit} className="px-5 mt-5 space-y-5">
      <section className="bg-white rounded-2xl border border-slate-200 p-4 shadow-sm space-y-4">
        <label className="block text-sm font-semibold text-slate-700">Fecha<input type="date" value={form.recordDate} onChange={e=>set("recordDate",e.target.value)} className={`${input} mt-1`} required/></label>
        <div><p className="text-sm font-semibold text-slate-700 mb-2">Estado de ánimo</p><div className="grid grid-cols-5 gap-2">{moods.map(m=><button type="button" key={m.value} onClick={()=>set("mood",m.value)} className={`rounded-xl border p-2 text-center ${form.mood===m.value?"border-[#0F766E] bg-emerald-50":"border-slate-200"}`}><span className="text-xl">{m.emoji}</span><span className="block text-[10px] text-slate-600">{m.label}</span></button>)}</div></div>
        <label className="block text-sm font-semibold text-slate-700">Síntomas<textarea value={form.symptoms} onChange={e=>set("symptoms",e.target.value)} className={`${input} mt-1 min-h-24`} placeholder="Describe cómo te sientes"/></label>
        <label className="block text-sm font-semibold text-slate-700">Nivel de dolor: {form.painLevel}/10<input type="range" min="0" max="10" value={form.painLevel} onChange={e=>set("painLevel",e.target.value)} className="w-full mt-2 accent-[#0F766E]"/></label>
      </section>
      <section className="bg-white rounded-2xl border border-slate-200 p-4 shadow-sm">
        <h2 className="font-bold text-slate-800 mb-3">Signos vitales</h2><div className="grid grid-cols-2 gap-3">
          {[ ["temperature","Temperatura °C"],["weight","Peso kg"],["heartRate","Frecuencia bpm"],["oxygenSaturation","Oxígeno %"],["systolicPressure","Presión sistólica"],["diastolicPressure","Presión diastólica"] ].map(([key,label])=><label key={key} className="text-xs font-medium text-slate-600">{label}<input type="number" step="0.1" value={form[key as keyof typeof form]} onChange={e=>set(key as keyof typeof form,e.target.value)} className={`${input} mt-1`}/></label>)}
        </div>
      </section>
      <section className="bg-white rounded-2xl border border-slate-200 p-4 shadow-sm">
        <h2 className="font-bold text-slate-800 mb-3">Hábitos del día</h2><div className="grid grid-cols-2 gap-3">
          {[ ["sleepHours","Sueño (horas)"],["waterGlasses","Vasos de agua"],["steps","Pasos"],["exerciseMinutes","Ejercicio (min)"] ].map(([key,label])=><label key={key} className="text-xs font-medium text-slate-600">{label}<input type="number" step="0.1" value={form[key as keyof typeof form]} onChange={e=>set(key as keyof typeof form,e.target.value)} className={`${input} mt-1`}/></label>)}
        </div><label className="block text-sm font-semibold text-slate-700 mt-3">Notas<textarea value={form.notes} onChange={e=>set("notes",e.target.value)} className={`${input} mt-1 min-h-20`}/></label>
      </section>
      <button disabled={saving} className="w-full rounded-2xl bg-[#0F766E] py-4 text-white font-semibold flex items-center justify-center gap-2 disabled:opacity-60">{saving?<Loader2 size={19} className="animate-spin"/>:<Save size={19}/>}Guardar registro</button>
    </form>
  </div>;
}
