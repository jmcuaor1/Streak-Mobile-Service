# 📱 GUÍA DE EXPLORACIÓN DEL CÓDIGO - STREAK APP

## 🎯 **CÓMO VER TODO EL CÓDIGO QUE CREAMOS**

---

## 📂 **UBICACIÓN DEL PROYECTO**

```
C:\Users\Lenovo\Desktop\Streak\streak-app\
```

---

## 🔍 **FORMAS DE EXPLORAR EL CÓDIGO**

### **Opción 1: Visual Studio Code (RECOMENDADO)** ✅

1. **Abrir VSCode**
2. **File → Open Folder**
3. **Seleccionar:** `C:\Users\Lenovo\Desktop\Streak\streak-app`
4. **Instalar extensiones recomendadas:**
   - Dart
   - Flutter
   - Flutter Widget Snippets

### **Opción 2: Android Studio**

1. **Abrir Android Studio**
2. **Open an Existing Project**
3. **Seleccionar:** `C:\Users\Lenovo\Desktop\Streak\streak-app`

### **Opción 3: Explorador de Windows**

1. **Navegar a:** `C:\Users\Lenovo\Desktop\Streak\streak-app`
2. **Abrir archivos con:** Notepad++, Sublime Text, o cualquier editor

---

## 📁 **ARCHIVOS CREADOS (EN ORDEN DE IMPORTANCIA)**

### **🎨 1. Configuración y Tema**

| Archivo                              | Líneas | Descripción                     |
| ------------------------------------ | ------ | ------------------------------- |
| `pubspec.yaml`                       | 90     | Dependencias y configuración    |
| `lib/core/config/api_constants.dart` | 100    | URLs y endpoints del backend    |
| `lib/core/theme/app_colors.dart`     | 160    | Paleta de colores Streak        |
| `lib/core/theme/app_theme.dart`      | 200    | Tema Material 3 completo        |
| `lib/main.dart`                      | 50     | Punto de entrada de la app      |
| `lib/app.dart`                       | 80     | Aplicación principal con Splash |

**Archivos clave para ver primero:**

```
📂 streak-app/
├── 📄 pubspec.yaml                    ← EMPIEZA AQUÍ (dependencias)
├── 📂 lib/
│   ├── 📄 main.dart                   ← PUNTO DE ENTRADA
│   ├── 📄 app.dart                    ← APP PRINCIPAL
│   └── 📂 core/
│       ├── 📂 config/
│       │   └── 📄 api_constants.dart  ← URLS BACKEND
│       └── 📂 theme/
│           ├── 📄 app_colors.dart     ← COLORES
│           └── 📄 app_theme.dart      ← TEMA
```

---

### **📦 2. Modelos de Datos (Sincronizados con Backend)**

| Archivo                                  | Líneas | Descripción                     |
| ---------------------------------------- | ------ | ------------------------------- |
| `lib/data/models/user_model.dart`        | 180    | Usuario, Perfil, Gamificación   |
| `lib/data/models/job_model.dart`         | 120    | Trabajo/Job, Salario, Empleador |
| `lib/data/models/application_model.dart` | 80     | Postulación a trabajos          |
| `lib/data/models/auth_models.dart`       | 200    | DTOs de autenticación           |

**Archivos de modelos:**

```
📂 lib/data/models/
├── 📄 user_model.dart           ← Usuario completo con gamificación
├── 📄 job_model.dart            ← Trabajos y empleadores
├── 📄 application_model.dart    ← Postulaciones
└── 📄 auth_models.dart          ← Login, Register, Tokens
```

**Para entenderlos mejor:**

```dart
// user_model.dart
UserModel → Modelo completo del usuario
├── profile → Nombre, avatar, bio
├── freelancerProfile → Skills, portfolio, rate
├── preferences → Notificaciones, tema, idioma
└── gamification → Puntos, nivel, streaks

// job_model.dart
JobModel → Modelo de trabajo
├── title, description, category
├── skills → Lista de habilidades requeridas
├── salary → Min, max, currency
└── employerInfo → Datos del empleador

// application_model.dart
ApplicationModel → Postulación
├── job → Trabajo al que aplica
├── applicant → Usuario que aplica
├── coverLetter → Carta de presentación
└── status → pending, accepted, rejected
```

---

### **🔌 3. Servicios (Backend + Storage)**

| Archivo                                  | Líneas | Descripción                               |
| ---------------------------------------- | ------ | ----------------------------------------- |
| `lib/data/services/api_service.dart`     | 250    | Comunicación con backend (Dio + Retrofit) |
| `lib/data/services/storage_service.dart` | 180    | Almacenamiento local (tokens, datos)      |

**Archivos de servicios:**

