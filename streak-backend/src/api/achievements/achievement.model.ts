import mongoose, { Document, Schema } from 'mongoose';

/**
 * Enumeraciones para el modelo Achievement
 */
export enum AchievementCategory {
  STREAK = 'streak',
  JOBS = 'jobs',
  APPLICATIONS = 'applications',
  PROFILE = 'profile',
  COMMUNITY = 'community',
}

/**
 * Interface para el documento Achievement
 */
export interface IAchievement extends Document {
  // Información básica
  name: string;
  description: string;
  icon: string;
  category: AchievementCategory;

  // Criterios
  criteria: {
    type: string; // 'streak_days', 'jobs_completed', 'applications_sent', etc.
    target: number;
  };

  // Recompensas
  points: number;
  badgeUrl?: string;

  // Metadata
  isActive: boolean;
  order: number; // Para ordenar achievements en el UI

  createdAt: Date;
  updatedAt: Date;
}

/**
 * Schema de Achievement
 */
const AchievementSchema = new Schema<IAchievement>(
  {
    name: {
      type: String,
      required: [true, 'El nombre es requerido'],
      unique: true,
      trim: true,
    },
    description: {
      type: String,
      required: [true, 'La descripción es requerida'],
      maxlength: [500, 'La descripción no puede exceder 500 caracteres'],
    },
    icon: {
      type: String,
      required: [true, 'El icono es requerido'],
    },
    category: {
      type: String,
      enum: Object.values(AchievementCategory),
      required: true,
    },

    criteria: {
      type: {
        type: String,
        required: true,
      },
      target: {
        type: Number,
        required: true,
        min: [1, 'El target debe ser al menos 1'],
      },
    },

    points: {
      type: Number,
      required: [true, 'Los puntos son requeridos'],
      min: [0, 'Los puntos no pueden ser negativos'],
    },
    badgeUrl: String,

    isActive: {
      type: Boolean,
      default: true,
    },
    order: {
      type: Number,
      default: 0,
    },
  },
  {
    timestamps: true,
  }
);

/**
 * Índices
 */
AchievementSchema.index({ category: 1, order: 1 });
AchievementSchema.index({ isActive: 1 });

/**
 * Exportar modelo
 */
export const Achievement = mongoose.model<IAchievement>('Achievement', AchievementSchema);
