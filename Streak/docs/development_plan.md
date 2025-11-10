# Plan de Desarrollo - Streak Backend

**Proyecto:** Streak Backend API

**Objetivo:** Construir el backend completo de la plataforma Streak siguiendo una metodología secuencial, completando una tarea a la vez.

**Metodología:** Cada fase debe completarse antes de avanzar a la siguiente. Cada tarea es atómica e independiente.

---

## Fase 0: Configuración Inicial del Proyecto

### Tarea 0.1: Inicializar proyecto Node.js

- Crear carpeta `streak-backend`
- Ejecutar `npm init -y`
- Configurar información básica en `package.json`

**Completado:** ❌

---

### Tarea 0.2: Instalar dependencias principales

- Instalar TypeScript y tipos: `typescript`, `@types/node`, `ts-node`, `tsx`
- Instalar Express: `express`, `@types/express`
- Instalar herramientas de desarrollo: `nodemon`, `eslint`, `prettier`

**Completado:** ❌

---

### Tarea 0.3: Configurar TypeScript

- Crear `tsconfig.json` con configuración apropiada
- Configurar paths, target ES2022, strict mode
- Configurar output directory `dist/`

**Completado:** ❌

---

### Tarea 0.4: Configurar ESLint y Prettier

- Crear `.eslintrc.js` con reglas TypeScript
- Crear `.prettierrc` para formato de código
- Agregar scripts de lint en `package.json`

**Completado:** ❌

---

### Tarea 0.5: Crear estructura de carpetas

- Crear todas las carpetas según arquitectura: `src/api/`, `src/core/`, `src/config/`, etc.
- Crear archivos `.gitkeep` en carpetas vacías

**Completado:** ❌

---

### Tarea 0.6: Configurar variables de entorno

- Crear archivo `.env.example` con todas las variables necesarias
- Instalar `dotenv`
- Crear `src/config/env.config.ts` para cargar y validar variables

**Completado:** ❌

---

### Tarea 0.7: Crear archivo .gitignore

- Agregar `node_modules/`, `dist/`, `.env`, etc.
- Incluir archivos temporales y de sistema

**Completado:** ❌

---

### Tarea 0.8: Crear servidor Express básico

- Crear `src/server.ts` con servidor HTTP básico
- Crear `src/app.ts` con configuración de Express
- Probar que el servidor levanta en puerto configurado

**Completado:** ❌

---

## Fase 1: Configuración de Base de Datos

### Tarea 1.1: Instalar MongoDB y Mongoose

- Instalar `mongoose` y `@types/mongoose`
- Configurar conexión a MongoDB Atlas o local

**Completado:** ❌

---

### Tarea 1.2: Crear módulo de conexión a base de datos

- Crear `src/core/database/connection.ts`
- Implementar función `connectDatabase()` con reintentos
- Manejar eventos de conexión (connected, error, disconnected)

**Completado:** ❌

---

### Tarea 1.3: Crear configuración de base de datos

- Crear `src/config/database.config.ts`
- Exportar opciones de Mongoose (timeouts, pools, etc.)

**Completado:** ❌

---

### Tarea 1.4: Integrar conexión en servidor

- Llamar `connectDatabase()` en `src/server.ts`
- Probar conexión exitosa antes de iniciar el servidor

**Completado:** ❌

---

## Fase 2: Middlewares Core

### Tarea 2.1: Crear middleware de logging

- Crear `src/core/middlewares/logger.ts`
- Implementar logging de requests (método, URL, tiempo de respuesta)
- Usar `morgan` o implementación personalizada

**Completado:** ❌

---

### Tarea 2.2: Crear middleware de manejo de errores

- Crear `src/core/middlewares/errorHandler.ts`
- Capturar errores de validación, errores de base de datos, errores generales
- Devolver respuestas con formato uniforme

**Completado:** ❌

---

### Tarea 2.3: Crear utilidades de respuesta

- Crear `src/core/utils/response.utils.ts`
- Implementar funciones: `successResponse()`, `errorResponse()`
- Establecer formato: `{ success, data, message, error }`

**Completado:** ❌

---

### Tarea 2.4: Instalar y configurar seguridad básica

- Instalar `helmet`, `cors`, `express-rate-limit`
- Configurar CORS con dominios permitidos
- Configurar helmet para headers de seguridad

**Completado:** ❌

---

### Tarea 2.5: Crear middleware de validación

- Instalar `zod`
- Crear `src/core/middlewares/validateRequest.ts`
- Implementar validador genérico que usa schemas Zod

**Completado:** ❌

---

## Fase 3: Sistema de Autenticación

