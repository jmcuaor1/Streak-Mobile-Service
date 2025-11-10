import 'package:flutter/material.dart';

// Nota: El nombre del archivo es 'add_a_job.dart' pero la clase es 'AddPostPage'.
// Esto puede ser confuso. Considera renombrar el archivo a 'add_post_page.dart'.
class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _textController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _isButtonEnabled = _textController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      _buildUserInfo(),
                      const SizedBox(height: 24),
                      _buildTextField(),
                    ],
                  ),
                ),
              ),
              _buildBottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFFF8F9FA),
      leading: IconButton(
        icon: const Icon(Icons.close, color: Colors.black87),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Crear Publicación",
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildUserInfo() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/images/avatar.png'),
          radius: 28,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Juan Miguel Cuao",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Compartiendo una actualización",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: _textController,
          maxLines: 8,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "¿Sobre qué quieres hablar?",
            hintStyle: TextStyle(color: Colors.black38, fontSize: 18),
            border: InputBorder.none,
          ),
          style: const TextStyle(fontSize: 18, height: 1.5),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "${_textController.text.length} / 2000",
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
      child: Column(
        children: [
          _buildActionToolbar(),
          const SizedBox(height: 16),
          _buildPublishButton(),
        ],
      ),
    );
  }

  Widget _buildActionToolbar() {
    return Row(
      children: [
        _buildToolbarButton(Icons.image_outlined),
        _buildToolbarButton(Icons.link_outlined),
        _buildToolbarButton(Icons.attach_file_outlined),
      ],
    );
  }

  Widget _buildToolbarButton(IconData icon) {
    return IconButton(
      onPressed: () {
        // TODO: Implementar la lógica para cada botón
      },
      icon: Icon(icon, color: Colors.blueAccent, size: 28),
    );
  }

  Widget _buildPublishButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _isButtonEnabled ? () {} : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          disabledBackgroundColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: const Text(
          "Publicar",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
