import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/common/app_toast.dart';

/// Pantalla para crear y ver posts
/// Basada en el diseño de Post.jpg y Add Post.jpg
class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({super.key});

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  
  bool _isLoading = false;
  String _selectedPostType = 'general';
  final List<String> _selectedHashtags = [];

  final List<String> _postTypes = [
    'general',
    'job_opportunity',
    'professional_tip',
    'industry_news',
    'achievement',
    'question',
  ];

  final List<String> _suggestedHashtags = [
    '#trabajo',
    '#empleo',
    '#carrera',
    '#tecnologia',
    '#desarrollo',
    '#diseño',
    '#marketing',
    '#freelance',
    '#remoto',
    '#colombia',
    '#bogota',
    '#medellin',
  ];

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _createPost() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    if (_contentController.text.trim().isEmpty) {
      AppToast.showError(context, 'El contenido del post es requerido');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simular creación de post
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        AppToast.showSuccess(context, 'Post publicado exitosamente');
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        AppToast.showError(context, 'Error al publicar: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Post'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _createPost,
            child: Text(
              'Publicar',
              style: TextStyle(
                color: _isLoading ? AppColors.grey400 : AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header del usuario
              _buildUserHeader(),
              
              const SizedBox(height: 24),
              
              // Tipo de post
              _buildPostTypeSection(),
              
              const SizedBox(height: 24),
              
              // Contenido del post
              _buildContentSection(),
              
              const SizedBox(height: 24),
              
              // Hashtags
              _buildHashtagsSection(),
              
              const SizedBox(height: 24),
              
              // Opciones adicionales
              _buildAdditionalOptions(),
              
              const SizedBox(height: 32),
              
              // Botón de publicar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _createPost,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Publicar Post',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: Icon(
            Icons.person,
            color: AppColors.primary,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Juan Pérez',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Desarrollador Full Stack',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            AppToast.showInfo(context, 'Opciones adicionales próximamente');
          },
        ),
      ],
    );
  }

  Widget _buildPostTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tipo de publicación',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _postTypes.map((type) {
            final isSelected = _selectedPostType == type;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPostType = type;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppColors.primary.withOpacity(0.1)
                      : AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected 
                        ? AppColors.primary
                        : AppColors.grey200,
                  ),
                ),
                child: Text(
                  _getPostTypeText(type),
                  style: TextStyle(
                    color: isSelected 
                        ? AppColors.primary
                        : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildContentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '¿Qué quieres compartir?',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _contentController,
          maxLines: 8,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'El contenido es requerido';
            }
            if (value.trim().length < 10) {
              return 'El contenido debe tener al menos 10 caracteres';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Comparte tus pensamientos, experiencias o consejos profesionales...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.grey300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.grey300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            filled: true,
            fillColor: AppColors.cardBackground,
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_contentController.text.length}/500',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.image_outlined),
                  onPressed: () {
                    AppToast.showInfo(context, 'Función de imagen próximamente');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    AppToast.showInfo(context, 'Función de archivo próximamente');
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHashtagsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hashtags',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Toca para agregar hashtags sugeridos',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _suggestedHashtags.map((hashtag) {
            final isSelected = _selectedHashtags.contains(hashtag);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedHashtags.remove(hashtag);
                  } else {
                    _selectedHashtags.add(hashtag);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppColors.primary
                      : AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  hashtag,
                  style: TextStyle(
                    color: isSelected 
                        ? Colors.white
                        : AppColors.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        if (_selectedHashtags.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            'Hashtags seleccionados: ${_selectedHashtags.join(' ')}',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAdditionalOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Opciones adicionales',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        SwitchListTile(
          title: const Text('Permitir comentarios'),
          subtitle: const Text('Otros usuarios podrán comentar tu post'),
          value: true,
          onChanged: (value) {
            // Handle comments toggle
          },
          activeThumbColor: AppColors.primary,
          contentPadding: EdgeInsets.zero,
        ),
        SwitchListTile(
          title: const Text('Notificar a mi red'),
          subtitle: const Text('Enviar notificación a mis conexiones'),
          value: true,
          onChanged: (value) {
            // Handle notification toggle
          },
          activeThumbColor: AppColors.primary,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  String _getPostTypeText(String type) {
    switch (type) {
      case 'general':
        return 'General';
      case 'job_opportunity':
        return 'Oportunidad de trabajo';
      case 'professional_tip':
        return 'Consejo profesional';
      case 'industry_news':
        return 'Noticias de la industria';
      case 'achievement':
        return 'Logro personal';
      case 'question':
        return 'Pregunta';
      default:
        return type;
    }
  }
}
