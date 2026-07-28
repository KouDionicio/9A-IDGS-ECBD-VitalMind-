import { Outlet, useLocation, useNavigate } from "react-router";
import { Home, BarChart2, ClipboardList, Brain, User, Sun, Moon, LogOut, Settings, Bell } from "lucide-react";
import { useEffect, useState } from "react";
import { Toaster } from "sonner";
import { ThemeProvider, useTheme } from "./ThemeContext";
import { clearSession, isAuthenticated } from "../lib/api";
import { ImageWithFallback } from "@/components/figma/ImageWithFallback";
import vitalMindLogo from "../../imports/Captura_de_pantalla_2026-07-07_185523-removebg-preview.png";

const navItems = [
  { icon: Home,          label: "Inicio",   path: "/dashboard" },
  { icon: BarChart2,     label: "Resumen",  path: "/resumen" },
  { icon: ClipboardList, label: "Registro", path: "/registro" },
  { icon: Brain,         label: "IA",       path: "/ia" },
  { icon: User,          label: "Perfil",   path: "/profile" },
];

const hideNavPaths = ["/", "/splash", "/onboarding", "/auth"];

function isActive(current: string, path: string) {
  return (
    current === path ||
    (path === "/dashboard" && current.startsWith("/medical-history")) ||
    (path === "/resumen"   && current === "/graficas") ||
    (path === "/registro"  && current === "/habitos") ||
    (path === "/ia"        && (current === "/notificaciones" || current === "/chatbot"))
  );
}

