# ---------- Etapa de compilación ----------
FROM node:20-alpine AS build

WORKDIR /app

# Instala únicamente dependencias declaradas en el lockfile.
COPY package.json package-lock.json ./
RUN npm ci

COPY . .

# Variables Vite quedan embebidas durante el build.
ARG VITE_API_URL=http://localhost:4000/api
ARG VITE_SOCKET_URL=http://localhost:4000
ARG VITE_ML_API_URL=http://localhost:8000/api/v1

ENV VITE_API_URL=${VITE_API_URL}
ENV VITE_SOCKET_URL=${VITE_SOCKET_URL}
ENV VITE_ML_API_URL=${VITE_ML_API_URL}

RUN npm run build

# ---------- Etapa de producción ----------
FROM nginx:1.27-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

# Healthcheck para Docker/Compose.
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://127.0.0.1/health || exit 1

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
