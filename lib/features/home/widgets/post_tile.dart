import 'package:flutter/material.dart';
import '../../../data/models/post_model.dart';

class PostTile extends StatefulWidget {
  final PostModel post;

  const PostTile({super.key, required this.post});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  bool _isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: AspectRatio(
        aspectRatio: widget.post.aspectRatio,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ✅ Placeholder luôn hiển thị trước
            Image.asset(
              'assets/placeholder.png',
              fit: BoxFit.cover,
            ),

            // ✅ Image chính sẽ đè lên khi tải xong
            Opacity(
              opacity: _isLoaded ? 1.0 : 0.0,
              child: Image.network(
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
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import '../../../data/models/post_model.dart';

// class PostTile extends StatefulWidget {
//   final PostModel post;

//   const PostTile({super.key, required this.post});

//   @override
//   State<PostTile> createState() => _PostTileState();
// }

// class _PostTileState extends State<PostTile> {
//   double? _aspectRatio;

//   @override
//   void initState() {
//     super.initState();
//     _getImageAspectRatio(widget.post.imageUrl);
//   }

//   void _getImageAspectRatio(String url) {
//     final image = Image.network(url);
//     image.image
//         .resolve(const ImageConfiguration())
//         .addListener(
//           ImageStreamListener((ImageInfo info, bool _) {
//             final width = info.image.width.toDouble();
//             final height = info.image.height.toDouble();

//             if (mounted) {
//               setState(() {
//                 _aspectRatio = width / height;
//                 print(_aspectRatio);
//                 print(url);
//               });
//             }
//           }),
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ratio = _aspectRatio ?? 2 / 3; // fallback tạm thời

//     return ClipRRect(
//       borderRadius: BorderRadius.circular(8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           AspectRatio(
//             aspectRatio: ratio,
//             child: FadeInImage.assetNetwork(
//               placeholder: 'assets/placeholder.png',
//               image: widget.post.imageUrl,
//               fit: BoxFit.cover,
//               width: double.infinity,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
