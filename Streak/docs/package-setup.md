# Configuración de Dependencias - Streak Backend

**Proyecto:** Streak — Plataforma laboral gamificada y marketplace freelance

**Stack Backend:** Node.js + Express + TypeScript + MongoDB + Socket.io

**Documentos relacionados:**

- [Contexto General](./context.md) - Arquitectura y modelos de datos
- [Plan de Desarrollo](./development_plan.md) - Roadmap paso a paso
- [Configuración Frontend](./frontend-setup.md) - Setup de Flutter

---

## Tabla de Contenidos

1. [Requisitos Previos](#requisitos-previos)
2. [Inicialización del Proyecto](#inicialización-del-proyecto)
3. [Instalación de Dependencias](#instalación-de-dependencias)
4. [Configuración de TypeScript](#configuración-de-typescript)
5. [Configuración de Linters](#configuración-de-linters)
6. [Scripts de NPM](#scripts-de-npm)
7. [Variables de Entorno](#variables-de-entorno)
8. [Estructura del Proyecto](#estructura-del-proyecto)
9. [Troubleshooting](#troubleshooting)

---

## Requisitos Previos

Antes de comenzar, asegúrate de tener instalado:

- **Node.js:** v18.0.0 o superior
- **npm:** v9.0.0 o superior (viene con Node.js)
- **MongoDB:** Local o cuenta en MongoDB Atlas
- **Git:** Para control de versiones
- **Editor:** VSCode o Cursor AI

### Verificar instalaciones

```bash
node --version    # Debe mostrar v18.x.x o superior
npm --version     # Debe mostrar v9.x.x o superior
git --version     # Cualquier versión reciente
```

---

## Inicialización del Proyecto

### Paso 1: Crear la carpeta del proyecto

```bash
mkdir streak-backend
cd streak-backend
```

### Paso 2: Inicializar npm

```bash
npm init -y
```

### Paso 3: Crear estructura de carpetas

```bash
# En Windows (PowerShell)
New-Item -ItemType Directory -Path src\api\auth, src\api\users, src\api\jobs, src\api\applications, src\api\gigs, src\api\orders, src\api\messages, src\api\streaks, src\api\notifications, src\api\achievements, src\api\reviews, src\core\database, src\core\middlewares, src\core\utils, src\core\events, src\config, src\sockets, src\workers, src\types, tests\unit, tests\integration -Force

# En Linux/Mac
mkdir -p src/api/{auth,users,jobs,applications,gigs,orders,messages,streaks,notifications,achievements,reviews}
mkdir -p src/core/{database,middlewares,utils,events}
mkdir -p src/{config,sockets,workers,types}
mkdir -p tests/{unit,integration}
```

---

## Instalación de Dependencias

### Instalación Completa (Recomendada)

Copia y ejecuta el siguiente bloque completo:

```bash
# Dependencias de producción
npm install express mongoose dotenv bcryptjs jsonwebtoken cors helmet express-rate-limit zod http-errors morgan socket.io firebase-admin node-cron

# Dependencias de desarrollo
npm install -D typescript ts-node-dev @types/node @types/express @types/jsonwebtoken @types/bcryptjs @types/cors eslint prettier @typescript-eslint/eslint-plugin @typescript-eslint/parser jest ts-jest supertest mongodb-memory-server @types/jest @types/supertest tsx nodemon
```

### Instalación por Categorías

Si prefieres instalar por categorías para entender mejor cada grupo:

#### 1. Core y Framework

```bash
npm install express mongoose dotenv
npm install -D @types/express
```

**Propósito:**

- `express` - Framework web para Node.js
- `mongoose` - ODM para MongoDB
- `dotenv` - Gestión de variables de entorno

#### 2. Seguridad y Autenticación

```bash
npm install bcryptjs jsonwebtoken cors helmet express-rate-limit
npm install -D @types/jsonwebtoken @types/bcryptjs @types/cors
```

**Propósito:**

- `bcryptjs` - Encriptación de contraseñas
- `jsonwebtoken` - Generación y verificación de JWT
- `cors` - Control de acceso entre dominios
- `helmet` - Headers de seguridad HTTP
- `express-rate-limit` - Protección contra fuerza bruta

#### 3. Validación y Manejo de Errores

```bash
npm install zod http-errors
```

**Propósito:**

- `zod` - Validación de esquemas con TypeScript
- `http-errors` - Generación de errores HTTP estandarizados

#### 4. Utilidades

```bash
npm install morgan node-cron
```

**Propósito:**

- `morgan` - Logger de peticiones HTTP
- `node-cron` - Tareas programadas (workers)

#### 5. Comunicación en Tiempo Real

```bash
npm install socket.io
```

**Propósito:**

- `socket.io` - WebSockets para chat y notificaciones en tiempo real

#### 6. Servicios Externos

```bash
npm install firebase-admin
```

**Propósito:**

- `firebase-admin` - SDK para notificaciones push con FCM

#### 7. TypeScript y Herramientas de Desarrollo

```bash
npm install -D typescript ts-node-dev tsx nodemon @types/node
```

**Propósito:**

- `typescript` - Compilador de TypeScript
- `ts-node-dev` - Ejecutar TypeScript con hot reload
- `tsx` - Ejecutor de TypeScript moderno
- `nodemon` - Reinicio automático del servidor
- `@types/node` - Tipos de Node.js

#### 8. Linting y Formateo

```bash
npm install -D eslint prettier @typescript-eslint/eslint-plugin @typescript-eslint/parser
```

**Propósito:**

- `eslint` - Linter para JavaScript/TypeScript
- `prettier` - Formateador de código
- Plugins de TypeScript para ESLint

#### 9. Testing

```bash
npm install -D jest ts-jest supertest mongodb-memory-server @types/jest @types/supertest
```

**Propósito:**

- `jest` - Framework de testing
- `ts-jest` - Preset de Jest para TypeScript
- `supertest` - Testing de endpoints HTTP
- `mongodb-memory-server` - MongoDB en memoria para tests
- Tipos de Jest y Supertest

---

## Configuración de TypeScript

### Crear tsconfig.json

```bash
npx tsc --init
```

### Reemplazar contenido de tsconfig.json

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "commonjs",
    "lib": ["ES2022"],
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "moduleResolution": "node",
    "allowSyntheticDefaultImports": true,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "types": ["node", "jest"],
    "baseUrl": "./src",
    "paths": {
      "@/*": ["./*"],
      "@api/*": ["api/*"],
      "@core/*": ["core/*"],
      "@config/*": ["config/*"]
    }
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "tests"]
}
```

**Características clave:**

- Target ES2022 para características modernas
- Strict mode habilitado
- Source maps para debugging
- Path aliases para imports limpios
- Declaraciones para librerías

---

## Configuración de Linters

### .eslintrc.js

Crear archivo `.eslintrc.js` en la raíz:

```javascript
module.exports = {
  parser: "@typescript-eslint/parser",
  parserOptions: {
    ecmaVersion: 2022,
    sourceType: "module",
    project: "./tsconfig.json",
  },
  plugins: ["@typescript-eslint"],
  extends: [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:@typescript-eslint/recommended-requiring-type-checking",
  ],
  rules: {
    "@typescript-eslint/no-unused-vars": ["error", { argsIgnorePattern: "^_" }],
    "@typescript-eslint/explicit-function-return-type": "off",
    "@typescript-eslint/explicit-module-boundary-types": "off",
    "@typescript-eslint/no-explicit-any": "warn",
    "@typescript-eslint/no-floating-promises": "error",
    "no-console": ["warn", { allow: ["warn", "error"] }],
  },
  env: {
    node: true,
    es2022: true,
    jest: true,
  },
};
```

### .prettierrc

Crear archivo `.prettierrc` en la raíz:

```json
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false,
  "arrowParens": "always",
  "endOfLine": "lf"
}
```

### .eslintignore

Crear archivo `.eslintignore`:

```
node_modules
dist
coverage
*.config.js
```

### .prettierignore

Crear archivo `.prettierignore`:

```
node_modules
dist
coverage
package-lock.json
```

---

## Scripts de NPM

Actualizar la sección `"scripts"` en `package.json`:

```json
{
  "scripts": {
    "dev": "ts-node-dev --respawn --transpile-only --ignore-watch node_modules src/server.ts",
    "dev:tsx": "tsx watch src/server.ts",
    "build": "tsc",
    "start": "node dist/server.js",
    "lint": "eslint . --ext .ts",
    "lint:fix": "eslint . --ext .ts --fix",
    "format": "prettier --write \"src/**/*.ts\"",
    "format:check": "prettier --check \"src/**/*.ts\"",
    "test": "jest --passWithNoTests",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "test:unit": "jest --testPathPattern=tests/unit",
    "test:integration": "jest --testPathPattern=tests/integration",
    "clean": "rimraf dist",
    "prebuild": "npm run clean",
    "typecheck": "tsc --noEmit"
  }
}
```

**Descripción de scripts:**

- `dev` - Ejecutar servidor en desarrollo con auto-reload (ts-node-dev)
- `dev:tsx` - Alternativa con tsx (más rápido)
- `build` - Compilar TypeScript a JavaScript
- `start` - Ejecutar versión compilada (producción)
- `lint` - Verificar errores de linting
- `lint:fix` - Corregir errores automáticamente
- `format` - Formatear código con Prettier
- `format:check` - Verificar formato sin modificar
- `test` - Ejecutar todos los tests
- `test:watch` - Tests en modo watch
- `test:coverage` - Tests con reporte de cobertura
- `test:unit` - Solo tests unitarios
- `test:integration` - Solo tests de integración
- `clean` - Eliminar carpeta dist
- `typecheck` - Verificar tipos sin compilar

---

## Variables de Entorno

### .env.example

Crear archivo `.env.example` en la raíz (este SÍ se sube a Git):

```env
# Servidor
NODE_ENV=development
PORT=4000
API_URL=http://localhost:4000

# Base de datos
MONGODB_URI=mongodb://localhost:27017/streak
MONGODB_URI_TEST=mongodb://localhost:27017/streak-test

# JWT
JWT_SECRET=your_super_secret_jwt_key_change_this_in_production
JWT_ACCESS_EXPIRES_IN=1h
JWT_REFRESH_EXPIRES_IN=7d

# CORS
CORS_ORIGIN=http://localhost:3000,http://localhost:8080
ALLOWED_ORIGINS=http://localhost:3000,http://localhost:8080

# Rate Limiting
RATE_LIMIT_WINDOW_MS=900000
RATE_LIMIT_MAX_REQUESTS=100

# Firebase Cloud Messaging (Notificaciones Push)
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_PRIVATE_KEY=your-private-key
FIREBASE_CLIENT_EMAIL=your-client-email
# O usar service account file:
FIREBASE_SERVICE_ACCOUNT_PATH=./config/firebase-service-account.json

# AWS S3 (Opcional - para archivos)
AWS_ACCESS_KEY_ID=your-access-key
AWS_SECRET_ACCESS_KEY=your-secret-key
AWS_REGION=us-east-1
AWS_S3_BUCKET=streak-uploads

# Cloudinary (Alternativa a S3)
CLOUDINARY_CLOUD_NAME=your-cloud-name
CLOUDINARY_API_KEY=your-api-key
CLOUDINARY_API_SECRET=your-api-secret

# Redis (Opcional - para BullMQ)
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=

# Logging
LOG_LEVEL=debug

# Email (Opcional - para notificaciones por email)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-app-password
EMAIL_FROM=noreply@streak.com
```

### .env

Crear archivo `.env` en la raíz (NO subir a Git):

```bash
# Copiar .env.example y llenar con valores reales
cp .env.example .env
```

**IMPORTANTE:** Editar `.env` con tus valores reales.

---

## Estructura del Proyecto

Después de la configuración inicial, tu proyecto debería verse así:

```text
streak-backend/
├── src/
│   ├── api/
│   │   ├── auth/
│   │   ├── users/
│   │   ├── jobs/
│   │   ├── applications/
│   │   ├── gigs/
│   │   ├── orders/
│   │   ├── messages/
│   │   ├── streaks/
│   │   ├── notifications/
│   │   ├── achievements/
│   │   └── reviews/
│   ├── core/
│   │   ├── database/
│   │   ├── middlewares/
│   │   ├── utils/
│   │   └── events/
│   ├── config/
│   ├── sockets/
│   ├── workers/
│   ├── types/
│   ├── app.ts         # Configuración de Express
│   └── server.ts      # Punto de entrada
├── tests/
│   ├── unit/
│   ├── integration/
│   └── setup.ts
├── docs/
│   ├── context.md
│   ├── development_plan.md
│   ├── package-setup.md
│   └── frontend-setup.md
├── .env
├── .env.example
├── .gitignore
├── .eslintrc.js
├── .eslintignore
├── .prettierrc
├── .prettierignore
├── tsconfig.json
├── jest.config.js
├── package.json
├── package-lock.json
└── README.md
```

---

## Configuración Adicional

### .gitignore

Crear archivo `.gitignore` en la raíz:

```gitignore
# Dependencias
node_modules/
package-lock.json

# Build
dist/
build/

# Logs
logs/
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Variables de entorno
.env
.env.local
.env.*.local

# Tests
coverage/
.nyc_output/

# IDEs
.vscode/
.idea/
*.swp
*.swo
*~
.DS_Store

# Firebase
firebase-service-account.json
*-firebase-adminsdk-*.json

# Temporal
*.tmp
temp/
tmp/

# Sistema operativo
Thumbs.db
ehthumbs.db
Desktop.ini
```

### jest.config.js

Crear archivo `jest.config.js`:

```javascript
module.exports = {
  preset: "ts-jest",
  testEnvironment: "node",
  roots: ["<rootDir>/tests", "<rootDir>/src"],
  testMatch: ["**/*.test.ts", "**/*.spec.ts"],
  collectCoverageFrom: [
    "src/**/*.ts",
    "!src/**/*.d.ts",
    "!src/types/**",
    "!src/server.ts",
  ],
  coverageDirectory: "coverage",
  coverageReporters: ["text", "lcov", "html"],
  moduleNameMapper: {
    "^@/(.*)$": "<rootDir>/src/$1",
    "^@api/(.*)$": "<rootDir>/src/api/$1",
    "^@core/(.*)$": "<rootDir>/src/core/$1",
    "^@config/(.*)$": "<rootDir>/src/config/$1",
  },
  setupFilesAfterEnv: ["<rootDir>/tests/setup.ts"],
  verbose: true,
};
```

---

## Archivos Base Iniciales

### src/server.ts

```typescript
import dotenv from "dotenv";

// Cargar variables de entorno primero
dotenv.config();

import app from "./app";

const PORT = process.env.PORT || 4000;

const server = app.listen(PORT, () => {
  console.log(`🚀 Servidor corriendo en puerto ${PORT}`);
  console.log(`📍 Entorno: ${process.env.NODE_ENV || "development"}`);
});

// Manejo de errores no capturados
process.on("unhandledRejection", (reason, promise) => {
  console.error("Unhandled Rejection at:", promise, "reason:", reason);
  server.close(() => process.exit(1));
});

process.on("uncaughtException", (error) => {
  console.error("Uncaught Exception:", error);
  process.exit(1);
});

export default server;
```

### src/app.ts

```typescript
import express, { Application } from "express";
import cors from "cors";
import helmet from "helmet";
import morgan from "morgan";

const app: Application = express();

// Middlewares básicos
app.use(helmet());
app.use(cors());
app.use(morgan("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Ruta de prueba
app.get("/", (req, res) => {
  res.json({
    success: true,
    message: "Streak API - Bienvenido",
    version: "1.0.0",
  });
});

// Health check
app.get("/health", (req, res) => {
  res.json({
    success: true,
    status: "OK",
    timestamp: new Date().toISOString(),
  });
});

// Aquí se registrarán las rutas de los módulos
// app.use('/api/auth', authRoutes);
// app.use('/api/users', userRoutes);
// etc...

export default app;
```

---

## Verificación de la Instalación

### Checklist

Después de completar la configuración, verifica:

- [ ] Node.js v18+ instalado
- [ ] MongoDB activo (local o Atlas)
- [ ] Todas las dependencias instaladas sin errores
- [ ] Archivo `.env` creado y configurado
- [ ] TypeScript configurado (`tsconfig.json`)
- [ ] ESLint y Prettier configurados
- [ ] Scripts de npm funcionando
- [ ] Archivos base creados (`src/app.ts`, `src/server.ts`)
- [ ] Carpeta `docs/` con documentación

### Probar la instalación

```bash
# Verificar que no hay errores de TypeScript
npm run typecheck

# Verificar linting
npm run lint

# Ejecutar servidor en desarrollo
npm run dev
```

Deberías ver en consola:

```
🚀 Servidor corriendo en puerto 4000
📍 Entorno: development
```

Visita `http://localhost:4000` en el navegador y deberías ver el mensaje de bienvenida.

---

## Troubleshooting

### Error: Cannot find module 'typescript'

**Solución:**

```bash
npm install -D typescript
```

### Error: EADDRINUSE - Puerto ya en uso

**Solución:**

```bash
# Windows
netstat -ano | findstr :4000
taskkill /PID <PID> /F

# Linux/Mac
lsof -ti:4000 | xargs kill -9
```

O cambiar el puerto en `.env`:

```
PORT=5000
```

### Error: MongoServerError: bad auth

**Solución:** Verificar credenciales en `MONGODB_URI` en `.env`

### Error: Module path resolution

Si los path aliases no funcionan, instalar:

```bash
npm install -D tsconfig-paths
```

Y actualizar script dev:

```json
"dev": "ts-node-dev -r tsconfig-paths/register --respawn src/server.ts"
```

### Error: ESLint no encuentra archivos

**Solución:**

```bash
# Ejecutar desde la raíz del proyecto
npm run lint
```

### Hot reload no funciona

**Solución:** Usar `tsx` en lugar de `ts-node-dev`:

```bash
npm run dev:tsx
```

---

## Recursos Adicionales

### Documentación Oficial

- [Express.js](https://expressjs.com/)
- [Mongoose](https://mongoosejs.com/)
- [TypeScript](https://www.typescriptlang.org/)
- [Zod](https://zod.dev/)
- [Socket.io](https://socket.io/)
- [Jest](https://jestjs.io/)

### Extensiones VSCode/Cursor Recomendadas

- ESLint (`dbaeumer.vscode-eslint`)
- Prettier (`esbenp.prettier-vscode`)
- REST Client (`humao.rest-client`)
- DotENV (`mikestead.dotenv`)
- Error Lens (`usernamehw.errorlens`)
- MongoDB for VS Code (`mongodb.mongodb-vscode`)
- GitLens (`eamodio.gitlens`)

### Próximos Pasos

1. Revisar [development_plan.md](./development_plan.md) para comenzar desarrollo
2. Seguir las tareas desde Fase 0 hasta Fase 15
3. Consultar [context.md](./context.md) para arquitectura y modelos

---

**Última actualización:** Octubre 2025

**Notas:**

- Este archivo se actualizará conforme avance el desarrollo
- Reportar cualquier problema o dependencia faltante
- Mantener `.env.example` actualizado con nuevas variables
