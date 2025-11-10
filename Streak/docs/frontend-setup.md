# Configuración Frontend - Streak Flutter App

**Proyecto:** Streak — Aplicación móvil para plataforma laboral gamificada

**Stack Frontend:** Flutter + Dart + Riverpod + Socket.io

**Documentos relacionados:**

- [Contexto General](./context.md) - Arquitectura completa del sistema
- [Configuración Backend](./package-setup.md) - Setup del servidor
- [Plan de Desarrollo](./development_plan.md) - Roadmap general

---

## Tabla de Contenidos

1. [Requisitos Previos](#requisitos-previos)
2. [Instalación de Flutter](#instalación-de-flutter)
3. [Creación del Proyecto](#creación-del-proyecto)
4. [Dependencias del Proyecto](#dependencias-del-proyecto)
5. [Configuración del Proyecto](#configuración-del-proyecto)
6. [Estructura de Carpetas](#estructura-de-carpetas)
7. [Configuración de Entorno](#configuración-de-entorno)
8. [Testing](#testing)
9. [Troubleshooting](#troubleshooting)

---

## Requisitos Previos

### Software Necesario

- **Flutter SDK:** 3.16.0 o superior
- **Dart:** 3.2.0 o superior (viene con Flutter)
- **Android Studio:** Para desarrollo Android
- **Xcode:** Para desarrollo iOS (solo macOS)
- **Git:** Para control de versiones
- **Editor:** VSCode o Android Studio

### Verificar instalaciones

```bash
flutter --version
dart --version
git --version
```

### Instalación de Flutter

#### Windows

```powershell
# Descargar Flutter SDK desde https://flutter.dev/docs/get-started/install/windows
# Extraer en C:\src\flutter

# Agregar a PATH (en Variables de Entorno del Sistema)
C:\src\flutter\bin

# Verificar instalación
flutter doctor
```

#### macOS

```bash
# Usando Homebrew
brew install --cask flutter

# O descarga manual desde https://flutter.dev/docs/get-started/install/macos

# Verificar instalación
flutter doctor
```

#### Linux

```bash
# Descargar Flutter SDK
cd ~/development
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.0-stable.tar.xz
tar xf flutter_linux_3.16.0-stable.tar.xz

# Agregar a PATH en ~/.bashrc o ~/.zshrc
export PATH="$PATH:$HOME/development/flutter/bin"

# Verificar instalación
flutter doctor
```

### Configurar Android Studio

```bash
# Instalar Android SDK y emuladores
flutter doctor --android-licenses
```

---

## Creación del Proyecto

### Crear proyecto Flutter

```bash
# Navegar a la carpeta raíz de Streak
cd Streak

# Crear proyecto Flutter
flutter create streak_app --org com.magneto.streak

# Entrar al proyecto
cd streak_app
```

### Estructura inicial generada

```
streak_app/
├── android/          # Configuración Android
├── ios/              # Configuración iOS
├── lib/              # Código Dart
│   └── main.dart
├── test/             # Tests
├── pubspec.yaml      # Dependencias
└── README.md
```

---

## Dependencias del Proyecto

### pubspec.yaml

Editar `pubspec.yaml` y agregar las siguientes dependencias:

```yaml
name: streak_app
description: Plataforma laboral gamificada y marketplace freelance
publish_to: "none"
version: 1.0.0+1

environment:
  sdk: ">=3.2.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter

  # HTTP y API
  dio: ^5.4.0 # Cliente HTTP avanzado
  retrofit: ^4.0.3 # Generador de APIs REST
  json_annotation: ^4.8.1 # Anotaciones para JSON

  # Estado y arquitectura
  flutter_riverpod: ^2.4.9 # Gestión de estado reactiva
  riverpod_annotation: ^2.3.3 # Code generation para Riverpod

  # Comunicación en tiempo real
  socket_io_client: ^2.0.3 # WebSockets para chat

  # Navegación
  go_router: ^13.0.0 # Enrutamiento declarativo

  # Almacenamiento local
  shared_preferences: ^2.2.2 # Preferencias del usuario
  flutter_secure_storage: ^9.0.0 # Almacenamiento seguro (tokens)
  hive: ^2.2.3 # Base de datos local NoSQL
  hive_flutter: ^1.1.0

  # UI y diseño
  flutter_svg: ^2.0.9 # Soporte SVG
  cached_network_image: ^3.3.1 # Caché de imágenes
  shimmer: ^3.0.0 # Efectos de carga
  lottie: ^3.0.0 # Animaciones Lottie
  google_fonts: ^6.1.0 # Fuentes de Google

  # Formularios y validación
  flutter_form_builder: ^9.1.1 # Constructor de formularios
  form_builder_validators: ^9.1.0 # Validadores predefinidos

  # Utilidades
  intl: ^0.19.0 # Internacionalización y formatos
  timeago: ^3.6.0 # Formatos de tiempo relativo
  logger: ^2.0.2 # Logger avanzado
  equatable: ^2.0.5 # Comparación de objetos
  freezed_annotation: ^2.4.1 # Clases inmutables

  # Notificaciones
  firebase_core: ^2.24.2 # Core de Firebase
  firebase_messaging: ^14.7.9 # Notificaciones push

  # Permisos
  permission_handler: ^11.1.0 # Gestión de permisos

  # Archivos e imágenes
  image_picker: ^1.0.5 # Selección de imágenes
  file_picker: ^6.1.1 # Selección de archivos
  path_provider: ^2.1.1 # Rutas del sistema

dev_dependencies:
  flutter_test:
    sdk: flutter

  # Linting
  flutter_lints: ^3.0.1 # Reglas de linting recomendadas
  very_good_analysis: ^5.1.0 # Linting estricto

  # Code generation
  build_runner: ^2.4.7 # Generación de código
  retrofit_generator: ^8.0.6 # Generador de Retrofit
  json_serializable: ^6.7.1 # Serialización JSON
  riverpod_generator: ^2.3.9 # Generador de Riverpod
  freezed: ^2.4.6 # Generador de clases inmutables
  hive_generator: ^2.0.1 # Generador de Hive

  # Testing
  mockito: ^5.4.4 # Mocks para testing
  integration_test:
    sdk: flutter

flutter:
  uses-material-design: true

  # Recursos
  assets:
    - assets/images/
    - assets/icons/
    - assets/animations/
    - assets/fonts/

  # Fuentes personalizadas (opcional)
  # fonts:
  #   - family: CustomFont
  #     fonts:
  #       - asset: assets/fonts/CustomFont-Regular.ttf
  #       - asset: assets/fonts/CustomFont-Bold.ttf
  #         weight: 700
```

### Instalar dependencias

```bash
flutter pub get
```

### Ejecutar generadores de código

```bash
# Ejecutar una vez
flutter pub run build_runner build --delete-conflicting-outputs

# O ejecutar en modo watch (recomendado durante desarrollo)
flutter pub run build_runner watch --delete-conflicting-outputs
```

---

## Configuración del Proyecto

### analysis_options.yaml

Crear archivo `analysis_options.yaml` en la raíz:

```yaml
include: package:very_good_analysis/analysis_options.yaml

analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
  errors:
    invalid_annotation_target: ignore

linter:
  rules:
    # Personalizar reglas según preferencias
    public_member_api_docs: false
    lines_longer_than_80_chars: false
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
    avoid_print: true
    prefer_single_quotes: true
```

### Firebase Configuration (Android)

1. Ir a [Firebase Console](https://console.firebase.google.com/)
2. Crear proyecto o usar existente
3. Agregar app Android:

   - Package name: `com.magneto.streak.streak_app`
   - Descargar `google-services.json`
   - Colocar en `android/app/`

4. Editar `android/build.gradle`:

```gradle
buildscript {
    dependencies {
        // Agregar esta línea
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

5. Editar `android/app/build.gradle`:

```gradle
apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'
// Agregar esta línea
apply plugin: 'com.google.gms.google-services'
```

### Firebase Configuration (iOS)

1. En Firebase Console, agregar app iOS:
   - Bundle ID: `com.magneto.streak.streakApp`
   - Descargar `GoogleService-Info.plist`
   - Abrir `ios/Runner.xcworkspace` en Xcode
   - Arrastrar `GoogleService-Info.plist` a la carpeta Runner

---

## Estructura de Carpetas

Reorganizar `lib/` con la siguiente estructura:

```
lib/
├── main.dart                    # Punto de entrada
├── app.dart                     # Configuración de la app
│
├── core/
│   ├── constants/
│   │   ├── api_constants.dart
│   │   ├── app_constants.dart
│   │   └── storage_keys.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── app_colors.dart
│   │   └── app_text_styles.dart
│   ├── routes/
│   │   ├── app_router.dart
│   │   └── route_names.dart
│   ├── services/
│   │   ├── storage_service.dart
│   │   ├── api_service.dart
│   │   ├── socket_service.dart
│   │   ├── notification_service.dart
│   │   └── logger_service.dart
│   ├── utils/
│   │   ├── validators.dart
│   │   ├── formatters.dart
│   │   └── helpers.dart
│   └── errors/
│       ├── exceptions.dart
│       └── failures.dart
│
├── data/
│   ├── models/
│   │   ├── user/
│   │   │   ├── user_model.dart
│   │   │   └── user_model.g.dart
│   │   ├── job/
│   │   ├── application/
│   │   ├── gig/
│   │   ├── order/
│   │   ├── message/
│   │   ├── streak/
│   │   └── notification/
│   ├── repositories/
│   │   ├── auth_repository.dart
│   │   ├── user_repository.dart
│   │   ├── job_repository.dart
│   │   └── ...
│   └── providers/
│       └── dio_provider.dart
│
├── domain/
│   ├── entities/
│   └── usecases/
│
├── presentation/
│   ├── auth/
│   │   ├── screens/
│   │   │   ├── login_screen.dart
│   │   │   └── register_screen.dart
│   │   ├── widgets/
│   │   └── providers/
│   │       └── auth_provider.dart
│   ├── home/
│   ├── jobs/
│   ├── gigs/
│   ├── messages/
│   ├── profile/
│   └── shared/
│       └── widgets/
│           ├── custom_button.dart
│           ├── custom_text_field.dart
│           └── loading_indicator.dart
│
└── l10n/                        # Internacionalización
    ├── app_en.arb
    └── app_es.arb
```

### Crear carpetas

```bash
# En la raíz del proyecto Flutter
mkdir -p lib/core/{constants,theme,routes,services,utils,errors}
mkdir -p lib/data/{models,repositories,providers}
mkdir -p lib/domain/{entities,usecases}
mkdir -p lib/presentation/{auth,home,jobs,gigs,messages,profile,shared}/{screens,widgets,providers}
mkdir -p assets/{images,icons,animations,fonts}
```

---

## Configuración de Entorno

### lib/core/constants/api_constants.dart

```dart
class ApiConstants {
  // URLs base
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://localhost:4000',
  );

  static const String apiVersion = '/api';
  static const String apiUrl = '$baseUrl$apiVersion';

  // WebSocket
  static const String socketUrl = String.fromEnvironment(
    'SOCKET_URL',
    defaultValue: 'http://localhost:4000',
  );

  // Endpoints
  static const String authEndpoint = '/auth';
  static const String usersEndpoint = '/users';
  static const String jobsEndpoint = '/jobs';
  static const String gigsEndpoint = '/gigs';
  static const String ordersEndpoint = '/orders';
  static const String messagesEndpoint = '/messages';
  static const String streaksEndpoint = '/streaks';
  static const String notificationsEndpoint = '/notifications';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
```

### Ejecutar con variables de entorno

```bash
# Desarrollo local
flutter run --dart-define=BASE_URL=http://localhost:4000

# Staging
flutter run --dart-define=BASE_URL=https://api-staging.streak.com

# Producción
flutter run --dart-define=BASE_URL=https://api.streak.com
```

### Archivo de configuración (opcional)

Crear `config/development.json`:

```json
{
  "baseUrl": "http://localhost:4000",
  "socketUrl": "http://localhost:4000",
  "environment": "development"
}
```

---

## Testing

### test/widget_test.dart (ejemplo básico)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streak_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
```

### Ejecutar tests

```bash
# Todos los tests
flutter test

# Con cobertura
flutter test --coverage

# Tests específicos
flutter test test/widget_test.dart
```

---

## Scripts Útiles

### Crear archivo `Makefile` (opcional)

```makefile
.PHONY: help get build watch clean test run

help:
	@echo "Comandos disponibles:"
	@echo "  make get      - Instalar dependencias"
	@echo "  make build    - Generar código"
	@echo "  make watch    - Generar código en modo watch"
	@echo "  make clean    - Limpiar proyecto"
	@echo "  make test     - Ejecutar tests"
	@echo "  make run      - Ejecutar app"

get:
	flutter pub get

build:
	flutter pub run build_runner build --delete-conflicting-outputs

watch:
	flutter pub run build_runner watch --delete-conflicting-outputs

clean:
	flutter clean
	flutter pub get

test:
	flutter test --coverage

run:
	flutter run --dart-define=BASE_URL=http://localhost:4000
```

---

## Troubleshooting

### Error: CocoaPods not installed

**Solución (macOS):**

```bash
sudo gem install cocoapods
pod setup
```

### Error: Gradle build failed

**Solución:**

```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### Error: Multiple dex files

**Solución:** En `android/app/build.gradle`:

```gradle
android {
    defaultConfig {
        multiDexEnabled true
    }
}
```

### Error: build_runner issues

**Solución:**

```bash
flutter pub run build_runner clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Recursos Adicionales

### Documentación Oficial

- [Flutter](https://flutter.dev/docs)
- [Dart](https://dart.dev/guides)
- [Riverpod](https://riverpod.dev/)
- [Dio](https://pub.dev/packages/dio)
- [Go Router](https://pub.dev/packages/go_router)

### Extensiones VSCode Recomendadas

- Flutter (`Dart-Code.flutter`)
- Dart (`Dart-Code.dart-code`)
- Awesome Flutter Snippets (`Nash.awesome-flutter-snippets`)
- Pubspec Assist (`jeroen-meijer.pubspec-assist`)
- Error Lens (`usernamehw.errorlens`)

### Comandos Útiles

```bash
# Listar dispositivos disponibles
flutter devices

# Ejecutar en dispositivo específico
flutter run -d <device_id>

# Modo release
flutter run --release

# Análisis de código
flutter analyze

# Formatear código
dart format lib/

# Actualizar dependencias
flutter pub upgrade

# Ver dependencias obsoletas
flutter pub outdated
```

---

## Próximos Pasos

1. Configurar tema de la aplicación en `lib/core/theme/`
2. Implementar servicio de API con Dio
3. Configurar Riverpod providers
4. Crear modelos de datos según `context.md`
5. Implementar autenticación
6. Desarrollar pantallas principales

---

**Última actualización:** Octubre 2025

**Notas:**

- Mantener dependencias actualizadas regularmente
- Seguir las convenciones de código de Dart
- Documentar widgets y funciones complejas
