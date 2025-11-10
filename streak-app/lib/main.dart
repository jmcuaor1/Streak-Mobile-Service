import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'app.dart';
import 'data/services/storage_service.dart';
import 'data/services/api_service.dart';
import 'core/providers.dart';

void main() async {
  // Asegurar que los bindings de Flutter estén inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // Inicializar FlutterSecureStorage
  const secureStorage = FlutterSecureStorage();

  // Crear StorageService
  final storageService = StorageService(
    secureStorage: secureStorage,
    prefs: prefs,
  );

  // Crear ApiService
  final apiService = ApiService(storage: storageService);

  // Ejecutar la app con ProviderScope (Riverpod)
  runApp(
    ProviderScope(
      overrides: [
        // Proveer las instancias de los servicios
        storageServiceProvider.overrideWithValue(storageService),
        apiServiceProvider.overrideWithValue(apiService),
      ],
      child: const StreakApp(),
    ),
  );
}

// Providers globales están en core/providers.dart

