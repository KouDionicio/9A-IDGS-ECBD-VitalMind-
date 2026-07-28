import { useState } from "react";
import { BellRing, Loader2, Send } from "lucide-react";
import { toast } from "sonner";
import { apiRequest } from "../../../lib/api";

const kinds = [
  { value: "tip", label: "Consejo" },
  { value: "reminder", label: "Recordatorio" },
  { value: "ai", label: "Recomendación" },
  { value: "alert", label: "Alerta" },
] as const;

type Kind = (typeof kinds)[number]["value"];

export function AdminNotificationsScreen() {
  const [form, setForm] = useState({ title: "", body: "", kind: "tip" as Kind, userId: "", broadcast: true });
  const [sending, setSending] = useState(false);

  const submit = async () => {
    if (!form.title.trim() || !form.body.trim()) {
      toast.error("Escribe el título y el mensaje");
      return;
    }
    if (!form.broadcast && !Number(form.userId)) {
      toast.error("Indica un ID de usuario válido");
      return;
    }
    setSending(true);
    try {
      const created = await apiRequest<Array<{ id: string }>>("/notifications", {
        method: "POST",
        body: JSON.stringify({
          title: form.title.trim(),
          body: form.body.trim(),
          kind: form.kind,
          broadcast: form.broadcast,
          userId: form.broadcast ? undefined : Number(form.userId),
          time: "Ahora",
        }),
      });
      toast.success(`${created.length} notificación(es) enviada(s)`);
      setForm((current) => ({ ...current, title: "", body: "" }));
    } catch (error) {
      toast.error(error instanceof Error ? error.message : "No se pudo enviar la notificación");
    } finally {
      setSending(false);
    }
  };

  return (
    <div className="min-h-full bg-slate-50 pb-24">
      <header className="bg-slate-900 px-5 pb-7 pt-10 text-white">
        <div className="flex items-center gap-3">
          <div className="flex h-11 w-11 items-center justify-center rounded-2xl bg-teal-600/20 text-teal-300">
            <BellRing size={22} />
          </div>
          <div>
            <h1 className="text-2xl font-bold">Notificaciones</h1>
            <p className="text-sm text-slate-400">Envío real mediante el backend protegido</p>
          </div>
        </div>
      </header>

      <main className="mx-5 mt-5 space-y-4 rounded-3xl border border-slate-200 bg-white p-5 shadow-sm">
        <label className="block">
          <span className="mb-1.5 block text-sm font-semibold text-slate-700">Tipo</span>
          <select
            value={form.kind}
            onChange={(event) => setForm({ ...form, kind: event.target.value as Kind })}
            className="w-full rounded-xl border border-slate-200 px-3 py-3 outline-none focus:border-teal-600"
          >
            {kinds.map((kind) => <option key={kind.value} value={kind.value}>{kind.label}</option>)}
          </select>
        </label>

        <label className="flex items-center justify-between rounded-xl bg-slate-50 p-3">
          <div>
            <p className="text-sm font-semibold text-slate-700">Enviar a todos</p>
            <p className="text-xs text-slate-400">Solo usuarios activos</p>
          </div>
          <input
            type="checkbox"
            checked={form.broadcast}
            onChange={(event) => setForm({ ...form, broadcast: event.target.checked })}
            className="h-5 w-5 accent-teal-600"
          />
        </label>

        {!form.broadcast && (
          <label className="block">
            <span className="mb-1.5 block text-sm font-semibold text-slate-700">ID del usuario</span>
            <input
              type="number"
              min="1"
              value={form.userId}
              onChange={(event) => setForm({ ...form, userId: event.target.value })}
              className="w-full rounded-xl border border-slate-200 px-3 py-3 outline-none focus:border-teal-600"
              placeholder="Ejemplo: 2"
            />
          </label>
        )}

        <label className="block">
          <span className="mb-1.5 block text-sm font-semibold text-slate-700">Título</span>
          <input
            maxLength={180}
            value={form.title}
            onChange={(event) => setForm({ ...form, title: event.target.value })}
            className="w-full rounded-xl border border-slate-200 px-3 py-3 outline-none focus:border-teal-600"
            placeholder="Título de la notificación"
          />
        </label>

        <label className="block">
          <span className="mb-1.5 block text-sm font-semibold text-slate-700">Mensaje</span>
          <textarea
            maxLength={2000}
            rows={5}
            value={form.body}
            onChange={(event) => setForm({ ...form, body: event.target.value })}
            className="w-full resize-none rounded-xl border border-slate-200 px-3 py-3 outline-none focus:border-teal-600"
            placeholder="Escribe el mensaje..."
          />
        </label>

        <button
          onClick={submit}
          disabled={sending}
          className="flex w-full items-center justify-center gap-2 rounded-xl bg-teal-700 py-3.5 font-semibold text-white disabled:opacity-60"
        >
          {sending ? <Loader2 className="animate-spin" size={18} /> : <Send size={18} />}
          {sending ? "Enviando..." : "Enviar notificación"}
        </button>

        <p className="text-center text-xs text-slate-400">
          La ruta está limitada a administradores mediante JWT y control de rol.
        </p>
      </main>
    </div>
  );
}