```
📂 lib/data/services/
├── 📄 api_service.dart       ← CONEXIÓN AL BACKEND
│   ├── register()            ← POST /api/auth/register
│   ├── login()               ← POST /api/auth/login
│   ├── getJobs()             ← GET /api/jobs
│   ├── createApplication()   ← POST /api/applications
│   └── + 30 métodos más      ← Todos los endpoints
│
└── 📄 storage_service.dart   ← ALMACENAMIENTO LOCAL
    ├── saveTokens()          ← Guardar JWT tokens
    ├── getAccessToken()      ← Obtener access token
    ├── saveUserData()        ← Guardar datos de usuario
    └── clearAll()            ← Limpiar al logout
```

**Cómo funciona ApiService:**

```dart
// 1. Inicialización
ApiService → Usa Dio para HTTP
├── BaseURL: http://localhost:4000
├── Interceptors:
│   ├── Agrega token JWT automáticamente
│   ├── Refresca token si expira (401)
│   └── Logging de todas las peticiones
│
└── Métodos para cada endpoint:
    ├── Auth: register, login, logout
    ├── Users: getUsers, updateProfile
    ├── Jobs: getJobs, createJob, updateJob
    ├── Applications: createApplication, accept, reject
    └── Gamification: getStats, getLeaderboard
```

---

## 🚀 **CÓMO CORRER EL PROYECTO**

### **Prerequisitos:**

1. **Flutter instalado** (Verifica con: `flutter doctor`)
2. **Backend corriendo** en `http://localhost:4000`

### **Pasos:**

```bash
# 1. Navegar al proyecto
cd C:\Users\Lenovo\Desktop\Streak\streak-app

# 2. Instalar dependencias
flutter pub get

# 3. Generar código (para Freezed y JSON)
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Correr la app
flutter run

# O para hot reload continuo:
flutter run --debug
```

---

## 📊 **ARQUITECTURA VISUAL**

```
┌─────────────────────────────────────────┐
│         PRESENTATION LAYER              │
│  (Widgets, Screens, Providers)          │
│                                         │
│  ┌──────────┐  ┌──────────┐           │
│  │ Screens  │  │ Widgets  │           │
│  └────┬─────┘  └────┬─────┘           │
│       │             │                  │
│       └─────┬───────┘                  │
│             │                          │
│       ┌─────▼──────┐                   │
│       │  Providers │ (Riverpod)        │
│       └─────┬──────┘                   │
└─────────────┼──────────────────────────┘
              │
┌─────────────▼──────────────────────────┐
│          DOMAIN LAYER                   │
│     (Use Cases, Entities)               │
│                                         │
│  ┌──────────────┐  ┌───────────────┐  │
│  │  Use Cases   │  │   Entities    │  │
│  └──────────────┘  └───────────────┘  │
└─────────────┬──────────────────────────┘
              │
┌─────────────▼──────────────────────────┐
│           DATA LAYER                    │
│  (Models, Repositories, Services)       │
│                                         │
│  ┌────────────┐  ┌──────────────────┐ │
│  │  Models    │  │  Repositories    │ │
│  └────────────┘  └──────────────────┘ │
│                                        │
│  ┌──────────────────────────────────┐ │
│  │         SERVICES                 │ │
│  │                                  │ │
│  │  ┌─────────────┐  ┌──────────┐  │ │
│  │  │ ApiService  │  │ Storage  │  │ │
│  │  │   (Dio)     │  │ Service  │  │ │
│  │  └──────┬──────┘  └────┬─────┘  │ │
│  └─────────┼──────────────┼────────┘ │
└────────────┼──────────────┼──────────┘
             │              │
             │              │
      ┌──────▼────┐    ┌───▼─────────┐
      │  BACKEND  │    │ LOCAL       │
      │  Node.js  │    │ STORAGE     │
      │  MongoDB  │    │ Secure+Hive │
      └───────────┘    └─────────────┘
```

---

## 🔍 **EXPLORANDO ARCHIVOS ESPECÍFICOS**

### **1. Ver el modelo de Usuario**

```bash
# Ruta
C:\Users\Lenovo\Desktop\Streak\streak-app\lib\data\models\user_model.dart

# Contiene:
- UserModel → Modelo principal
- ProfileModel → Perfil básico
- FreelancerProfileModel → Perfil de freelancer
- GamificationModel → Puntos, nivel, streaks
- PreferencesModel → Configuraciones

# Ejemplo de uso:
final user = UserModel(
  id: '123',
  email: 'juan@email.com',
  role: 'freelancer',
  profile: ProfileModel(
    firstName: 'Juan',
    lastName: 'Pérez',
  ),
  gamification: GamificationModel(
    totalPoints: 150,
    level: 3,
    currentStreak: 7,
  ),
);
```

### **2. Ver el ApiService**

```bash
# Ruta
C:\Users\Lenovo\Desktop\Streak\streak-app\lib\data\services\api_service.dart

# Métodos principales:
- register() → POST /api/auth/register
- login() → POST /api/auth/login
- getJobs() → GET /api/jobs
- createJob() → POST /api/jobs
- createApplication() → POST /api/applications

# Características:
✅ Auto-refresh de tokens
✅ Interceptors para logging
✅ Manejo de errores automático
✅ Headers con JWT automático
```

