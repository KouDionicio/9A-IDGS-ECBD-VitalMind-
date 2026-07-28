import { useEffect, useMemo, useState } from "react";
import { useNavigate } from "react-router";
import { Activity, Bell, CalendarDays, Clock, FileBarChart, Loader2, Moon, Pill, RefreshCw, Shield, Sun, Users } from "lucide-react";
import { Bar, BarChart, ResponsiveContainer, Tooltip, XAxis, YAxis } from "recharts";
import { apiRequest } from "../../../lib/api";
import { useAdminTheme } from "../../admin/AdminThemeContext";

type Report = {
  generatedAt: string;
  users: { total: number; active: number; inactive: number; pending: number; recent: Array<{ id: number; name: string; email: string; status: string; role: string; createdAt: string }> };
  medications: { total: number; taken: number; adherence: number };
  appointments: { total: number; upcoming: number; completed: number; canceled: number };
  healthRecords: { total: number; usersWithRecords: number };
  recentAudit: Array<{ id: number; actorId: number | null; action: string; entity: string; entityId: string | null; createdAt: string }>;
};

export function AdminDashboardScreen() {
  const navigate = useNavigate();
  const { dark, toggle } = useAdminTheme();
  const [data, setData] = useState<Report | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  const load = () => {
    setLoading(true); setError("");
    apiRequest<Report>("/reports/summary")
      .then(setData)
      .catch((reason) => setError(reason instanceof Error ? reason.message : "No se pudo cargar el dashboard"))
      .finally(() => setLoading(false));
  };
  useEffect(load, []);

  const chart = useMemo(() => data ? [
    { name: "Activos", value: data.users.active },
    { name: "Inactivos", value: data.users.inactive },
    { name: "Pendientes", value: data.users.pending },
  ] : [], [data]);

  const bg = dark ? "#0B1120" : "#F1F5F9";
  const card = dark ? "rgba(255,255,255,0.04)" : "#FFFFFF";
  const border = dark ? "rgba(255,255,255,0.08)" : "#E2E8F0";
  const text = dark ? "#F1F5F9" : "#0F172A";
  const muted = dark ? "#94A3B8" : "#64748B";

  const kpis = data ? [
    { label: "Usuarios", value: data.users.total, detail: `${data.users.active} activos`, icon: Users, color: "#0F766E" },
    { label: "Registros de salud", value: data.healthRecords.total, detail: `${data.healthRecords.usersWithRecords} pacientes`, icon: Activity, color: "#2563EB" },
    { label: "Medicamentos", value: data.medications.total, detail: `${data.medications.adherence}% adherencia`, icon: Pill, color: "#8B5CF6" },
    { label: "Citas", value: data.appointments.total, detail: `${data.appointments.upcoming} próximas`, icon: CalendarDays, color: "#F59E0B" },
  ] : [];

  return (
    <div className="min-h-full overflow-y-auto pb-24" style={{ backgroundColor: bg }}>
      <header className="px-5 pb-5 pt-11">
        <div className="flex items-center justify-between">
          <div><p className="text-xs font-bold uppercase tracking-wider text-teal-600">VitalMind</p><h1 className="text-2xl font-bold" style={{ color: text }}>Dashboard administrativo</h1><p className="text-xs" style={{ color: muted }}>{data ? `Actualizado ${new Date(data.generatedAt).toLocaleString("es-MX")}` : "Datos protegidos por rol"}</p></div>
          <div className="flex gap-2"><button onClick={load} className="flex h-9 w-9 items-center justify-center rounded-full border" style={{ backgroundColor: card, borderColor: border }}><RefreshCw size={16} className={loading ? "animate-spin" : ""} style={{ color: muted }} /></button><button onClick={toggle} className="flex h-9 w-9 items-center justify-center rounded-full border" style={{ backgroundColor: card, borderColor: border }}>{dark ? <Sun size={16} className="text-amber-500" /> : <Moon size={16} className="text-indigo-600" />}</button></div>
        </div>
      </header>

      <main className="space-y-4 px-5">
        {loading && !data && <div className="flex justify-center py-20"><Loader2 className="animate-spin text-teal-600" /></div>}
        {error && <div className="rounded-2xl border border-red-200 bg-red-50 p-4 text-sm text-red-700">{error}<button onClick={load} className="mt-2 block font-bold">Reintentar</button></div>}
        {data && <>
          <div className="grid grid-cols-2 gap-3">{kpis.map((item) => { const Icon = item.icon; return <article key={item.label} className="rounded-2xl border p-4" style={{ backgroundColor: card, borderColor: border }}><div className="flex h-9 w-9 items-center justify-center rounded-xl" style={{ backgroundColor: `${item.color}18`, color: item.color }}><Icon size={18} /></div><p className="mt-3 text-2xl font-bold" style={{ color: text }}>{item.value}</p><p className="text-sm font-semibold" style={{ color: text }}>{item.label}</p><p className="text-xs" style={{ color: muted }}>{item.detail}</p></article>; })}</div>

          <section className="rounded-2xl border p-4" style={{ backgroundColor: card, borderColor: border }}><div className="mb-3 flex items-center justify-between"><div><h2 className="font-bold" style={{ color: text }}>Estado de usuarios</h2><p className="text-xs" style={{ color: muted }}>Datos reales de MySQL</p></div><FileBarChart className="text-teal-600" /></div><div className="h-52"><ResponsiveContainer width="100%" height="100%"><BarChart data={chart}><XAxis dataKey="name" fontSize={11} stroke={muted} /><YAxis allowDecimals={false} fontSize={11} stroke={muted} /><Tooltip /><Bar dataKey="value" fill="#14B8A6" radius={[8, 8, 0, 0]} /></BarChart></ResponsiveContainer></div></section>

          <section className="rounded-2xl border p-4" style={{ backgroundColor: card, borderColor: border }}><h2 className="font-bold" style={{ color: text }}>Auditoría reciente</h2><div className="mt-3 divide-y" style={{ borderColor: border }}>{data.recentAudit.length ? data.recentAudit.slice(0, 6).map((item) => <div key={item.id} className="flex items-center gap-3 py-3"><div className="flex h-9 w-9 items-center justify-center rounded-xl bg-teal-500/10 text-teal-600"><Shield size={17} /></div><div className="min-w-0 flex-1"><p className="truncate text-sm font-semibold" style={{ color: text }}>{item.action}</p><p className="truncate text-xs" style={{ color: muted }}>{item.entity}{item.entityId ? ` #${item.entityId}` : ""}</p></div><div className="flex items-center gap-1 text-[10px]" style={{ color: muted }}><Clock size={10} />{new Date(item.createdAt).toLocaleDateString("es-MX")}</div></div>) : <p className="py-6 text-center text-sm" style={{ color: muted }}>Todavía no hay eventos de auditoría.</p>}</div></section>

          <div className="grid grid-cols-2 gap-3">{[
            { label: "Gestionar usuarios", path: "/admin/users", icon: Users },
            { label: "Ver reportes", path: "/admin/reports", icon: FileBarChart },
            { label: "Enviar notificación", path: "/admin/notifications", icon: Bell },
            { label: "Configuración", path: "/admin/settings", icon: Shield },
          ].map((item) => { const Icon = item.icon; return <button key={item.label} onClick={() => navigate(item.path)} className="flex items-center gap-3 rounded-2xl border p-4 text-left" style={{ backgroundColor: card, borderColor: border, color: text }}><Icon size={19} className="text-teal-600" /><span className="text-sm font-semibold">{item.label}</span></button>; })}</div>
        </>}
      </main>
    </div>
  );
}
