import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/data/services/api_service.dart';
import 'package:streak/data/services/storage_service.dart';

/// Proveedores globales de servicios
final storageServiceProvider = Provider<StorageService>((ref) {
  throw UnimplementedError();
});

final apiServiceProvider = Provider<ApiService>((ref) {
  throw UnimplementedError();
});


