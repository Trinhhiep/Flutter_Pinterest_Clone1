import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoPageRoute<T> extends CupertinoPageRoute<T> {
  final Widget page;

  CustomCupertinoPageRoute({required this.page})
      : super(builder: (context) => page);

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