### Tarea 3.1: Instalar dependencias de autenticación

- Instalar `bcryptjs`, `@types/bcryptjs`
- Instalar `jsonwebtoken`, `@types/jsonwebtoken`

**Completado:** ❌

---

### Tarea 3.2: Crear utilidades de JWT

- Crear `src/core/utils/jwt.utils.ts`
- Implementar `generateAccessToken()` y `generateRefreshToken()`
- Implementar `verifyToken()`

**Completado:** ❌

---

### Tarea 3.3: Crear utilidades de bcrypt

- Crear `src/core/utils/bcrypt.utils.ts`
- Implementar `hashPassword()` y `comparePassword()`

**Completado:** ❌

---

### Tarea 3.4: Crear configuración JWT

- Crear `src/config/jwt.config.ts`
- Definir secretos y tiempos de expiración para access y refresh tokens

**Completado:** ❌

---

### Tarea 3.5: Crear modelo User

- Crear `src/api/users/user.model.ts`
- Definir schema de Mongoose con todos los campos según base de datos
- Agregar índices (email unique, roles, etc.)
- NO incluir métodos aún, solo el schema

**Completado:** ❌

---

### Tarea 3.6: Crear DTOs de autenticación

- Crear `src/api/auth/auth.dto.ts`
- Definir schemas Zod: `RegisterDTO`, `LoginDTO`, `RefreshTokenDTO`

**Completado:** ❌

---

### Tarea 3.7: Crear servicio de autenticación - Registro

- Crear `src/api/auth/auth.service.ts`
- Implementar método `register()`: validar email único, hashear password, crear usuario
- Generar tokens access y refresh

**Completado:** ❌

---

### Tarea 3.8: Crear servicio de autenticación - Login

- En `auth.service.ts`, implementar método `login()`
- Validar email y password
- Generar y devolver tokens

**Completado:** ❌

---

### Tarea 3.9: Crear servicio de autenticación - Refresh Token

- En `auth.service.ts`, implementar método `refreshToken()`
- Verificar refresh token válido
- Generar nuevo access token

**Completado:** ❌

---

### Tarea 3.10: Crear controlador de autenticación

- Crear `src/api/auth/auth.controller.ts`
- Implementar handlers: `register()`, `login()`, `refreshToken()`
- Manejar errores y devolver respuestas con formato correcto

**Completado:** ❌

---

### Tarea 3.11: Crear rutas de autenticación

- Crear `src/api/auth/auth.routes.ts`
- Definir rutas: `POST /api/auth/register`, `POST /api/auth/login`, `POST /api/auth/refresh`
- Aplicar middleware de validación con DTOs

**Completado:** ❌

---

### Tarea 3.12: Crear middleware de autenticación

- Crear `src/core/middlewares/authMiddleware.ts`
- Implementar verificación de JWT en header Authorization
- Agregar información de usuario a `req.user`

**Completado:** ❌

---

### Tarea 3.13: Integrar rutas de auth en app

- En `src/app.ts`, registrar rutas `/api/auth`
- Probar endpoints con Postman/Thunder Client

**Completado:** ❌

---

### Tarea 3.14: Crear middleware de autorización por roles

- En `authMiddleware.ts`, crear función `requireRole(...roles)`
- Validar que usuario tenga rol permitido

**Completado:** ❌

---

## Fase 4: CRUD de Usuarios

### Tarea 4.1: Crear repository de usuarios

- Crear `src/api/users/user.repository.ts`
- Implementar métodos básicos: `findById()`, `findByEmail()`, `findAll()`, `update()`, `delete()`

**Completado:** ❌

---

### Tarea 4.2: Crear DTOs de usuarios

- Crear `src/api/users/user.dto.ts`
- Definir schemas: `UpdateUserDTO`, `UpdateProfileDTO`

**Completado:** ❌

---

### Tarea 4.3: Crear servicio de usuarios - Obtener perfil

- Crear `src/api/users/user.service.ts`
- Implementar método `getProfile(userId)` usando repository

**Completado:** ❌

---

### Tarea 4.4: Crear servicio de usuarios - Actualizar perfil

- En `user.service.ts`, implementar `updateProfile(userId, data)`
- Validar y actualizar información del usuario

**Completado:** ❌

---

### Tarea 4.5: Crear servicio de usuarios - Listar usuarios

- En `user.service.ts`, implementar `getAllUsers(filters, pagination)`
- Incluir filtros por rol, búsqueda por nombre

**Completado:** ❌

---

### Tarea 4.6: Crear servicio de usuarios - Obtener usuario por ID

