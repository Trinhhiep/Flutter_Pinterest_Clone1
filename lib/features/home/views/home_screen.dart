import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_layout_app/core/extension.dart';
import 'package:pinterest_layout_app/features/home/viewmodels/home_viewmodel.dart';
import 'package:pinterest_layout_app/features/mul_detail_post/mul_detail_post_screen.dart';
import 'package:provider/provider.dart';

import '../viewmodels/home_viewmodel.dart';
import '../widgets/post_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final GlobalKey previewKey = GlobalKey();

  Future<ui.Image> captureScreen(GlobalKey key) async {
    final boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) throw Exception("Cannot find render boundary");
    final image = await boundary.toImage(pixelRatio: 2.0);
    return image;
  }

  Future<Uint8List> imageToBytes(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    final topPadding = MediaQuery.of(context).padding.top;
    final double horizontalPadding = 4;

    return Scaffold(
      body: RepaintBoundary(
        key: previewKey,
        child: Container(
          color: Colors.white,
          child: SafeArea(
            top: false,
            child:
                viewModel.isFirstFetch
                    ? const Center(child: CupertinoActivityIndicator())
                    : CustomScrollView(
                      controller: viewModel.scrollController,
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.only(top: topPadding),
                          sliver: CupertinoSliverRefreshControl(
                            onRefresh: viewModel.refreshPosts,
                            refreshTriggerPullDistance: 200.0,
                            refreshIndicatorExtent: 60.0,
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.only(
                            top: 0,
                            left: horizontalPadding,
                            right: horizontalPadding,
                            bottom: 12,
                          ),
                          sliver: SliverMasonryGrid.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 4,
                            childCount: viewModel.posts.length,
                            itemBuilder: (context, index) {
                              return PostTile(
                                key: key,
                                post: viewModel.posts[index],
                                onTap: () async {
                                  final image = await captureScreen(previewKey);
                                  final bytes = await imageToBytes(image);
                                  Navigator.of(context).pushMultiDetailScreen(
                                    viewModel.posts,
                                    index,
                                    bytes,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        if (viewModel.isFetchingMore)
                          const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            ),
                          ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
