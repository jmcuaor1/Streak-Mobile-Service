import mongoose from 'mongoose';
import { Job } from '../src/api/jobs/job.model';
import { env } from '../src/config/env.config';

async function checkJobs() {
  try {
    // Conectar a la base de datos
    await mongoose.connect(env.MONGODB_URI);
    console.log('✅ Conectado a MongoDB');

    // Contar trabajos
    const totalJobs = await Job.countDocuments();
    console.log(`📊 Total de trabajos en la base de datos: ${totalJobs}`);

    // Obtener trabajos con estado OPEN
    const openJobs = await Job.find({ status: 'open' });
    console.log(`🔓 Trabajos abiertos: ${openJobs.length}`);

    // Mostrar detalles de los primeros 5 trabajos
    console.log('\n📋 Primeros 5 trabajos:');
    for (let i = 0; i < Math.min(5, openJobs.length); i++) {
      const job = openJobs[i];
      console.log(`${i + 1}. ${job.title}`);
      console.log(`   - Categoría: ${job.category}`);
      console.log(`   - Tipo: ${job.type}`);
      console.log(`   - Estado: ${job.status}`);
      console.log(`   - Urgente: ${job.isUrgent ? 'Sí' : 'No'}`);
      console.log(`   - Presupuesto: ${job.budget ? `$${job.budget}` : 'Por hora'}`);
      console.log('');
    }

    // Verificar configuración de la API
    console.log('🔧 Configuración de la API:');
    console.log(`   - Puerto: ${env.PORT || 4000}`);
    console.log(`   - Entorno: ${env.NODE_ENV}`);
    console.log(`   - MongoDB URI: ${env.MONGODB_URI ? 'Configurado' : 'No configurado'}`);
  } catch (error) {
    console.error('❌ Error verificando trabajos:', error);
  } finally {
    await mongoose.disconnect();
    console.log('🔌 Desconectado de MongoDB');
  }
}

// Ejecutar si se llama directamente
if (require.main === module) {
  checkJobs();
}

export { checkJobs };
