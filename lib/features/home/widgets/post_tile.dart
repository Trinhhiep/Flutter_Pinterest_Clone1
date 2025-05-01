import 'package:flutter/material.dart';
import '../../../data/models/post_model.dart';

class PostTile extends StatefulWidget {
  final PostModel post;

  const PostTile({super.key, required this.post});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  double? _aspectRatio;

  @override
  void initState() {
    super.initState();
    _getImageAspectRatio(widget.post.imageUrl);
  }

  void _getImageAspectRatio(String url) {
    final image = Image.network(url);
    image.image
        .resolve(const ImageConfiguration())
        .addListener(
          ImageStreamListener((ImageInfo info, bool _) {
            final width = info.image.width.toDouble();
            final height = info.image.height.toDouble();

            if (mounted) {
              setState(() {
                _aspectRatio = width / height;
                print(_aspectRatio);
                print(url);
              });
            }
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    final ratio = _aspectRatio ?? 2 / 3; // fallback tạm thời

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: ratio,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/placeholder.png',
              image: widget.post.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          // const SizedBox(height: 8),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8),
          //   child: Text(
          //     widget.post.title,
          //     style: const TextStyle(fontSize: 14),
          //   ),
          // ),
          // const SizedBox(height: 8),
        ],
      ),
    );
  }
}
