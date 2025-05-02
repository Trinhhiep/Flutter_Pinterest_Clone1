import 'package:flutter/cupertino.dart';
import 'package:pinterest_layout_app/data/models/post_model.dart';
import 'package:pinterest_layout_app/features/detailpost/detaipost_viewmodel.dart';
import 'package:pinterest_layout_app/features/home/widgets/post_grid.dart';
import 'package:pinterest_layout_app/features/home/widgets/post_tile.dart';
import 'package:pinterest_layout_app/routes/app_routes.dart';
import 'package:provider/provider.dart';

class DetailPostScreen extends StatelessWidget {
  final PostModel post;

  const DetailPostScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DetailPostViewModel>(context);
    final topPadding = MediaQuery.of(context).padding.top; // top safe erea
    return CupertinoPageScaffold(
      child: SafeArea(
        top: false,
        child: CustomScrollView(
          controller: viewModel.scrollController,
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(
                top: topPadding,
                left: 12,
                right: 12,
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
                  padding: const EdgeInsets.only(
                    top: 0,
                    left: 12,
                    right: 12,
                    bottom: 12,
                  ),
                  sliver: PostGrid(
                    posts: viewModel.posts,
                    onTap: (index) {
                      Navigator.push(
                        context,
                        _createRoute(viewModel.posts[index]),
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
      ),
    );
  }

  CustomCupertinoPageRoute _createRoute(PostModel post) {
    return CustomCupertinoPageRoute(page: DetailPostScreen(post: post));
  }
}
