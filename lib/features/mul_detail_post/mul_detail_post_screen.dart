import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinterest_layout_app/data/models/post_model.dart';
import 'package:pinterest_layout_app/features/detail_post/detail_post_creen.dart';
import 'package:pinterest_layout_app/features/detail_post/detail_post_viewmodel.dart';
import 'package:pinterest_layout_app/features/home/viewmodels/home_viewmodel.dart';
import 'package:pinterest_layout_app/features/home/views/home_screen.dart';
import 'package:pinterest_layout_app/features/mul_detail_post/mul_detail_post_viewmodel.dart';
import 'package:provider/provider.dart';

class MulDetailPostScreen extends StatelessWidget {
  final List<PostModel> posts;
  final int pageIndex;
  final double horizontalPading = 4;

  const MulDetailPostScreen({
    super.key,
    required this.posts,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MulDetailPostViewModel>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.setPage(
        pageIndex,
      ); // ví dụ: chuyển sang trang 1 khi mở màn hình
    });

    return Scaffold(
      body:
      // SafeArea(
      //   top: false,
      //   bottom: false,
      //   child:
      PageView.builder(
        controller: viewModel.pageController,
        itemCount: viewModel.posts.length,
        itemBuilder: (context, index) {
          final post = viewModel.posts[index];

          return ChangeNotifierProvider(
            create:
                (_) => DetailPostViewModel(post), // truyền repository phù hợp
            child: DetailPostScreen(post: post),
          );
        },
      ),
      // ),
    );
  }
}

class MultiDetailScreen extends StatefulWidget {
  final List<PostModel> posts;
  final int initialIndex;
  const MultiDetailScreen({
    Key? key,
    required this.posts,
    required this.initialIndex,
  }) : super(key: key);

  @override
  _MultiDetailScreenState createState() => _MultiDetailScreenState();
}

class _MultiDetailScreenState extends State<MultiDetailScreen> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    // final viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
       backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.posts.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider(
                  create:
                      (_) => DetailPostViewModel(
                        widget.posts[index],
                      ), // truyền repository phù hợp
                  child: DetailPostScreen(post: widget.posts[index]),
                );
        },
      ),
    );
  }
}
