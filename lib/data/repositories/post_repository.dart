import 'package:pinterest_layout_app/core/base_network_service.dart';
import '../models/post_model.dart';
import '../datasources/post_remote_datasource.dart';

class PostRepository {
  final remoteDataSource = PostRemoteDataSource(
    BaseNetworkService(
      baseUrl: 'https://pixabay.com/api/',
      defaultHeaders: {}, // ❌ Pixabay không cần header
    ),
  );

  Future<List<PostModel>> getPosts({int page = 0, String? category}) {
    return remoteDataSource.fetchPosts(page: page, category: category);
  }
}

// Future<List<PostModel>> getPostsByQuery({String? tag, String? category}) {