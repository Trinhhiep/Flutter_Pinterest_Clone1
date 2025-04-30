import 'package:flutter/material.dart';
import '../../../data/models/post_model.dart';

class PostTile extends StatelessWidget {
  final PostModel post;

  const PostTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    print('Image URL: ${post.imageUrl}'); // 👈 In ra console
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        post.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