function RootContent() {
  const location = useLocation();
  const navigate = useNavigate();
  const { dark, toggle } = useTheme();
  const showNav = !hideNavPaths.includes(location.pathname);
  const [sessionName] = useState(() => localStorage.getItem("userName") || "Usuario");

  useEffect(() => {
    if (["/", "/splash", "/onboarding"].includes(location.pathname)) return;
    if (!isAuthenticated() && location.pathname !== "/auth") navigate("/auth", { replace: true });
  }, [location.pathname, navigate]);

  const frameBg      = dark ? "#0F172A" : "#F8FAFC";
  const navBg        = dark ? "#0B1120" : "#FFFFFF";
  const navBorder    = dark ? "rgba(255,255,255,0.07)" : "#E2E8F0";
  const iconActive   = "#0F766E";
  const iconInactive = dark ? "#475569" : "#94A3B8";
  const textPrimary  = dark ? "#F1F5F9" : "#0F172A";
  const textMuted    = dark ? "#64748B" : "#94A3B8";

  const handleLogout = () => {
    clearSession();
    navigate("/auth", { replace: true });
  };

  return (
    <div className="flex h-[100dvh] overflow-hidden" style={{ backgroundColor: frameBg }}>
      <Toaster position="top-center" richColors />

      {showNav && (
        <aside
          className="hidden md:flex flex-col w-56 lg:w-64 flex-shrink-0 h-full border-r"
          style={{ backgroundColor: navBg, borderColor: navBorder }}
        >
          <div className="px-5 py-6 border-b flex-shrink-0" style={{ borderColor: navBorder }}>
            <ImageWithFallback
              src={vitalMindLogo}
              alt="VitalMind AI"
              className="h-9 w-auto object-contain"
              style={dark ? { filter: "brightness(0) invert(1) opacity(0.85)" } : {}}
            />
          </div>

          <nav className="flex-1 p-3 space-y-1 overflow-y-auto">
            <p className="text-[10px] font-semibold uppercase tracking-widest px-3 mb-3 mt-2" style={{ color: textMuted }}>
              Menú principal
            </p>
            {navItems.map(({ icon: Icon, label, path }) => {
              const active = isActive(location.pathname, path);
              return (
                <button
                  key={path}
                  onClick={() => navigate(path)}
                  className="w-full flex items-center gap-3 px-4 py-3 rounded-2xl transition-all text-left"
                  style={{
                    backgroundColor: active ? "#0F766E18" : "transparent",
                    color: active ? iconActive : iconInactive,
                  }}
                >
                  <div
                    className="w-8 h-8 rounded-xl flex items-center justify-center flex-shrink-0 transition-all"
                    style={{ backgroundColor: active ? "#0F766E20" : "transparent" }}
                  >
                    <Icon size={18} />
                  </div>
                  <span className="text-sm font-medium">{label}</span>
                  {active && (
                    <div className="ml-auto w-1.5 h-1.5 rounded-full flex-shrink-0" style={{ backgroundColor: iconActive }} />
                  )}
                </button>
              );
            })}

            <div className="h-px mx-3 my-3" style={{ backgroundColor: navBorder }} />
            <p className="text-[10px] font-semibold uppercase tracking-widest px-3 mb-3" style={{ color: textMuted }}>
              Herramientas
            </p>

            {[
              { icon: Bell,     label: "Notificaciones", path: "/notificaciones" },
              { icon: Settings, label: "Servicios de salud", path: "/servicios" },
              { icon: Bell,     label: "Chatbot IA", path: "/chatbot" },
            ].map(({ icon: Icon, label, path }) => {
              const active = isActive(location.pathname, path);
              return (
                <button
                  key={path}
                  onClick={() => navigate(path)}
                  className="w-full flex items-center gap-3 px-4 py-3 rounded-2xl transition-all text-left"
                  style={{ backgroundColor: active ? "#0F766E18" : "transparent", color: active ? iconActive : iconInactive }}
                >
                  <div className="w-8 h-8 rounded-xl flex items-center justify-center flex-shrink-0">
                    <Icon size={18} />
                  </div>
                  <span className="text-sm font-medium">{label}</span>
                </button>
              );
            })}
          </nav>

          <div className="p-4 border-t flex-shrink-0 space-y-1" style={{ borderColor: navBorder }}>
            <button
              onClick={toggle}
              className="w-full flex items-center gap-3 px-4 py-2.5 rounded-2xl transition-all text-left"
            >
              {dark
                ? <Sun size={16} style={{ color: "#F59E0B" }} />
                : <Moon size={16} style={{ color: "#6366F1" }} />}
              <span className="text-sm font-medium" style={{ color: textPrimary }}>
                {dark ? "Modo claro" : "Modo oscuro"}
              </span>
            </button>

            <button
              onClick={handleLogout}
              className="w-full flex items-center gap-3 px-4 py-2.5 rounded-2xl transition-all text-left"
              style={{ color: "#EF4444" }}
            >
              <LogOut size={16} />
              <span className="text-sm font-medium">Cerrar sesión</span>
            </button>

            <div
              className="flex items-center gap-3 px-3 py-3 rounded-2xl mt-1"
              style={{ backgroundColor: dark ? "rgba(255,255,255,0.04)" : "#F8FAFC", border: `1px solid ${navBorder}` }}
            >
              <div
                className="w-8 h-8 rounded-full flex items-center justify-center flex-shrink-0 text-xs font-bold text-white"
                style={{ background: "linear-gradient(135deg, #0F766E, #2563EB)" }}
              >
                VM
              </div>
              <div className="flex-1 min-w-0">
                <p className="text-xs font-semibold truncate" style={{ color: textPrimary }}>{sessionName}</p>
                <p className="text-[10px] truncate" style={{ color: textMuted }}>Sesión demo</p>
              </div>
            </div>
          </div>
        </aside>
      )}

      <div className="flex-1 flex flex-col h-full min-w-0 relative">
        <div className={`flex-1 overflow-y-auto overscroll-contain min-h-0 ${showNav ? "pb-[72px] md:pb-0" : ""}`}>
          <div className="h-full w-full">
            <Outlet />
          </div>
        </div>

        {showNav && (
          <nav
            className="md:hidden flex-shrink-0 border-t flex items-center justify-around px-1 py-2 z-40"
            style={{ backgroundColor: navBg, borderColor: navBorder }}
          >
            {navItems.map(({ icon: Icon, label, path }) => {
              const active = isActive(location.pathname, path);
              return (
                <button
                  key={path}
                  onClick={() => navigate(path)}
                  className="flex flex-col items-center justify-center px-3 py-1.5 rounded-2xl transition-all min-w-[56px]"
                >
                  <div className={`w-10 h-10 flex items-center justify-center rounded-2xl transition-all ${active ? "bg-[#0F766E]/10" : ""}`}>
                    <Icon size={20} style={{ color: active ? iconActive : iconInactive }} />
                  </div>
                  <span className="text-[10px] font-medium mt-0.5" style={{ color: active ? iconActive : iconInactive }}>
                    {label}
                  </span>
                </button>
              );
            })}
          </nav>
        )}
      </div>
    </div>
  );
}

export function Root() {
  return (
    <ThemeProvider>
      <RootContent />
    </ThemeProvider>
  );
}
