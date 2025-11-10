import mongoose, { Document, Schema } from 'mongoose';

/**
 * Enumeraciones para el modelo ActivityEvent
 */
export enum ActivityType {
  LOGIN = 'login',
  JOB_POSTED = 'job_posted',
  APPLICATION_SENT = 'application_sent',
  APPLICATION_ACCEPTED = 'application_accepted',
  JOB_COMPLETED = 'job_completed',
  PROFILE_UPDATED = 'profile_updated',
}

/**
 * Interface para el documento ActivityEvent
 */
export interface IActivityEvent extends Document {
  userId: mongoose.Types.ObjectId;
  type: ActivityType;
  points: number;
  metadata?: Record<string, unknown>;
  date: Date;
  createdAt: Date;
}

/**
 * Schema de ActivityEvent
 */
const ActivityEventSchema = new Schema<IActivityEvent>(
  {
    userId: {
      type: Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
    type: {
      type: String,
      enum: Object.values(ActivityType),
      required: true,
    },
    points: {
      type: Number,
      required: true,
      min: [0, 'Los puntos no pueden ser negativos'],
    },
    metadata: {
      type: Schema.Types.Mixed,
    },
    date: {
      type: Date,
      required: true,
      default: Date.now,
    },
  },
  {
    timestamps: true,
  }
);

/**
 * Índices
 */
ActivityEventSchema.index({ userId: 1, date: -1 });
ActivityEventSchema.index({ userId: 1, type: 1 });
ActivityEventSchema.index({ date: -1 });

/**
 * Exportar modelo
 */
export const ActivityEvent = mongoose.model<IActivityEvent>('ActivityEvent', ActivityEventSchema);
