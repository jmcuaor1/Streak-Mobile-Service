# Estructura del Backend - Streak API

## 📁 Organización de Archivos

### 🔐 Autenticación y Usuarios

```
src/api/auth/
├── auth.controller.ts      # Controlador de autenticación
├── auth.dto.ts            # DTOs de autenticación
├── auth.routes.ts         # Rutas de autenticación
└── auth.service.ts        # Servicio de autenticación

src/api/users/
├── user.controller.ts     # Controlador de usuarios
├── user.dto.ts           # DTOs de usuarios
├── user.model.ts         # Modelo de usuario
├── user.routes.ts        # Rutas básicas de usuario
├── user-professional.routes.ts  # Rutas profesionales
├── user-professional.dto.ts     # DTOs profesionales
└── user.service.ts       # Servicio de usuarios
```

### 💼 Trabajos y Aplicaciones

```
src/api/jobs/
├── job.controller.ts      # Controlador de trabajos
├── job.dto.ts           # DTOs de trabajos
├── job.model.ts         # Modelo de trabajo
├── job.routes.ts        # Rutas de trabajos
└── job.service.ts       # Servicio de trabajos

src/api/applications/
├── application.controller.ts  # Controlador de aplicaciones
├── application.dto.ts         # DTOs de aplicaciones
├── application.model.ts       # Modelo de aplicación
├── application.routes.ts      # Rutas de aplicaciones
└── application.service.ts     # Servicio de aplicaciones
```

### 🏢 Empresas

```
src/api/companies/
├── company.controller.ts  # Controlador de empresas
├── company.dto.ts        # DTOs de empresas
├── company.model.ts      # Modelo de empresa
├── company.routes.ts     # Rutas de empresas
└── company.service.ts    # Servicio de empresas
```

### 📱 Funcionalidades Sociales

```
src/api/social/
├── post.controller.ts     # Controlador de posts
├── post.dto.ts          # DTOs de posts
├── post.model.ts        # Modelo de post
├── post.routes.ts       # Rutas de posts
├── post.service.ts      # Servicio de posts
├── connection.controller.ts  # Controlador de conexiones
├── connection.dto.ts         # DTOs de conexiones
├── connection.model.ts       # Modelo de conexión
├── connection.routes.ts      # Rutas de conexiones
└── connection.service.ts     # Servicio de conexiones
```

### 🎮 Gamificación

```
src/api/gamification/
├── gamification.controller.ts  # Controlador de gamificación
├── gamification.routes.ts      # Rutas de gamificación
└── gamification.service.ts     # Servicio de gamificación

src/api/achievements/
└── achievement.model.ts        # Modelo de logros

src/api/streaks/
└── streak.model.ts             # Modelo de rachas
```

## 🔗 Endpoints Disponibles

### 👤 Usuarios

- `GET /api/users` - Listar usuarios
- `GET /api/users/:id` - Obtener usuario por ID
- `PUT /api/users/:id/profile` - Actualizar perfil
- `PUT /api/users/:id/freelancer-profile` - Actualizar perfil freelancer
- `PUT /api/users/:id/preferences` - Actualizar preferencias
- `DELETE /api/users/:id` - Eliminar usuario

### 💼 Perfil Profesional

- `GET /api/users/:id/resumes` - Obtener currículums
- `POST /api/users/:id/resumes` - Crear currículum
- `PUT /api/users/:id/resumes/:resumeId` - Actualizar currículum
- `DELETE /api/users/:id/resumes/:resumeId` - Eliminar currículum
- `GET /api/users/:id/skills` - Obtener habilidades
- `POST /api/users/:id/skills` - Agregar habilidad
- `PUT /api/users/:id/skills/:skillId` - Actualizar habilidad
- `DELETE /api/users/:id/skills/:skillId` - Eliminar habilidad
- `GET /api/users/:id/work-experience` - Obtener experiencia laboral
- `POST /api/users/:id/work-experience` - Agregar experiencia
- `PUT /api/users/:id/work-experience/:expId` - Actualizar experiencia
- `DELETE /api/users/:id/work-experience/:expId` - Eliminar experiencia
- `GET /api/users/:id/education` - Obtener educación
- `POST /api/users/:id/education` - Agregar educación
- `PUT /api/users/:id/education/:eduId` - Actualizar educación
- `DELETE /api/users/:id/education/:eduId` - Eliminar educación
- `GET /api/users/:id/languages` - Obtener idiomas
- `POST /api/users/:id/languages` - Agregar idioma
- `PUT /api/users/:id/languages/:langId` - Actualizar idioma
- `DELETE /api/users/:id/languages/:langId` - Eliminar idioma
- `POST /api/users/:id/upload-cv` - Subir CV
- `GET /api/users/:id/cv/:cvId/download` - Descargar CV
- `DELETE /api/users/:id/cv/:cvId` - Eliminar CV

