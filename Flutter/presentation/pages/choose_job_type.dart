import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ¡PLUS!: Para la retroalimentación táctil
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ¡PLUS!: Modelo de datos para hacer el código más robusto y legible.
class JobType {
  final IconData icon;
  final String title;

  const JobType({required this.icon, required this.title});
}

class ChooseJobTypePage extends StatefulWidget {
  const ChooseJobTypePage({super.key});

  @override
  State<ChooseJobTypePage> createState() => _ChooseJobTypePageState();
}

class _ChooseJobTypePageState extends State<ChooseJobTypePage> {
  JobType? _selectedType;

  // Usamos el nuevo modelo de datos.
  final List<JobType> _jobTypes = const [
    JobType(icon: FontAwesomeIcons.houseLaptop, title: 'Remoto'),
    JobType(icon: FontAwesomeIcons.buildingUser, title: 'Presencial'),
    JobType(icon: FontAwesomeIcons.shuffle, title: 'Híbrido'),
    JobType(icon: FontAwesomeIcons.userClock, title: 'Medio tiempo'),
    JobType(icon: FontAwesomeIcons.solidClock, title: 'Tiempo completo'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Elige el tipo de trabajo',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFFF8F9FA),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildHeader(),
            const SizedBox(height: 24),
            Expanded(
              child: _buildJobTypeList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildConfirmButton(),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'Selecciona la modalidad que mejor se ajuste a la vacante.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 17, color: Colors.black54, height: 1.5),
    );
  }

  Widget _buildJobTypeList() {
    return ListView.builder(
      itemCount: _jobTypes.length,
      itemBuilder: (context, index) {
        final job = _jobTypes[index];
        final isSelected = _selectedType == job;
        return _buildJobTypeTile(job, isSelected);
      },
    );
  }

  Widget _buildJobTypeTile(JobType job, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // ¡PLUS!: Retroalimentación táctil para una mejor UX.
        HapticFeedback.lightImpact();
        setState(() => _selectedType = job);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3E1BFF) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF3E1BFF) : Colors.grey.shade300,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF3E1BFF).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            FaIcon(
              job.icon,
              color: isSelected ? Colors.white : const Color(0xFF3E1BFF),
              size: 22,
            ),
            const SizedBox(width: 20),
            Text(
              job.title,
              style: TextStyle(
                fontSize: 17,
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.white, size: 26),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
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
                // ¡PLUS!: Devuelve el valor seleccionado a la pantalla anterior.
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
          'CONFIRMAR SELECCIÓN',
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
