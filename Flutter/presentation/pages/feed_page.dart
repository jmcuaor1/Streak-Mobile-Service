import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:gemini_project/models/post_model.dart';
import 'package:gemini_project/models/comment_model.dart';
import 'package:gemini_project/models/user_profile_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:gemini_project/providers/post_provider.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    // Usamos Consumer para escuchar los cambios en PostProvider.
    // El widget se reconstruirá automáticamente cuando notifyListeners() sea llamado.
    return Consumer<PostProvider>(
      builder: (context, postProvider, child) {
        final displayedPosts = postProvider.posts;
        return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Feed de la Comunidad",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: displayedPosts.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: displayedPosts.length,
              itemBuilder: (context, index) {
                return _buildPostCard(displayedPosts[index]);
              },
            ),
        );
      },
    );
  }

  Widget _buildPostCard(Post post) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostHeader(post),
            const SizedBox(height: 16),
            if (post.text.isNotEmpty)
              Text(
                post.text,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            if (post.text.isNotEmpty) const SizedBox(height: 16),
            if (post.image != null) _buildImagePreview(post),
            if (post.link != null) _buildLinkPreview(post),
            if (post.file != null) _buildFilePreview(post),
            const Divider(height: 32),
            _buildPostActions(post),
          ],
        ),
      ),
    );
  }

  Widget _buildPostHeader(Post post) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(post.author.avatarUrl),
          radius: 24,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.author.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              DateFormat('d MMM yyyy, hh:mm a').format(post.createdAt),
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImagePreview(Post post) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Image.file(post.image!, fit: BoxFit.cover, width: double.infinity),
      ),
    );
  }

  Widget _buildLinkPreview(Post post) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: AnyLinkPreview(
        link: post.link!,
        displayDirection: UIDirection.uiDirectionHorizontal,
        showMultimedia: true,
        bodyMaxLines: 3,
        removeElevation: true,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: 12,
      ),
    );
  }

  Widget _buildFilePreview(Post post) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            const Icon(Icons.insert_drive_file_outlined, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                post.file!.name,
                style: const TextStyle(color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostActions(Post post) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton.icon(
          onPressed: () => context.read<PostProvider>().toggleLike(post),
          icon: Icon(
            post.isLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
            color: post.isLiked ? Colors.blueAccent : Colors.grey,
          ),
          label: Text(
            'Me gusta (${post.likes})',
            style: TextStyle(
              color: post.isLiked ? Colors.blueAccent : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton.icon(
          onPressed: () => _showCommentsSheet(post),
          icon: const Icon(Icons.comment_outlined, color: Colors.grey),
          label: Text(
            'Comentar (${post.comments.length})',
            style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void _showCommentsSheet(Post post) {
    final commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Permite que el sheet ocupe más altura
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  children: [
                    const Text('Comentarios', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Divider(height: 24),
                    Expanded(
                      child: post.comments.isEmpty
                          ? const Center(child: Text('No hay comentarios aún.'))
                          : ListView.builder(
                              itemCount: post.comments.length,
                              itemBuilder: (context, index) {
                                final comment = post.comments[index];
                                // Simulación: "Juan Miguel Cuao" es el usuario actual.
                                final isCurrentUserComment = comment.author.name == "Juan Miguel Cuao";

                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: AssetImage(comment.author.avatarUrl),
                                  ),
                                  title: Text(comment.author.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Text(comment.text),
                                  trailing: isCurrentUserComment
                                      ? PopupMenuButton<String>(
                                          onSelected: (value) {
                                            if (value == 'edit') {
                                              _showEditCommentDialog(context, post, comment, setModalState);
                                            } else if (value == 'delete') {
                                              _showDeleteConfirmationDialog(context, post, comment, setModalState);
                                            }
                                          },
                                          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                            const PopupMenuItem<String>(value: 'edit', child: Text('Editar')),
                                            const PopupMenuItem<String>(value: 'delete', child: Text('Eliminar')),
                                          ],
                                        )
                                      : null,
                                );
                              },
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: commentController,
                              decoration: InputDecoration(
                                hintText: 'Añade un comentario...',
                                filled: true,
                                fillColor: const Color(0xFFF0F2F5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send, color: Colors.blueAccent),
                            onPressed: () {
                              if (commentController.text.isNotEmpty) {
                                final newComment = Comment(
                                  author: UserProfile( // Simulación del usuario actual
                                    name: "Juan Miguel Cuao",
                                    avatarUrl: 'assets/images/avatar.png',
                                    email: 'juan.cuao@example.com',
                                    title: 'Desarrollador Flutter Senior',
                                  ),
                                  text: commentController.text,
                                  createdAt: DateTime.now(),
                                );

                                // Actualiza el estado del modal y de la página principal
                                context.read<PostProvider>().addComment(post, newComment);
                                setModalState(() {}); // Solo para reconstruir el modal
                                commentController.clear();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showEditCommentDialog(BuildContext pageContext, Post post, Comment comment, StateSetter setModalState) async {
    final editController = TextEditingController(text: comment.text);
    final updatedText = await showDialog<String>(
      context: pageContext,
      builder: (context) => AlertDialog(
        title: const Text('Editar comentario'),
        content: TextField(
          controller: editController,
          autofocus: true,
          maxLines: null,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, editController.text);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );

    if (updatedText != null && updatedText.isNotEmpty) {
      context.read<PostProvider>().editComment(comment, updatedText);
      setModalState(() {}); // Reconstruye el modal
    }
  }

  void _showDeleteConfirmationDialog(BuildContext pageContext, Post post, Comment comment, StateSetter setModalState) async {
    final bool? confirmed = await showDialog<bool>(
      context: pageContext,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar comentario'),
        content: const Text('¿Estás seguro de que quieres eliminar este comentario? Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // Actualiza el estado del modal y de la página principal
      context.read<PostProvider>().deleteComment(post, comment);
      setModalState(() {}); // Reconstruye el modal

      ScaffoldMessenger.of(pageContext).showSnackBar(
        const SnackBar(content: Text('Comentario eliminado.')),
      );
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.dynamic_feed_rounded, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text(
            "El feed está vacío",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          const Text(
            "Sé el primero en publicar un consejo.",
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}