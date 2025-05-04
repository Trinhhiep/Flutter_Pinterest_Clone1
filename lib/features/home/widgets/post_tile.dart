import 'package:flutter/material.dart';
import '../../../data/models/post_model.dart';

class PostTile extends StatefulWidget {
  final PostModel post;
  final VoidCallback? onTap;

  const PostTile({super.key, required this.post, this.onTap});

  @override
  State<PostTile> createState() => _PostTileState(onTap: onTap);
}

class _PostTileState extends State<PostTile> {
  bool _isLoaded = false;
  final VoidCallback? onTap;

  _PostTileState({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.post.id,
      createRectTween: (begin, end) => RectTween(begin: begin, end: end),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Material(
            child: AspectRatio(
              aspectRatio: widget.post.aspectRatio,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // ✅ Placeholder luôn hiển thị trước
                  Image.asset('assets/placeholder.png', fit: BoxFit.cover),

                  // ✅ Image chính sẽ đè lên khi tải xong
                  Opacity(
                    opacity: _isLoaded ? 1.0 : 0.0,
                    child:
                    // Material(
                    //   child:
                    Image.network(
                      widget.post.imageUrl,
                      fit: BoxFit.cover,
                      // ⛔ Không dùng setState ngay lập tức → dùng addPostFrameCallback
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null && !_isLoaded) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted) {
                              setState(() {
                                _isLoaded = true;
                              });
                            }
                          });
                        }
                        return child;
                      },
                      errorBuilder:
                          (context, error, stackTrace) => const Center(
                            child: Icon(Icons.broken_image, color: Colors.red),
                          ),
                    ),
                    // ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
