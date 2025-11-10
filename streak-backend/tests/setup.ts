// Setup para tests
// Configurar variables de entorno para testing
process.env.NODE_ENV = 'test';
process.env.PORT = '4001';
process.env.MONGODB_URI = 'mongodb://localhost:27017/streak-test';
process.env.JWT_SECRET = 'test_secret_key';

// Configuración global para tests
beforeAll(async () => {
  // Setup inicial si es necesario
});

afterAll(async () => {
  // Cleanup después de todos los tests
});
