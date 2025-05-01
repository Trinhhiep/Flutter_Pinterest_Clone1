import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../../data/models/post_model.dart';
import '../../../data/repositories/post_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final PostRepository repository;
  final ScrollController scrollController = ScrollController();

  List<PostModel> posts = [];
  bool isLoading = false;
  int _currentPage = 0;
  bool _isFetchingMore = false;
  bool _hasMore = true;

  HomeViewModel(this.repository) {
    fetchData();
    scrollController.addListener(_onScroll);
  }

  bool get isFetchingMore => _isFetchingMore;


  Future<void> fetchData() async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    final newPosts = await repository.getPosts(page: _currentPage);
    posts = newPosts;
    isLoading = false;
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
}
