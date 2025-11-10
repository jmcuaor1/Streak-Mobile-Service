import mongoose from 'mongoose';
import { Job, JobStatus } from '../src/api/jobs/job.model';
import { User, UserRole } from '../src/api/users/user.model';
import { env } from '../src/config/env.config';

// Datos de ejemplo para trabajos
const sampleJobs = [
  {
    title: 'Desarrollador Frontend React',
    description:
      'Buscamos un desarrollador frontend con experiencia en React para trabajar en una aplicación web moderna. Debe tener conocimientos en TypeScript, Redux y testing.',
    category: 'web_development',
    type: 'fixed_price',
    budget: 2500,
    skillsRequired: ['React', 'TypeScript', 'Redux', 'Jest', 'CSS'],
    experienceLevel: 'intermediate',
    isUrgent: false,
    estimatedDuration: '2-3 semanas',
    status: JobStatus.OPEN,
  },
  {
    title: 'Diseñador UI/UX para App Móvil',
    description:
      'Necesitamos un diseñador creativo para crear la interfaz de usuario de nuestra nueva aplicación móvil. Debe tener experiencia en Figma y diseño responsive.',
    category: 'ui_ux_design',
    type: 'hourly',
    hourlyRate: { min: 25, max: 40 },
    skillsRequired: ['Figma', 'Adobe XD', 'Sketch', 'Principle', 'Prototyping'],
    experienceLevel: 'intermediate',
    isUrgent: true,
    estimatedDuration: '1-2 semanas',
    status: JobStatus.OPEN,
  },
  {
    title: 'Desarrollador Backend Node.js',
    description:
      'Proyecto de API REST con Node.js y Express. Debe tener experiencia con MongoDB, JWT y arquitectura de microservicios.',
    category: 'web_development',
    type: 'fixed_price',
    budget: 1800,
    skillsRequired: ['Node.js', 'Express', 'MongoDB', 'JWT', 'Docker'],
    experienceLevel: 'expert',
    isUrgent: false,
    estimatedDuration: '3-4 semanas',
    status: JobStatus.OPEN,
  },
  {
    title: 'Especialista en Marketing Digital',
    description:
      'Campaña de marketing digital para lanzamiento de producto. Debe tener experiencia en Google Ads, Facebook Ads y análisis de métricas.',
    category: 'digital_marketing',
    type: 'hourly',
    hourlyRate: { min: 20, max: 35 },
    skillsRequired: ['Google Ads', 'Facebook Ads', 'Analytics', 'SEO', 'Content Marketing'],
    experienceLevel: 'intermediate',
    isUrgent: false,
    estimatedDuration: '4-6 semanas',
    status: JobStatus.OPEN,
  },
  {
    title: 'Traductor Inglés-Español',
    description:
      'Traducción de documentos técnicos y contenido web. Debe ser nativo en español con excelente dominio del inglés técnico.',
    category: 'translation',
    type: 'fixed_price',
    budget: 800,
    skillsRequired: ['Inglés', 'Español', 'Traducción Técnica', 'CAT Tools'],
    experienceLevel: 'expert',
    isUrgent: true,
    estimatedDuration: '1 semana',
    status: JobStatus.OPEN,
  },
  {
    title: 'Desarrollador Flutter',
    description:
      'Desarrollo de aplicación móvil multiplataforma con Flutter. Debe tener experiencia en Dart y conocimiento de APIs REST.',
    category: 'mobile_development',
    type: 'fixed_price',
    budget: 3200,
    skillsRequired: ['Flutter', 'Dart', 'Firebase', 'REST APIs', 'Git'],
    experienceLevel: 'intermediate',
    isUrgent: false,
    estimatedDuration: '5-6 semanas',
    status: JobStatus.OPEN,
  },
  {
    title: 'Diseñador Gráfico',
    description:
      'Creación de identidad visual y materiales de marketing. Debe tener experiencia en Illustrator, Photoshop y diseño de logos.',
    category: 'graphic_design',
    type: 'hourly',
    hourlyRate: { min: 18, max: 30 },
    skillsRequired: ['Illustrator', 'Photoshop', 'InDesign', 'Branding', 'Logo Design'],
    experienceLevel: 'intermediate',
    isUrgent: false,
    estimatedDuration: '2-3 semanas',
    status: JobStatus.OPEN,
  },
  {
    title: 'Escritor de Contenido Técnico',
    description:
      'Creación de contenido técnico para blog y documentación. Debe tener experiencia en tecnología y escritura técnica.',
    category: 'content_writing',
    type: 'fixed_price',
    budget: 1200,
    skillsRequired: ['Escritura Técnica', 'SEO', 'WordPress', 'Investigación', 'Edición'],
    experienceLevel: 'intermediate',
    isUrgent: false,
    estimatedDuration: '3-4 semanas',
    status: JobStatus.OPEN,
  },
  {
    title: 'Analista de Datos',
    description:
      'Análisis de datos de ventas y creación de reportes. Debe tener experiencia en Python, SQL y herramientas de visualización.',
    category: 'data_analysis',
    type: 'hourly',
    hourlyRate: { min: 30, max: 50 },
    skillsRequired: ['Python', 'SQL', 'Tableau', 'Excel', 'Estadística'],
    experienceLevel: 'expert',
    isUrgent: true,
    estimatedDuration: '2-3 semanas',
    status: JobStatus.OPEN,
  },
  {
    title: 'Fotógrafo de Productos',
    description:
      'Sesión fotográfica para catálogo de productos e-commerce. Debe tener experiencia en fotografía de productos y edición.',
    category: 'photography',
    type: 'fixed_price',
    budget: 600,
    skillsRequired: ['Fotografía', 'Lightroom', 'Photoshop', 'Iluminación', 'Composición'],
    experienceLevel: 'intermediate',
    isUrgent: false,
    estimatedDuration: '1 semana',
    status: JobStatus.OPEN,
  },
];

