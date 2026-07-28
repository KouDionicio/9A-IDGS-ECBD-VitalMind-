import { Navigate, useLocation } from "react-router";
import { getSessionRole, isAuthenticated } from "../lib/api";
import type { ReactNode } from "react";
import type { UserRole } from "../lib/types";

export function ProtectedRoute({ children, role }: { children: ReactNode; role?: UserRole }) {
  const location = useLocation();
  if (!isAuthenticated()) {
    const destination = role === "admin" ? "/admin" : "/auth";
    return <Navigate to={destination} replace state={{ from: location.pathname }} />;
  }
  if (role && getSessionRole() !== role) {
    return <Navigate to={role === "admin" ? "/admin" : "/dashboard"} replace />;
  }
  return <>{children}</>;
}
