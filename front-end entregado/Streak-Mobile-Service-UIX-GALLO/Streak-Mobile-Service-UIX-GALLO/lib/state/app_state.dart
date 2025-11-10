import 'package:flutter/foundation.dart';

class AppState {
  AppState._();
  static final AppState I = AppState._();

  // Conjuntos de IDs
  final ValueNotifier<Set<String>> appliedJobs = ValueNotifier(<String>{});
  final ValueNotifier<Set<String>> savedJobs   = ValueNotifier(<String>{});

  bool isApplied(String id) => appliedJobs.value.contains(id);
  bool isSaved(String id)   => savedJobs.value.contains(id);

  void toggleApply(String id) {
    final s = Set<String>.from(appliedJobs.value);
    s.contains(id) ? s.remove(id) : s.add(id);
    appliedJobs.value = s;
  }

  void toggleSave(String id) {
    final s = Set<String>.from(savedJobs.value);
    s.contains(id) ? s.remove(id) : s.add(id);
    savedJobs.value = s;
  }
}
