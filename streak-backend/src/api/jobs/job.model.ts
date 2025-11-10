import mongoose, { Document, Schema } from 'mongoose';

/**
 * Enumeraciones para el modelo Job
 */
export enum JobStatus {
  DRAFT = 'draft',
  OPEN = 'open',
  IN_PROGRESS = 'in_progress',
  COMPLETED = 'completed',
  CANCELLED = 'cancelled',
}

export enum JobType {
  FIXED_PRICE = 'fixed_price',
  HOURLY = 'hourly',
}

/**
 * Interface para el documento Job
 */
export interface IJob extends Document {
  // Información básica
  title: string;
  description: string;
  category: string;
  subcategory?: string;

  // Cliente
  clientId: mongoose.Types.ObjectId;

  // Tipo y presupuesto
  type: JobType;
  budget?: number; // Para fixed_price
  hourlyRate?: {
    min: number;
    max: number;
  }; // Para hourly

  // Detalles del proyecto
  skillsRequired: string[];
  experienceLevel: 'entry' | 'intermediate' | 'expert';
  estimatedDuration?: string;
  attachments?: string[];

  // Estado
  status: JobStatus;
  isUrgent: boolean;

  // Freelancer asignado (cuando está in_progress)
  assignedFreelancerId?: mongoose.Types.ObjectId;

  // Estadísticas
  stats: {
    views: number;
    applicationsCount: number;
    savedCount: number;
  };

  // Fechas
  deadline?: Date;
  startDate?: Date;
  completionDate?: Date;
  createdAt: Date;
  updatedAt: Date;
}

/**
 * Schema de Job
 */
const JobSchema = new Schema<IJob>(
  {
    title: {
      type: String,
      required: [true, 'El título es requerido'],
      trim: true,
      minlength: [10, 'El título debe tener al menos 10 caracteres'],
      maxlength: [100, 'El título no puede exceder 100 caracteres'],
    },
    description: {
      type: String,
      required: [true, 'La descripción es requerida'],
      minlength: [50, 'La descripción debe tener al menos 50 caracteres'],
      maxlength: [5000, 'La descripción no puede exceder 5000 caracteres'],
    },
    category: {
      type: String,
      required: [true, 'La categoría es requerida'],
    },
    subcategory: String,

    clientId: {
      type: Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },

    type: {
      type: String,
      enum: Object.values(JobType),
      required: true,
    },
    budget: {
      type: Number,
      min: [0, 'El presupuesto no puede ser negativo'],
    },
    hourlyRate: {
      min: {
        type: Number,
        min: [0, 'La tarifa mínima no puede ser negativa'],
      },
      max: {
        type: Number,
        min: [0, 'La tarifa máxima no puede ser negativa'],
      },
    },

    skillsRequired: {
      type: [String],
      validate: {
        validator: (v: string[]) => v && v.length > 0,
        message: 'Se requiere al menos una habilidad',
      },
    },
    experienceLevel: {
      type: String,
      enum: ['entry', 'intermediate', 'expert'],
      default: 'intermediate',
    },
    estimatedDuration: String,
    attachments: [String],

    status: {
      type: String,
      enum: Object.values(JobStatus),
      default: JobStatus.DRAFT,
    },
    isUrgent: {
      type: Boolean,
      default: false,
    },

    assignedFreelancerId: {
      type: Schema.Types.ObjectId,
      ref: 'User',
    },

    stats: {
      views: { type: Number, default: 0, min: 0 },
      applicationsCount: { type: Number, default: 0, min: 0 },
      savedCount: { type: Number, default: 0, min: 0 },
    },

    deadline: Date,
    startDate: Date,
    completionDate: Date,
  },
  {
    timestamps: true,
    toJSON: { virtuals: true },
    toObject: { virtuals: true },
  }
);

/**
 * Índices
 */
JobSchema.index({ clientId: 1, status: 1 });
JobSchema.index({ status: 1, createdAt: -1 });
JobSchema.index({ category: 1, status: 1 });
JobSchema.index({ skillsRequired: 1 });
JobSchema.index({ 'stats.applicationsCount': -1 });
JobSchema.index({ createdAt: -1 });

/**
 * Virtual: Cliente
 */
JobSchema.virtual('client', {
  ref: 'User',
  localField: 'clientId',
  foreignField: '_id',
  justOne: true,
});

/**
 * Virtual: Freelancer asignado
 */
JobSchema.virtual('assignedFreelancer', {
  ref: 'User',
  localField: 'assignedFreelancerId',
  foreignField: '_id',
  justOne: true,
});

/**
 * Exportar modelo
 */
export const Job = mongoose.model<IJob>('Job', JobSchema);
