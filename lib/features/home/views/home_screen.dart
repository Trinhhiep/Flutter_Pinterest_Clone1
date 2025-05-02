import 'package:flutter/cupertino.dart';
import 'package:pinterest_layout_app/features/home/widgets/post_grid.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    final topPadding = MediaQuery.of(context).padding.top; // top safe erea
    final double horizontalPading = 4;
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
                        refreshTriggerPullDistance:
                            200.0, // tăng giá trị này để giảm độ nhạy (mặc định là 100.0)
                        refreshIndicatorExtent:
                            60.0, // chiều cao indicator hiển thị khi đang refresh
                      ),
                    ),

                    // Masonry grid dạng Sliver
                    SliverPadding(
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
                            viewModel.createRoute(viewModel.posts, index),
                            // CupertinoPageRoute(
                            //   builder:
                            //       (_) => DetailPostScreen(
                            //         post: viewModel.posts[index],
                            //       ),
                            // ),
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

//  CustomCupertinoPageRoute _createRoute(PostModel post) {
//   return CustomCupertinoPageRoute(
//     page: DetailPostScreen(post: post),
//   );
// }

}
