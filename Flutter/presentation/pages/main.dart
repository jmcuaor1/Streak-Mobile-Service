import 'package:flutter/material.dart';
// Asegúrate de que el path sea correcto después de mover los archivos.
// Y que el nombre del archivo coincida con la clase (home_page.dart).
import 'package:gemini_project/providers/post_provider.dart';
import 'package:gemini_project/providers/job_provider.dart';
import 'package:gemini_project/providers/saved_job_provider.dart';
import 'package:gemini_project/presentation/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos MultiProvider para poder añadir más providers en el futuro.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => JobProvider()),
        ChangeNotifierProvider(create: (_) => SavedJobProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(), // El nombre correcto de la clase es HomePage
      ),
    );
  }
}
