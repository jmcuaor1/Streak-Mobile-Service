# Contexto general

**Proyecto:** Streak — Plataforma laboral gamificada y marketplace freelance para Magneto.

**Propósito:** Combinar la búsqueda de empleo tradicional con un ecosistema freelance y un sistema de gamificación (rachas, logros, aprendizaje) para aumentar retención de usuarios.

## Tecnologías principales

- **Frontend:** Flutter (Dart)
- **Backend:** Node.js + Express + TypeScript
- **Base de datos:** MongoDB (Mongoose ODM)
- **Comunicación tiempo real:** Socket.io
- **Tareas asincrónicas:** BullMQ o node-cron
- **Notificaciones:** Firebase Cloud Messaging (FCM)

## Arquitectura backend

### Estructura de carpetas completa

```text
streak-backend/
├── src/
│   ├── api/
│   │   ├── auth/
│   │   │   ├── auth.controller.ts
│   │   │   ├── auth.service.ts
│   │   │   ├── auth.routes.ts
│   │   │   ├── auth.dto.ts
│   │   │   └── auth.validators.ts
│   │   ├── users/
│   │   │   ├── user.controller.ts
│   │   │   ├── user.service.ts
│   │   │   ├── user.repository.ts
│   │   │   ├── user.model.ts
│   │   │   ├── user.routes.ts
│   │   │   ├── user.dto.ts
│   │   │   └── user.validators.ts
│   │   ├── jobs/
│   │   │   ├── job.controller.ts
│   │   │   ├── job.service.ts
│   │   │   ├── job.repository.ts
│   │   │   ├── job.model.ts
│   │   │   ├── job.routes.ts
│   │   │   ├── job.dto.ts
│   │   │   └── job.validators.ts
│   │   ├── applications/
│   │   │   ├── application.controller.ts
│   │   │   ├── application.service.ts
│   │   │   ├── application.repository.ts
│   │   │   ├── application.model.ts
│   │   │   ├── application.routes.ts
│   │   │   ├── application.dto.ts
│   │   │   └── application.validators.ts
│   │   ├── gigs/
│   │   │   ├── gig.controller.ts
│   │   │   ├── gig.service.ts
│   │   │   ├── gig.repository.ts
│   │   │   ├── gig.model.ts
│   │   │   ├── gig.routes.ts
│   │   │   ├── gig.dto.ts
│   │   │   └── gig.validators.ts
│   │   ├── orders/
│   │   │   ├── order.controller.ts
│   │   │   ├── order.service.ts
│   │   │   ├── order.repository.ts
│   │   │   ├── order.model.ts
│   │   │   ├── order.routes.ts
│   │   │   ├── order.dto.ts
│   │   │   └── order.validators.ts
│   │   ├── messages/
│   │   │   ├── message.controller.ts
│   │   │   ├── message.service.ts
│   │   │   ├── message.repository.ts
│   │   │   ├── message.model.ts
│   │   │   ├── message.routes.ts
│   │   │   └── message.dto.ts
│   │   ├── streaks/
│   │   │   ├── streak.controller.ts
│   │   │   ├── streak.service.ts
│   │   │   ├── streak.repository.ts
│   │   │   ├── streak.model.ts
│   │   │   ├── streak.routes.ts
│   │   │   └── streak.dto.ts
│   │   ├── notifications/
│   │   │   ├── notification.controller.ts
│   │   │   ├── notification.service.ts
│   │   │   ├── notification.repository.ts
│   │   │   ├── notification.model.ts
│   │   │   ├── notification.routes.ts
│   │   │   └── notification.dto.ts
│   │   └── achievements/
│   │       ├── achievement.controller.ts
│   │       ├── achievement.service.ts
│   │       ├── achievement.model.ts
│   │       └── achievement.routes.ts
│   ├── core/
│   │   ├── database/
│   │   │   ├── connection.ts
│   │   │   └── seeders.ts
│   │   ├── middlewares/
│   │   │   ├── authMiddleware.ts
│   │   │   ├── errorHandler.ts
│   │   │   ├── validateRequest.ts
│   │   │   ├── rateLimiter.ts
│   │   │   └── logger.ts
│   │   ├── utils/
│   │   │   ├── jwt.utils.ts
│   │   │   ├── bcrypt.utils.ts
│   │   │   ├── response.utils.ts
│   │   │   ├── date.utils.ts
│   │   │   └── validators.utils.ts
│   │   └── events/
│   │       ├── eventEmitter.ts
│   │       └── eventHandlers.ts
│   ├── config/
│   │   ├── env.config.ts
│   │   ├── database.config.ts
│   │   ├── jwt.config.ts
│   │   ├── firebase.config.ts
│   │   └── socket.config.ts
│   ├── sockets/
│   │   ├── socket.handler.ts
│   │   ├── chat.socket.ts
│   │   └── notification.socket.ts
│   ├── workers/
│   │   ├── streakChecker.worker.ts
│   │   ├── notificationSender.worker.ts
│   │   └── achievementCalculator.worker.ts
│   ├── types/
│   │   ├── express.d.ts
│   │   ├── user.types.ts
│   │   └── common.types.ts
│   ├── app.ts
│   └── server.ts
├── tests/
│   ├── unit/
│   │   ├── auth.test.ts
│   │   ├── streak.test.ts
│   │   └── user.test.ts
│   ├── integration/
│   │   ├── auth.integration.test.ts
│   │   └── jobs.integration.test.ts
│   └── setup.ts
├── .env
├── .env.example
├── .gitignore
├── .eslintrc.js
├── .prettierrc
├── tsconfig.json
├── package.json
├── package-lock.json
└── README.md
```

