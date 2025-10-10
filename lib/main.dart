import 'package:flutter/material.dart';
import 'package:streak/widgets/common/bottom_nav.dart';

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
      home: NavScreen(userName: userName),
      
    );
  }
}