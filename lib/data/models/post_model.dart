import 'package:uuid/uuid.dart';

class PostModel {
  final String id = Uuid().v4(); // Tạo id ngẫu nhiên
  final String imageUrl;
  final String title;
  final double width;
  final double height;
  final String category;
  PostModel({
    required this.imageUrl,
    required this.title,
    required this.width,
    required this.height,
    required this.category,
  });
  double get aspectRatio {
    if (width > 0 && height > 0) {
      return width / height;
    }
    return 2 / 3; // fallback nếu không có thông tin về width/height
  }
}
