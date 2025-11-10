import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/cv_model.dart';

class CVNotifier extends Notifier<List<CVModel>> {
  @override
  List<CVModel> build() {
    return _loadMockCVs();
  }

  List<CVModel> _loadMockCVs() {
    return [
      CVModel(
        id: '1',
        fileName: 'curriculum_principal.pdf',
        originalName: 'Mi Currículum Principal',
        fileType: 'pdf',
        fileUrl: '/uploads/cv/curriculum_principal.pdf',
        fileSize: 2048576, // 2MB
        isPublic: true,
        isDefault: true,
        uploadedAt: DateTime.now().subtract(const Duration(days: 30)),
        description: 'CV principal con experiencia completa',
        tags: ['desarrollador', 'flutter', 'senior'],
        downloadCount: 15,
        viewCount: 45,
      ),
      CVModel(
        id: '2',
        fileName: 'curriculum_breve.pdf',
        originalName: 'CV Resumido',
        fileType: 'pdf',
        fileUrl: '/uploads/cv/curriculum_breve.pdf',
        fileSize: 1024768, // 1MB
        isPublic: false,
        isDefault: false,
        uploadedAt: DateTime.now().subtract(const Duration(days: 15)),
        description: 'Versión resumida para aplicaciones rápidas',
        tags: ['resumen', 'rapido'],
        downloadCount: 8,
        viewCount: 12,
      ),
      CVModel(
        id: '3',
        fileName: 'curriculum_ingles.docx',
        originalName: 'Resume English',
        fileType: 'docx',
        fileUrl: '/uploads/cv/curriculum_ingles.docx',
        fileSize: 1536000, // 1.5MB
        isPublic: true,
        isDefault: false,
        uploadedAt: DateTime.now().subtract(const Duration(days: 7)),
        description: 'CV en inglés para oportunidades internacionales',
        tags: ['ingles', 'internacional'],
        downloadCount: 5,
        viewCount: 18,
      ),
    ];
  }

  void addCV(CVModel cv) {
    state = [cv, ...state];
  }

  void updateCV(String id, CVModel updatedCV) {
    state = state.map((cv) => cv.id == id ? updatedCV : cv).toList();
  }

  void deleteCV(String id) {
    state = state.where((cv) => cv.id != id).toList();
  }

  void setAsDefault(String id) {
    state = state.map((cv) {
      return cv.copyWith(isDefault: cv.id == id);
    }).toList();
  }

  void togglePublic(String id) {
    state = state.map((cv) {
      if (cv.id == id) {
        return cv.copyWith(isPublic: !cv.isPublic);
      }
      return cv;
    }).toList();
  }

  CVModel? get defaultCV {
    try {
      return state.firstWhere((cv) => cv.isDefault);
    } catch (e) {
      return state.isNotEmpty ? state.first : null;
    }
  }

  List<CVModel> get publicCVs {
    return state.where((cv) => cv.isPublic).toList();
  }

  List<CVModel> get privateCVs {
    return state.where((cv) => !cv.isPublic).toList();
  }

  int get totalCVs => state.length;
  int get publicCVsCount => publicCVs.length;
  int get privateCVsCount => privateCVs.length;
}

final cvProvider = NotifierProvider<CVNotifier, List<CVModel>>(() {
  return CVNotifier();
});

final defaultCVProvider = Provider<CVModel?>((ref) {
  return ref.watch(cvProvider.notifier).defaultCV;
});

final publicCVsProvider = Provider<List<CVModel>>((ref) {
  return ref.watch(cvProvider.notifier).publicCVs;
});

final privateCVsProvider = Provider<List<CVModel>>((ref) {
  return ref.watch(cvProvider.notifier).privateCVs;
});

final cvStatsProvider = Provider<Map<String, int>>((ref) {
  final notifier = ref.watch(cvProvider.notifier);
  return {
    'total': notifier.totalCVs,
    'public': notifier.publicCVsCount,
    'private': notifier.privateCVsCount,
  };
});
