import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/common/app_toast.dart';

/// Pantalla para agregar/editar idiomas
/// Basada en el diseño de Add Language.jpg
class AddLanguageScreen extends ConsumerStatefulWidget {
  const AddLanguageScreen({super.key});

  @override
  ConsumerState<AddLanguageScreen> createState() => _AddLanguageScreenState();
}

class _AddLanguageScreenState extends ConsumerState<AddLanguageScreen> {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  
  String _selectedLanguage = '';
  String _selectedProficiency = 'intermediate';
  bool _isLoading = false;
  bool _isSearching = false;

  final List<String> _proficiencyLevels = [
    'beginner',
    'intermediate',
    'advanced',
    'native',
  ];

  final List<String> _commonLanguages = [
    'Español',
    'Inglés',
    'Francés',
    'Alemán',
    'Italiano',
    'Portugués',
    'Chino Mandarín',
    'Japonés',
    'Coreano',
    'Árabe',
    'Ruso',
    'Holandés',
    'Sueco',
    'Noruego',
    'Danés',
    'Finlandés',
    'Polaco',
    'Checo',
    'Húngaro',
    'Rumano',
    'Griego',
    'Turco',
    'Hebreo',
    'Hindi',
    'Bengalí',
    'Tailandés',
    'Vietnamita',
    'Indonesio',
    'Malayo',
    'Filipino',
  ];

  List<String> _filteredLanguages = [];

  @override
  void initState() {
    super.initState();
    _filteredLanguages = _commonLanguages;
    _searchController.addListener(_filterLanguages);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterLanguages() {
    setState(() {
      _isSearching = _searchController.text.isNotEmpty;
      if (_searchController.text.isEmpty) {
        _filteredLanguages = _commonLanguages;
      } else {
        _filteredLanguages = _commonLanguages
            .where((language) => language
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> _addLanguage() async {
    if (_selectedLanguage.isEmpty) {
      AppToast.showError(context, 'Por favor selecciona un idioma');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simular agregado de idioma
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        AppToast.showSuccess(context, 'Idioma agregado exitosamente');
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        AppToast.showError(context, 'Error al agregar el idioma: ${e.toString()}');
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
        title: const Text('Agregar Idioma'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _addLanguage,
            child: Text(
              'Agregar',
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
              // Búsqueda de idioma
              _buildSection(
                'Seleccionar Idioma',
                [
                  TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Buscar idioma',
                      hintText: 'Escribe para buscar un idioma...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                            )
                          : null,
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
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildLanguageGrid(),
                ],
              ),

              const SizedBox(height: 24),

              // Nivel de competencia
              if (_selectedLanguage.isNotEmpty) ...[
                _buildSection(
                  'Nivel de Competencia',
                  [
                    _buildDropdownField(
                      value: _selectedProficiency,
                      label: 'Selecciona tu nivel',
                      items: _proficiencyLevels.map((level) {
                        return DropdownMenuItem(
                          value: level,
                          child: Text(_getProficiencyText(level)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedProficiency = value ?? 'intermediate';
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],

              // Botón de agregar
              if (_selectedLanguage.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _addLanguage,
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
                            'Agregar Idioma',
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

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildLanguageGrid() {
    return SizedBox(
      height: 300,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: _filteredLanguages.length,
        itemBuilder: (context, index) {
          final language = _filteredLanguages[index];
          final isSelected = _selectedLanguage == language;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedLanguage = language;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: isSelected 
                    ? AppColors.primary.withOpacity(0.1)
                    : AppColors.cardBackground,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected 
                      ? AppColors.primary
                      : AppColors.grey200,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Center(
                child: Text(
                  language,
                  style: TextStyle(
                    color: isSelected 
                        ? AppColors.primary
                        : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDropdownField({
    required String value,
    required String label,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      items: items,
      onChanged: onChanged,
    );
  }

  String _getProficiencyText(String level) {
    switch (level) {
      case 'beginner':
        return 'Principiante';
      case 'intermediate':
        return 'Intermedio';
      case 'advanced':
        return 'Avanzado';
      case 'native':
        return 'Nativo';
      default:
        return level;
    }
  }
}