- En `user.service.ts`, implementar `getUserById(userId)`
- Devolver perfil público (sin datos sensibles)

**Completado:** ❌

---

### Tarea 4.7: Crear controlador de usuarios

- Crear `src/api/users/user.controller.ts`
- Implementar handlers: `getProfile()`, `updateProfile()`, `getUsers()`, `getUserById()`

**Completado:** ❌

---

### Tarea 4.8: Crear rutas de usuarios

- Crear `src/api/users/user.routes.ts`
- Definir rutas: `GET /api/users/me`, `PUT /api/users/me`, `GET /api/users`, `GET /api/users/:id`
- Aplicar middleware de autenticación

**Completado:** ❌

---

### Tarea 4.9: Integrar rutas de usuarios en app

- En `src/app.ts`, registrar rutas `/api/users`
- Probar endpoints

**Completado:** ❌

---

## Fase 5: Módulo de Jobs (Ofertas de Empleo)

### Tarea 5.1: Crear modelo Job

- Crear `src/api/jobs/job.model.ts`
- Definir schema de Mongoose con todos los campos
- Agregar índices (employerId, status, type, skills, etc.)

**Completado:** ❌

---

### Tarea 5.2: Crear repository de jobs

- Crear `src/api/jobs/job.repository.ts`
- Implementar métodos CRUD: `create()`, `findById()`, `findAll()`, `update()`, `delete()`

**Completado:** ❌

---

### Tarea 5.3: Crear DTOs de jobs

- Crear `src/api/jobs/job.dto.ts`
- Definir schemas: `CreateJobDTO`, `UpdateJobDTO`, `JobFiltersDTO`

**Completado:** ❌

---

### Tarea 5.4: Crear servicio de jobs - Crear oferta

- Crear `src/api/jobs/job.service.ts`
- Implementar método `createJob(employerId, data)`
- Validar que el usuario sea employer

**Completado:** ❌

---

### Tarea 5.5: Crear servicio de jobs - Listar ofertas

- En `job.service.ts`, implementar `getJobs(filters, pagination)`
- Filtros: location, type, skills, search text
- Incluir paginación

**Completado:** ❌

---

### Tarea 5.6: Crear servicio de jobs - Obtener detalle

- En `job.service.ts`, implementar `getJobById(jobId)`
- Incluir información del empleador (populate)

**Completado:** ❌

---

### Tarea 5.7: Crear servicio de jobs - Actualizar oferta

- En `job.service.ts`, implementar `updateJob(jobId, employerId, data)`
- Validar que el usuario sea el dueño de la oferta

**Completado:** ❌

---

### Tarea 5.8: Crear servicio de jobs - Eliminar oferta

- En `job.service.ts`, implementar `deleteJob(jobId, employerId)`
- Validar propiedad y eliminar (soft delete cambiando status a 'closed')

**Completado:** ❌

---

### Tarea 5.9: Crear controlador de jobs

- Crear `src/api/jobs/job.controller.ts`
- Implementar handlers para todos los métodos del servicio

**Completado:** ❌

---

### Tarea 5.10: Crear rutas de jobs

- Crear `src/api/jobs/job.routes.ts`
- Definir rutas CRUD: POST, GET, GET/:id, PUT/:id, DELETE/:id
- Aplicar autenticación y validación

**Completado:** ❌

---

### Tarea 5.11: Integrar rutas de jobs en app

- En `src/app.ts`, registrar rutas `/api/jobs`
- Probar endpoints

**Completado:** ❌

---

## Fase 6: Módulo de Applications (Postulaciones)

### Tarea 6.1: Crear modelo Application

- Crear `src/api/applications/application.model.ts`
- Definir schema con relaciones a User y Job
- Agregar índices (userId, jobId, status, compound unique)

**Completado:** ❌

---

### Tarea 6.2: Crear repository de applications

- Crear `src/api/applications/application.repository.ts`
- Implementar métodos CRUD y búsquedas específicas

**Completado:** ❌

---

### Tarea 6.3: Crear DTOs de applications

- Crear `src/api/applications/application.dto.ts`
- Definir schemas: `CreateApplicationDTO`, `UpdateApplicationStatusDTO`

**Completado:** ❌

---

### Tarea 6.4: Crear servicio de applications - Postular

- Crear `src/api/applications/application.service.ts`
- Implementar `applyToJob(userId, jobId, data)`
- Validar que job exista y esté activo
- Validar que no haya postulado antes
- Incrementar `applicationCount` en job

**Completado:** ❌

---

### Tarea 6.5: Crear servicio de applications - Listar mis postulaciones

