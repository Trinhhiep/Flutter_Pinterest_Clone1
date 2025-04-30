import 'package:flutter/foundation.dart';
import '../../../data/models/post_model.dart';
import '../../../data/repositories/post_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final PostRepository repository;

  List<PostModel> posts = [];
  bool isLoading = false;

  HomeViewModel(this.repository);

  Future<void> fetchPosts() async {
    isLoading = true;
    notifyListeners();

    posts = await repository.getPosts();

    isLoading = false;
    notifyListeners();
  }
}
