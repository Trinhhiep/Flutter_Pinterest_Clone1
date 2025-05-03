// import 'package:flutter/cupertino.dart';

// class CustomCupertinoPageRoute<T> extends CupertinoPageRoute<T> {
//   final Widget page;

//   CustomCupertinoPageRoute({required this.page})
//       : super(builder: (context) => page);

//   @override
//   Duration get transitionDuration => const Duration(milliseconds: 300);

// }
import 'package:flutter/cupertino.dart';

class CustomCupertinoPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  CustomCupertinoPageRoute({required this.page})
      : super(
        pageBuilder: (c, a1, a2) => page,
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (c, animation, a2, child) {
          return child;  // Hero sẽ tự động zoom từ đúng vị trí
        },
      );



}