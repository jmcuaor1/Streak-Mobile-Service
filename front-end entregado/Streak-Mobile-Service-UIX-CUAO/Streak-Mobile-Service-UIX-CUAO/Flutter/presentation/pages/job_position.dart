import 'package:flutter/material.dart';
import 'package:gemini_project/models/job_model.dart';
import 'package:gemini_project/presentation/pages/job_details_page.dart';

class JobPositionScreen extends StatefulWidget {
  const JobPositionScreen({super.key});

  @override
  State<JobPositionScreen> createState() => _JobPositionScreenState();
}

class _JobPositionScreenState extends State<JobPositionScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;

  final List<String> _categories = [
    'Software Engineer',
    'UI/UX Designer',
    'Data Analyst',
    'Marketing Specialist',
    'Project Manager',
    'Customer Support',
  ];

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_validateForm);
    _descriptionController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
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
          "Crear Posición",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              _buildHeader(),
              const SizedBox(height: 30),
              _buildInputField(
                controller: _titleController,
                label: "Título del Puesto",
                icon: Icons.work_outline,
              ),
              const SizedBox(height: 20),
              _buildInputField(
                controller: _descriptionController,
                label: "Descripción del Puesto",
                icon: Icons.description_outlined,
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              _buildCategoryDropdown(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Crea una Posición",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF333333)),
        ),
        SizedBox(height: 8),
        Text(
          "Completa los detalles para publicar una nueva posición de trabajo.",
          style: TextStyle(color: Colors.black54, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Este campo es obligatorio";
        }
        return null;
      },
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "Categoría del Puesto",
        prefixIcon: const Icon(Icons.category_outlined, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      value: _selectedCategory,
      items: _categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value;
          _validateForm();
        });
      },
      validator: (value) {
        if (value == null) {
          return "Por favor selecciona una categoría";
        }
        return null;
      },
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
                  // ¡PLUS!: Creamos un objeto Job y navegamos a los detalles.
                  final newJob = Job(
                    position: _titleController.text,
                    description: _descriptionController.text,
                    jobType: _selectedCategory!,
                    // Datos de ejemplo para los campos faltantes
                    company: 'Mi Empresa',
                    location: 'Ubicación por definir',
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobDetailsPage(job: newJob),
                    ),
                  );
                }
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          disabledBackgroundColor: Colors.grey.shade300,
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: const Text(
          "Guardar Posición",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