- En `application.service.ts`, implementar `getMyApplications(userId, filters)`
- Incluir información del job (populate)

**Completado:** ❌

---

### Tarea 6.6: Crear servicio de applications - Ver postulaciones de un job

- En `application.service.ts`, implementar `getJobApplications(jobId, employerId)`
- Validar que el usuario sea el empleador del job
- Incluir información del aplicante

**Completado:** ❌

---

### Tarea 6.7: Crear servicio de applications - Actualizar status

- En `application.service.ts`, implementar `updateApplicationStatus(applicationId, employerId, status)`
- Validar propiedad del job
- Estados: reviewed, accepted, rejected

**Completado:** ❌

---

### Tarea 6.8: Crear servicio de applications - Obtener detalle

- En `application.service.ts`, implementar `getApplicationById(applicationId, userId)`
- Validar que sea el aplicante o el empleador

**Completado:** ❌

---

### Tarea 6.9: Crear controlador de applications

- Crear `src/api/applications/application.controller.ts`
- Implementar handlers para todos los métodos

**Completado:** ❌

---

### Tarea 6.10: Crear rutas de applications

- Crear `src/api/applications/application.routes.ts`
- Definir rutas: POST, GET (mis apps), GET/:id, PUT/:id/status
- Aplicar autenticación y roles

**Completado:** ❌

---

### Tarea 6.11: Integrar rutas de applications en app

- En `src/app.ts`, registrar rutas `/api/applications`
- Probar flujo completo: crear job → aplicar → revisar

**Completado:** ❌

---

## Fase 7: Módulo de Gigs (Freelance Marketplace)

### Tarea 7.1: Crear modelo Gig

- Crear `src/api/gigs/gig.model.ts`
- Definir schema con packages (basic, standard, premium)
- Agregar índices (userId, category, status, rating, etc.)

**Completado:** ❌

---

### Tarea 7.2: Crear repository de gigs

- Crear `src/api/gigs/gig.repository.ts`
- Implementar métodos CRUD y búsquedas con filtros

**Completado:** ❌

---

### Tarea 7.3: Crear DTOs de gigs

- Crear `src/api/gigs/gig.dto.ts`
- Definir schemas: `CreateGigDTO`, `UpdateGigDTO`, `GigFiltersDTO`

**Completado:** ❌

---

### Tarea 7.4: Crear servicio de gigs - Crear gig

- Crear `src/api/gigs/gig.service.ts`
- Implementar `createGig(freelancerId, data)`
- Validar que usuario tenga rol freelancer

**Completado:** ❌

---

### Tarea 7.5: Crear servicio de gigs - Listar gigs

- En `gig.service.ts`, implementar `getGigs(filters, pagination)`
- Filtros: category, price range, rating, search
- Ordenar por featured, rating, createdAt

**Completado:** ❌

---

### Tarea 7.6: Crear servicio de gigs - Obtener detalle

- En `gig.service.ts`, implementar `getGigById(gigId)`
- Incluir información del freelancer

**Completado:** ❌

---

### Tarea 7.7: Crear servicio de gigs - Actualizar gig

- En `gig.service.ts`, implementar `updateGig(gigId, freelancerId, data)`
- Validar propiedad

**Completado:** ❌

---

### Tarea 7.8: Crear servicio de gigs - Eliminar gig

- En `gig.service.ts`, implementar `deleteGig(gigId, freelancerId)`
- Soft delete (status = 'paused')

**Completado:** ❌

---

### Tarea 7.9: Crear servicio de gigs - Obtener mis gigs

- En `gig.service.ts`, implementar `getMyGigs(freelancerId)`

**Completado:** ❌

---

### Tarea 7.10: Crear controlador de gigs

- Crear `src/api/gigs/gig.controller.ts`
- Implementar handlers para todos los métodos

**Completado:** ❌

---

### Tarea 7.11: Crear rutas de gigs

- Crear `src/api/gigs/gig.routes.ts`
- Definir rutas CRUD completas

**Completado:** ❌

---

### Tarea 7.12: Integrar rutas de gigs en app

- En `src/app.ts`, registrar rutas `/api/gigs`
- Probar endpoints

**Completado:** ❌

---

## Fase 8: Módulo de Orders (Órdenes de Gigs)

### Tarea 8.1: Crear modelo Order

- Crear `src/api/orders/order.model.ts`
- Definir schema con relaciones a Gig, Client, Freelancer
- Agregar índices múltiples

**Completado:** ❌

---

### Tarea 8.2: Crear repository de orders

- Crear `src/api/orders/order.repository.ts`
- Implementar métodos CRUD y queries complejas

