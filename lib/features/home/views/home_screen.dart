import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_layout_app/features/detail_post/detail_post_creen.dart';
import 'package:pinterest_layout_app/features/detail_post/detail_post_viewmodel.dart';
import 'package:pinterest_layout_app/features/home/widgets/post_grid.dart';
import 'package:pinterest_layout_app/features/home/widgets/post_tile.dart';
import 'package:pinterest_layout_app/features/mul_detail_post/mul_detail_post_screen.dart';
import 'package:pinterest_layout_app/features/mul_detail_post/mul_detail_post_viewmodel.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    final topPadding = MediaQuery.of(context).padding.top; // top safe erea
    final double horizontalPading = 4;
   
    return Scaffold(
      // appBar: AppBar(title: Text('Gallery')),
      body: SafeArea(
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
                      sliver: SliverMasonryGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 4,
                        childCount: viewModel.posts.length,
                        itemBuilder: (context, index) {
                          return _buildTile(
                            context,
                            index,
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
}

Widget _buildTile(BuildContext context, int index) {
  final viewModel = Provider.of<HomeViewModel>(context);
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder:
              (_, __, ___) => MultiDetailScreen(
                posts: viewModel.posts,
                initialIndex: index,
              ),
          transitionDuration: Duration(milliseconds: 300),
          reverseTransitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (_, __, ___, child) => child,
        ),
      );
    },
    child: Hero(
      tag: viewModel.posts[index].id,
      createRectTween: (begin, end) => RectTween(begin: begin, end: end),
      child: AspectRatio(
        aspectRatio:
            viewModel.posts[index].aspectRatio, // dùng ratio thay cho height
        child: Material(
          // 👈 Thêm dòng này để tránh biến dạng
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(viewModel.posts[index].imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
