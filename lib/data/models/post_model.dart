class PostModel {
  final String id;
  final String imageUrl;
  final String title;
  final double width;
  final double height;

  PostModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.width,
    required this.height,
  });
  double get aspectRatio {
    if (width > 0 && height > 0) {
      return width / height;
    }
    return 2 / 3; // fallback nếu không có thông tin về width/height
  }
  // double get aspectRatio {
  //   final regex = RegExp(r'/(\d+)/(\d+)$'); // bắt width & height từ cuối URL
  //   final match = regex.firstMatch(imageUrl);

  //   if (match != null && match.groupCount == 2) {
  //     final width = double.tryParse(match.group(1)!);
  //     final height = double.tryParse(match.group(2)!);
  //     if (width != null && height != null && height != 0) {
  //       return width / height;
  //     }
  //   }

  //   return 2 / 3; // fallback nếu lỗi
  // }
}
