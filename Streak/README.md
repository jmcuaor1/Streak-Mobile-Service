# Streak - Plataforma Laboral Gamificada

<div align="center">

![Streak Logo](https://via.placeholder.com/200x200?text=Streak)

**Plataforma laboral gamificada y marketplace freelance para Magneto**

[![Node.js](https://img.shields.io/badge/Node.js-18+-green.svg)](https://nodejs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.0+-blue.svg)](https://www.typescriptlang.org/)
[![Flutter](https://img.shields.io/badge/Flutter-3.16+-02569B.svg)](https://flutter.dev/)
[![MongoDB](https://img.shields.io/badge/MongoDB-7.0+-green.svg)](https://www.mongodb.com/)
[![License](https://img.shields.io/badge/License-Proprietary-red.svg)]()

[Documentación](./docs) · [Reportar Bug](../../issues) · [Solicitar Feature](../../issues)

</div>

---

## 📋 Tabla de Contenidos

- [Acerca del Proyecto](#-acerca-del-proyecto)
- [Características Principales](#-características-principales)
- [Stack Tecnológico](#-stack-tecnológico)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Inicio Rápido](#-inicio-rápido)
- [Documentación](#-documentación)
- [Desarrollo](#-desarrollo)
- [Roadmap](#-roadmap)
- [Licencia](#-licencia)

---

## 🎯 Acerca del Proyecto

**Streak** es una plataforma innovadora que combina la búsqueda de empleo tradicional con un ecosistema freelance y un sistema de gamificación completo. El objetivo es aumentar la retención y engagement de usuarios mediante rachas de actividad, logros desbloqueables y un sistema de recompensas.

### Problema que Resuelve

- **Baja retención** en plataformas de empleo tradicionales
- **Falta de motivación** para mantenerse activo en la búsqueda
- **Desconexión** entre trabajo freelance y empleo tradicional
- **Ausencia de seguimiento** del progreso del usuario

### Solución

- 🔥 **Sistema de Rachas** - Mantén tu racha aplicando a trabajos o completando gigs
- 🏆 **Logros y Achievements** - Desbloquea logros según tu actividad
- 💼 **Dual Marketplace** - Empleo tradicional + freelance en una sola plataforma
- 💬 **Chat en Tiempo Real** - Comunicación directa cliente-freelancer
- 📊 **Dashboard Gamificado** - Visualiza tu progreso y estadísticas

---

## ✨ Características Principales

### Para Buscadores de Empleo (Jobseekers)

- ✅ Búsqueda y aplicación a ofertas laborales
- ✅ Seguimiento de aplicaciones
- ✅ Rachas por actividad diaria
- ✅ Logros desbloqueables
- ✅ Perfil profesional completo

### Para Freelancers

- ✅ Creación y gestión de gigs (servicios)
- ✅ Sistema de órdenes con estados
- ✅ Chat integrado con clientes
- ✅ Sistema de reviews y ratings
- ✅ Paquetes de servicios (basic, standard, premium)

### Para Empleadores

- ✅ Publicación de ofertas laborales
- ✅ Gestión de aplicaciones
- ✅ Filtrado y búsqueda de candidatos
- ✅ Panel de administración

### Características del Sistema

- 🔔 **Notificaciones Push** vía Firebase
- ⚡ **Tiempo Real** con Socket.io
- 🔐 **Autenticación JWT** con refresh tokens
- 📈 **Sistema de Streaks** inteligente
- 🎖️ **Sistema de Achievements** personalizable
- 🔄 **Workers** para tareas programadas
- 🧪 **Testing** completo (unitario + integración)

---

## 🛠️ Stack Tecnológico

### Backend

| Tecnología | Versión | Propósito              |
| ---------- | ------- | ---------------------- |
| Node.js    | 18+     | Runtime JavaScript     |
| TypeScript | 5.0+    | Tipado estático        |
| Express    | 4.18+   | Framework web          |
| MongoDB    | 7.0+    | Base de datos NoSQL    |
| Mongoose   | 8.0+    | ODM para MongoDB       |
| Socket.io  | 4.6+    | WebSockets             |
| JWT        | 9.0+    | Autenticación          |
| Zod        | 3.22+   | Validación de esquemas |
| Jest       | 29+     | Testing                |

### Frontend

| Tecnología       | Versión | Propósito           |
| ---------------- | ------- | ------------------- |
| Flutter          | 3.16+   | Framework móvil     |
| Dart             | 3.2+    | Lenguaje            |
| Riverpod         | 2.4+    | Gestión de estado   |
| Dio              | 5.4+    | Cliente HTTP        |
| Socket.io Client | 2.0+    | WebSockets          |
| Firebase         | Latest  | Notificaciones push |
| Go Router        | 13+     | Navegación          |

### DevOps & Herramientas

- **Control de Versiones:** Git
- **CI/CD:** GitHub Actions (futuro)
- **Testing:** Jest, Flutter Test
- **Linting:** ESLint, Dart Analyzer
- **Formateo:** Prettier, Dart Format

---

## 📁 Estructura del Proyecto

```
Streak/
├── docs/                        # 📚 Documentación completa
│   ├── README.md               # Índice de documentación
│   ├── context.md              # Arquitectura y modelos
│   ├── development_plan.md     # Plan de desarrollo (150+ tareas)
│   ├── package-setup.md        # Setup del backend
│   └── frontend-setup.md       # Setup del frontend
│
├── streak-backend/             # 🖥️ API Backend (Node.js + TypeScript)
│   ├── src/
│   │   ├── api/               # Módulos de la API
│   │   ├── core/              # Utilidades core
│   │   ├── config/            # Configuraciones
│   │   ├── sockets/           # WebSocket handlers
│   │   └── workers/           # Tareas programadas
│   ├── tests/                 # Tests
│   ├── package.json
│   └── tsconfig.json
│
├── streak_app/                 # 📱 App Móvil (Flutter)
│   ├── lib/
│   │   ├── core/              # Configuración core
│   │   ├── data/              # Modelos y repositorios
│   │   ├── domain/            # Lógica de negocio
│   │   └── presentation/      # UI y pantallas
│   ├── test/                  # Tests
│   ├── pubspec.yaml
│   └── analysis_options.yaml
│
├── .gitignore
└── README.md                   # Este archivo
```

---

## 🚀 Inicio Rápido

### Prerrequisitos

Antes de comenzar, asegúrate de tener instalado:

- **Node.js** v18.0.0 o superior
- **npm** v9.0.0 o superior
- **MongoDB** (local o Atlas)
- **Flutter** v3.16.0 o superior (para el frontend)
- **Git**

### Instalación

#### 1. Clonar el Repositorio

```bash
git clone https://github.com/magneto/streak.git
cd Streak
```

#### 2. Setup del Backend

```bash
# Navegar a la carpeta del backend
cd streak-backend

# Instalar dependencias
npm install

# Copiar archivo de entorno
cp .env.example .env

# Editar .env con tus configuraciones
# nano .env  (o usar tu editor favorito)

# Ejecutar en desarrollo
npm run dev
```

**Documentación completa:** [docs/package-setup.md](./docs/package-setup.md)

#### 3. Setup del Frontend

```bash
# Navegar a la carpeta del frontend
cd streak_app

# Instalar dependencias
flutter pub get

# Ejecutar generadores de código
flutter pub run build_runner build --delete-conflicting-outputs

# Ejecutar en emulador/dispositivo
flutter run
```

**Documentación completa:** [docs/frontend-setup.md](./docs/frontend-setup.md)

#### 4. Verificar Instalación

**Backend:**

```bash
curl http://localhost:4000/health
```

Deberías recibir:

```json
{
  "success": true,
  "status": "OK",
  "timestamp": "2025-10-14T..."
}
```

**Frontend:**

- La app debería iniciar en tu emulador/dispositivo

---

## 📚 Documentación

Toda la documentación del proyecto está en la carpeta `docs/`:

| Documento                                              | Descripción                                                               |
| ------------------------------------------------------ | ------------------------------------------------------------------------- |
| [docs/README.md](./docs/README.md)                     | **Índice de documentación** - Punto de entrada a toda la documentación    |
| [docs/context.md](./docs/context.md)                   | **Arquitectura completa** - Modelos, esquemas, tecnologías y convenciones |
| [docs/development_plan.md](./docs/development_plan.md) | **Plan de desarrollo** - 150+ tareas organizadas en 15 fases              |
| [docs/package-setup.md](./docs/package-setup.md)       | **Setup del backend** - Instalación y configuración completa              |
| [docs/frontend-setup.md](./docs/frontend-setup.md)     | **Setup del frontend** - Configuración de Flutter                         |

### Para Empezar a Desarrollar

1. Lee [docs/context.md](./docs/context.md) - Entender la arquitectura
2. Sigue [docs/package-setup.md](./docs/package-setup.md) - Configurar backend
3. Consulta [docs/development_plan.md](./docs/development_plan.md) - Seguir tareas

---

## 💻 Desarrollo

### Scripts del Backend

```bash
npm run dev          # Ejecutar en desarrollo con hot reload
npm run build        # Compilar TypeScript
npm run start        # Ejecutar versión compilada
npm run lint         # Verificar linting
npm run lint:fix     # Corregir errores de linting
npm run test         # Ejecutar tests
npm run test:watch   # Tests en modo watch
npm run test:coverage # Tests con cobertura
```

### Scripts del Frontend

```bash
flutter run          # Ejecutar app
flutter test         # Ejecutar tests
flutter analyze      # Analizar código
flutter build apk    # Compilar APK (Android)
flutter build ios    # Compilar iOS
```

### Convenciones de Código

#### Backend (TypeScript)

- Usar `async/await` en lugar de callbacks
- Tipado estricto (evitar `any`)
- Comentarios JSDoc en funciones públicas
- Validación con Zod en DTOs
- Nombres descriptivos para variables y funciones

#### Frontend (Dart/Flutter)

- Seguir guía de estilo de Dart
- Usar Riverpod para estado
- Widgets pequeños y reutilizables
- Separación de UI y lógica de negocio

### Flujo de Git

```bash
# Crear rama para feature
git checkout -b feat/nombre-del-feature

# Hacer commits siguiendo convenciones
git commit -m "feat(module): descripción"

# Push y crear Pull Request
git push origin feat/nombre-del-feature
```

**Convenciones de commits:**

```
feat(module): nueva característica
fix(module): corrección de bug
refactor(module): refactorización
test(module): agregar tests
docs: actualizar documentación
```

---

## 🗺️ Roadmap

### ✅ Fase 0: Setup Inicial (Semana 1)

- [x] Configuración del proyecto
- [x] Documentación completa
- [ ] Instalación de dependencias
- [ ] Estructura de carpetas

### 🔄 Fase 1-3: Core del Sistema (Semanas 2-4)

- [ ] Base de datos configurada
- [ ] Sistema de autenticación (JWT)
- [ ] CRUD de usuarios
- [ ] Middlewares básicos

### 📝 Fase 4-6: Módulos Principales (Semanas 5-8)

- [ ] Módulo de Jobs
- [ ] Módulo de Applications
- [ ] Módulo de Gigs

### 💬 Fase 7-9: Features Avanzadas (Semanas 9-12)

- [ ] Sistema de Orders
- [ ] Chat en tiempo real
- [ ] Sistema de Reviews

### 🎮 Fase 10-12: Gamificación (Semanas 13-16)

- [ ] Sistema de Streaks
- [ ] Achievements
- [ ] Notificaciones push

### 🧪 Fase 13-15: Finalización (Semanas 17-20)

- [ ] Workers y tareas programadas
- [ ] Testing completo
- [ ] Deployment

**Detalle completo:** [docs/development_plan.md](./docs/development_plan.md)

---

## 🤝 Contribución

Este es un proyecto privado de **Magneto**. El acceso y contribución están restringidos al equipo de desarrollo autorizado.

### Para el Equipo

1. Leer toda la documentación en `docs/`
2. Seguir convenciones de código establecidas
3. Escribir tests para nueva funcionalidad
4. Actualizar documentación cuando sea necesario
5. Hacer code review antes de merge

---

## 📞 Soporte

Para soporte técnico o preguntas:

- **Documentación:** Revisar carpeta `docs/`
- **Issues:** Crear issue en el repositorio
- **Equipo:** Contactar a los desarrolladores principales

---

## 📜 Licencia

Este proyecto es propiedad de **Magneto** y está protegido por derechos de autor. Todos los derechos reservados.

El uso, reproducción, modificación o distribución no autorizada de este código está estrictamente prohibido.

---

## 👥 Equipo

**Proyecto:** Streak

**Empresa:** Magneto

**Desarrollado por:** Equipo de Desarrollo Magneto

---

<div align="center">

**Hecho con ❤️ por el equipo de Magneto**

[Volver arriba](#streak---plataforma-laboral-gamificada)

</div>