### Principales capas

| Capa         | Descripción                                                           |
| ------------ | --------------------------------------------------------------------- |
| Controllers  | Reciben y validan peticiones HTTP, devuelven respuestas JSON.         |
| Services     | Lógica de negocio (crear usuario, calcular racha, crear gig, etc.).   |
| Repositories | Interacción directa con MongoDB usando Mongoose.                      |
| Middlewares  | Autenticación (JWT), validación de datos, logging, manejo de errores. |
| Sockets      | Chat freelance y eventos en tiempo real.                              |
| Workers      | Tareas programadas, envíos de notificaciones, cálculos de logros.     |

### Configuración general

- **Estilo de endpoints:** RESTful — prefijos `/api/...`
- **Autenticación:** JWT (access + refresh tokens)
- **Roles:** `jobseeker`, `freelancer`, `employer`, `admin`

## Esquema completo de la base de datos (MongoDB)

### Collection: users

```typescript
{
  _id: ObjectId,
  name: String,                    // Required, min: 2, max: 100
  email: String,                   // Required, unique, lowercase, validated
  passwordHash: String,            // Required, bcrypt hashed
  roles: [String],                 // Enum: ['jobseeker', 'freelancer', 'employer', 'admin']
  bio: String,                     // Optional, max: 500
  skills: [String],                // Array of skills
  cvUrl: String,                   // URL to CV file
  profilePicture: String,          // URL to profile image
  phone: String,                   // Optional
  location: {
    city: String,
    country: String,
    coordinates: {
      lat: Number,
      lng: Number
    }
  },
  rating: {
    average: Number,               // Default: 0, min: 0, max: 5
    count: Number                  // Default: 0
  },
  streak: {
    current: Number,               // Default: 0
    best: Number,                  // Default: 0
    lastActionDate: Date           // Last activity date
  },
  achievements: [String],          // Array of achievement IDs
  fcmToken: String,                // Firebase Cloud Messaging token
  isActive: Boolean,               // Default: true
  isVerified: Boolean,             // Default: false
  refreshToken: String,            // JWT refresh token
  createdAt: Date,                 // Auto-generated
  updatedAt: Date                  // Auto-generated
}

// Indexes:
// - email (unique)
// - roles
// - rating.average
// - createdAt
```

