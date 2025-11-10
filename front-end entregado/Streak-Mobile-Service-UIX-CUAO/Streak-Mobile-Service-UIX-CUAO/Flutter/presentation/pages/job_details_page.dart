import 'package:flutter/material.dart';
import 'package:gemini_project/models/job_model.dart';
import 'package:intl/intl.dart';

class JobDetailsPage extends StatelessWidget {
  final Job job;

  const JobDetailsPage({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF8F9FA),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Detalles del Empleo",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildHeader(),
            const SizedBox(height: 30),
            _buildKeyDetails(),
            const SizedBox(height: 30),
            _buildDescription(),
            const SizedBox(height: 120), // Espacio para el botón flotante
          ],
        ),
      ),
      bottomNavigationBar: _buildApplyButton(),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          // Placeholder para el logo de la empresa
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(Icons.business_center_outlined, size: 40, color: Colors.blueAccent),
          ),
          const SizedBox(height: 16),
          Text(
            job.position,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${job.company} • ${job.location}",
            style: const TextStyle(color: Colors.black54, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyDetails() {
    // ¡PLUS!: Helper para formatear los números con separadores de miles.
    String _formatSalary(String? salaryString) {
      if (salaryString == null || salaryString.isEmpty) return '';
      final number = double.tryParse(salaryString);
      if (number == null) return salaryString; // Devuelve el original si no es un número
      return NumberFormat("#,##0").format(number);
    }

    // Construye el texto del salario de forma segura
    String salaryText = "No especificado";
    final formattedMin = _formatSalary(job.minSalary);
    final formattedMax = _formatSalary(job.maxSalary);

    if (formattedMin.isNotEmpty && formattedMax.isNotEmpty) {
      salaryText = "\$${formattedMin} - \$${formattedMax}";
    } else if (formattedMin.isNotEmpty) {
      salaryText = "Desde \$${formattedMin}";
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDetailCard(Icons.work_history_outlined, job.jobType),
        const SizedBox(width: 16),
        _buildDetailCard(Icons.monetization_on_outlined, salaryText),
      ],
    );
  }

  Widget _buildDetailCard(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Acerca del trabajo",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          job.description,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildApplyButton() {
    return Builder(
      builder: (context) {
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
            onPressed: () {
              // Lógica para aplicar al trabajo
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3E1BFF),
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Text(
              "APLICAR AHORA",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 0.5,
              ),
            ),
          ),
        );
      }
    );
  }
}