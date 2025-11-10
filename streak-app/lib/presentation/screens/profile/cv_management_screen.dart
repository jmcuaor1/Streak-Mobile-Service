import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/cv_model.dart';
import '../../providers/cv_provider.dart';
import '../../widgets/common/app_toast.dart';
import '../../widgets/cv/cv_widgets.dart';
import '../profile/upload_cv_screen.dart';

/// Pantalla principal de gestión de CVs
class CVManagementScreen extends ConsumerStatefulWidget {
  const CVManagementScreen({super.key});

  @override
  ConsumerState<CVManagementScreen> createState() => _CVManagementScreenState();
}

class _CVManagementScreenState extends ConsumerState<CVManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cvs = ref.watch(cvProvider);
    final cvNotifier = ref.read(cvProvider.notifier);
    final stats = ref.watch(cvStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis CVs'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showFilterDialog(),
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filtrar',
          ),
          IconButton(
            onPressed: () => _navigateToUploadCV(),
            icon: const Icon(Icons.add),
            tooltip: 'Subir CV',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Todos'),
                  if (stats['total']! > 0) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${stats['total']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Públicos'),
                  if (stats['public']! > 0) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${stats['public']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Privados'),
                  if (stats['private']! > 0) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.warning,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${stats['private']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCVsList(cvs, cvNotifier),
          _buildCVsList(cvNotifier.publicCVs, cvNotifier),
          _buildCVsList(cvNotifier.privateCVs, cvNotifier),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToUploadCV(),
        icon: const Icon(Icons.upload_file),
        label: const Text('Subir CV'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildCVsList(List<CVModel> cvs, CVNotifier cvNotifier) {
    if (cvs.isEmpty) {
      return CVEmptyState(
        onUploadCV: () => _navigateToUploadCV(),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        // Simular refresh
        await Future.delayed(const Duration(seconds: 1));
        AppToast.showSuccess(context, 'CVs actualizados');
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cvs.length,
        itemBuilder: (context, index) {
          final cv = cvs[index];
          return CVCard(
            cv: cv,
            onTap: () => _showCVDetails(cv),
            onEdit: () => _editCV(cv),
            onDelete: () => _deleteCV(cv, cvNotifier),
            onSetDefault: () => _setAsDefault(cv, cvNotifier),
            onTogglePublic: () => _togglePublic(cv, cvNotifier),
          );
        },
      ),
    );
  }

  void _navigateToUploadCV() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const UploadCVScreen(),
      ),
    );
  }

  void _showCVDetails(CVModel cv) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(cv.originalName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tipo: ${cv.fileType.toUpperCase()}'),
            Text('Tamaño: ${_formatFileSize(cv.fileSize)}'),
            Text('Subido: ${_formatDate(cv.uploadedAt)}'),
            Text('Vistas: ${cv.viewCount}'),
            Text('Descargas: ${cv.downloadCount}'),
            Text('Estado: ${cv.isPublic ? 'Público' : 'Privado'}'),
            if (cv.isDefault) const Text('CV Predeterminado'),
            if (cv.description != null) ...[
              const SizedBox(height: 8),
              Text('Descripción: ${cv.description}'),
            ],
            if (cv.tags.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('Tags: ${cv.tags.join(', ')}'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _editCV(cv);
            },
            child: const Text('Editar'),
          ),
        ],
      ),
    );
  }

  void _editCV(CVModel cv) {
    AppToast.showInfo(context, 'Función de edición próximamente');
  }

  void _deleteCV(CVModel cv, CVNotifier cvNotifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar CV'),
        content: Text('¿Estás seguro de que quieres eliminar "${cv.originalName}"? Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              cvNotifier.deleteCV(cv.id);
              Navigator.pop(context);
              AppToast.showSuccess(context, 'CV eliminado exitosamente');
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _setAsDefault(CVModel cv, CVNotifier cvNotifier) {
    if (cv.isDefault) {
      AppToast.showInfo(context, 'Este CV ya es el predeterminado');
      return;
    }

    cvNotifier.setAsDefault(cv.id);
    AppToast.showSuccess(context, 'CV establecido como predeterminado');
  }

  void _togglePublic(CVModel cv, CVNotifier cvNotifier) {
    cvNotifier.togglePublic(cv.id);
    final newStatus = cv.isPublic ? 'privado' : 'público';
    AppToast.showSuccess(context, 'CV marcado como $newStatus');
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrar CVs'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Todos'),
              value: 'all',
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Solo predeterminados'),
              value: 'default',
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Solo públicos'),
              value: 'public',
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Solo privados'),
              value: 'private',
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Hoy';
    } else if (difference.inDays == 1) {
      return 'Ayer';
    } else if (difference.inDays < 7) {
      return 'Hace ${difference.inDays} días';
    } else if (difference.inDays < 30) {
      return 'Hace ${(difference.inDays / 7).floor()} semanas';
    } else {
      return 'Hace ${(difference.inDays / 30).floor()} meses';
    }
  }
}
