import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TypeOfWorkplacePage extends StatefulWidget {
  const TypeOfWorkplacePage({super.key});

  @override
  State<TypeOfWorkplacePage> createState() => _TypeOfWorkplacePageState();
}

class _TypeOfWorkplacePageState extends State<TypeOfWorkplacePage> {
  WorkplaceType? _selectedType;

  final List<WorkplaceType> _workplaceTypes = const [
    WorkplaceType(
      title: 'Remoto',
      description: 'Trabaja desde cualquier lugar del mundo.',
      icon: FontAwesomeIcons.houseLaptop,
      color: Colors.indigo,
    ),
    WorkplaceType(
      title: 'Híbrido',
      description: 'Combina la oficina y el trabajo remoto.',
      icon: FontAwesomeIcons.shuffle,
      color: Colors.orange.shade700,
    ),
    WorkplaceType(
      title: 'Presencial',
      description: 'Trabaja directamente en la oficina.',
      icon: FontAwesomeIcons.buildingUser,
      color: Colors.green.shade600,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFFF8F9FA),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tipo de Lugar de Trabajo',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildHeader(),
            const SizedBox(height: 20),
            Expanded(
              child: _buildWorkplaceList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildContinueButton(),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'Selecciona el tipo de entorno laboral que mejor se ajuste a la vacante.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 17, color: Colors.black54, height: 1.5),
    );
  }

  Widget _buildWorkplaceList() {
    return ListView.builder(
      itemCount: _workplaceTypes.length,
      itemBuilder: (context, index) {
        final type = _workplaceTypes[index];
        final isSelected = _selectedType == type;
        return _buildWorkplaceTile(type, isSelected);
      },
    );
  }

  Widget _buildWorkplaceTile(WorkplaceType type, bool isSelected) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() => _selectedType = type);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? type.color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? type.color : Colors.grey.shade200,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: type.color.withOpacity(0.15),
              child: FaIcon(type.icon, color: type.color, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: type.color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    type.description,
                    style: TextStyle(
                      color: isSelected ? type.color.withOpacity(0.9) : Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Icon(Icons.check_circle, color: type.color, size: 28),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12).copyWith(
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _selectedType == null
            ? null
            : () {
                Navigator.pop(context, _selectedType);
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3E1BFF),
          disabledBackgroundColor: Colors.grey.shade300,
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: const Text(
          'CONFIRMAR',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class WorkplaceType {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const WorkplaceType({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