### **3. Ver el tema**

```bash
# Ruta
C:\Users\Lenovo\Desktop\Streak\streak-app\lib/core/theme/app_theme.dart

# Incluye:
- Tema Light (completo)
- Tema Dark (placeholder)
- Google Fonts (Inter)
- Material 3
- Todos los widgets themed:
  - AppBar
  - Buttons (Elevated, Outlined, Text)
  - TextFields
  - Cards
  - Chips
  - BottomNavigationBar
```

---

## 📋 **CHECKLIST DE ARCHIVOS CREADOS**

### ✅ **Configuración (5 archivos)**

- [x] `pubspec.yaml`
- [x] `lib/core/config/api_constants.dart`
- [x] `lib/core/theme/app_colors.dart`
- [x] `lib/core/theme/app_theme.dart`
- [x] `lib/main.dart`
- [x] `lib/app.dart`

### ✅ **Modelos (4 archivos)**

- [x] `lib/data/models/user_model.dart`
- [x] `lib/data/models/job_model.dart`
- [x] `lib/data/models/application_model.dart`
- [x] `lib/data/models/auth_models.dart`

### ✅ **Servicios (2 archivos)**

- [x] `lib/data/services/api_service.dart`
- [x] `lib/data/services/storage_service.dart`

**Total: 11 archivos creados (~1,500 líneas de código)**

---

## 🎨 **VISUALIZAR ESTRUCTURA EN VSCode**

Una vez abras VSCode en la carpeta del proyecto, verás:

```
STREAK-APP
├── 📂 android/
├── 📂 ios/
├── 📂 lib/                          ← AQUÍ ESTÁ TODO EL CÓDIGO
│   ├── 📄 main.dart                 ← PUNTO DE ENTRADA
│   ├── 📄 app.dart                  ← APP PRINCIPAL
│   │
│   ├── 📂 core/                     ← CONFIGURACIÓN
│   │   ├── 📂 config/
│   │   │   └── 📄 api_constants.dart
│   │   ├── 📂 theme/
│   │   │   ├── 📄 app_colors.dart
│   │   │   └── 📄 app_theme.dart
│   │   ├── 📂 utils/                (vacío)
│   │   └── 📂 constants/            (vacío)
│   │
│   ├── 📂 data/                     ← MODELOS Y SERVICIOS
│   │   ├── 📂 models/
│   │   │   ├── 📄 user_model.dart
│   │   │   ├── 📄 job_model.dart
│   │   │   ├── 📄 application_model.dart
│   │   │   └── 📄 auth_models.dart
│   │   ├── 📂 repositories/         (vacío)
│   │   └── 📂 services/
│   │       ├── 📄 api_service.dart
│   │       └── 📄 storage_service.dart
│   │
│   ├── 📂 domain/                   (vacío)
│   │   ├── 📂 entities/
│   │   └── 📂 usecases/
│   │
│   └── 📂 presentation/             (vacío - próximos)
│       ├── 📂 providers/
│       ├── 📂 screens/
│       └── 📂 widgets/
│
├── 📄 pubspec.yaml                  ← DEPENDENCIAS
└── 📄 README.md
```

---

## 🚀 **PRÓXIMOS PASOS**

### **Lo que sigue:**

1. **Generar código Freezed**

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

2. **Migrar widgets de UIX-GALLO**

   - JobCard
   - PromoCard
   - StatCard

3. **Crear pantallas de Auth**

   - Login Screen
   - Register Screen

4. **Crear Providers con Riverpod**
   - AuthProvider
   - JobProvider
   - ApplicationProvider

---

## 💡 **TIPS PARA EXPLORAR**

### **En VSCode:**

1. **Ctrl + P** → Buscar archivos rápidamente
2. **Ctrl + Click** en un import → Ir a ese archivo
3. **F12** → Ir a definición
4. **Shift + F12** → Ver todas las referencias

### **Navegación rápida:**

```dart
// En cualquier archivo, puedes hacer Ctrl+Click en:
import 'package:streak/data/models/user_model.dart';  // ← Ir al archivo
import '../services/api_service.dart';  // ← Ir al servicio

final apiService = ref.read(apiServiceProvider);  // ← Ver provider
```

---

## 📞 **ARCHIVOS IMPORTANTES**

### **Para empezar a ver código:**

1. **`pubspec.yaml`** → Ver todas las dependencias
2. **`lib/main.dart`** → Entender cómo inicia la app
3. **`lib/core/config/api_constants.dart`** → Ver endpoints del backend
4. **`lib/data/services/api_service.dart`** → Ver cómo se conecta al backend
5. **`lib/data/models/user_model.dart`** → Ver estructura de datos

---

**🎉 ¡Ya tienes TODO el código base listo!**

**¿Listo para explorar? Abre VSCode y navega por los archivos.** 🚀

_Actualizado: Octubre 2024_
