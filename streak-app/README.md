# 📱 Streak Mobile App

> Aplicación móvil Flutter para la plataforma gamificada de empleos y freelancing Streak

![Flutter](https://img.shields.io/badge/Flutter-3.9.0-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.9.0-0175C2?logo=dart)
![Status](https://img.shields.io/badge/Status-En_Desarrollo-yellow)

---

## 📊 Estado del Proyecto

### ✅ **Completado**

- [x] Proyecto Flutter creado con estructura limpia
- [x] Arquitectura Clean Architecture configurada
- [x] Estructura de carpetas organizada
- [x] Todas las dependencias agregadas (30+ packages)
- [x] Tema de la app configurado
- [x] Constantes de API configuradas
- [x] Conexión al backend preparada

### 🚧 **En Progreso**

- [ ] Modelos de datos sincronizados con backend
- [ ] API Service con Dio
- [ ] Storage Service para tokens
- [ ] Pantallas de autenticación
- [ ] Sistema de gamificación

---

## 🏗️ Arquitectura

Este proyecto sigue **Clean Architecture** con la siguiente estructura:

```
lib/
├── core/                          ✅ Configurado
│   ├── config/
│   │   └── api_constants.dart     ✅ URLs del backend
│   ├── theme/
│   │   ├── app_theme.dart         ✅ Tema completo
│   │   └── app_colors.dart        ✅ Paleta de colores
│   ├── utils/                     🚧 Pendiente
│   └── constants/                 🚧 Pendiente
│
├── data/                          🚧 En progreso
│   ├── models/                    🚧 Sincronizar con backend
│   ├── repositories/              🚧 Implementar
│   └── services/
│       ├── api_service.dart       🚧 Dio + Retrofit
│       ├── storage_service.dart   🚧 SecureStorage
│       └── socket_service.dart    📅 Futuro
│
├── domain/                        📅 Próximamente
│   ├── entities/
│   └── usecases/
│
└── presentation/                  🚧 En progreso
    ├── providers/                 🚧 Riverpod
    ├── screens/
    │   ├── auth/                  🚧 Login, Register
    │   ├── home/                  📋 Migrar de UIX-GALLO
    │   ├── jobs/                  📋 Migrar de UIX-GALLO
    │   ├── applications/          📋 Migrar de UIX-CUAO
    │   ├── profile/               📋 Migrar de UIX-CUAO
    │   └── gamification/          🆕 Crear desde cero
    └── widgets/
        ├── common/                📋 Migrar de UIX-GALLO
        ├── job/                   📋 Migrar de UIX-GALLO
        └── gamification/          🆕 Crear desde cero
```

---

## 📦 Dependencias

### State Management

- `flutter_riverpod` - Gestión de estado

### HTTP & API

- `dio` - Cliente HTTP
- `retrofit` - API REST type-safe
- `json_annotation` - Serialización JSON

### Storage

- `shared_preferences` - Datos simples
- `flutter_secure_storage` - Tokens seguros
- `hive` - Base de datos local

### Navigation

- `go_router` - Navegación declarativa

### UI

- `google_fonts` - Tipografías
- `cached_network_image` - Imágenes con caché
- `shimmer` - Loading placeholders
- `lottie` - Animaciones

### Firebase

- `firebase_core` - Core Firebase
- `firebase_messaging` - Notificaciones push

**Total: 30+ dependencias**

---

## 🔗 Backend

Este proyecto se conecta al backend Node.js + TypeScript que ya está funcionando:

| Aspecto           | Estado                    |
| ----------------- | ------------------------- |
| **URL Dev**       | `http://localhost:4000`   |
| **URL Prod**      | Pendiente configurar      |
| **Endpoints**     | 38 REST endpoints         |
| **Base de datos** | MongoDB Atlas ✅          |
| **Autenticación** | JWT (access + refresh) ✅ |

---

## 🎨 UI/UX Reutilizada

### De UIX-GALLO ⭐ (Mejor calidad)

- ✅ Home Screen
- ✅ Job Detail Screen
- ✅ Search Screen
- ✅ Filter Screen
- ✅ Widgets: JobCard, PromoCard, StatCard

### De UIX-CUAO

- ✅ Create Job Page
- ✅ Profile Page
- ✅ Applications Page

### Nuevas (Por crear)

- ❌ Login Screen
- ❌ Register Screen
- ❌ Streaks Screen
- ❌ Achievements Screen
- ❌ Leaderboard

---

## 🚀 Instalación y Uso

### Prerequisitos

- Flutter SDK 3.9.0+
- Dart SDK 3.9.0+
- Android Studio / Xcode
- Backend corriendo en `localhost:4000`

### Setup

```bash
# 1. Instalar dependencias
flutter pub get

# 2. Generar código (modelos, etc.)
flutter pub run build_runner build --delete-conflicting-outputs

# 3. Correr la app
flutter run

# 4. Para desarrollo (hot reload)
flutter run --debug
```

---

## 📋 Próximos Pasos

### Fase 1: Core (En progreso)

1. [ ] Crear modelos `User`, `Job`, `Application` sincronizados con backend
2. [ ] Implementar `ApiService` con Dio + interceptors
3. [ ] Implementar `StorageService` para tokens
4. [ ] Configurar manejo de errores global

### Fase 2: Autenticación

5. [ ] Pantalla de Login
6. [ ] Pantalla de Registro
7. [ ] Auth Provider con Riverpod
8. [ ] Manejo de JWT (access + refresh tokens)
9. [ ] Navegación condicional (logged in/out)

### Fase 3: Jobs

10. [ ] Migrar Home Screen y conectar al backend
11. [ ] Migrar Job Detail y conectar
12. [ ] Implementar Search y Filters
13. [ ] Crear Job screen

### Fase 4: Applications

14. [ ] Ver mis postulaciones
15. [ ] Postular a jobs
16. [ ] Gestionar postulaciones

### Fase 5: Gamificación

17. [ ] Pantalla de Streaks
18. [ ] Pantalla de Achievements
19. [ ] Leaderboard
20. [ ] Widgets de gamificación

---

## 🎯 Características

### Implementadas ✅

- Estructura de proyecto limpia
- Tema personalizado
- Configuración de API

### En Desarrollo 🚧

- Autenticación JWT
- Gestión de estado con Riverpod
- Conexión con backend

### Pendientes 📅

- Búsqueda y filtros de jobs
- Sistema de postulaciones
- Gamificación completa
- Notificaciones push
- Chat en tiempo real

---

## 📝 Convenciones

### Código

- Usar `flutter_lints` para estilo
- Nombrar archivos en `snake_case`
- Clases en `PascalCase`
- Variables y funciones en `camelCase`

### Commits

- `feat:` Nueva funcionalidad
- `fix:` Corrección de bugs
- `refactor:` Refactorización
- `docs:` Documentación
- `style:` Formateo
- `test:` Tests

---

## 📚 Documentación

- [Análisis Frontend](../ANALISIS_FRONTEND.md) - Análisis del código de tus compañeros
- [Backend](../streak-backend/README.md) - Documentación del backend
- [API Docs](../docs/package-setup.md) - Endpoints disponibles

---

## 👥 Equipo

- **Backend:** Backend completo con 38 endpoints ✅
- **Frontend:** Proyecto nuevo con arquitectura profesional 🚧
- **UI/UX:** Reutilizado de UIX-GALLO y UIX-CUAO ♻️

---

## 📄 Licencia

Proyecto privado - Todos los derechos reservados

---

**🚀 ¡Proyecto en construcción activa!**

_Última actualización: Octubre 2024_
