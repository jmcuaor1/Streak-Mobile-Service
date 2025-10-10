import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:gemini_project/models/post_model.dart';
import 'package:gemini_project/models/user_profile_model.dart';
import 'package:gemini_project/presentation/pages/feed_page.dart';
import 'package:gemini_project/providers/post_provider.dart';
import 'package:provider/provider.dart';

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
  // ¡PLUS!: Estado para guardar la imagen seleccionada.
  File? _selectedImage;
  // ¡PLUS!: Estado para guardar el enlace adjunto.
  String? _attachedLink;
  // ¡PLUS!: Estado para guardar el archivo adjunto.
  PlatformFile? _attachedFile;

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

  // ¡PLUS!: Método para seleccionar una imagen de la galería.
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // ¡PLUS!: Método para seleccionar un archivo del dispositivo.
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _attachedFile = result.files.first;
      });
    }
  }

  // ¡PLUS!: Método para mostrar un diálogo y añadir un enlace.
  Future<void> _showAddLinkDialog() async {
    final linkController = TextEditingController();

    final String? link = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Añadir enlace'),
        content: TextField(
          controller: linkController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'https://ejemplo.com',
            prefixIcon: Icon(Icons.link),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final text = linkController.text;
              if (text.isNotEmpty && (text.startsWith('http://') || text.startsWith('https://'))) {
                Navigator.pop(context, text);
              }
              // Opcional: Mostrar un error si la URL no es válida
            },
            child: const Text('Añadir'),
          ),
        ],
      ),
    );

    if (link != null && link.isNotEmpty) {
      setState(() {
        _attachedLink = link;
      });
    }
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
                      // ¡PLUS!: Muestra la vista previa de la imagen si existe.
                      if (_attachedLink != null) _buildLinkPreview(),
                      if (_attachedFile != null) _buildFilePreview(),
                      if (_selectedImage != null) _buildImagePreview(),
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

  // ¡PLUS!: Widget para mostrar la vista previa de la imagen.
  Widget _buildImagePreview() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.file(
              _selectedImage!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedImage = null;
                });
              },
              child: const CircleAvatar(
                backgroundColor: Colors.black54,
                child: Icon(Icons.close, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ¡PLUS!: Widget para mostrar la vista previa del enlace.
  Widget _buildLinkPreview() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: AnyLinkPreview(
              link: _attachedLink!,
              displayDirection: UIDirection.uiDirectionHorizontal,
              showMultimedia: true,
              bodyMaxLines: 3,
              bodyTextOverflow: TextOverflow.ellipsis,
              titleStyle: const TextStyle(fontWeight: FontWeight.bold),
              boxShadow: const [], // Quitamos la sombra por defecto
              removeElevation: true,
              border: Border.all(color: Colors.grey.shade300),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _attachedLink = null;
                });
              },
              child: const CircleAvatar(
                radius: 14,
                backgroundColor: Colors.black54,
                child: Icon(Icons.close, color: Colors.white, size: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ¡PLUS!: Widget para mostrar la vista previa del archivo adjunto.
  Widget _buildFilePreview() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            const Icon(Icons.insert_drive_file_outlined, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _attachedFile!.name,
                style: const TextStyle(color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: () {
                setState(() {
                  _attachedFile = null;
                });
              },
              splashRadius: 20,
            ),
          ],
        ),
      ),
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
        IconButton(
          onPressed: _showImageSourceActionSheet,
          icon: const Icon(Icons.image_outlined, color: Colors.blueAccent, size: 28),
        ),
        IconButton(
          onPressed: _showAddLinkDialog,
          icon: const Icon(Icons.link_outlined, color: Colors.blueAccent, size: 28),
        ),
        IconButton(
          onPressed: _pickFile,
          icon: const Icon(Icons.attach_file_outlined, color: Colors.blueAccent, size: 28),
        ),
      ],
    );
  }

  Widget _buildPublishButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _isButtonEnabled
            ? () {
                // 1. Crear el objeto Post con los datos actuales
                final newPost = Post(
                  author: UserProfile(
                    name: "Juan Miguel Cuao",
                    title: "Desarrollador Flutter Senior",
                    avatarUrl: 'assets/images/avatar.png',
                    email: 'juan.cuao@example.com',
                  ),
                  text: _textController.text,
                  createdAt: DateTime.now(),
                  image: _selectedImage,
                  link: _attachedLink,
                  file: _attachedFile,
                );

                // 2. Añadir el nuevo post a la lista global
                // Usamos context.read para llamar a un método del provider.
                context.read<PostProvider>().addPost(newPost);

                // 3. Navegar a la pantalla del Feed
                // Usamos pushAndRemoveUntil para limpiar el stack de navegación
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const FeedPage()),
                  (Route<dynamic> route) => route.isFirst, // Mantiene solo la HomePage
                );
              }
            : null,
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