**Completado:** ❌

---

### Tarea 8.3: Crear DTOs de orders

- Crear `src/api/orders/order.dto.ts`
- Definir schemas: `CreateOrderDTO`, `UpdateOrderStatusDTO`, `DeliverOrderDTO`

**Completado:** ❌

---

### Tarea 8.4: Crear servicio de orders - Crear orden

- Crear `src/api/orders/order.service.ts`
- Implementar `createOrder(clientId, gigId, package, requirements)`
- Calcular precio, deadline, revisions desde gig
- Incrementar `orderCount` en gig

**Completado:** ❌

---

### Tarea 8.5: Crear servicio de orders - Listar mis órdenes (cliente)

- En `order.service.ts`, implementar `getMyOrders(userId, role)`
- Filtrar según si es cliente o freelancer
- Incluir información de gig y usuarios

**Completado:** ❌

---

### Tarea 8.6: Crear servicio de orders - Obtener detalle

- En `order.service.ts`, implementar `getOrderById(orderId, userId)`
- Validar que sea cliente o freelancer de la orden

**Completado:** ❌

---

### Tarea 8.7: Crear servicio de orders - Actualizar status

- En `order.service.ts`, implementar `updateOrderStatus(orderId, freelancerId, status)`
- Validar estados permitidos según rol
- Freelancer: in_progress, delivered
- Cliente: revision, completed, cancelled

**Completado:** ❌

---

### Tarea 8.8: Crear servicio de orders - Entregar trabajo

- En `order.service.ts`, implementar `deliverOrder(orderId, freelancerId, deliverables)`
- Cambiar status a 'delivered'
- Guardar archivos entregables

**Completado:** ❌

---

### Tarea 8.9: Crear servicio de orders - Completar orden

- En `order.service.ts`, implementar `completeOrder(orderId, clientId)`
- Cambiar status a 'completed'
- Actualizar `completedAt`

**Completado:** ❌

---

### Tarea 8.10: Crear controlador de orders

- Crear `src/api/orders/order.controller.ts`
- Implementar handlers para todos los métodos

**Completado:** ❌

---

### Tarea 8.11: Crear rutas de orders

- Crear `src/api/orders/order.routes.ts`
- Definir rutas: POST, GET, GET/:id, PUT/:id/status, POST/:id/deliver, POST/:id/complete

**Completado:** ❌

---

### Tarea 8.12: Integrar rutas de orders en app

- En `src/app.ts`, registrar rutas `/api/orders`
- Probar flujo: crear orden → entregar → completar

**Completado:** ❌

---

## Fase 9: Sistema de Mensajería con Socket.io

### Tarea 9.1: Instalar Socket.io

- Instalar `socket.io` y `@types/socket.io`

**Completado:** ❌

---

### Tarea 9.2: Crear configuración de Socket.io

- Crear `src/config/socket.config.ts`
- Definir opciones de CORS para sockets

**Completado:** ❌

---

### Tarea 9.3: Crear modelo Message

- Crear `src/api/messages/message.model.ts`
- Definir schema con relaciones
- Agregar índices (orderId, senderId, receiverId, sentAt)

**Completado:** ❌

---

### Tarea 9.4: Crear repository de messages

- Crear `src/api/messages/message.repository.ts`
- Implementar métodos: `create()`, `findByOrder()`, `markAsRead()`

**Completado:** ❌

---

### Tarea 9.5: Crear servicio de messages

- Crear `src/api/messages/message.service.ts`
- Implementar `getOrderMessages(orderId, userId)`
- Implementar `markMessagesAsRead(orderId, userId)`

**Completado:** ❌

---

### Tarea 9.6: Configurar servidor Socket.io

- En `src/server.ts`, integrar Socket.io con servidor HTTP
- Crear `src/sockets/socket.handler.ts` como punto de entrada

**Completado:** ❌

---

### Tarea 9.7: Implementar autenticación en Socket.io

- En `socket.handler.ts`, verificar JWT en handshake
- Agregar información de usuario a socket

**Completado:** ❌

---

### Tarea 9.8: Crear handler de chat

- Crear `src/sockets/chat.socket.ts`
- Implementar evento `join:order` para unirse a room de orden
- Validar que usuario sea parte de la orden

**Completado:** ❌

---

### Tarea 9.9: Implementar envío de mensajes

- En `chat.socket.ts`, implementar evento `message:send`
- Guardar mensaje en base de datos
- Emitir `message:receive` a room

**Completado:** ❌

---

### Tarea 9.10: Implementar indicadores de lectura

