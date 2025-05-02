import 'package:flutter/cupertino.dart';
import 'package:pinterest_layout_app/data/models/post_model.dart';
import 'package:pinterest_layout_app/features/detail_post/detail_post_viewmodel.dart';
import 'package:pinterest_layout_app/features/home/widgets/back_button.dart';
import 'package:pinterest_layout_app/features/home/widgets/post_grid.dart';
import 'package:pinterest_layout_app/features/home/widgets/post_tile.dart';
import 'package:provider/provider.dart';

class DetailPostScreen extends StatelessWidget {
  final PostModel post;
  final double horizontalPading = 4;
  const DetailPostScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DetailPostViewModel>(context);
    final topPadding = MediaQuery.of(context).padding.top; // top safe erea
    return CupertinoPageScaffold(
      child: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            CustomScrollView(
              controller: viewModel.scrollController,
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(
                    top: topPadding,
                    left: horizontalPading,
                    right: horizontalPading,
                    bottom: 12,
                    
                  ),
                  sliver: SliverToBoxAdapter(
                    child: PostTile(post: post, onTap: () {}),
                  ),
                ),
                // Masonry grid dạng Sliver
                viewModel.isFirstFetch
                    ? SliverToBoxAdapter(
                      child: const Center(child: CupertinoActivityIndicator()),
                    )
                    : SliverPadding(
                      padding: EdgeInsets.only(
                        top: 0,
                        left: horizontalPading,
                        right: horizontalPading,
                        bottom: 12,
                      ),
                      sliver: PostGrid(
                        posts: viewModel.posts,
                        onTap: (index) {
                          Navigator.push(
                            context,
                            // _createRoute(viewModel.posts[index]),
                            viewModel.createRoute(viewModel.posts, index),
                          );
                        },
                      ),
                    ),

                // Loading indicator khi load more
                if (viewModel.isFetchingMore)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CupertinoActivityIndicator()),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: topPadding + 6,
                left: 12,
              ),
              child: CupertinoBackButton(),
            ),
          ],
        ),
      ),
    );
  }

  // CustomCupertinoPageRoute _createRoute(PostModel post) {
  //   return CustomCupertinoPageRoute(page: DetailPostScreen(post: post));
  // }
}
