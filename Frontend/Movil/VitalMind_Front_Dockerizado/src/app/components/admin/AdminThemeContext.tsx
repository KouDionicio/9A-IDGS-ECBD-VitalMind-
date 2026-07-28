import { createContext, useContext, useState, useEffect, ReactNode } from "react";

interface AdminThemeCtx {
  dark: boolean;
  toggle: () => void;
}

const AdminThemeContext = createContext<AdminThemeCtx>({ dark: true, toggle: () => {} });

export function AdminThemeProvider({ children }: { children: ReactNode }) {
  const [dark, setDark] = useState(() => localStorage.getItem("adminTheme") !== "light");

  const toggle = () => {
    setDark((d) => {
      localStorage.setItem("adminTheme", d ? "light" : "dark");
      return !d;
    });
  };

  return (
    <AdminThemeContext.Provider value={{ dark, toggle }}>
      {children}
    </AdminThemeContext.Provider>
  );
}

export const useAdminTheme = () => useContext(AdminThemeContext);