### Collection: jobs

```typescript
{
  _id: ObjectId,
  employerId: ObjectId,            // Ref: users, Required
  title: String,                   // Required, max: 200
  company: String,                 // Required
  description: String,             // Required, max: 5000
  requirements: [String],          // Array of requirements
  skills: [String],                // Required skills
  location: {
    city: String,
    country: String,
    remote: Boolean,               // Default: false
    hybrid: Boolean                // Default: false
  },
  type: String,                    // Enum: ['full-time', 'part-time', 'contract', 'internship']
  salary: {
    min: Number,
    max: Number,
    currency: String               // Default: 'USD'
  },
  applicationCount: Number,        // Default: 0
  status: String,                  // Enum: ['active', 'closed', 'draft'], Default: 'active'
  expiresAt: Date,                 // Job expiration date
  tags: [String],                  // Search tags
  createdAt: Date,                 // Auto-generated
  updatedAt: Date                  // Auto-generated
}

// Indexes:
// - employerId
// - status
// - type
// - location.city
// - skills
// - createdAt
// - expiresAt
```

### Collection: applications

```typescript
{
  _id: ObjectId,
  userId: ObjectId,                // Ref: users, Required
  jobId: ObjectId,                 // Ref: jobs, Required
  coverLetter: String,             // Optional, max: 2000
  status: String,                  // Enum: ['pending', 'reviewed', 'accepted', 'rejected'], Default: 'pending'
  resume: String,                  // URL to resume file
  answers: [{
    question: String,
    answer: String
  }],
  notes: String,                   // Employer notes
  reviewedAt: Date,                // Date when reviewed
  appliedAt: Date,                 // Default: Date.now
  updatedAt: Date                  // Auto-generated
}

// Indexes:
// - userId
// - jobId
// - status
// - appliedAt
// - Compound: (userId, jobId) unique
```

### Collection: gigs

```typescript
{
  _id: ObjectId,
  userId: ObjectId,                // Ref: users (freelancer), Required
  title: String,                   // Required, max: 150
  category: String,                // Enum: ['design', 'development', 'writing', 'marketing', 'video', 'music', 'business', 'other']
  subcategory: String,             // Optional
  description: String,             // Required, max: 3000
  images: [String],                // Array of image URLs, max: 5
  price: {
    basic: Number,                 // Required
    standard: Number,              // Optional
    premium: Number                // Optional
  },
  deliveryTime: {
    basic: Number,                 // Days, Required
    standard: Number,              // Days, Optional
    premium: Number                // Days, Optional
  },
  revisions: {
    basic: Number,                 // Default: 1
    standard: Number,              // Default: 2
    premium: Number                // Default: 3
  },
  tags: [String],                  // Max: 10
  requirements: String,            // What freelancer needs from client
  rating: {
    average: Number,               // Default: 0, min: 0, max: 5
    count: Number                  // Default: 0
  },
  orderCount: Number,              // Default: 0
  status: String,                  // Enum: ['active', 'paused', 'draft'], Default: 'active'
  featured: Boolean,               // Default: false
  createdAt: Date,                 // Auto-generated
  updatedAt: Date                  // Auto-generated
}

// Indexes:
// - userId
// - category
// - status
// - rating.average
// - featured
// - createdAt
// - tags
```

### Collection: orders

