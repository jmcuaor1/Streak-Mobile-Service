import 'package:flutter/material.dart';
import 'package:gemini_project/models/job_model.dart';

class JobNotification {
  final String title;
  final String subtitle;
  final DateTime timestamp;
  final IconData icon;
  final Job relatedJob;
  bool isRead;

  JobNotification({
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.icon,
    required this.relatedJob,
    this.isRead = false,
  });
}