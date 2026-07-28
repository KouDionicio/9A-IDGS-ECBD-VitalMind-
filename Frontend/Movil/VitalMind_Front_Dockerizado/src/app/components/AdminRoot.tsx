import { Outlet, useLocation, useNavigate } from "react-router";
import { LayoutDashboard, Users, BarChart2, Bell, Settings } from "lucide-react";

import { Toaster } from "sonner";
import { AdminThemeProvider, useAdminTheme } from "./admin/AdminThemeContext";

const adminNavItems = [
  { icon: LayoutDashboard, label: "Dashboard", path: "/admin/dashboard" },
  { icon: Users, label: "Usuarios", path: "/admin/users" },
  { icon: BarChart2, label: "Reportes", path: "/admin/reports" },
  { icon: Bell, label: "Notifs.", path: "/admin/notifications" },
  { icon: Settings, label: "Config.", path: "/admin/settings" },
];

const hideNavPaths = ["/admin", "/admin/"];

function AdminLayout() {
  const location = useLocation();
  const navigate = useNavigate();
  const { dark } = useAdminTheme();
  const showNav = !hideNavPaths.includes(location.pathname);


  const bg = dark ? "#0B1120" : "#F8FAFC";
  const navBg = dark ? "#0F172A" : "#FFFFFF";
  const navBorder = dark ? "rgba(255,255,255,0.08)" : "#E2E8F0";
  const activeColor = "#14B8A6";
  const inactiveColor = dark ? "#475569" : "#94A3B8";

  return (
    <div className="flex min-h-[100dvh] items-start sm:items-center justify-center sm:p-6" style={{ backgroundColor: dark ? "#060B18" : "#E2E8F0" }}>
      <Toaster position="top-center" richColors />
      <div
        className="relative w-full h-[100dvh] sm:w-[430px] sm:h-[900px] sm:rounded-[48px] sm:overflow-hidden sm:shadow-[0_32px_80px_rgba(0,0,0,0.28)] overflow-hidden"
        style={{ backgroundColor: bg }}
      >
        <div className={`h-full overflow-y-auto overscroll-contain ${showNav ? "pb-[72px]" : ""}`}>
          <Outlet />
        </div>

        {showNav && (
          <div
            className="absolute bottom-0 left-0 right-0 border-t"
            style={{ backgroundColor: navBg, borderColor: navBorder }}
          >
            <div className="flex items-center justify-around px-1 py-2">
              {adminNavItems.map((item) => {
                const Icon = item.icon;
                const isActive = location.pathname === item.path;
                return (
                  <button
                    key={item.path}
                    onClick={() => navigate(item.path)}
                    className="flex flex-col items-center justify-center px-2 py-1.5 rounded-2xl transition-all min-w-[56px]"
                  >
                    <div
                      className="w-10 h-10 flex items-center justify-center rounded-2xl transition-all"
                      style={{ backgroundColor: isActive ? activeColor + "20" : "transparent" }}
                    >
                      <Icon
                        className="w-5 h-5 transition-colors"
                        style={{ color: isActive ? activeColor : inactiveColor }}
                      />
                    </div>
                    <span
                      className="text-[10px] font-medium mt-0.5"
                      style={{ color: isActive ? activeColor : inactiveColor }}
                    >
                      {item.label}
                    </span>
                  </button>
                );
              })}
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

export function AdminRoot() {
  return (
    <AdminThemeProvider>
      <AdminLayout />
    </AdminThemeProvider>
  );
}
