import 'package:flutter/cupertino.dart';
import 'package:pinterest_layout_app/features/detail_post/detail_post_creen.dart';
import 'package:pinterest_layout_app/features/mul_detail_post/mul_detail_post_screen.dart';
import 'package:pinterest_layout_app/routes/app_routes.dart';
import 'package:provider/provider.dart';
import '../../../data/models/post_model.dart';
import '../../../data/repositories/post_repository.dart';

class MulDetailPostViewModel extends ChangeNotifier {
  final PostRepository repository = PostRepository();
  final PageController pageController = PageController();
  final List<PostModel> posts;

  MulDetailPostViewModel(this.posts) {
    pageController.addListener(_onScroll);
  }
  void setPage(int index) {
    pageController.jumpToPage(index);
  }

  void _onScroll() {
    if (pageController.position.pixels >=
        pageController.position.maxScrollExtent - 500) {}
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

}
