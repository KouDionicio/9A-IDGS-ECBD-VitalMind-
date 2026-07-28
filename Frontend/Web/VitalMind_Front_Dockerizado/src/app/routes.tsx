import { createBrowserRouter } from "react-router";
import { lazy } from "react";
import type { ReactNode } from "react";
import { Root } from "./components/Root";
import { AdminRoot } from "./components/AdminRoot";
import { ProtectedRoute } from "./components/ProtectedRoute";

const SplashScreen = lazy(() => import("./components/screens/SplashScreen").then((m) => ({ default: m.SplashScreen })));
const OnboardingFlow = lazy(() => import("./components/screens/OnboardingFlow").then((m) => ({ default: m.OnboardingFlow })));
const AuthScreen = lazy(() => import("./components/screens/AuthScreen").then((m) => ({ default: m.AuthScreen })));
const DashboardScreen = lazy(() => import("./components/screens/DashboardScreen").then((m) => ({ default: m.DashboardScreen })));
const ResumenScreen = lazy(() => import("./components/screens/ResumenScreen").then((m) => ({ default: m.ResumenScreen })));
const RegistroScreen = lazy(() => import("./components/screens/RegistroScreen").then((m) => ({ default: m.RegistroScreen })));
const RecomendacionesIAScreen = lazy(() => import("./components/screens/RecomendacionesIAScreen").then((m) => ({ default: m.RecomendacionesIAScreen })));
const ChatbotScreen = lazy(() => import("./components/screens/ChatbotScreen").then((m) => ({ default: m.ChatbotScreen })));
const HabitosScreen = lazy(() => import("./components/screens/HabitosScreen").then((m) => ({ default: m.HabitosScreen })));
const GraficasScreen = lazy(() => import("./components/screens/GraficasScreen").then((m) => ({ default: m.GraficasScreen })));
const NotificacionesScreen = lazy(() => import("./components/screens/NotificacionesScreen").then((m) => ({ default: m.NotificacionesScreen })));
const ProfileScreen = lazy(() => import("./components/screens/ProfileScreen").then((m) => ({ default: m.ProfileScreen })));
const MedicalHistoryScreen = lazy(() => import("./components/screens/MedicalHistoryScreen").then((m) => ({ default: m.MedicalHistoryScreen })));
const MedicamentosScreen = lazy(() => import("./components/screens/MedicamentosScreen").then((m) => ({ default: m.MedicamentosScreen })));
const CitasScreen = lazy(() => import("./components/screens/CitasScreen").then((m) => ({ default: m.CitasScreen })));
const ServiciosExternosScreen = lazy(() => import("./components/screens/ServiciosExternosScreen").then((m) => ({ default: m.ServiciosExternosScreen })));
const AdminLoginScreen = lazy(() => import("./components/screens/admin/AdminLoginScreen").then((m) => ({ default: m.AdminLoginScreen })));
const AdminDashboardScreen = lazy(() => import("./components/screens/admin/AdminDashboardScreen").then((m) => ({ default: m.AdminDashboardScreen })));
const AdminUsersScreen = lazy(() => import("./components/screens/admin/AdminUsersScreen").then((m) => ({ default: m.AdminUsersScreen })));
const AdminReportsScreen = lazy(() => import("./components/screens/admin/AdminReportsScreen").then((m) => ({ default: m.AdminReportsScreen })));
const AdminNotificationsScreen = lazy(() => import("./components/screens/admin/AdminNotificationsScreen").then((m) => ({ default: m.AdminNotificationsScreen })));
const AdminSettingsScreen = lazy(() => import("./components/screens/admin/AdminSettingsScreen").then((m) => ({ default: m.AdminSettingsScreen })));

const patient = (element: ReactNode) => <ProtectedRoute>{element}</ProtectedRoute>;
const admin = (element: ReactNode) => <ProtectedRoute role="admin">{element}</ProtectedRoute>;

export const router = createBrowserRouter([
  { path: "/", element: <Root />, children: [
    { index: true, element: <SplashScreen /> },
    { path: "splash", element: <SplashScreen /> },
    { path: "onboarding", element: <OnboardingFlow /> },
    { path: "auth", element: <AuthScreen /> },
    { path: "dashboard", element: patient(<DashboardScreen />) },
    { path: "resumen", element: patient(<ResumenScreen />) },
    { path: "registro", element: patient(<RegistroScreen />) },
    { path: "ia", element: patient(<RecomendacionesIAScreen />) },
    { path: "chatbot", element: patient(<ChatbotScreen />) },
    { path: "habitos", element: patient(<HabitosScreen />) },
    { path: "graficas", element: patient(<GraficasScreen />) },
    { path: "notificaciones", element: patient(<NotificacionesScreen />) },
    { path: "profile", element: patient(<ProfileScreen />) },
    { path: "medical-history", element: patient(<MedicalHistoryScreen />) },
    { path: "medicamentos", element: patient(<MedicamentosScreen />) },
    { path: "citas", element: patient(<CitasScreen />) },
    { path: "servicios", element: patient(<ServiciosExternosScreen />) },
  ]},
  { path: "/admin", element: <AdminRoot />, children: [
    { index: true, element: <AdminLoginScreen /> },
    { path: "dashboard", element: admin(<AdminDashboardScreen />) },
    { path: "users", element: admin(<AdminUsersScreen />) },
    { path: "reports", element: admin(<AdminReportsScreen />) },
    { path: "notifications", element: admin(<AdminNotificationsScreen />) },
    { path: "settings", element: admin(<AdminSettingsScreen />) },
  ]},
]);
