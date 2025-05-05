import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_layout_app/data/models/post_model.dart';
import 'package:pinterest_layout_app/features/detail_post/detail_post_viewmodel.dart';
import 'package:pinterest_layout_app/features/home/views/home_screen.dart';
import 'package:pinterest_layout_app/features/home/widgets/back_button.dart';
import 'package:pinterest_layout_app/features/home/widgets/post_grid.dart';
import 'package:pinterest_layout_app/features/home/widgets/post_tile.dart';
import 'package:pinterest_layout_app/features/mul_detail_post/mul_detail_post_screen.dart';
import 'package:provider/provider.dart';

class DetailPostScreen extends StatelessWidget {
  final PostModel post;
  final double horizontalPading = 4;

  DetailPostScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DetailPostViewModel>(context);
    final topPadding = MediaQuery.of(context).padding.top; // top safe erea
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
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
                    child: Hero(
                      tag: post.id,
                      createRectTween:
                          (begin, end) => RectTween(begin: begin, end: end),
                      child: Material(
                        // 👈 Thêm dòng này để tránh biến dạng
                        color: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: AspectRatio(
                            aspectRatio: post.aspectRatio,
                            child: Image.network(
                              post.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Masonry grid dạng Sliver
                // viewModel.isFirstFetch
                //     ? SliverToBoxAdapter(
                //       child: const Center(child: CupertinoActivityIndicator()),
                //     )
                //     : SliverPadding(
                //       padding: EdgeInsets.only(
                //         top: 0,
                //         left: horizontalPading,
                //         right: horizontalPading,
                //         bottom: 12,
                //       ),
                //       sliver: SliverMasonryGrid.count(
                //         crossAxisCount: 2,
                //         mainAxisSpacing: 8,
                //         crossAxisSpacing: 4,
                //         childCount: viewModel.posts.length,
                //         itemBuilder: (context, index) {
                //           return PostTile(
                //             post: viewModel.posts[index],
                //             onTap: () {
                //               Navigator.of(context).push(
                //                 PageRouteBuilder(
                //                   pageBuilder:
                //                       (_, __, ___) => MultiDetailScreen(
                //                         posts: viewModel.posts,
                //                         initialIndex: index,
                //                       ),
                //                   transitionDuration: const Duration(
                //                     milliseconds: 300,
                //                   ),
                //                   reverseTransitionDuration: const Duration(
                //                     milliseconds: 300,
                //                   ),
                //                   transitionsBuilder:
                //                       (_, __, ___, child) => child,
                //                 ),
                //               );
                //             },
                //           );
                //         },
                //       ),
                //     ),

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
              padding: EdgeInsets.only(top: topPadding + 6, left: 12),
              child: CupertinoBackButton(),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget _buildTile(BuildContext context, int index) {
//   final viewModel = Provider.of<DetailPostViewModel>(context);
//   return GestureDetector(
//     onTap: () {
//       Navigator.of(context).push(
//         PageRouteBuilder(
//           pageBuilder:
//               (_, __, ___) => MultiDetailScreen(
//                 posts: viewModel.posts,
//                 initialIndex: index,
//               ),
//           transitionDuration: Duration(milliseconds: 300),
//           reverseTransitionDuration: Duration(milliseconds: 300),
//           transitionsBuilder: (_, __, ___, child) => child,
//         ),
//       );
//     },
//     child: Hero(
//       tag: viewModel.posts[index].id,
//       createRectTween: (begin, end) => RectTween(begin: begin, end: end),
//       child: AspectRatio(
//         aspectRatio:
//             viewModel.posts[index].aspectRatio, // dùng ratio thay cho height
//         child: Material(
//           // 👈 Thêm dòng này để tránh biến dạng
//           color: Colors.transparent,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               image: DecorationImage(
//                 image: NetworkImage(viewModel.posts[index].imageUrl),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
