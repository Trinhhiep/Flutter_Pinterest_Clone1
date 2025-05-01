import '../models/post_model.dart';
import '../datasources/post_remote_datasource.dart';

class PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepository(this.remoteDataSource);

  Future<List<PostModel>> getPosts({int page = 0}) {
    return remoteDataSource.fetchPosts(page: page);
  }
}
