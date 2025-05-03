import 'package:flutter/cupertino.dart';
import 'package:pinterest_layout_app/data/models/post_model.dart';
import 'package:pinterest_layout_app/features/detail_post/detail_post_creen.dart';
import 'package:pinterest_layout_app/features/detail_post/detail_post_viewmodel.dart';
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

    return CupertinoPageScaffold(
      child: SafeArea(
        top: false,
        bottom: false,
        child: PageView.builder(
          controller: viewModel.pageController,
          itemCount: viewModel.posts.length,
          itemBuilder: (context, index) {
            final post = viewModel.posts[index];

            return ChangeNotifierProvider(
              create:
                  (_) => DetailPostViewModel(
                    viewModel.repository,
                    post,
                  ), // truyền repository phù hợp
              child: DetailPostScreen(post: post),
            );
          },
        ),
      ),
    );
  }
}
