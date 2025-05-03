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
      : super(transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => page,
       transitionsBuilder: (context, animation, secondaryAnimation, child) => 
        FadeTransition(
          opacity: animation,
          child: child,
        ),
      );



}