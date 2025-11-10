import 'package:flutter/material.dart';
import 'package:gemini_project/models/company_model.dart';
import 'package:gemini_project/models/job_model.dart';
import 'package:gemini_project/presentation/pages/job_details_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyPage extends StatefulWidget {
  // ¡PLUS!: La página ahora acepta un objeto Company para ser dinámica.
  final Company company;

  const CompanyPage({super.key, required this.company});

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos un CustomScrollView para un efecto de AppBar que se encoge.
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeaderSection(),
            const SizedBox(height: 24),
            _buildAboutSection(),
            const SizedBox(height: 24),
            _buildJobOffersSection(),
            const SizedBox(height: 24),
            _buildContactSection(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- Encabezado con logo e info ---
  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: const Text('Perfil de Empresa', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.grey.shade200,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Image.network(widget.company.logoUrl, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.company.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.company.industry,
            style: const TextStyle(color: Colors.black54, fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              setState(() => isFollowing = !isFollowing);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isFollowing ? Colors.blue.shade50 : Colors.blueAccent,
              foregroundColor: isFollowing ? Colors.blueAccent : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              elevation: 0,
            ),
            icon: Icon(isFollowing ? Icons.check : Icons.add, size: 20),
            label: Text(isFollowing ? 'Siguiendo' : 'Seguir', style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // --- Sección "Sobre la empresa" ---
  Widget _buildAboutSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sobre la Empresa',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.company.about,
            style: const TextStyle(color: Colors.black54, fontSize: 16, height: 1.6),
          ),
        ],
      ),
    );
  }

  // --- Sección de ofertas disponibles ---
  Widget _buildJobOffersSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ofertas Disponibles (${_CompanyPageState})',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            itemCount: widget.company.openJobs.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildJobCard(widget.company.openJobs[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildJobCard(Job job) {
    return GestureDetector(
      onTap: () {
        // ¡PLUS!: Navega a la página de detalles real.
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JobDetailsPage(job: job)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            const Icon(Icons.work_outline, color: Colors.blueAccent, size: 28),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.position,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${job.jobType} • ${job.location}",
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // --- Sección de contacto / redes ---
  Widget _buildContactSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contacto y Redes',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (widget.company.linkedinUrl != null)
                _contactIcon(FontAwesomeIcons.linkedin, Colors.blue.shade700, 'LinkedIn', widget.company.linkedinUrl!),
              if (widget.company.websiteUrl != null)
                _contactIcon(FontAwesomeIcons.globe, Colors.green, 'Página Web', widget.company.websiteUrl!),
              if (widget.company.instagramUrl != null)
                _contactIcon(FontAwesomeIcons.instagram, Colors.pink, 'Instagram', widget.company.instagramUrl!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contactIcon(IconData icon, Color color, String label, String url) {
    return GestureDetector(
      onTap: () async {
        // ¡PLUS!: Abre la URL real.
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color.withOpacity(0.1),
            child: FaIcon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.black54)),
        ),
      ),
    );
  }
}
