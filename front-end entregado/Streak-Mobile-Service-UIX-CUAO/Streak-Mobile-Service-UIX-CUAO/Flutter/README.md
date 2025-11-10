# Job Finder & Community App (Flutter)

Una aplicación móvil completa construida con Flutter que combina una plataforma de búsqueda de empleo con funciones de red social. Los usuarios pueden buscar y postularse a trabajos, así como compartir consejos y experiencias en un feed comunitario interactivo.

Este proyecto fue desarrollado como una demostración de habilidades en Flutter, enfocándose en una interfaz de usuario moderna, una experiencia de usuario fluida y una arquitectura de código limpia y escalable.

---

## 🎬 Galería de la App

*(Reemplaza estos enlaces con GIFs o capturas de pantalla de tu aplicación)*

| Búsqueda de Empleo | Feed Social | Perfil de Usuario |
| :---: | :---: | :---: |
| ![Búsqueda de Empleo](https://via.placeholder.com/250x500.png?text=Búsqueda+de+Empleo) | ![Feed Social](https://via.placeholder.com/250x500.png?text=Feed+Social) | ![Perfil de Usuario](https://via.placeholder.com/250x500.png?text=Perfil+de+Usuario) |

---

## ✨ Características Principales

### 🔍 Búsqueda de Empleo
- **Feed de Trabajos Recientes:** Pantalla de inicio con las últimas ofertas de trabajo.
- **Animación de Carga:** Efecto "shimmer" profesional mientras se cargan los datos.
- **Búsqueda en Tiempo Real:** Filtra la lista de trabajos por título a medida que el usuario escribe.
- **Limpieza de Búsqueda:** Botón para borrar fácilmente el término de búsqueda.
- **Detalles del Trabajo:** Pantalla dedicada para cada oferta con toda la información relevante.

### 💬 Feed Social Interactivo
- **Creación de Posts:** Publica consejos o experiencias con texto, imágenes, enlaces y archivos.
- **Selección de Multimedia:** Opción para elegir imágenes desde la galería o tomar una foto con la cámara.
- **Vista Previa de Enlaces:** Muestra una vista previa enriquecida de las URLs adjuntas.
- **Sistema de "Me Gusta":** Botón interactivo para dar "me gusta" a las publicaciones.
- **Sección de Comentarios:**
  - Añade comentarios en tiempo real en una hoja modal.
  - **Edita y elimina** tus propios comentarios con confirmación.

### 👤 Gestión de Perfil y Actividad
- **Perfil de Usuario:** Visualiza y edita tu información personal (nombre, título, etc.).
- **Biblioteca Personal:**
  - **Empleos Guardados:** Guarda tus trabajos favoritos en una lista.
  - **Notificaciones Inteligentes:** Recibe alertas sobre tus trabajos guardados.
  - **Función de "Deshacer":** Restaura un trabajo eliminado por error.
- **Perfiles de Empresa:** Páginas dinámicas para cada empresa, mostrando su información y ofertas de trabajo.

### 🛠️ Funcionalidad y UX
- **Formularios Inteligentes:** Campos con validación en tiempo real y botones que se activan solo cuando el formulario es válido.
- **Compartición Real:** Comparte ofertas de trabajo en apps externas como LinkedIn, Twitter, WhatsApp o Email.
- **Navegación Fluida:** Experiencia de usuario consistente y bien estructurada.
- **Diseño Moderno:** Interfaz bonita, simétrica y agradable, con retroalimentación táctil en las interacciones clave.

---

## 🚀 Tecnologías y Paquetes Utilizados

- **Framework:** Flutter
- **Lenguaje:** Dart
- **Gestión de Estado:** Provider
- **Paquetes Clave:**
  - `image_picker`: Para seleccionar imágenes de la galería y la cámara.
  - `file_picker`: Para adjuntar archivos del dispositivo.
  - `url_launcher`: Para abrir enlaces externos y apps de redes sociales.
  - `any_link_preview`: Para generar vistas previas de enlaces.
  - `shimmer`: Para la animación de carga.
  - `intl`: Para formateo de fechas y números.
  - `font_awesome_flutter`: Para una colección de íconos extendida.

---

## ⚙️ Instalación y Ejecución

Sigue estos pasos para ejecutar el proyecto en tu máquina local:

1.  **Clona el repositorio:**
    ```bash
    git clone https://github.com/tu-usuario/tu-repositorio.git
    ```

2.  **Navega al directorio del proyecto:**
    ```bash
    cd tu-repositorio
    ```

3.  **Instala las dependencias:**
    Asegúrate de tener el SDK de Flutter instalado. Luego, ejecuta:
    ```bash
    flutter pub get
    ```

4.  **Ejecuta la aplicación:**
    ```bash
    flutter run
    ```

---

## 📂 Estructura del Proyecto

El código fuente de la aplicación se encuentra dentro de la carpeta `lib` y sigue una estructura organizada por funcionalidades:

- `lib/main.dart`: Punto de entrada de la aplicación.
- `lib/data/`: Contiene datos en memoria (simulación de base de datos).
- `lib/models/`: Contiene las clases de modelo de datos (ej. `Job`, `Post`, `Company`).
- `lib/presentation/pages/`: Contiene todos los widgets de las pantallas de la aplicación.