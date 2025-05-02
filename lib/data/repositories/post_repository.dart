import 'package:pinterest_layout_app/core/base_network_service.dart';
import '../models/post_model.dart';
import '../datasources/post_remote_datasource.dart';

class PostRepository {
  final remoteDataSource = PostRemoteDataSource(
    BaseNetworkService(
      baseUrl: 'https://api.pexels.com/v1/',
      defaultHeaders: {
        'Authorization':
            'jLisoOyly4OkH3Ih4hovJEA2KT49eoU0DeZFdh3MxMhpXVCEl1I26z8z',
      },
    ),
  );

  Future<List<PostModel>> getPosts({int page = 0}) {
    return remoteDataSource.fetchPosts(page: page);
  }
}