- En `chat.socket.ts`, implementar evento `message:read`
- Actualizar mensajes como leídos
- Emitir confirmación

**Completado:** ❌

---

### Tarea 9.11: Crear endpoints REST para mensajes

- Crear `src/api/messages/message.controller.ts`
- Implementar handler `getMessages()` para historial
- Crear `src/api/messages/message.routes.ts`

**Completado:** ❌

---

### Tarea 9.12: Integrar rutas de messages en app

- En `src/app.ts`, registrar rutas `/api/messages`
- Probar flujo completo de chat

**Completado:** ❌

---

## Fase 10: Sistema de Reviews

### Tarea 10.1: Crear modelo Review

- Crear `src/api/reviews/review.model.ts`
- Definir schema (ya definido en context.md)
- Agregar índices

**Completado:** ❌

---

### Tarea 10.2: Crear repository de reviews

- Crear `src/api/reviews/review.repository.ts`
- Implementar métodos CRUD

**Completado:** ❌

---

### Tarea 10.3: Crear DTOs de reviews

- Crear `src/api/reviews/review.dto.ts`
- Definir `CreateReviewDTO`, `RespondReviewDTO`

**Completado:** ❌

---

### Tarea 10.4: Crear servicio de reviews - Crear reseña

- Crear `src/api/reviews/review.service.ts`
- Implementar `createReview(orderId, clientId, rating, comment)`
- Validar que orden esté completada
- Validar que cliente sea dueño de la orden
- Actualizar rating del freelancer y del gig

**Completado:** ❌

---

### Tarea 10.5: Crear servicio de reviews - Responder reseña

- En `review.service.ts`, implementar `respondToReview(reviewId, freelancerId, response)`
- Validar propiedad

**Completado:** ❌

---

### Tarea 10.6: Crear servicio de reviews - Listar reseñas

- En `review.service.ts`, implementar `getGigReviews(gigId)`
- Implementar `getUserReviews(userId)` para perfil de freelancer

**Completado:** ❌

---

### Tarea 10.7: Crear controlador y rutas de reviews

- Crear `src/api/reviews/review.controller.ts`
- Crear `src/api/reviews/review.routes.ts`
- Integrar en app

**Completado:** ❌

---

## Fase 11: Sistema de Streaks y Gamificación

### Tarea 11.1: Crear modelo Streak

- Crear `src/api/streaks/streak.model.ts`
- Definir schema según context.md
- Agregar índices

**Completado:** ❌

---

### Tarea 11.2: Crear repository de streaks

- Crear `src/api/streaks/streak.repository.ts`
- Implementar métodos específicos

**Completado:** ❌

---

### Tarea 11.3: Crear modelo Achievement

- Crear `src/api/achievements/achievement.model.ts`
- Definir schema de logros

**Completado:** ❌

---

### Tarea 11.4: Crear servicio de streaks - Registrar actividad

- Crear `src/api/streaks/streak.service.ts`
- Implementar `registerActivity(userId, activityType, metadata)`
- Calcular si continúa o rompe la racha
- Actualizar current y best streak

**Completado:** ❌

---

### Tarea 11.5: Crear servicio de streaks - Obtener racha

- En `streak.service.ts`, implementar `getUserStreak(userId)`
- Devolver información completa de racha y milestones

**Completado:** ❌

---

### Tarea 11.6: Crear servicio de achievements - Verificar logros

- Crear `src/api/achievements/achievement.service.ts`
- Implementar `checkAchievements(userId)`
- Validar criterios y otorgar achievements

**Completado:** ❌

---

### Tarea 11.7: Integrar registro de actividades en otros módulos

- En `application.service.ts`, llamar `registerActivity()` al aplicar a job
- En `order.service.ts`, llamar `registerActivity()` al entregar gig
- En `gig.service.ts`, llamar `registerActivity()` al crear gig
- En `user.service.ts`, llamar `registerActivity()` al actualizar perfil

**Completado:** ❌

---

### Tarea 11.8: Crear seeder de achievements

- Crear `src/core/database/seeders.ts`
- Definir achievements predefinidos (STREAK_7, FIRST_JOB, etc.)
- Crear script para poblar base de datos

**Completado:** ❌

---

### Tarea 11.9: Crear controlador y rutas de streaks

- Crear `src/api/streaks/streak.controller.ts`
- Crear `src/api/streaks/streak.routes.ts`
- Rutas: GET /api/streaks/me

**Completado:** ❌

---

### Tarea 11.10: Crear controlador y rutas de achievements