// Datos de ejemplo para usuarios clientes
const sampleClients = [
  {
    email: 'cliente1@example.com',
    password: 'password123',
    role: UserRole.CLIENT,
    profile: {
      firstName: 'María',
      lastName: 'González',
      phone: '+1234567890',
      address: {
        city: 'Madrid',
        country: 'España',
      },
    },
  },
  {
    email: 'cliente2@example.com',
    password: 'password123',
    role: UserRole.CLIENT,
    profile: {
      firstName: 'Carlos',
      lastName: 'Rodríguez',
      phone: '+1234567891',
      address: {
        city: 'Barcelona',
        country: 'España',
      },
    },
  },
  {
    email: 'cliente3@example.com',
    password: 'password123',
    role: UserRole.CLIENT,
    profile: {
      firstName: 'Ana',
      lastName: 'Martín',
      phone: '+1234567892',
      address: {
        city: 'Valencia',
        country: 'España',
      },
    },
  },
];

async function seedDatabase() {
  try {
    // Conectar a la base de datos
    await mongoose.connect(env.MONGODB_URI);
    console.log('✅ Conectado a MongoDB');

    // Limpiar datos existentes
    await Job.deleteMany({});
    console.log('🗑️ Trabajos existentes eliminados');

    // Crear usuarios clientes o usar existentes
    const clients = [];
    for (const clientData of sampleClients) {
      let client = await User.findOne({ email: clientData.email });
      if (!client) {
        client = new User(clientData);
        await client.save();
        console.log(`👤 Cliente creado: ${client.profile.firstName} ${client.profile.lastName}`);
      } else {
        console.log(`👤 Cliente existente: ${client.profile.firstName} ${client.profile.lastName}`);
      }
      clients.push(client);
    }

    // Crear trabajos
    for (let i = 0; i < sampleJobs.length; i++) {
      const jobData = sampleJobs[i];
      const client = clients[i % clients.length]; // Rotar entre clientes

      const job = new Job({
        ...jobData,
        clientId: client._id,
        stats: {
          views: Math.floor(Math.random() * 100),
          applications: Math.floor(Math.random() * 20),
          savedCount: Math.floor(Math.random() * 15),
        },
      });

      await job.save();
      console.log(`💼 Trabajo creado: ${job.title}`);
    }

    console.log('🎉 Base de datos sembrada exitosamente');
    console.log(`📊 Creados: ${clients.length} clientes, ${sampleJobs.length} trabajos`);
  } catch (error) {
    console.error('❌ Error sembrando la base de datos:', error);
  } finally {
    await mongoose.disconnect();
    console.log('🔌 Desconectado de MongoDB');
  }
}

// Ejecutar si se llama directamente
if (require.main === module) {
  seedDatabase();
}

export { seedDatabase };
