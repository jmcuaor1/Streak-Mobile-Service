import 'package:flutter/foundation.dart';
import 'package:gemini_project/models/comment_model.dart';
import 'package:gemini_project/models/post_model.dart';

class PostProvider with ChangeNotifier {
  // La lista de posts ahora es privada y vive dentro del Provider.
  final List<Post> _posts = [];

  // Un getter público para que los widgets puedan acceder a la lista.
  // Se devuelve una copia invertida para mostrar los más nuevos primero.
  List<Post> get posts => List.from(_posts.reversed);

  void addPost(Post post) {
    _posts.add(post);
    // Notifica a todos los widgets que están escuchando que los datos han cambiado.
    notifyListeners();
  }

  void toggleLike(Post post) {
    post.isLiked = !post.isLiked;
    post.isLiked ? post.likes++ : post.likes--;
    notifyListeners();
  }

  void addComment(Post post, Comment comment) {
    post.comments.add(comment);
    notifyListeners();
  }

  void editComment(Comment comment, String newText) {
    // Como el objeto Comment se pasa por referencia, podemos modificarlo directamente.
    comment.text = newText;
    notifyListeners();
  }

  void deleteComment(Post post, Comment comment) {
    post.comments.remove(comment);
    notifyListeners();
  }
}