```typescript
{
  _id: ObjectId,
  gigId: ObjectId,                 // Ref: gigs, Required
  clientId: ObjectId,              // Ref: users, Required
  freelancerId: ObjectId,          // Ref: users, Required
  package: String,                 // Enum: ['basic', 'standard', 'premium'], Required
  price: Number,                   // Required
  description: String,             // Order specific requirements
  requirements: String,            // Client requirements
  status: String,                  // Enum: ['pending', 'in_progress', 'delivered', 'revision', 'completed', 'cancelled'], Default: 'pending'
  deliveryTime: Number,            // Days
  revisions: Number,               // Remaining revisions
  deliverables: [{
    url: String,
    description: String,
    uploadedAt: Date
  }],
  deadline: Date,                  // Calculated delivery date
  completedAt: Date,               // Date when completed
  paymentStatus: String,           // Enum: ['pending', 'paid', 'refunded'], Default: 'pending'
  paymentId: String,               // External payment reference
  review: {
    rating: Number,                // 1-5
    comment: String,
    createdAt: Date
  },
  createdAt: Date,                 // Auto-generated
  updatedAt: Date                  // Auto-generated
}

// Indexes:
// - clientId
// - freelancerId
// - gigId
// - status
// - paymentStatus
// - createdAt
// - deadline
```

### Collection: messages

```typescript
{
  _id: ObjectId,
  orderId: ObjectId,               // Ref: orders, Required
  senderId: ObjectId,              // Ref: users, Required
  receiverId: ObjectId,            // Ref: users, Required
  content: String,                 // Required, max: 2000
  type: String,                    // Enum: ['text', 'file', 'image', 'system'], Default: 'text'
  fileUrl: String,                 // URL if type is file/image
  isRead: Boolean,                 // Default: false
  readAt: Date,                    // Date when message was read
  sentAt: Date,                    // Default: Date.now
  deletedBy: [ObjectId]            // Users who deleted this message
}

// Indexes:
// - orderId
// - senderId
// - receiverId
// - sentAt
// - isRead
```

### Collection: streaks

```typescript
{
  _id: ObjectId,
  userId: ObjectId,                // Ref: users, Required, Unique
  current: Number,                 // Default: 0, Current streak days
  best: Number,                    // Default: 0, Best streak ever
  lastActionDate: Date,            // Date of last activity
  actions: [{
    type: String,                  // Enum: ['job_application', 'gig_delivery', 'course_completed', 'profile_update', 'gig_created']
    date: Date,
    metadata: Object               // Additional action info
  }],
  milestones: [{
    days: Number,                  // Milestone days (7, 30, 60, 90, 365)
    achievedAt: Date
  }],
  updatedAt: Date                  // Auto-generated
}

// Indexes:
// - userId (unique)
// - current
// - best
// - lastActionDate
```

### Collection: notifications

```typescript
{
  _id: ObjectId,
  userId: ObjectId,                // Ref: users, Required
  title: String,                   // Required, max: 100
  body: String,                    // Required, max: 500
  type: String,                    // Enum: ['job_match', 'application_update', 'order_update', 'message', 'achievement', 'streak', 'system']
  data: Object,                    // Additional data (jobId, orderId, etc.)
  read: Boolean,                   // Default: false
  actionUrl: String,               // Deep link or URL
  priority: String,                // Enum: ['low', 'medium', 'high'], Default: 'medium'
  sentAt: Date,                    // When notification was sent
  readAt: Date,                    // When user read it
  createdAt: Date                  // Auto-generated
}

// Indexes:
// - userId
// - read
// - type
// - createdAt
// - priority
```

### Collection: achievements

```typescript
{
  _id: ObjectId,
  code: String,                    // Required, Unique (e.g., 'STREAK_7', 'FIRST_JOB')
  name: String,                    // Required
  description: String,             // Required
  icon: String,                    // URL or emoji
  category: String,                // Enum: ['streak', 'applications', 'gigs', 'orders', 'profile']
  criteria: {
    type: String,                  // Type of achievement
    value: Number                  // Required value to unlock
  },
  points: Number,                  // Gamification points, Default: 10
  rarity: String,                  // Enum: ['common', 'rare', 'epic', 'legendary'], Default: 'common'
  isActive: Boolean,               // Default: true
  createdAt: Date                  // Auto-generated
}

// Indexes:
// - code (unique)
// - category
// - rarity
```

### Collection: reviews

