import 'package:gemini_project/models/user_profile_model.dart';

class Comment {
  final UserProfile author;
  final String text;
  final DateTime createdAt;

  Comment({
    required this.author,
    required this.text,
    required this.createdAt,
  });
}