- Crear `src/api/achievements/achievement.controller.ts`
- Crear `src/api/achievements/achievement.routes.ts`
- Rutas: GET /api/achievements, GET /api/achievements/me

**Completado:** ❌

---

### Tarea 11.11: Integrar rutas en app

- Registrar `/api/streaks` y `/api/achievements`
- Probar flujo de gamificación

**Completado:** ❌

---

## Fase 12: Sistema de Notificaciones

### Tarea 12.1: Instalar Firebase Admin SDK

- Instalar `firebase-admin`
- Configurar credenciales de Firebase

**Completado:** ❌

---

### Tarea 12.2: Crear configuración de Firebase

- Crear `src/config/firebase.config.ts`
- Inicializar Firebase Admin con service account

**Completado:** ❌

---

### Tarea 12.3: Crear modelo Notification

- Crear `src/api/notifications/notification.model.ts`
- Definir schema según context.md

**Completado:** ❌

---

### Tarea 12.4: Crear repository de notifications

- Crear `src/api/notifications/notification.repository.ts`
- Implementar métodos CRUD

**Completado:** ❌

---

### Tarea 12.5: Crear servicio de notifications - Crear notificación

- Crear `src/api/notifications/notification.service.ts`
- Implementar `createNotification(userId, title, body, type, data)`
- Guardar en base de datos

**Completado:** ❌

---

### Tarea 12.6: Crear servicio de notifications - Enviar push

- En `notification.service.ts`, implementar `sendPushNotification(userId, notification)`
- Obtener FCM token del usuario
- Enviar notificación via Firebase

**Completado:** ❌

---

### Tarea 12.7: Crear servicio de notifications - Listar notificaciones

- En `notification.service.ts`, implementar `getUserNotifications(userId, filters)`
- Soportar filtros: read/unread, type
- Paginación

**Completado:** ❌

---

### Tarea 12.8: Crear servicio de notifications - Marcar como leída

- En `notification.service.ts`, implementar `markAsRead(notificationId, userId)`
- Implementar `markAllAsRead(userId)`

**Completado:** ❌

---

### Tarea 12.9: Integrar notificaciones en otros módulos

- En `application.service.ts`, enviar notificación al cambiar status
- En `order.service.ts`, enviar notificación en cada cambio de estado
- En `message.service.ts`, enviar notificación de nuevo mensaje
- En `streak.service.ts`, enviar notificación de milestone

**Completado:** ❌

---

### Tarea 12.10: Crear controlador y rutas de notifications

- Crear `src/api/notifications/notification.controller.ts`
- Crear `src/api/notifications/notification.routes.ts`
- Rutas: GET /api/notifications, PUT /api/notifications/:id/read, PUT /api/notifications/read-all

**Completado:** ❌

---

### Tarea 12.11: Implementar Socket.io para notificaciones en tiempo real

- Crear `src/sockets/notification.socket.ts`
- Emitir evento `notification:new` cuando se crea notificación

**Completado:** ❌

---

### Tarea 12.12: Integrar rutas de notifications en app

- Registrar `/api/notifications`
- Probar flujo completo

**Completado:** ❌

---

## Fase 13: Workers y Tareas Programadas

### Tarea 13.1: Instalar node-cron

- Instalar `node-cron` y `@types/node-cron`

**Completado:** ❌

---

### Tarea 13.2: Crear worker de verificación de streaks

- Crear `src/workers/streakChecker.worker.ts`
- Implementar job que corre diariamente
- Verificar usuarios que no han tenido actividad en 24h
- Resetear racha a 0 si es necesario

**Completado:** ❌

---

### Tarea 13.3: Crear worker de notificaciones de inactividad

- Crear `src/workers/notificationSender.worker.ts`
- Implementar job diario
- Detectar usuarios inactivos
- Enviar notificaciones de recordatorio

**Completado:** ❌

---

### Tarea 13.4: Crear worker de cálculo de achievements

- Crear `src/workers/achievementCalculator.worker.ts`
- Implementar job que corre periódicamente
- Verificar achievements no otorgados aún

**Completado:** ❌

---

### Tarea 13.5: Registrar workers en servidor

- En `src/server.ts`, inicializar todos los workers
- Configurar intervalos de ejecución

**Completado:** ❌

---

## Fase 14: Testing

### Tarea 14.1: Instalar dependencias de testing

- Instalar `jest`, `@types/jest`, `ts-jest`
- Instalar `supertest`, `@types/supertest`

**Completado:** ❌

---

### Tarea 14.2: Configurar Jest

- Crear `jest.config.js`
- Configurar para TypeScript
- Configurar cobertura de código

**Completado:** ❌

