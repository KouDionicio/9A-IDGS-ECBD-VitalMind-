import { useNavigate, useParams } from "react-router";
import { ArrowLeft, Pill, Clock, Calendar, Edit, Trash2, Play, Pause, AlertCircle } from "lucide-react";
import { motion } from "motion/react";
import { LineChart, Line, XAxis, YAxis, ResponsiveContainer, Tooltip } from "recharts";
import { toast } from "sonner";

const historyData = [
  { date: "01", taken: 2, missed: 0 },
  { date: "02", taken: 2, missed: 0 },
  { date: "03", taken: 1, missed: 1 },
  { date: "04", taken: 2, missed: 0 },
  { date: "05", taken: 2, missed: 0 },
  { date: "06", taken: 2, missed: 0 },
  { date: "07", taken: 2, missed: 0 },
];

export function MedicationDetailScreen() {
  const navigate = useNavigate();
  const { id } = useParams();

  const medication = {
    id: 1,
    name: "Aspirina",
    dose: "100mg",
    presentation: "Tableta",
    frequency: "Diario",
    times: ["08:00", "20:00"],
    duration: 30,
    startDate: "2026-06-01",
    stock: 28,
    notes: "Tomar con alimentos para evitar molestias estomacales",
    indications: "Antiinflamatorio y analgésico. Ayuda a prevenir coágulos sanguíneos.",
    status: "active",
    color: "#2563EB",
  };

  const handlePause = () => {
    toast.success("Medicamento pausado");
  };

  const handleDelete = () => {
    if (confirm("¿Estás seguro de eliminar este medicamento?")) {
      toast.success("Medicamento eliminado");
      navigate("/medications");
    }
  };

  return (
    <div className="h-full bg-background flex flex-col">
      {/* Header */}
      <div 
        className="px-6 pt-12 pb-8"
        style={{ background: `linear-gradient(135deg, ${medication.color} 0%, ${medication.color}CC 100%)` }}
      >
        <div className="flex items-center gap-4 mb-6">
          <button 
            onClick={() => navigate("/medications")}
            className="w-10 h-10 bg-white/20 backdrop-blur-sm rounded-full flex items-center justify-center"
          >
            <ArrowLeft className="w-5 h-5 text-white" />
          </button>
          <h1 className="text-2xl font-bold text-white flex-1">{medication.name}</h1>
          <button 
            onClick={() => navigate(`/medications/${id}/edit`)}
            className="w-10 h-10 bg-white/20 backdrop-blur-sm rounded-full flex items-center justify-center"
          >
            <Edit className="w-5 h-5 text-white" />
          </button>
        </div>

        <div className="bg-white/10 backdrop-blur-md rounded-[24px] p-5 border border-white/20">
          <div className="grid grid-cols-2 gap-4">
            <div>
              <p className="text-white/70 text-sm mb-1">Dosis</p>
              <p className="text-white font-semibold text-lg">{medication.dose}</p>
            </div>
            <div>
              <p className="text-white/70 text-sm mb-1">Presentación</p>
              <p className="text-white font-semibold text-lg">{medication.presentation}</p>
            </div>
            <div>
              <p className="text-white/70 text-sm mb-1">Frecuencia</p>
              <p className="text-white font-semibold text-lg">{medication.frequency}</p>
            </div>
            <div>
              <p className="text-white/70 text-sm mb-1">Stock</p>
              <p className={`font-semibold text-lg ${medication.stock < 10 ? "text-accent-yellow" : "text-white"}`}>
                {medication.stock} días
              </p>
            </div>
          </div>
        </div>
      </div>

      {/* Content */}
      <div className="flex-1 overflow-y-auto px-6 py-6 space-y-6">
        {/* Horarios */}
        <div>
          <h2 className="text-lg font-semibold text-foreground mb-3 flex items-center gap-2">
            <Clock className="w-5 h-5 text-primary" />
            Horarios
          </h2>
          <div className="space-y-2">
            {medication.times.map((time, index) => (
              <div 
                key={index}
                className="bg-card border border-border rounded-[16px] px-4 py-3 flex items-center justify-between"
              >
                <span className="text-foreground font-medium">{time}</span>
                <span className="text-sm text-muted-foreground">{medication.dose}</span>
              </div>
            ))}
          </div>
        </div>

        {/* Indicaciones */}
        <div>
          <h2 className="text-lg font-semibold text-foreground mb-3 flex items-center gap-2">
            <Pill className="w-5 h-5 text-primary" />
            Indicaciones
          </h2>
          <p className="text-foreground bg-card border border-border rounded-[16px] p-4">
            {medication.indications}
          </p>
        </div>

        {/* Notas */}
        {medication.notes && (
          <div>
            <h2 className="text-lg font-semibold text-foreground mb-3 flex items-center gap-2">
              <AlertCircle className="w-5 h-5 text-accent-yellow" />
              Notas Importantes
            </h2>
            <p className="text-foreground bg-accent-yellow/10 border border-accent-yellow/30 rounded-[16px] p-4">
              {medication.notes}
            </p>
          </div>
        )}

        {/* Historial */}
        <div>
          <h2 className="text-lg font-semibold text-foreground mb-3 flex items-center gap-2">
            <Calendar className="w-5 h-5 text-primary" />
            Adherencia (7 días)
          </h2>
          <div className="bg-card border border-border rounded-[16px] p-4">
            <div className="h-40">
              <ResponsiveContainer width="100%" height="100%">
                <LineChart data={historyData}>
                  <XAxis dataKey="date" stroke="#64748B" fontSize={12} />
                  <YAxis stroke="#64748B" fontSize={12} />
                  <Tooltip
                    contentStyle={{
                      backgroundColor: "var(--card)",
                      border: "1px solid var(--border)",
                      borderRadius: "12px",
                    }}
                  />
                  <Line
                    type="monotone"
                    dataKey="taken"
                    stroke="#0F766E"
                    strokeWidth={2}
                    dot={{ fill: "#0F766E", r: 3 }}
                    name="Tomados"
                  />
                  <Line
                    type="monotone"
                    dataKey="missed"
                    stroke="#EF4444"
                    strokeWidth={2}
                    dot={{ fill: "#EF4444", r: 3 }}
                    name="Omitidos"
                  />
                </LineChart>
              </ResponsiveContainer>
            </div>
          </div>
        </div>

        {/* Actions */}
        <div className="grid grid-cols-2 gap-3 pb-8">
          <button
            onClick={handlePause}
            className="bg-accent-yellow/10 hover:bg-accent-yellow/20 text-accent-yellow border border-accent-yellow/30 py-4 rounded-[16px] font-semibold flex items-center justify-center gap-2 transition-all active:scale-95"
          >
            <Pause className="w-5 h-5" />
            Pausar
          </button>
          <button
            onClick={handleDelete}
            className="bg-accent-red/10 hover:bg-accent-red/20 text-accent-red border border-accent-red/30 py-4 rounded-[16px] font-semibold flex items-center justify-center gap-2 transition-all active:scale-95"
          >
            <Trash2 className="w-5 h-5" />
            Eliminar
          </button>
        </div>
      </div>
    </div>
  );
}
