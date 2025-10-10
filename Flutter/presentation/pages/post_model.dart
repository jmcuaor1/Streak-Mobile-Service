import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:gemini_project/models/user_profile_model.dart';
import 'package:gemini_project/models/comment_model.dart';

class Post {
  final UserProfile author;
  final String text;
  final DateTime createdAt;
  final File? image;
  final String? link;
  final PlatformFile? file;
  int likes;
  bool isLiked;
  final List<Comment> comments;

  Post({
    required this.author,
    required this.text,
    required this.createdAt,
    this.image,
    this.link,
    this.file,
    this.likes = 0,
    this.isLiked = false,
    List<Comment>? comments,
  }) : comments = comments ?? [];
}