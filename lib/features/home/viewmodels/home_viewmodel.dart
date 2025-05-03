import 'package:flutter/cupertino.dart';
import 'package:pinterest_layout_app/features/detail_post/detail_post_creen.dart';
import 'package:pinterest_layout_app/features/detail_post/detail_post_viewmodel.dart';
import 'package:pinterest_layout_app/features/mul_detail_post/mul_detail_post_screen.dart';
import 'package:pinterest_layout_app/features/mul_detail_post/mul_detail_post_viewmodel.dart';
import 'package:pinterest_layout_app/routes/app_routes.dart';
import 'package:provider/provider.dart';
import '../../../data/models/post_model.dart';
import '../../../data/repositories/post_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final PostRepository repository;
  final ScrollController scrollController = ScrollController();

  List<PostModel> posts = [];
  bool isFirstFetch = false;
  int _currentPage = 0;
  bool _isFetchingMore = false;
  bool _hasMore = true;

  HomeViewModel(this.repository) {
    fetchData();
    scrollController.addListener(_onScroll);
  }

  bool get isFetchingMore => _isFetchingMore;

  Future<void> refreshPosts() async {
    _currentPage = 0 ;
    notifyListeners();
    // Giả lập lấy lại dữ liệu
    final newPosts = await repository.getPosts(page: _currentPage);
    posts = newPosts;

    print("HomeViewModel pullToRefresh");
    notifyListeners();
  }

  Future<void> fetchData() async {
    _currentPage = 0;
    if (isFirstFetch) return;

    isFirstFetch = true;
    notifyListeners();

    final newPosts = await repository.getPosts(page: _currentPage);
    posts = newPosts;
    isFirstFetch = false;
    notifyListeners();
  }

  Future<void> fetchMore() async {
    if (_isFetchingMore || !_hasMore) return;

    _isFetchingMore = true;
    _currentPage++;

    final morePosts = await repository.getPosts(page: _currentPage);
    if (morePosts.isEmpty) {
      _hasMore = false;
    } else {
      posts.addAll(morePosts);
    }

    _isFetchingMore = false;
    notifyListeners();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 500) {
      fetchMore();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  // CustomCupertinoPageRoute createRoute(List<PostModel> posts, int pageIndex) {
  //   final vm = MulDetailPostViewModel(repository, posts);
  //   return CustomCupertinoPageRoute(
  //     childWidget: MulDetailPostScreen(pageIndex: pageIndex, posts: posts),
  //     provider: vm,
  //   );
  // }
CustomCupertinoPageRoute createRoute(List<PostModel> posts, int pageIndex) {
  return CustomCupertinoPageRoute(
    page: ChangeNotifierProvider(
      create: (_) => MulDetailPostViewModel(repository,posts), // truyền repository của bạn
      child: MulDetailPostScreen(posts: posts, pageIndex: pageIndex),
    ),
  );
}

}


