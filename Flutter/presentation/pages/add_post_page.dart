import 'package:flutter/material.dart';
import 'package:gemini_project/models/job_model.dart';
import 'package:gemini_project/presentation/pages/choose_job_type.dart';
import 'package:gemini_project/presentation/pages/job_details_page.dart';

// Nota: He renombrado la clase a `AddJobPage` para que coincida con el nombre del archivo.
class AddJobPage extends StatefulWidget {
  const AddJobPage({super.key});

  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

  final TextEditingController _positionController = TextEditingController();
  // ¡PLUS!: Usamos un controlador para el Dropdown
  final TextEditingController _typeController = TextEditingController(); 
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  // ¡PLUS!: Controladores para los nuevos campos de salario.
  final TextEditingController _minSalaryController = TextEditingController();
  final TextEditingController _maxSalaryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // ¡PLUS!: Listeners para habilitar el botón dinámicamente
    _positionController.addListener(_validateForm);
    _typeController.addListener(_validateForm);
    _locationController.addListener(_validateForm);
    _companyController.addListener(_validateForm);
    _descriptionController.addListener(_validateForm);
    // ¡PLUS!: Listener para re-validar el formulario cuando cambia el salario.
    _minSalaryController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _positionController.dispose();
    _typeController.dispose();
    _locationController.dispose();
    _companyController.dispose();
    _descriptionController.dispose();
    _minSalaryController.dispose();
    _maxSalaryController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  // ¡PLUS!: Navega a la pantalla de selección y actualiza el campo.
  void _navigateToChooseJobType() async {
    // Esperamos el resultado que devuelve la pantalla ChooseJobTypePage
    final result = await Navigator.push<JobType>(
      context,
      MaterialPageRoute(builder: (context) => const ChooseJobTypePage()),
    );

    // Si el usuario seleccionó algo y confirmó...
    if (result != null) {
      _typeController.text = result.title; // Actualizamos el texto del controlador
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar y fondo unificados para un look más limpio
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF8F9FA),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Crear Puesto de Trabajo",
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
        child: Form(
          key: _formKey,
          // Valida automáticamente al interactuar el usuario
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 30),

              // Campos
              _buildInputField(
                controller: _positionController,
                label: "Puesto de trabajo",
                icon: Icons.badge_outlined,
                hint: "Ej: Diseñador UX",
              ),
              // ¡PLUS!: Campo interactivo que abre la pantalla de selección.
              _buildJobTypeField(),
              _buildInputField(
                controller: _locationController,
                label: "Ubicación",
                icon: Icons.location_on_outlined,
                hint: "Ej: Medellín, Colombia",
              ),
              _buildInputField(
                controller: _companyController,
                label: "Empresa",
                icon: Icons.apartment_outlined,
                hint: "Ej: Gemini Labs",
              ),

              // ¡PLUS!: Nuevos campos para el rango salarial.
              _buildSalaryFields(),

              // Descripción
              _buildInputField(
                  controller: _descriptionController,
                  label: "Descripción del trabajo",
                  icon: Icons.description_outlined,
                  hint: "Responsabilidades, requisitos, beneficios...",
                  maxLines: 5),

              const SizedBox(height: 120), // Espacio para el botón flotante
            ],
          ),
        ),
      ),

      // Botón flotante “Publicar”
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Completa los detalles",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color(0xFF333333),
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Publica una nueva oportunidad para la comunidad.",
          style: TextStyle(color: Colors.black54, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(label, icon),
          const SizedBox(height: 12),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Este campo es obligatorio";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSalaryFields() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel("Rango Salarial (Opcional)", Icons.monetization_on_outlined),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _minSalaryController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Mínimo",
                    prefixText: "\$ ",
                    prefixStyle: const TextStyle(color: Colors.black54),
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        _minSalaryController.text.isNotEmpty) {
                      final minSalary = double.tryParse(_minSalaryController.text);
                      final maxSalary = double.tryParse(value);
                      if (minSalary != null && maxSalary != null && maxSalary < minSalary) {
                        return 'Debe ser mayor al mínimo';
                      }
                    }
                    return null;
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _maxSalaryController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Máximo",
                    prefixText: "\$ ",
                    prefixStyle: const TextStyle(color: Colors.black54),
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJobTypeField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel("Tipo de trabajo", Icons.work_history_outlined),
          const SizedBox(height: 12),
          TextFormField(
            controller: _typeController,
            readOnly: true, // Impide que el usuario escriba directamente.
            onTap: _navigateToChooseJobType, // Llama a la función de navegación.
            decoration: InputDecoration(
              hintText: "Selecciona una opción",
              hintStyle: TextStyle(color: Colors.grey.shade400),
              filled: true,
              fillColor: Colors.white,
              suffixIcon: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            validator: (value) {
              return (value == null || value.isEmpty) ? 'Selecciona un tipo de trabajo' : null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 20),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
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
        onPressed: _isFormValid
            ? () {
                if (_formKey.currentState!.validate()) {
                  // 1. Crear el objeto Job con los datos del formulario
                  final newJob = Job(
                    position: _positionController.text,
                    company: _companyController.text,
                    location: _locationController.text,
                    jobType: _typeController.text,
                    description: _descriptionController.text,
                    minSalary: _minSalaryController.text,
                    maxSalary: _maxSalaryController.text,
                  );

                  // 2. Navegar a la pantalla de detalles, pasando el nuevo objeto Job
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => JobDetailsPage(job: newJob)),
                  );
                }
              }
            : null, // El botón está deshabilitado si _isFormValid es false
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
          "PUBLICAR EMPLEO",
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
}
