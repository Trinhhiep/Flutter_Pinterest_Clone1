import 'package:flutter/material.dart';
import '../../../data/models/post_model.dart';

class PostTile extends StatelessWidget {
  final PostModel post;

  const PostTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    print('🖼️ Image URL: ${post.imageUrl}');

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        post.imageUrl,
        fit: BoxFit.cover,

        // 👇 Bắt lỗi khi ảnh không tải được
        errorBuilder: (context, error, stackTrace) {
          print('❌ Lỗi khi tải ảnh: $error');
          return Container(
            color: Colors.grey[300],
            child: const Icon(Icons.error, color: Colors.red),
          );
        },
      ),
    );
  }
}
