import { useState } from "react";
import { useNavigate } from "react-router";
import { motion } from "motion/react";
import { Mail, Lock, User, Eye, EyeOff, ChevronDown, LayoutDashboard, KeyRound } from "lucide-react";
import { toast } from "sonner";
import { ImageWithFallback } from "@/components/figma/ImageWithFallback";
import vitalMindLogo from "../../../imports/Captura_de_pantalla_2026-07-07_185523-removebg-preview.png";
import mediTechLogo from "../../../imports/image-1.png";
import { ForgotPasswordModal } from "../modals/ForgotPasswordModal";
import { setSession } from "../../lib/api";

export function AuthScreen() {
  const navigate = useNavigate();
  const [tab, setTab] = useState<"login" | "register">("login");
  const [showPass, setShowPass] = useState(false);
  const [showConfirmPass, setShowConfirmPass] = useState(false);
  const [showForgotPassword, setShowForgotPassword] = useState(false);

  const [loginForm, setLoginForm] = useState({ email: "demo@vitalmind.ai", password: "12345" });
  const [registerForm, setRegisterForm] = useState({
    name: "", email: "", age: "", sex: "", weight: "", height: "", password: "", confirmPassword: "",
  });

  const handleLogin = () => {
    if (!loginForm.email || !loginForm.password) {
      toast.error("Completa todos los campos");
      return;
    }

    const email = loginForm.email.trim().toLowerCase();
    const isAdmin = email.includes("admin");
    const name = email.split("@")[0];

    setSession(
      `demo-${email}`,
      name.charAt(0).toUpperCase() + name.slice(1),
      isAdmin ? "admin" : "patient"
    );

    toast.success(isAdmin ? "Acceso administrativo listo" : "Bienvenido a VitalMind AI");
    navigate(isAdmin ? "/admin/dashboard" : "/dashboard");
  };

  const handleRegister = () => {
    if (!registerForm.name || !registerForm.email || !registerForm.password) {
      toast.error("Completa los campos obligatorios");
      return;
    }
    if (registerForm.password !== registerForm.confirmPassword) {
      toast.error("Las contraseñas no coinciden");
      return;
    }

    setSession(
      `demo-${registerForm.email.toLowerCase()}`,
      registerForm.name,
      "patient"
    );

    toast.success("Cuenta creada en modo demo");
    navigate("/dashboard");
  };

  const inputClass = "w-full bg-white border border-[#E2E8F0] rounded-2xl pl-12 pr-4 py-4 text-slate-800 placeholder-slate-400 focus:outline-none focus:border-[#0F766E] text-sm shadow-sm";

  return (
    <div className="h-full flex flex-col overflow-y-auto relative bg-white dark:bg-slate-950">
      <ForgotPasswordModal isOpen={showForgotPassword} onClose={() => setShowForgotPassword(false)} />

      <div className="absolute inset-0 pointer-events-none overflow-hidden">
        <div className="absolute top-0 left-0 right-0 h-[42%] bg-gradient-to-b from-[#F0FDFA] to-white dark:from-slate-900 dark:to-slate-950" />
        <div className="absolute top-[-100px] right-[-70px] w-72 h-72 rounded-full bg-[#0F766E]/6" />
        <div className="absolute top-[18%] left-[-60px] w-52 h-52 rounded-full bg-[#2563EB]/5" />
        <div className="absolute bottom-[12%] right-[-40px] w-40 h-40 rounded-full bg-[#14B8A6]/6" />
        <div className="absolute bottom-[30%] left-[-30px] w-28 h-28 rounded-full bg-[#0F766E]/4" />
      </div>

      <div className="relative z-10 flex flex-col items-center pt-14 pb-6 px-6">
        <ImageWithFallback
          src={vitalMindLogo}
          alt="VitalMind AI"
          className="w-24 h-24 object-contain mb-4"
        />
        <h1 className="text-2xl font-bold text-slate-800 dark:text-slate-100 mb-1">
          {tab === "login" ? "Bienvenido de vuelta" : "Crea tu cuenta"}
        </h1>
        <p className="text-slate-400 text-sm">
          {tab === "login" ? "Inicia sesión para continuar" : "Únete a VitalMind AI"}
        </p>

        <div className="mt-5 grid grid-cols-2 gap-3 w-full max-w-md">
          <div className="rounded-2xl border border-[#E2E8F0] dark:border-slate-800 bg-white/80 dark:bg-slate-900/80 p-3 text-center shadow-sm">
            <p className="text-[10px] uppercase tracking-wider text-slate-400">Usuario demo</p>
            <p className="text-sm font-semibold text-slate-700 dark:text-slate-200 mt-1">demo@vitalmind.ai</p>
          </div>
          <div className="rounded-2xl border border-[#E2E8F0] dark:border-slate-800 bg-white/80 dark:bg-slate-900/80 p-3 text-center shadow-sm">
            <p className="text-[10px] uppercase tracking-wider text-slate-400">Contraseña</p>
            <p className="text-sm font-semibold text-slate-700 dark:text-slate-200 mt-1">12345</p>
          </div>
        </div>
      </div>

      <div className="relative z-10 flex-1 px-5 pb-6">
        <div className="flex bg-white dark:bg-slate-900 rounded-2xl p-1 mb-5 border border-[#E8F4F2] dark:border-slate-800 shadow-sm">
          {(["login", "register"] as const).map((t) => (
            <button
              key={t}
              onClick={() => setTab(t)}
              className={`flex-1 py-3 rounded-xl text-sm font-semibold transition-all ${
                tab === t ? "text-white shadow-sm" : "text-slate-400 dark:text-slate-500"
              }`}
              style={tab === t ? { background: "linear-gradient(135deg, #0F766E 0%, #2563EB 100%)" } : {}}
            >
              {t === "login" ? "Iniciar sesión" : "Registrarse"}
            </button>
          ))}
        </div>

        {tab === "login" && (
          <motion.div key="login" initial={{ opacity: 0, x: -16 }} animate={{ opacity: 1, x: 0 }} transition={{ duration: 0.22 }} className="space-y-3">
            <div className="relative">
              <Mail className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400" />
              <input
                type="email"
                placeholder="Correo electrónico"
                value={loginForm.email}
                onChange={(e) => setLoginForm({ ...loginForm, email: e.target.value })}
                className={inputClass}
              />
            </div>
            <div className="relative">
              <Lock className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400" />
              <input
                type={showPass ? "text" : "password"}
                placeholder="Contraseña"
                value={loginForm.password}
                onChange={(e) => setLoginForm({ ...loginForm, password: e.target.value })}
                className="w-full bg-white border border-[#E2E8F0] rounded-2xl pl-12 pr-12 py-4 text-slate-800 placeholder-slate-400 focus:outline-none focus:border-[#0F766E] text-sm shadow-sm"
              />
              <button onClick={() => setShowPass(!showPass)} className="absolute right-4 top-1/2 -translate-y-1/2">
                {showPass ? <EyeOff className="w-5 h-5 text-slate-400" /> : <Eye className="w-5 h-5 text-slate-400" />}
              </button>
            </div>

            <button
              onClick={() => setShowForgotPassword(true)}
              className="text-[#0F766E] text-sm font-medium block text-right w-full hover:underline"
            >
              ¿Olvidaste tu contraseña?
            </button>

            <button
              onClick={handleLogin}
              className="w-full text-white font-semibold py-4 rounded-2xl active:scale-95 transition-all"
              style={{ background: "linear-gradient(135deg, #0F766E 0%, #2563EB 100%)", boxShadow: "0 8px 24px rgba(15,118,110,0.28)" }}
            >
              Iniciar Sesión
            </button>

            <button
              onClick={() => navigate("/admin")}
              className="w-full flex items-center justify-center gap-2 rounded-2xl py-3.5 border border-[#E2E8F0] bg-white text-slate-500 text-sm font-medium active:scale-95 transition-all shadow-sm dark:bg-slate-900 dark:border-slate-800"
            >
              <LayoutDashboard className="w-4 h-4" />
              Acceso al panel administrativo
            </button>

            <div className="flex items-center gap-4 pt-1">
              <div className="flex-1 h-px bg-[#E8F4F2] dark:bg-slate-800" />
              <span className="text-slate-400 text-xs">o continúa con</span>
              <div className="flex-1 h-px bg-[#E8F4F2] dark:bg-slate-800" />
            </div>

            <div className="grid grid-cols-2 gap-3">
              <button className="flex items-center justify-center gap-2 bg-white dark:bg-slate-900 border border-[#E2E8F0] dark:border-slate-800 rounded-2xl py-3.5 text-sm font-medium text-slate-700 dark:text-slate-200 active:scale-95 transition-all shadow-sm">
                <svg className="w-5 h-5" viewBox="0 0 24 24">
                  <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
                  <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
                  <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
                  <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
                </svg>
                Google
              </button>
              <button className="flex items-center justify-center gap-2 bg-white dark:bg-slate-900 border border-[#E2E8F0] dark:border-slate-800 rounded-2xl py-3.5 text-sm font-medium text-slate-700 dark:text-slate-200 active:scale-95 transition-all shadow-sm">
                <svg className="w-5 h-5" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.8-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z"/>
                </svg>
                Apple
              </button>
            </div>
          </motion.div>
        )}

        {tab === "register" && (
          <motion.div key="register" initial={{ opacity: 0, x: 16 }} animate={{ opacity: 1, x: 0 }} transition={{ duration: 0.22 }} className="space-y-3">
            <div className="relative">
              <User className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400" />
              <input
                type="text"
                placeholder="Nombre completo"
                value={registerForm.name}
                onChange={(e) => setRegisterForm({ ...registerForm, name: e.target.value })}
                className={inputClass}
              />
            </div>
            <div className="relative">
              <Mail className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400" />
              <input
                type="email"
                placeholder="Correo electrónico"
                value={registerForm.email}
                onChange={(e) => setRegisterForm({ ...registerForm, email: e.target.value })}
                className={inputClass}
              />
            </div>
            <div className="grid grid-cols-2 gap-3">
              <input
                type="number"
                placeholder="Edad"
                value={registerForm.age}
                onChange={(e) => setRegisterForm({ ...registerForm, age: e.target.value })}
                className="bg-white dark:bg-slate-900 border border-[#E2E8F0] dark:border-slate-800 rounded-2xl px-4 py-4 text-slate-800 dark:text-slate-200 placeholder-slate-400 focus:outline-none focus:border-[#0F766E] text-sm shadow-sm"
              />
              <div className="relative">
                <select
                  value={registerForm.sex}
                  onChange={(e) => setRegisterForm({ ...registerForm, sex: e.target.value })}
                  className="w-full bg-white dark:bg-slate-900 border border-[#E2E8F0] dark:border-slate-800 rounded-2xl px-4 py-4 text-slate-800 dark:text-slate-200 focus:outline-none focus:border-[#0F766E] text-sm appearance-none shadow-sm"
                >
                  <option value="">Sexo</option>
                  <option value="M">Masculino</option>
                  <option value="F">Femenino</option>
                  <option value="O">Otro</option>
                </select>
                <ChevronDown className="absolute right-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400 pointer-events-none" />
              </div>
            </div>
            <div className="grid grid-cols-2 gap-3">
              <input
                type="number"
                placeholder="Peso (kg)"
                value={registerForm.weight}
                onChange={(e) => setRegisterForm({ ...registerForm, weight: e.target.value })}
                className="bg-white dark:bg-slate-900 border border-[#E2E8F0] dark:border-slate-800 rounded-2xl px-4 py-4 text-slate-800 dark:text-slate-200 placeholder-slate-400 focus:outline-none focus:border-[#0F766E] text-sm shadow-sm"
              />
              <input
                type="number"
                placeholder="Estatura (cm)"
                value={registerForm.height}
                onChange={(e) => setRegisterForm({ ...registerForm, height: e.target.value })}
                className="bg-white dark:bg-slate-900 border border-[#E2E8F0] dark:border-slate-800 rounded-2xl px-4 py-4 text-slate-800 dark:text-slate-200 placeholder-slate-400 focus:outline-none focus:border-[#0F766E] text-sm shadow-sm"
              />
            </div>
            <div className="relative">
              <Lock className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400" />
              <input
                type={showPass ? "text" : "password"}
                placeholder="Contraseña"
                value={registerForm.password}
                onChange={(e) => setRegisterForm({ ...registerForm, password: e.target.value })}
                className="w-full bg-white dark:bg-slate-900 border border-[#E2E8F0] dark:border-slate-800 rounded-2xl pl-12 pr-12 py-4 text-slate-800 dark:text-slate-200 placeholder-slate-400 focus:outline-none focus:border-[#0F766E] text-sm shadow-sm"
              />
              <button onClick={() => setShowPass(!showPass)} className="absolute right-4 top-1/2 -translate-y-1/2">
                {showPass ? <EyeOff className="w-5 h-5 text-slate-400" /> : <Eye className="w-5 h-5 text-slate-400" />}
              </button>
            </div>
            <div className="relative">
              <Lock className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400" />
              <input
                type={showConfirmPass ? "text" : "password"}
                placeholder="Confirmar contraseña"
                value={registerForm.confirmPassword}
                onChange={(e) => setRegisterForm({ ...registerForm, confirmPassword: e.target.value })}
                className="w-full bg-white dark:bg-slate-900 border border-[#E2E8F0] dark:border-slate-800 rounded-2xl pl-12 pr-12 py-4 text-slate-800 dark:text-slate-200 placeholder-slate-400 focus:outline-none focus:border-[#0F766E] text-sm shadow-sm"
              />
              <button onClick={() => setShowConfirmPass(!showConfirmPass)} className="absolute right-4 top-1/2 -translate-y-1/2">
                {showConfirmPass ? <EyeOff className="w-5 h-5 text-slate-400" /> : <Eye className="w-5 h-5 text-slate-400" />}
              </button>
            </div>

            <button
              onClick={handleRegister}
              className="w-full text-white font-semibold py-4 rounded-2xl active:scale-95 transition-all"
              style={{ background: "linear-gradient(135deg, #0F766E 0%, #2563EB 100%)", boxShadow: "0 8px 24px rgba(15,118,110,0.28)" }}
            >
              Crear cuenta
            </button>

            <button
              onClick={() => navigate("/admin")}
              className="w-full flex items-center justify-center gap-2 rounded-2xl py-3.5 border border-[#E2E8F0] bg-white text-slate-500 text-sm font-medium active:scale-95 transition-all shadow-sm dark:bg-slate-900 dark:border-slate-800"
            >
              <LayoutDashboard className="w-4 h-4" />
              Acceso al panel administrativo
            </button>
          </motion.div>
        )}

        <div className="rounded-2xl border border-[#E2E8F0] dark:border-slate-800 bg-white/90 dark:bg-slate-900/90 px-4 py-4 mt-5 shadow-sm">
          <div className="flex items-start gap-3">
            <div className="w-10 h-10 rounded-full bg-[#0F766E]/10 flex items-center justify-center shrink-0">
              <KeyRound className="w-5 h-5 text-[#0F766E]" />
            </div>
            <div className="flex-1">
              <p className="text-sm font-semibold text-slate-800 dark:text-slate-100">Acceso sin backend</p>
              <p className="text-xs text-slate-500 dark:text-slate-400 mt-1">
                El inicio de sesión y el registro funcionan en modo demo para revisar pantallas, dashboard y flujo de recuperación.
              </p>
            </div>
          </div>
        </div>

        <div className="flex flex-col items-center gap-1.5 pt-6 pb-2">
          <p className="text-slate-300 text-[10px] uppercase tracking-widest font-medium">Desarrollado por</p>
          <ImageWithFallback src={mediTechLogo} alt="MediTech" className="h-6 w-auto object-contain opacity-50" />
        </div>
      </div>
    </div>
  );
}
