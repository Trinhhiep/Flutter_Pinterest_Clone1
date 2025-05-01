import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/post_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return CupertinoPageScaffold(
      // navigationBar: const CupertinoNavigationBar(
      //   // middle: Text("Home"),
      // ),
      child: SafeArea(
        child: viewModel.isFirstFetch
            ? const Center(child: CupertinoActivityIndicator())
            : CustomScrollView(
                controller: viewModel.scrollController,
                slivers: [
                  // Pull-to-refresh
                  CupertinoSliverRefreshControl(
                    onRefresh: viewModel.refreshPosts,
                  ),

                  // Masonry grid dạng Sliver
                  SliverPadding(
                    padding: const EdgeInsets.all(12),
                    sliver: SliverMasonryGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childCount: viewModel.posts.length,
                      itemBuilder: (context, index) {
                        return PostTile(post: viewModel.posts[index]);
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
}
