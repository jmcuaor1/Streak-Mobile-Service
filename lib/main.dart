import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {

  String usuarioLogueado = "Carlos"; // Variable para tomar el usuario logeado y saludarlo en el home 

  runApp(StreakApp(userName: usuarioLogueado));
}

class StreakApp extends StatelessWidget {
  final String userName;
  const StreakApp({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Streak Jobs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2F6FED)),
        useMaterial3: true,
      ),
      // Le pasamos el nombre del usuario a la pantalla del home
      home: HomeScreen(userName: userName),
    );
  }
}