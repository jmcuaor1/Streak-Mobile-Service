import 'package:flutter/material.dart';
import 'package:gemini_project/models/job_model.dart';
import 'package:gemini_project/presentation/pages/job_details_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gemini_project/models/job_notification_model.dart';
import 'package:gemini_project/presentation/pages/shared_a_job.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:gemini_project/providers/saved_job_provider.dart';

class SaveJobPage extends StatefulWidget {
  const SaveJobPage({super.key});

  @override
  State<SaveJobPage> createState() => _SaveJobPageState();
}

class _SaveJobPageState extends State<SaveJobPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(() {
      context.read<SavedJobProvider>().filterJobs(_searchController.text);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Mi Biblioteca',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blueAccent,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blueAccent,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'Guardados'),
            Tab(text: 'Notificaciones'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Pestaña de Empleos Guardados
          Consumer<SavedJobProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  _buildSearchBar(),
                  Expanded(
                    child: provider.filteredJobs.isEmpty
                        ? _buildEmptyState()
                        : AnimatedList(
                            key: provider.listKey,
                            initialItemCount: provider.filteredJobs.length,
                            padding: const EdgeInsets.all(16.0),
                            itemBuilder: (context, index, animation) {
                              final job = provider.filteredJobs[index];
                              return _buildAnimatedItem(job, index, animation, provider);
                            },
                          ),
                  ),
                ],
              );
            },
          ),
          // Pestaña de Notificaciones
          _buildNotificationsTab(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Buscar por puesto o empresa...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedItem(Job job, int index, Animation<double> animation, SavedJobProvider provider) {
    return SizeTransition(
      sizeFactor: animation,
      child: Dismissible(
        key: ValueKey(job.position + job.company), // Clave única
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => provider.removeJob(index, job, context),
        background: _buildDismissibleBackground(),
        child: _buildJobCard(job),
      ),
    );
  }

  Widget _buildDismissibleBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 24),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
    );
  }

  Widget _buildJobCard(Job job, {bool isBeingRemoved = false}) {
    String _formatSalary(String? salaryString) {
      if (salaryString == null || salaryString.isEmpty) return '';
      final number = double.tryParse(salaryString);
      if (number == null) return salaryString;
      return NumberFormat("#,##0").format(number);
    }

    String salaryText = "No especificado";
    final formattedMin = _formatSalary(job.minSalary);
    final formattedMax = _formatSalary(job.maxSalary);

    if (formattedMin.isNotEmpty && formattedMax.isNotEmpty) {
      salaryText = "\$${formattedMin} - \$${formattedMax}";
    } else if (formattedMin.isNotEmpty) {
      salaryText = "Desde \$${formattedMin}";
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Stack(
        children: [
          ListTile(
        onTap: isBeingRemoved ? null : () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JobDetailsPage(job: job)),
          );
        },
        contentPadding: const EdgeInsets.all(16),
            leading: const CircleAvatar(
              radius: 26,
              backgroundColor: Color(0xFFE8ECFF),
              child: Icon(Icons.business_center_outlined, color: Colors.blueAccent),
            ),
            title: Text(job.position, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(job.company, style: const TextStyle(color: Colors.black54)),
                  const SizedBox(height: 2),
                  Text(job.location, style: const TextStyle(color: Colors.black45)),
                  const SizedBox(height: 4),
                  Text(
                    salaryText,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blueAccent,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'share') {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SharedAJobPage()));
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(value: 'share', child: Text('Compartir empleo')),
                const PopupMenuItem<String>(value: 'company', child: Text('Ver empresa')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(
              FontAwesomeIcons.bookmark,
              size: 60,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 20),
            const Text(
              'No tienes empleos guardados aún.',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Guarda las oportunidades que te interesen para revisarlas luego.',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

  Widget _buildNotificationsTab() {
    return Consumer<SavedJobProvider>(
      builder: (context, provider, child) {
        return provider.notifications.isEmpty
            ? const Center(child: Text('No tienes notificaciones.'))
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          context.read<SavedJobProvider>().markAllNotificationsAsRead();
                        },
                        child: const Text('Marcar todo como leído'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: provider.notifications.length,
                      itemBuilder: (context, index) {
                        final notification = provider.notifications[index];
                        return _buildNotificationCard(notification, provider);
                      },
                    ),
                  ),
                ],
              );
      },
    );
  }

  Widget _buildNotificationCard(JobNotification notification, SavedJobProvider provider) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: notification.isRead ? Colors.white : const Color(0xFFE8F0FE),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: notification.isRead ? Colors.grey.shade200 : Colors.blue.shade200),
      ),
      child: ListTile(
        onTap: () {
          provider.markNotificationAsRead(notification);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JobDetailsPage(job: notification.relatedJob)),
          );
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: notification.isRead ? Colors.grey.shade200 : Colors.blue.shade100,
          child: Icon(notification.icon, color: notification.isRead ? Colors.grey.shade600 : Colors.blueAccent),
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: notification.isRead ? Colors.black87 : Colors.blue.shade800,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(notification.subtitle, style: TextStyle(color: notification.isRead ? Colors.black54 : Colors.black87)),
            const SizedBox(height: 8),
            Text(
              DateFormat('d MMM, hh:mm a').format(notification.timestamp),
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