---

### Tarea 14.3: Crear setup de tests

- Crear `tests/setup.ts`
- Configurar base de datos de prueba (MongoDB Memory Server)
- Helpers para limpiar DB entre tests

**Completado:** ❌

---

### Tarea 14.4: Crear tests unitarios de Auth

- Crear `tests/unit/auth.test.ts`
- Testear funciones de JWT, bcrypt
- Testear métodos de AuthService

**Completado:** ❌

---

### Tarea 14.5: Crear tests unitarios de Streak

- Crear `tests/unit/streak.test.ts`
- Testear lógica de cálculo de rachas
- Testear detección de ruptura de racha

**Completado:** ❌

---

### Tarea 14.6: Crear tests unitarios de Users

- Crear `tests/unit/user.test.ts`
- Testear métodos de UserService

**Completado:** ❌

---

### Tarea 14.7: Crear tests de integración de Auth

- Crear `tests/integration/auth.integration.test.ts`
- Testear endpoints: register, login, refresh
- Testear flujos completos

**Completado:** ❌

---

### Tarea 14.8: Crear tests de integración de Jobs

- Crear `tests/integration/jobs.integration.test.ts`
- Testear CRUD completo
- Testear autorizaciones

**Completado:** ❌

---

### Tarea 14.9: Agregar scripts de test

- En `package.json`, agregar scripts: `test`, `test:watch`, `test:coverage`
- Ejecutar tests y verificar cobertura

**Completado:** ❌

---

## Fase 15: Documentación y Deployment

### Tarea 15.1: Crear README.md principal

- Documentar instalación
- Documentar scripts disponibles
- Documentar estructura del proyecto

**Completado:** ❌

---

### Tarea 15.2: Documentar API con Swagger/OpenAPI (opcional)

- Instalar `swagger-ui-express`, `swagger-jsdoc`
- Crear `src/docs/swagger.ts`
- Documentar endpoints principales

**Completado:** ❌

---

### Tarea 15.3: Crear Dockerfile

- Crear `Dockerfile` para producción
- Multi-stage build
- Optimizar tamaño de imagen

**Completado:** ❌

---

### Tarea 15.4: Crear docker-compose.yml

- Configurar servicio de app
- Configurar MongoDB
- Configurar volúmenes y redes

**Completado:** ❌

---

### Tarea 15.5: Configurar CI/CD (opcional)

- Crear `.github/workflows/ci.yml` o similar
- Pipeline: lint → test → build
- Deploy automático a staging/producción

**Completado:** ❌

---

### Tarea 15.6: Agregar health check endpoint

- En `src/app.ts`, crear ruta `GET /health`
- Verificar conexión a base de datos
- Devolver status de la aplicación

**Completado:** ❌

---

### Tarea 15.7: Configurar logging avanzado (opcional)

- Instalar `winston` o `pino`
- Configurar niveles de log
- Guardar logs en archivos

**Completado:** ❌

---

### Tarea 15.8: Auditoría de seguridad

- Ejecutar `npm audit`
- Revisar dependencias vulnerables
- Actualizar paquetes

**Completado:** ❌

---

### Tarea 15.9: Optimización de performance

- Configurar compression middleware
- Configurar rate limiting por endpoint
- Optimizar queries de base de datos con índices

**Completado:** ❌

---

### Tarea 15.10: Deploy a producción

- Configurar variables de entorno en servidor
- Deploy inicial
- Verificar funcionamiento

**Completado:** ❌

---

## Checklist Final

- [ ] Todas las colecciones de MongoDB implementadas
- [ ] Sistema de autenticación completo (JWT + roles)
- [ ] CRUD completo de Users, Jobs, Applications, Gigs, Orders
- [ ] Sistema de mensajería en tiempo real con Socket.io
- [ ] Sistema de reviews funcional
- [ ] Sistema de streaks y gamificación operativo
- [ ] Sistema de notificaciones push con Firebase
- [ ] Workers programados funcionando
- [ ] Tests unitarios y de integración con buena cobertura
- [ ] Documentación completa
- [ ] API desplegada en producción

---

## Notas Importantes

1. **Orden estricto:** No avanzar a la siguiente tarea hasta completar la actual
2. **Testing continuo:** Probar cada endpoint después de implementarlo
3. **Git commits:** Hacer commit después de cada tarea completada usando convención de commits
4. **Code review:** Revisar el código antes de avanzar
5. **Refactoring:** Si algo se puede mejorar, hacerlo inmediatamente
6. **Documentación:** Comentar código complejo con JSDoc

---

**Última actualización:** Octubre 2025
