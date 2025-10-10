import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadCVScreen extends StatefulWidget {
  const UploadCVScreen({super.key});

  @override
  State<UploadCVScreen> createState() => _UploadCVScreenState();
}

class _UploadCVScreenState extends State<UploadCVScreen> {
  File? selectedFile;   // Guarda el archivo
  String? fileName;     // Guarda el nombre
  bool submitted = false; // Cambia al enviar

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
        fileName = result.files.single.name;
      });
    }
  }

  void removeFile() {
    setState(() {
      selectedFile = null;
      fileName = null;
    });
  }

  void submitApplication() {
    // Aquí conectas con tu API: enviar selectedFile
    setState(() => submitted = true);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subir CV'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: submitted
            ? _SuccessState(tt, cs)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Subir CV', style: tt.titleMedium),
                  const SizedBox(height: 8),
                  selectedFile == null
                      ? OutlinedButton.icon(
                          icon: const Icon(Icons.upload_file),
                          label: const Text('Cargar CV/Resumen'),
                          onPressed: pickFile,
                        )
                      : Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: cs.surfaceVariant,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.picture_as_pdf, color: Colors.red),
                              const SizedBox(width: 12),
                              Expanded(child: Text(fileName ?? '', style: tt.bodyMedium)),
                              IconButton(
                                onPressed: removeFile,
                                icon: const Icon(Icons.delete_outline, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(height: 24),
                  Text('Información', style: tt.titleMedium),
                  const SizedBox(height: 8),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Explica por qué eres la persona adecuada...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: selectedFile == null ? null : submitApplication,
                      style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                      child: const Text('APLICAR AHORA'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _SuccessState(TextTheme tt, ColorScheme cs) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
          const SizedBox(height: 12),
          Text('¡Hecho!', style: tt.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(
            'Felicidades, tu solicitud ha sido enviada',
            style: tt.bodyMedium!.copyWith(color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
            child: const Text('BUSCAR UN EMPLEO SIMILAR'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
            child: const Text('VOLVER AL INICIO'),
          ),
        ],
      ),
    );
  }
}
