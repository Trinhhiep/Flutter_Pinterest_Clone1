import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_layout_app/data/models/post_model.dart';
import 'package:pinterest_layout_app/features/home/widgets/post_tile.dart';

class PostGrid extends StatelessWidget {
  final List<PostModel> posts;
  final Function(int) onTap;

  const PostGrid({required this.posts, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return SliverMasonryGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 4,
        childCount: posts.length,
        itemBuilder: (context, index) {
          return PostTile(
            post: posts[index],
            onTap: () => onTap(index),
          );
        },
      );
  }
}
