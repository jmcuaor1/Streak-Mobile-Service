# Streak Backend API

Backend API para Streak - Plataforma laboral gamificada y marketplace freelance.

## 🚀 Stack Tecnológico

- **Runtime:** Node.js 18+
- **Lenguaje:** TypeScript 5.0+
- **Framework:** Express.js
- **Base de datos:** MongoDB + Mongoose
- **Autenticación:** JWT
- **Real-time:** Socket.io
- **Validación:** Zod
- **Testing:** Jest + Supertest

## 📦 Instalación

```bash
# Instalar dependencias
npm install

# Copiar archivo de variables de entorno
cp .env.example .env

# Editar .env con tus configuraciones
```

## 🔧 Scripts Disponibles

```bash
# Desarrollo
npm run dev          # Ejecutar en desarrollo con hot reload
npm run dev:tsx      # Alternativa con tsx (más rápido)

# Build y Producción
npm run build        # Compilar TypeScript
npm run start        # Ejecutar versión compilada

# Linting y Formato
npm run lint         # Verificar errores de linting
npm run lint:fix     # Corregir errores automáticamente
npm run format       # Formatear código con Prettier
npm run format:check # Verificar formato sin modificar

# Testing
npm run test         # Ejecutar todos los tests
npm run test:watch   # Tests en modo watch
npm run test:coverage # Tests con reporte de cobertura
npm run test:unit    # Solo tests unitarios
npm run test:integration # Solo tests de integración

# Utilidades
npm run typecheck    # Verificar tipos sin compilar
npm run clean        # Eliminar carpeta dist
```

## 🌐 Endpoints

### Health Check

```bash
GET http://localhost:4000/health
```

Respuesta:

```json
{
  "success": true,
  "status": "OK",
  "timestamp": "2025-10-14T...",
  "environment": "development"
}
```

### Root

```bash
GET http://localhost:4000/
```

Respuesta:

```json
{
  "success": true,
  "message": "Streak API - Bienvenido",
  "version": "1.0.0",
  "environment": "development"
}
```

## 📁 Estructura del Proyecto

```
streak-backend/
├── src/
│   ├── api/              # Módulos de la API
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
│   ├── core/             # Código core
│   │   ├── database/
│   │   ├── middlewares/
│   │   ├── utils/
│   │   └── events/
│   ├── config/           # Configuraciones
│   ├── sockets/          # WebSocket handlers
│   ├── workers/          # Tareas programadas
│   ├── types/            # Tipos TypeScript
│   ├── app.ts            # Configuración de Express
│   └── server.ts         # Punto de entrada
├── tests/                # Tests
│   ├── unit/
│   ├── integration/
│   └── setup.ts
├── .env                  # Variables de entorno (no versionado)
├── .env.example          # Ejemplo de variables de entorno
├── tsconfig.json         # Configuración TypeScript
├── jest.config.js        # Configuración Jest
├── .eslintrc.js          # Configuración ESLint
├── .prettierrc           # Configuración Prettier
└── package.json
```

## ⚙️ Variables de Entorno

Ver `.env.example` para la lista completa de variables necesarias.

Variables principales:

- `NODE_ENV` - Entorno (development/production/test)
- `PORT` - Puerto del servidor (default: 4000)
- `MONGODB_URI` - URL de conexión a MongoDB
- `JWT_SECRET` - Secret para tokens JWT
- `CORS_ORIGIN` - Orígenes permitidos para CORS

## 🧪 Testing

```bash
# Ejecutar todos los tests
npm test

# Tests en modo watch
npm run test:watch

# Ver cobertura
npm run test:coverage
```

## 🚀 Deployment

### Build para producción

```bash
# Compilar TypeScript
npm run build

# Ejecutar versión compilada
npm start
```

### Variables de entorno en producción

Asegúrate de configurar todas las variables de entorno necesarias en tu servidor:

```bash
NODE_ENV=production
PORT=4000
MONGODB_URI=mongodb+srv://...
JWT_SECRET=<tu_secret_seguro>
# ... otras variables
```

## 📚 Documentación

Para más información sobre la arquitectura y desarrollo:

- [Contexto General](../Streak/docs/context.md)
- [Plan de Desarrollo](../Streak/docs/development_plan.md)
- [Configuración Completa](../Streak/docs/package-setup.md)

## 🔐 Seguridad

- Helmet.js para headers de seguridad
- CORS configurado
- Rate limiting
- JWT para autenticación
- Validación de datos con Zod
- Variables de entorno para secretos

## 📝 Convenciones de Código

- TypeScript strict mode habilitado
- ESLint + Prettier configurados
- Usar `async/await` en lugar de callbacks
- Evitar `any` cuando sea posible
- Comentarios JSDoc en funciones públicas

## 🐛 Troubleshooting

### El servidor no inicia

Verifica que:

1. Node.js esté instalado (v18+)
2. MongoDB esté corriendo
3. Las variables de entorno estén configuradas
4. El puerto 4000 no esté en uso

### Errores de TypeScript

```bash
# Limpiar y recompilar
npm run clean
npm run build
```

### Errores de ESLint

```bash
# Corregir automáticamente
npm run lint:fix
```

## 🤝 Contribución

1. Seguir las convenciones de código establecidas
2. Escribir tests para nueva funcionalidad
3. Ejecutar linter antes de hacer commit
4. Seguir las convenciones de commits (ver docs)

## 📄 Licencia

UNLICENSED - Propiedad privada de Magneto

---

**Última actualización:** Octubre 2025