```typescript
{
  _id: ObjectId,
  orderId: ObjectId,               // Ref: orders, Required, Unique
  reviewerId: ObjectId,            // Ref: users (client), Required
  revieweeId: ObjectId,            // Ref: users (freelancer), Required
  gigId: ObjectId,                 // Ref: gigs, Required
  rating: Number,                  // Required, min: 1, max: 5
  comment: String,                 // Optional, max: 1000
  response: {
    text: String,                  // Freelancer response
    createdAt: Date
  },
  isPublic: Boolean,               // Default: true
  helpful: [ObjectId],             // Users who found this helpful
  createdAt: Date,                 // Auto-generated
  updatedAt: Date                  // Auto-generated
}

// Indexes:
// - orderId (unique)
// - reviewerId
// - revieweeId
// - gigId
// - rating
// - createdAt
```

### Relaciones entre colecciones

```text
users (1) ──> (N) jobs [employerId]
users (1) ──> (N) applications [userId]
users (1) ──> (N) gigs [userId]
users (1) ──> (N) orders [clientId, freelancerId]
users (1) ──> (N) messages [senderId, receiverId]
users (1) ──> (1) streaks [userId]
users (1) ──> (N) notifications [userId]
users (1) ──> (N) reviews [reviewerId, revieweeId]

jobs (1) ──> (N) applications [jobId]

gigs (1) ──> (N) orders [gigId]
gigs (1) ──> (N) reviews [gigId]

orders (1) ──> (N) messages [orderId]
orders (1) ──> (1) reviews [orderId]
```

## Convenciones de código

- **Lenguaje:** TypeScript (ESNext)
- **Estilo:** `async/await` preferido, sin callbacks.
- **Validaciones:** Zod o Joi en DTOs.
- **Documentación:** comentarios JSDoc en servicios y controladores.

### Respuestas uniformes

```json
{ "success": true, "data": { ... }, "message": "optional" }
```

- Errores manejados por middleware global (`errorHandler.ts`).
- **Autenticación:** middleware `authMiddleware` añade `req.user`.

## Gamificación y lógica de rachas

- Cada acción (aplicar a vacante, entregar gig, completar curso) genera un "evento de actividad".
- El servicio `StreakService` actualiza `current` y `best` streak del usuario.
- Las rachas pueden generar `achievements` guardados en `users.achievements`.

## Chat freelance

- Cada `order` tiene su propio canal (room) en Socket.io.

### Eventos

- `message:send` (cliente → servidor → room)
- `message:receive` (servidor → clientes del room)
- Mensajes se guardan en `messages`.

## Notificaciones

- **Push** via Firebase Cloud Messaging.
- **Persistencia local** en `notifications` collection.
- **Worker diario** revisa usuarios inactivos y les envía recordatorios.

## Dependencias recomendadas

- `express`
- `mongoose`
- `dotenv`
- `bcryptjs`
- `jsonwebtoken`
- `zod`
- `cors`
- `helmet`
- `socket.io`
- `node-cron`
- `bullmq`
- `firebase-admin`

## Reglas de generación para Cursor

- Generar siempre en TypeScript.
- Usar `export const <nombre>` en lugar de `module.exports`.
- No usar `any` (si es posible).
- Cada módulo debe incluir un archivo de rutas (`*.routes.ts`) que se registre en `app.ts`.
- No incluir código frontend en este repositorio.
- Mantener comentarios claros tipo `// TODO: implementar validación` o `// @desc: ...`.

## Objetivos de desarrollo (en orden)

1. Auth (register, login, refresh token)
2. CRUD Users
3. CRUD Jobs y Applications
4. Freelance Marketplace (Gigs + Orders)
5. Chat con Socket.io
6. Streaks y gamificación
7. Notifications + Workers
8. Tests + CI/CD

## Estructura de commits sugerida

```text
feat(auth): register/login endpoints
feat(jobs): CRUD job offers
feat(gigs): freelance module
fix(auth): password hash issue
refactor: unify response format
test(streak): add unit tests for streakService
```
