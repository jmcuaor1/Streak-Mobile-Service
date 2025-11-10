import mongoose, { Document, Schema } from 'mongoose';

/**
 * Enumeraciones para el modelo Application
 */
export enum ApplicationStatus {
  PENDING = 'pending',
  ACCEPTED = 'accepted',
  REJECTED = 'rejected',
  WITHDRAWN = 'withdrawn',
}

/**
 * Interface para el documento Application
 */
export interface IApplication extends Document {
  // Relaciones
  jobId: mongoose.Types.ObjectId;
  freelancerId: mongoose.Types.ObjectId;

  // Propuesta
  coverLetter: string;
  proposedRate?: number;
  proposedDuration?: string;
  portfolio?: string[];

  // Estado
  status: ApplicationStatus;

  // Fechas
  appliedAt: Date;
  respondedAt?: Date;
  createdAt: Date;
  updatedAt: Date;
}

/**
 * Schema de Application
 */
const ApplicationSchema = new Schema<IApplication>(
  {
    jobId: {
      type: Schema.Types.ObjectId,
      ref: 'Job',
      required: true,
    },
    freelancerId: {
      type: Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },

    coverLetter: {
      type: String,
      required: [true, 'La carta de presentación es requerida'],
      minlength: [50, 'La carta debe tener al menos 50 caracteres'],
      maxlength: [2000, 'La carta no puede exceder 2000 caracteres'],
    },
    proposedRate: {
      type: Number,
      min: [0, 'La tarifa propuesta no puede ser negativa'],
    },
    proposedDuration: String,
    portfolio: [String],

    status: {
      type: String,
      enum: Object.values(ApplicationStatus),
      default: ApplicationStatus.PENDING,
    },

    appliedAt: {
      type: Date,
      default: Date.now,
    },
    respondedAt: Date,
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
ApplicationSchema.index({ jobId: 1, freelancerId: 1 }, { unique: true }); // Un freelancer solo puede postularse una vez
ApplicationSchema.index({ jobId: 1, status: 1 });
ApplicationSchema.index({ freelancerId: 1, status: 1 });
ApplicationSchema.index({ createdAt: -1 });

/**
 * Virtual: Job
 */
ApplicationSchema.virtual('job', {
  ref: 'Job',
  localField: 'jobId',
  foreignField: '_id',
  justOne: true,
});

/**
 * Virtual: Freelancer
 */
ApplicationSchema.virtual('freelancer', {
  ref: 'User',
  localField: 'freelancerId',
  foreignField: '_id',
  justOne: true,
});

/**
 * Exportar modelo
 */
export const Application = mongoose.model<IApplication>('Application', ApplicationSchema);
