import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/common/app_toast.dart';

/// Pantalla de conexiones profesionales
/// Basada en el diseño de My connection.jpg
class MyConnectionsScreen extends ConsumerStatefulWidget {
  const MyConnectionsScreen({super.key});

  @override
  ConsumerState<MyConnectionsScreen> createState() => _MyConnectionsScreenState();
}

class _MyConnectionsScreenState extends ConsumerState<MyConnectionsScreen> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'all';
  bool _isLoading = false;

  final List<String> _filters = [
    'all',
    'recent',
    'mutual',
    'suggested',
  ];

  // Mock data - en una app real esto vendría del backend
  List<Map<String, dynamic>> _connections = [];
  List<Map<String, dynamic>> _filteredConnections = [];

  @override
  void initState() {
    super.initState();
    _loadConnections();
    _searchController.addListener(_filterConnections);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadConnections() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Simular carga de conexiones
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data
      _connections = [
        {
          'id': '1',
          'name': 'María González',
          'title': 'Product Manager',
          'company': 'TechCorp',
          'avatar': null,
          'isOnline': true,
          'mutualConnections': 5,
          'connectedDate': '2024-01-15',
          'location': 'Bogotá, Colombia',
        },
        {
          'id': '2',
          'name': 'Carlos Rodríguez',
          'title': 'UX Designer',
          'company': 'DesignStudio',
          'avatar': null,
          'isOnline': false,
          'mutualConnections': 3,
          'connectedDate': '2024-01-10',
          'location': 'Medellín, Colombia',
        },
        {
          'id': '3',
          'name': 'Ana Martínez',
          'title': 'Data Scientist',
          'company': 'DataCorp',
          'avatar': null,
          'isOnline': true,
          'mutualConnections': 8,
          'connectedDate': '2024-01-05',
          'location': 'Cali, Colombia',
        },
        {
          'id': '4',
          'name': 'Luis Fernández',
          'title': 'Backend Developer',
          'company': 'DevSolutions',
          'avatar': null,
          'isOnline': false,
          'mutualConnections': 2,
          'connectedDate': '2023-12-20',
          'location': 'Barranquilla, Colombia',
        },
        {
          'id': '5',
          'name': 'Sofia Herrera',
          'title': 'Marketing Manager',
          'company': 'MarketingPro',
          'avatar': null,
          'isOnline': true,
          'mutualConnections': 6,
          'connectedDate': '2023-12-15',
          'location': 'Cartagena, Colombia',
        },
      ];
      
      _filteredConnections = List.from(_connections);
      
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        AppToast.showError(context, 'Error al cargar las conexiones');
      }
    }
  }

  void _filterConnections() {
    setState(() {
      _filteredConnections = _connections.where((connection) {
        final searchTerm = _searchController.text.toLowerCase();
        final matchesSearch = connection['name'].toLowerCase().contains(searchTerm) ||
                            connection['title'].toLowerCase().contains(searchTerm) ||
                            connection['company'].toLowerCase().contains(searchTerm);
        
        if (!matchesSearch) return false;
        
        switch (_selectedFilter) {
          case 'recent':
            return DateTime.parse(connection['connectedDate']).isAfter(
              DateTime.now().subtract(const Duration(days: 30))
            );
          case 'mutual':
            return connection['mutualConnections'] > 0;
          case 'suggested':
            return connection['mutualConnections'] >= 3;
          default:
            return true;
        }
      }).toList();
    });
  }

  Future<void> _removeConnection(String connectionId) async {
    try {
      setState(() {
        _connections.removeWhere((conn) => conn['id'] == connectionId);
        _filteredConnections.removeWhere((conn) => conn['id'] == connectionId);
      });
      
      AppToast.showSuccess(context, 'Conexión removida exitosamente');
    } catch (e) {
      AppToast.showError(context, 'Error al remover la conexión');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Conexiones'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              AppToast.showInfo(context, 'Buscar nuevas conexiones próximamente');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda y filtros
          _buildSearchAndFilters(),
          
          // Lista de conexiones
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredConnections.isEmpty
                    ? _buildEmptyState()
                    : _buildConnectionsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Barra de búsqueda
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar conexiones...',
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
          
          const SizedBox(height: 12),
          
          // Filtros
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _filters.map((filter) {
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(_getFilterText(filter)),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                      _filterConnections();
                    },
                    backgroundColor: AppColors.cardBackground,
                    selectedColor: AppColors.primary.withOpacity(0.2),
                    checkmarkColor: AppColors.primary,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredConnections.length,
      itemBuilder: (context, index) {
        final connection = _filteredConnections[index];
        return _buildConnectionCard(connection);
      },
    );
  }

  Widget _buildConnectionCard(Map<String, dynamic> connection) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.grey200),
      ),
      child: ListTile(
        leading: Stack(
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
            if (connection['isOnline'])
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          connection['name'],
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${connection['title']} en ${connection['company']}',
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  connection['location'],
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                if (connection['mutualConnections'] > 0) ...[
                  const SizedBox(width: 12),
                  Icon(
                    Icons.people,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${connection['mutualConnections']} conexiones mutuas',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'message':
                AppToast.showInfo(context, 'Función de mensaje próximamente');
                break;
              case 'view_profile':
                AppToast.showInfo(context, 'Ver perfil próximamente');
                break;
              case 'remove':
                _showRemoveDialog(connection);
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'message',
              child: Row(
                children: [
                  Icon(Icons.message, size: 20),
                  SizedBox(width: 8),
                  Text('Enviar mensaje'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'view_profile',
              child: Row(
                children: [
                  Icon(Icons.person, size: 20),
                  SizedBox(width: 8),
                  Text('Ver perfil'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'remove',
              child: Row(
                children: [
                  Icon(Icons.person_remove, size: 20, color: AppColors.error),
                  SizedBox(width: 8),
                  Text('Remover conexión', style: TextStyle(color: AppColors.error)),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          AppToast.showInfo(context, 'Ver perfil de ${connection['name']} próximamente');
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 80,
              color: AppColors.grey400,
            ),
            const SizedBox(height: 24),
            Text(
              'No hay conexiones',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Comienza a conectar con profesionales de tu industria.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                AppToast.showInfo(context, 'Buscar conexiones próximamente');
              },
              icon: const Icon(Icons.person_add),
              label: const Text('Buscar Conexiones'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRemoveDialog(Map<String, dynamic> connection) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remover Conexión'),
        content: Text('¿Estás seguro de que quieres remover a ${connection['name']} de tus conexiones?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _removeConnection(connection['id']);
            },
            child: const Text(
              'Remover',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  String _getFilterText(String filter) {
    switch (filter) {
      case 'all':
        return 'Todas';
      case 'recent':
        return 'Recientes';
      case 'mutual':
        return 'Conexiones mutuas';
      case 'suggested':
        return 'Sugeridas';
      default:
        return filter;
    }
  }
}
