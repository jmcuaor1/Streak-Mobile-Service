import mongoose, { Document, Schema } from 'mongoose';
import bcrypt from 'bcryptjs';

/**
 * Enumeraciones para el modelo User
 */
export enum UserRole {
  CLIENT = 'client',
  FREELANCER = 'freelancer',
  ADMIN = 'admin',
}

export enum AccountStatus {
  PENDING = 'pending',
  ACTIVE = 'active',
  SUSPENDED = 'suspended',
  DELETED = 'deleted',
}

/**
 * Interface para el documento User
 */
export interface IUser extends Document {
  // Información básica
  email: string;
  password: string;
  role: UserRole;
  accountStatus: AccountStatus;

  // Perfil
  profile: {
    firstName: string;
    lastName: string;
    avatar?: string;
    bio?: string;
    location?: string;
    phone?: string;
  };

  // Para freelancers
  freelancerProfile?: {
    title?: string;
    hourlyRate?: number;
    skills: string[];
    portfolio?: string[];
    experience?: string;
    education?: string;
    languages: string[];
    availability: 'available' | 'busy' | 'unavailable';
  };

  // Gamificación
  gamification: {
    currentStreak: number;
    longestStreak: number;
    lastActivityDate?: Date;
    totalPoints: number;
    level: number;
    achievements: mongoose.Types.ObjectId[];
  };

  // Estadísticas
  stats: {
    jobsPosted: number;
    jobsCompleted: number;
    gigsCreated: number;
    totalEarnings: number;
    totalSpent: number;
    rating: number;
    reviewsCount: number;
  };

  // Notificaciones y preferencias
  preferences: {
    emailNotifications: boolean;
    pushNotifications: boolean;
    language: string;
    timezone: string;
  };

  // Seguridad
  emailVerified: boolean;
  emailVerificationToken?: string;
  passwordResetToken?: string;
  passwordResetExpires?: Date;
  refreshTokens: string[];

  // Timestamps
  lastLoginAt?: Date;
  createdAt: Date;
  updatedAt: Date;

  // Métodos de instancia
  comparePassword(candidatePassword: string): Promise<boolean>;
  generatePasswordResetToken(): string;
}

/**
 * Schema de User
 */
const UserSchema = new Schema<IUser>(
  {
    email: {
      type: String,
      required: [true, 'El email es requerido'],
      unique: true,
      lowercase: true,
      trim: true,
      match: [/^\S+@\S+\.\S+$/, 'Email inválido'],
    },
    password: {
      type: String,
      required: [true, 'La contraseña es requerida'],
      minlength: [8, 'La contraseña debe tener al menos 8 caracteres'],
      select: false, // No devolver password por defecto en queries
    },
    role: {
      type: String,
      enum: Object.values(UserRole),
      default: UserRole.CLIENT,
      required: true,
    },
    accountStatus: {
      type: String,
      enum: Object.values(AccountStatus),
      default: AccountStatus.PENDING,
    },

    // Perfil
    profile: {
      firstName: {
        type: String,
        required: [true, 'El nombre es requerido'],
        trim: true,
      },
      lastName: {
        type: String,
        required: [true, 'El apellido es requerido'],
        trim: true,
      },
      avatar: String,
      bio: {
        type: String,
        maxlength: [500, 'La bio no puede exceder 500 caracteres'],
      },
      location: String,
      phone: String,
    },

    // Perfil de freelancer (opcional)
    freelancerProfile: {
      title: String,
      hourlyRate: {
        type: Number,
        min: [0, 'La tarifa por hora no puede ser negativa'],
      },
      skills: [String],
      portfolio: [String],
      experience: String,
      education: String,
      languages: [String],
      availability: {
        type: String,
        enum: ['available', 'busy', 'unavailable'],
        default: 'available',
      },
    },

    // Gamificación
    gamification: {
      currentStreak: {
        type: Number,
        default: 0,
        min: 0,
      },
      longestStreak: {
        type: Number,
        default: 0,
        min: 0,
      },
      lastActivityDate: Date,
      totalPoints: {
        type: Number,
        default: 0,
        min: 0,
      },
      level: {
        type: Number,
        default: 1,
        min: 1,
      },
      achievements: [
        {
          type: Schema.Types.ObjectId,
          ref: 'Achievement',
        },
      ],
    },

    // Estadísticas
    stats: {
      jobsPosted: { type: Number, default: 0, min: 0 },
      jobsCompleted: { type: Number, default: 0, min: 0 },
      gigsCreated: { type: Number, default: 0, min: 0 },
      totalEarnings: { type: Number, default: 0, min: 0 },
      totalSpent: { type: Number, default: 0, min: 0 },
      rating: { type: Number, default: 0, min: 0, max: 5 },
      reviewsCount: { type: Number, default: 0, min: 0 },
    },

    // Preferencias
    preferences: {
      emailNotifications: { type: Boolean, default: true },
      pushNotifications: { type: Boolean, default: true },
      language: { type: String, default: 'es' },
      timezone: { type: String, default: 'America/Mexico_City' },
    },

    // Seguridad
    emailVerified: { type: Boolean, default: false },
    emailVerificationToken: String,
    passwordResetToken: String,
    passwordResetExpires: Date,
    refreshTokens: [String],

    lastLoginAt: Date,
  },
  {
    timestamps: true,
    toJSON: {
      virtuals: true,
      transform: (_doc, ret: Record<string, unknown>) => {
        delete ret.password;
        delete ret.refreshTokens;
        delete ret.emailVerificationToken;
        delete ret.passwordResetToken;
        delete ret.passwordResetExpires;
        delete ret.__v;
        return ret;
      },
    },
    toObject: { virtuals: true },
  }
);

/**
 * Índices
 */
UserSchema.index({ email: 1 });
UserSchema.index({ role: 1 });
UserSchema.index({ accountStatus: 1 });
UserSchema.index({ 'gamification.totalPoints': -1 });
UserSchema.index({ 'stats.rating': -1 });
UserSchema.index({ createdAt: -1 });

/**
 * Middleware: Hash password antes de guardar
 */
UserSchema.pre('save', async function (next) {
  // Solo hashear si la contraseña fue modificada
  if (!this.isModified('password')) {
    return next();
  }

  try {
    const salt = await bcrypt.genSalt(12);
    this.password = await bcrypt.hash(this.password, salt);
    next();
  } catch (error) {
    next(error as Error);
  }
});

/**
 * Método: Comparar contraseña
 */
UserSchema.methods.comparePassword = async function (candidatePassword: string): Promise<boolean> {
  try {
    return await bcrypt.compare(candidatePassword, this.password);
  } catch (error) {
    throw new Error('Error al comparar contraseñas');
  }
};

/**
 * Método: Generar token de reset de contraseña
 */
UserSchema.methods.generatePasswordResetToken = function (): string {
  const resetToken =
    Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);

  this.passwordResetToken = resetToken;
  this.passwordResetExpires = new Date(Date.now() + 3600000); // 1 hora

  return resetToken;
};

/**
 * Virtual: Nombre completo
 */
UserSchema.virtual('fullName').get(function () {
  return `${this.profile.firstName} ${this.profile.lastName}`;
});

/**
 * Exportar modelo
 */
export const User = mongoose.model<IUser>('User', UserSchema);
