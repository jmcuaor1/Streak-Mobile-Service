import 'package:flutter/material.dart';
import 'package:gemini_project/models/user_profile_model.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool _isEditing = false;

  // Simulación de datos de usuario
  late UserProfile _user;

  late TextEditingController _nameController;
  late TextEditingController _titleController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _user = UserProfile(
      name: "Juan Miguel Cuao",
      title: "Desarrollador Flutter Senior",
      email: "juan.cuao@example.com",
      phone: "+57 300 123 4567",
      avatarUrl: 'assets/images/avatar.png',
    );

    _nameController = TextEditingController(text: _user.name);
    _titleController = TextEditingController(text: _user.title);
    _emailController = TextEditingController(text: _user.email);
    _phoneController = TextEditingController(text: _user.phone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      if (_isEditing) {
        // Lógica para guardar los datos
        _user.name = _nameController.text;
        _user.title = _titleController.text;
        _user.email = _emailController.text;
        _user.phone = _phoneController.text;
      }
      _isEditing = !_isEditing;
    });
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
          "Mi Perfil",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _toggleEdit,
            child: Text(
              _isEditing ? "Guardar" : "Editar",
              style: const TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 30),
            _buildInfoCard(
              label: "Nombre Completo",
              controller: _nameController,
              icon: Icons.person_outline,
            ),
            _buildInfoCard(
              label: "Título Profesional",
              controller: _titleController,
              icon: Icons.work_outline,
            ),
            _buildInfoCard(
              label: "Correo Electrónico",
              controller: _emailController,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            _buildInfoCard(
              label: "Teléfono",
              controller: _phoneController,
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 40),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(_user.avatarUrl),
          ),
          if (_isEditing)
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // Lógica para cambiar la imagen
                },
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white, size: 22),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: _isEditing
            ? TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: const TextStyle(color: Colors.blueAccent),
                  prefixIcon: Icon(icon, color: Colors.grey),
                  border: InputBorder.none,
                ),
              )
            : ListTile(
                leading: Icon(icon, color: Colors.grey),
                title: Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                subtitle: Text(
                  controller.text,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return OutlinedButton.icon(
      onPressed: () {
        // Lógica para cerrar sesión
      },
      icon: const Icon(Icons.logout),
      label: const Text("Cerrar Sesión"),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.red,
        minimumSize: const Size(double.infinity, 50),
        side: const BorderSide(color: Colors.red),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}