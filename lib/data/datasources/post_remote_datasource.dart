import '../../../data/models/post_model.dart';

class PostRemoteDataSource {
  Future<List<PostModel>> fetchPosts() async {
    await Future.delayed(Duration(seconds: 2)); // giả lập call API
    return List.generate(20, (index) => PostModel(
      id: '$index',
      imageUrl: 'https://picsum.photos/id/${index + 10}/200/300',
      title: 'Post $index',
    ));
  }
}
