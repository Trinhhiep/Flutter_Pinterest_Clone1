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
    final topPadding = MediaQuery.of(context).padding.top; // top safe erea
    return CupertinoPageScaffold(
      // navigationBar: const CupertinoNavigationBar(
      //   // middle: Text("Home"),
      // ),
      child: SafeArea(
        top: false,
        child:
            viewModel.isFirstFetch
                ? const Center(child: CupertinoActivityIndicator())
                : CustomScrollView(
                  controller: viewModel.scrollController,
                  slivers: [
                    // Pull-to-refresh
                    SliverPadding(
                      padding: EdgeInsets.only(top: topPadding),
                      sliver: CupertinoSliverRefreshControl(
                        onRefresh: viewModel.refreshPosts,
                        refreshTriggerPullDistance: 250.0, // tăng giá trị này để giảm độ nhạy (mặc định là 100.0)
                        refreshIndicatorExtent: 60.0, // chiều cao indicator hiển thị khi đang refresh
                      ),
                    ),

                    // Masonry grid dạng Sliver
                    SliverPadding(
                      padding: const EdgeInsets.only(
                        top: 0,
                        left: 12,
                        right: 12,
                        bottom: 12,
                      ),
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
