import 'package:flutter/cupertino.dart';
import 'package:pinterest_layout_app/features/mul_detail_post/mul_detail_post_screen.dart';
import 'package:pinterest_layout_app/features/mul_detail_post/mul_detail_post_viewmodel.dart';
import 'package:pinterest_layout_app/routes/app_routes.dart';
import 'package:provider/provider.dart';
import '../../../data/models/post_model.dart';
import '../../../data/repositories/post_repository.dart';

class DetailPostViewModel extends ChangeNotifier {
  final PostRepository repository = PostRepository();
  final ScrollController scrollController = ScrollController();
  final PostModel mainPost;
  List<PostModel> posts = [];
  bool isFirstFetch = false;
  int _currentPage = 0;
  bool _isFetchingMore = false;
  bool _hasMore = true;

  DetailPostViewModel(this.mainPost) {
    fetchData();
    scrollController.addListener(_onScroll);
    print("DetailPostViewModel ===== Init =====");
    print('🧹 ViewModel Init → ${runtimeType}');
  }

  bool get isFetchingMore => _isFetchingMore;

  Future<void> refreshPosts() async {
    _currentPage = 0;
    notifyListeners();
    // Giả lập lấy lại dữ liệu
    final newPosts = await repository.getPosts(page: _currentPage, category: mainPost.category);
    posts = newPosts;

    print("DetailPostViewModel pullToRefresh");
    notifyListeners();
  }

  Future<void> fetchData() async {
    _currentPage = 0;
    if (isFirstFetch) return;

    isFirstFetch = true;
    notifyListeners();

    final newPosts = await repository.getPosts(page: _currentPage, category: mainPost.category);
    posts = newPosts;

    isFirstFetch = false;
    notifyListeners();
  }

  Future<void> fetchMore() async {
    if (_isFetchingMore || !_hasMore) return;

    _isFetchingMore = true;
    _currentPage++;

    final morePosts = await repository.getPosts(page: _currentPage, category: mainPost.category);
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
    print("DetailPostViewModel ===== Dispose =====");
    print('🧹 ViewModel Disposed → ${runtimeType}');
  }



}
