import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final TextEditingController _searchController = TextEditingController();
  String? selectedLocation;

  final List<String> suggestedLocations = [
    'Medellín, Antioquia',
    'Bogotá, Cundinamarca',
    'Cali, Valle del Cauca',
    'Barranquilla, Atlántico',
    'Cartagena, Bolívar',
    'Bucaramanga, Santander',
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
          'Seleccionar Ubicación',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 20),
            _buildCurrentLocationButton(),
            const SizedBox(height: 20),
            const Text(
              'Sugerencias',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            _buildLocationSuggestions(),
          ],
        ),
      ),
      bottomNavigationBar: _buildConfirmButton(),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          hintText: 'Buscar una ciudad o dirección...',
          filled: true,
          fillColor: Colors.white,
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _searchController.clear(),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentLocationButton() {
    return OutlinedButton.icon(
      onPressed: () {
        HapticFeedback.lightImpact();
        setState(() {
          selectedLocation = "Mi Ubicación Actual";
        });
      },
      icon: const Icon(Icons.my_location),
      label: const Text('Usar mi ubicación actual'),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        foregroundColor: Colors.blueAccent,
        side: const BorderSide(color: Colors.blueAccent),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildLocationSuggestions() {
    final query = _searchController.text.toLowerCase();
    final filteredList = suggestedLocations
        .where((loc) => loc.toLowerCase().contains(query))
        .toList();

    return Expanded(
      child: ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final location = filteredList[index];
          final isSelected = selectedLocation == location;

          return GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              setState(() {
                selectedLocation = location;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue.shade50 : Colors.white,
                border: Border.all(
                  color: isSelected ? Colors.blueAccent : Colors.grey.shade300,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.locationDot,
                  color: Colors.blueAccent,
                  size: 20,
                ),
                title: Text(
                  location,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.blueAccent : Colors.black87,
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check_circle, color: Colors.blueAccent)
                    : null,
              ),
            ),
          );
        },
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
        onPressed: selectedLocation != null
            ? () {
                // ¡PLUS!: Devuelve la ubicación seleccionada a la pantalla anterior.
                Navigator.pop(context, selectedLocation);
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          disabledBackgroundColor: Colors.grey[300],
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: const Text(
          'CONFIRMAR UBICACIÓN',
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