### 💼 Trabajos

- `GET /api/jobs` - Listar trabajos
- `POST /api/jobs` - Crear trabajo
- `GET /api/jobs/:id` - Obtener trabajo por ID
- `PUT /api/jobs/:id` - Actualizar trabajo
- `DELETE /api/jobs/:id` - Eliminar trabajo
- `POST /api/jobs/:id/save` - Guardar trabajo
- `DELETE /api/jobs/:id/save` - Quitar trabajo de guardados
- `POST /api/jobs/:id/publish` - Publicar trabajo
- `POST /api/jobs/:id/assign` - Asignar freelancer
- `POST /api/jobs/:id/complete` - Completar trabajo
- `POST /api/jobs/:id/cancel` - Cancelar trabajo

### 🏢 Empresas

- `GET /api/companies` - Listar empresas
- `POST /api/companies` - Crear empresa
- `GET /api/companies/:id` - Obtener empresa por ID
- `PUT /api/companies/:id` - Actualizar empresa
- `DELETE /api/companies/:id` - Eliminar empresa
- `POST /api/companies/:id/follow` - Seguir empresa
- `DELETE /api/companies/:id/follow` - Dejar de seguir empresa
- `GET /api/companies/:id/followers` - Obtener seguidores
- `GET /api/companies/:id/jobs` - Obtener trabajos de la empresa
- `GET /api/companies/:id/reviews` - Obtener reseñas
- `POST /api/companies/:id/review` - Crear reseña
- `GET /api/companies/search` - Buscar empresas

### 📱 Posts Sociales

- `GET /api/posts` - Obtener posts
- `POST /api/posts` - Crear post
- `GET /api/posts/:id` - Obtener post por ID
- `PUT /api/posts/:id` - Actualizar post
- `DELETE /api/posts/:id` - Eliminar post
- `POST /api/posts/:id/like` - Dar like
- `DELETE /api/posts/:id/like` - Quitar like
- `POST /api/posts/:id/comment` - Comentar
- `GET /api/posts/:id/comments` - Obtener comentarios
- `DELETE /api/posts/:id/comments/:commentId` - Eliminar comentario
- `POST /api/posts/:id/share` - Compartir post

### 🤝 Conexiones

- `GET /api/connections` - Obtener conexiones
- `GET /api/connections/requests` - Obtener solicitudes pendientes
- `POST /api/connections/request` - Enviar solicitud de conexión
- `POST /api/connections/:id/accept` - Aceptar conexión
- `POST /api/connections/:id/reject` - Rechazar conexión
- `DELETE /api/connections/:id` - Eliminar conexión
- `GET /api/connections/suggestions` - Obtener sugerencias
- `GET /api/connections/mutual/:userId` - Obtener conexiones mutuas

### 🎮 Gamificación

- `GET /api/gamification/achievements` - Obtener logros
- `GET /api/gamification/leaderboard` - Obtener ranking
- `GET /api/gamification/streaks` - Obtener rachas

## 🔧 Configuración

### 📦 Dependencias Principales

- **Express.js** - Framework web
- **MongoDB** - Base de datos
- **JWT** - Autenticación
- **class-validator** - Validación de DTOs
- **class-transformer** - Transformación de datos
- **helmet** - Seguridad
- **cors** - CORS
- **morgan** - Logging

### 🛡️ Middlewares de Seguridad

- **Helmet** - Headers de seguridad
- **CORS** - Control de acceso
- **Rate Limiting** - Límite de requests
- **JWT Authentication** - Autenticación
- **Request Validation** - Validación de datos

### 📊 Estructura de Respuestas

```json
{
  "success": true,
  "message": "Operación exitosa",
  "data": {},
  "pagination": {
    "page": 1,
    "limit": 10,
    "total": 100,
    "pages": 10
  }
}
```

## 🚀 Próximos Pasos

1. **Implementar Controladores** - Crear los controladores faltantes
2. **Implementar Servicios** - Crear la lógica de negocio
3. **Implementar Modelos** - Crear los modelos de MongoDB
4. **Testing** - Implementar tests unitarios e integración
5. **Documentación** - Crear documentación con Swagger
6. **Deployment** - Configurar deployment en producción
