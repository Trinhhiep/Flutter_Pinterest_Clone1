
import 'package:pinterest_layout_app/core/base_network_service.dart';
import '../../../data/models/post_model.dart';

class PostRemoteDataSource {
  static const int _pageSize = 10;
  static const String _apiKey = '50056118-d967d8a8e624a6293098c1f2a'; // 👈 Thay bằng API key của bạn

  final BaseNetworkService _networkService;

  PostRemoteDataSource(this._networkService);

  Future<List<PostModel>> fetchPosts({int page = 0, String? category}) async {
  final response = await _networkService.get(
    '',
    params: {
      'key': _apiKey,
      'q': category ?? '', // để trống nếu chưa có category
      'image_type': 'photo',
      'per_page': '$_pageSize',
      'page': '${page + 1}',
    },
  );

  final List hits = response['hits'];

  return hits.map<PostModel>((json) {
    final imageUrl = json['webformatURL'];
    final width = json['imageWidth']?.toDouble() ?? 0;
    final height = json['imageHeight']?.toDouble() ?? 0;

    return PostModel(
      title: json['user'] ?? 'Unknown',
      imageUrl: imageUrl,
      width: width,
      height: height,
      category: json['tags']?.split(',').first ?? 'Uncategorized',
    );
  }).toList();
}
}
