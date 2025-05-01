import 'dart:math';

import '../../../data/models/post_model.dart';

class PostRemoteDataSource {
  static const int _pageSize = 20;

  Future<List<PostModel>> fetchPosts({int page = 0}) async {
    await Future.delayed(Duration(seconds: 2)); // giả lập call API

    final startIndex = page * _pageSize;

    // Hàm random tỷ lệ
    String generateRandomRatioImageUrl(int index) {
      final random = Random();

      // Một số tỷ lệ phổ biến: width / height
      final aspectRatios = [
        1.0,    // 1:1
        4 / 3,  // 4:3
        3 / 4,  // 3:4
        16 / 9, // 16:9
        9 / 16, // 9:16
        2 / 3,  // 2:3
        3 / 2,  // 3:2
      ];

      // Chọn 1 tỷ lệ ngẫu nhiên
      final selectedRatio = aspectRatios[random.nextInt(aspectRatios.length)];

      // Định nghĩa chiều rộng ngẫu nhiên (từ 200 đến 400)
      final width = 200 + random.nextInt(201); // 200 ~ 400
      final height = (width / selectedRatio).round();

      // Trả về URL với id thay đổi và kích thước tuỳ theo ratio
      return 'https://picsum.photos/id/${index + 10}/$width/$height';
    }

    return List.generate(_pageSize, (index) => PostModel(
      id: '${startIndex + index}',
      imageUrl: generateRandomRatioImageUrl(startIndex + index),
      title: 'Post ${startIndex + index}',
    ));
  }
}
