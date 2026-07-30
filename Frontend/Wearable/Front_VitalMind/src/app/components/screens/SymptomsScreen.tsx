import { useNavigate } from "react-router";
import { ArrowLeft, Save, Heart, Thermometer, Activity, Frown, Smile, AlertCircle } from "lucide-react";
import { useState } from "react";
import { toast } from "sonner";

export function SymptomsScreen() {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    pain: 0,
    temperature: "",
    bloodPressure: "",
    glucose: "",
    weight: "",
    mood: "neutral",
    notes: "",
  });

  const painLevels = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  const moods = [
    { value: "happy", label: "Feliz", icon: "😊", color: "#22C55E" },
    { value: "neutral", label: "Normal", icon: "😐", color: "#F59E0B" },
    { value: "sad", label: "Triste", icon: "😢", color: "#EF4444" },
  ];

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    toast.success("Síntomas registrados exitosamente");
    navigate("/profile");
  };

  const handleChange = (field: string, value: any) => {
    setFormData({ ...formData, [field]: value });
  };

  return (
    <div className="h-full bg-background flex flex-col">
      {/* Header */}
      <div className="bg-card border-b border-border px-6 pt-12 pb-4">
        <div className="flex items-center gap-4">
          <button 
            onClick={() => navigate("/profile")}
            className="w-10 h-10 bg-muted rounded-full flex items-center justify-center"
          >
            <ArrowLeft className="w-5 h-5 text-foreground" />
          </button>
          <div>
            <h1 className="text-2xl font-bold text-foreground">Registrar Síntomas</h1>
            <div className="flex items-center gap-1 mt-1">
              <span className="px-2 py-0.5 bg-primary/10 text-primary text-xs font-medium rounded-full">
                Premium
              </span>
            </div>
          </div>
        </div>
      </div>

      {/* Form */}
      <form onSubmit={handleSubmit} className="flex-1 overflow-y-auto px-6 py-6">
        <div className="space-y-6">
          {/* Pain Level */}
          <div>
            <label className="block text-sm font-semibold text-foreground mb-3 flex items-center gap-2">
              <AlertCircle className="w-4 h-4 text-accent-red" />
              Nivel de Dolor (0-10)
            </label>
            <div className="flex items-center gap-2">
              {painLevels.map((level) => (
                <button
                  key={level}
                  type="button"
                  onClick={() => handleChange("pain", level)}
                  className={`flex-1 aspect-square rounded-[12px] font-semibold transition-all ${
                    formData.pain === level
                      ? "bg-primary text-primary-foreground scale-110"
                      : "bg-card border border-border text-muted-foreground hover:bg-muted"
                  }`}
                >
                  {level}
                </button>
              ))}
            </div>
          </div>

          {/* Temperature */}
          <div>
            <label className="block text-sm font-semibold text-foreground mb-2 flex items-center gap-2">
              <Thermometer className="w-4 h-4 text-accent-red" />
              Temperatura (°C)
            </label>
            <input
              type="number"
              step="0.1"
              value={formData.temperature}
              onChange={(e) => handleChange("temperature", e.target.value)}
              placeholder="36.5"
              className="w-full px-4 py-4 bg-card border border-border rounded-[20px] focus:outline-none focus:ring-2 focus:ring-primary text-foreground"
            />
          </div>

          {/* Blood Pressure */}
          <div>
            <label className="block text-sm font-semibold text-foreground mb-2 flex items-center gap-2">
              <Activity className="w-4 h-4 text-accent-red" />
              Presión Arterial (mmHg)
            </label>
            <input
              type="text"
              value={formData.bloodPressure}
              onChange={(e) => handleChange("bloodPressure", e.target.value)}
              placeholder="120/80"
              className="w-full px-4 py-4 bg-card border border-border rounded-[20px] focus:outline-none focus:ring-2 focus:ring-primary text-foreground"
            />
          </div>

          {/* Glucose */}
          <div>
            <label className="block text-sm font-semibold text-foreground mb-2 flex items-center gap-2">
              <Activity className="w-4 h-4 text-accent-blue" />
              Glucosa (mg/dL)
            </label>
            <input
              type="number"
              value={formData.glucose}
              onChange={(e) => handleChange("glucose", e.target.value)}
              placeholder="90"
              className="w-full px-4 py-4 bg-card border border-border rounded-[20px] focus:outline-none focus:ring-2 focus:ring-primary text-foreground"
            />
          </div>

          {/* Weight */}
          <div>
            <label className="block text-sm font-semibold text-foreground mb-2 flex items-center gap-2">
              <Activity className="w-4 h-4 text-primary" />
              Peso (kg)
            </label>
            <input
              type="number"
              step="0.1"
              value={formData.weight}
              onChange={(e) => handleChange("weight", e.target.value)}
              placeholder="70.5"
              className="w-full px-4 py-4 bg-card border border-border rounded-[20px] focus:outline-none focus:ring-2 focus:ring-primary text-foreground"
            />
          </div>

          {/* Mood */}
          <div>
            <label className="block text-sm font-semibold text-foreground mb-3 flex items-center gap-2">
              <Heart className="w-4 h-4 text-accent-red" />
              Estado de Ánimo
            </label>
            <div className="grid grid-cols-3 gap-3">
              {moods.map((mood) => (
                <button
                  key={mood.value}
                  type="button"
                  onClick={() => handleChange("mood", mood.value)}
                  className={`p-4 rounded-[20px] transition-all ${
                    formData.mood === mood.value
                      ? "bg-card border-2 scale-105 shadow-lg"
                      : "bg-card border border-border hover:bg-muted"
                  }`}
                  style={{
                    borderColor: formData.mood === mood.value ? mood.color : undefined,
                  }}
                >
                  <div className="text-4xl mb-2">{mood.icon}</div>
                  <p className="text-sm font-medium text-foreground">{mood.label}</p>
                </button>
              ))}
            </div>
          </div>

          {/* Notes */}
          <div>
            <label className="block text-sm font-semibold text-foreground mb-2">
              Notas Adicionales
            </label>
            <textarea
              value={formData.notes}
              onChange={(e) => handleChange("notes", e.target.value)}
              placeholder="Describe cómo te sientes..."
              rows={4}
              className="w-full px-4 py-4 bg-card border border-border rounded-[20px] focus:outline-none focus:ring-2 focus:ring-primary text-foreground resize-none"
            />
          </div>
        </div>

        {/* Save Button */}
        <button
          type="submit"
          className="w-full mt-6 mb-8 bg-primary hover:bg-primary/90 text-primary-foreground py-4 rounded-[20px] font-semibold text-lg shadow-lg flex items-center justify-center gap-2 transition-all active:scale-95"
        >
          <Save className="w-5 h-5" />
          Guardar Registro
        </button>
      </form>
    </div>
  );
}
