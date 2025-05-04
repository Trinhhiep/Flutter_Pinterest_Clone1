
import 'package:pinterest_layout_app/core/base_network_service.dart';
import '../../../data/models/post_model.dart';

class PostRemoteDataSource {
  static const int _pageSize = 10;

  final BaseNetworkService _networkService;

  PostRemoteDataSource(this._networkService);

  Future<List<PostModel>> fetchPosts({int page = 0}) async {
    final response = await _networkService.get(
      'search',
      params: {
        'query': 'nature',
        'per_page': '$_pageSize',
        'page': '${page + 1}', // API Pexels bắt đầu từ 1
      },
    );

    final List photos = response['photos'];

    return photos.map<PostModel>((json) {
      final imageUrl = json['src']['medium']; // hoặc 'original', 'large', etc.
      final width = json['width']?.toDouble() ?? 0;
      final height = json['height']?.toDouble() ?? 0;

      return PostModel(
        title: json['photographer'] ?? 'Unknown',
        imageUrl: imageUrl,
        width: width,
        height: height,
      );
    }).toList();
  }



  
}
