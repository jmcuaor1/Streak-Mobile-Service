import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SharePlatform {
  final String name;
  final IconData icon;
  final Color color;

  const SharePlatform({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class SharedAJobPage extends StatefulWidget {
  const SharedAJobPage({super.key});

  @override
  State<SharedAJobPage> createState() => _SharedAJobPageState();
}

class _SharedAJobPageState extends State<SharedAJobPage> {
  final _jobTitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _linkController = TextEditingController();

  SharePlatform? _selectedPlatform;
  bool _isButtonEnabled = false;

  final List<SharePlatform> _platforms = const [
    SharePlatform(name: 'LinkedIn', icon: FontAwesomeIcons.linkedin, color: Color(0xFF0A66C2)),
    SharePlatform(name: 'Twitter (X)', icon: FontAwesomeIcons.xTwitter, color: Color(0xFF000000)),
    SharePlatform(name: 'WhatsApp', icon: FontAwesomeIcons.whatsapp, color: Color(0xFF25D366)),
    SharePlatform(name: 'Correo', icon: FontAwesomeIcons.envelope, color: Color(0xFFEA4335)),
  ];

  @override
  void initState() {
    super.initState();
    _jobTitleController.addListener(_validateForm);
    _descriptionController.addListener(_validateForm);
    _linkController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _jobTitleController.dispose();
    _descriptionController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final bool isFormValid = _jobTitleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _linkController.text.isNotEmpty &&
        _selectedPlatform != null;

    if (isFormValid != _isButtonEnabled) {
      setState(() {
        _isButtonEnabled = isFormValid;
      });
    }
    // Actualiza la vista previa en cada cambio
    setState(() {});
  }

  String _generateShareMessage() {
    return '''
¡Hola! Te comparto esta oportunidad laboral:

*Puesto:* ${_jobTitleController.text}
*Descripción:* ${_descriptionController.text}

*Enlace para aplicar:* ${_linkController.text}
''';
  }

  Future<void> _share() async {
    if (!_isButtonEnabled) return;

    final message = _generateShareMessage();
    final encodedMessage = Uri.encodeComponent(message);
    final subject = Uri.encodeComponent("Oportunidad Laboral: ${_jobTitleController.text}");

    Uri? uri;

    switch (_selectedPlatform!.name) {
      case 'LinkedIn':
        // LinkedIn no tiene un buen esquema de URL para pre-rellenar texto.
        // La mejor opción es abrir la app o la web.
        uri = Uri.parse('https://www.linkedin.com/feed/');
        break;
      case 'Twitter (X)':
        uri = Uri.parse('https://twitter.com/intent/tweet?text=$encodedMessage');
        break;
      case 'WhatsApp':
        uri = Uri.parse('whatsapp://send?text=$encodedMessage');
        break;
      case 'Correo':
        uri = Uri.parse('mailto:?subject=$subject&body=$encodedMessage');
        break;
    }

    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir ${_selectedPlatform!.name}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF8F9FA),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Compartir Empleo',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _jobTitleController,
              label: 'Título del empleo',
              hint: 'Ej. Desarrollador Flutter Junior',
              icon: Icons.work_outline,
            ),
            _buildTextField(
              controller: _descriptionController,
              label: 'Descripción',
              hint: 'Breve descripción de la oportunidad...',
              icon: Icons.description_outlined,
              maxLines: 3,
            ),
            _buildTextField(
              controller: _linkController,
              label: 'Enlace o contacto',
              hint: 'Ej. https://empresa.com/oferta123',
              icon: Icons.link,
            ),
            const SizedBox(height: 24),
            _buildPreviewCard(),
            const SizedBox(height: 24),
            _buildPlatformSelector(),
            const SizedBox(height: 120), // Espacio para el botón flotante
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'Completa los detalles y elige una plataforma para compartir la oportunidad con tu red.',
      style: TextStyle(color: Colors.black54, fontSize: 16, height: 1.5),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("VISTA PREVIA DEL MENSAJE", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent, fontSize: 12)),
          const Divider(height: 20),
          Text(
            _generateShareMessage(),
            style: TextStyle(color: Colors.grey.shade700, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecciona una plataforma:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _platforms.map((platform) {
            final isSelected = _selectedPlatform == platform;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPlatform = platform;
                  _validateForm();
                });
              },
              child: Chip(
                avatar: FaIcon(platform.icon, color: isSelected ? Colors.white : platform.color, size: 18),
                label: Text(platform.name),
                backgroundColor: isSelected ? platform.color : Colors.white,
                labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: isSelected ? platform.color : Colors.grey.shade300),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            );
          }).toList(),
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
      child: ElevatedButton.icon(
        onPressed: _isButtonEnabled ? _share : null,
        icon: const Icon(Icons.share),
        label: const Text('COMPARTIR AHORA'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3E1BFF),
          disabledBackgroundColor: Colors.grey.shade300,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
