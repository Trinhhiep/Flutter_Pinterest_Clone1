import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pinterest_layout_app/data/models/post_model.dart';
import 'package:pinterest_layout_app/features/mul_detail_post/mul_detail_post_screen.dart';



extension NavigationExtensions on NavigatorState {
  Future<T?> pushMultiDetailScreen<T>(
    List<PostModel> posts,
    int initialIndex,
    Uint8List bytes,
  ) {
    return push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) =>
            MultiDetailScreen(posts: posts, initialIndex: initialIndex),
        transitionsBuilder: (context, animation, _, child) {
          final screenRect = Rect.fromLTWH(
            0,
            0,
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          );
          final endRect = Rect.fromLTWH(
            - MediaQuery.of(context).size.width * 0.1,
            - MediaQuery.of(context).size.height * 0.1,
            MediaQuery.of(context).size.width  + MediaQuery.of(context).size.width * 0.2,
            MediaQuery.of(context).size.height + MediaQuery.of(context).size.height * 0.2,
          );

          // Dùng Curves.linear cho animation của cả Hero và Zoom
          final linearAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );

          final rectAnimation = RectTween(
            begin: screenRect,
            end: endRect,
          ).animate(linearAnimation);

          final opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(linearAnimation);

          return Stack(
            children: [
              // Zoom nền
              AnimatedBuilder(
                animation: rectAnimation,
                builder: (_, __) {
                  final rect = rectAnimation.value!;
                  return Positioned.fromRect(
                    rect: rect,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16), // Tuỳ chọn
                      child: Image.memory(bytes, fit: BoxFit.cover),
                    ),
                  );
                },
              ),
              // Fade effect
              FadeTransition(opacity: opacityAnimation, child: child),
            ],
          );
        },
      ),
    );
  }
}
class LinearRectTween extends RectTween {
  LinearRectTween({required Rect begin, required Rect end})
      : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    final linearT = Curves.linear.transform(t); // về bản chất: t 그대로
    return Rect.lerp(begin, end, linearT)!;
  }
}