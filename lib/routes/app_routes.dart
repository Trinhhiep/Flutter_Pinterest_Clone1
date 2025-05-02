import 'package:flutter/cupertino.dart';

class CustomCupertinoPageRoute<T> extends CupertinoPageRoute<T> {
  final Widget page;

  CustomCupertinoPageRoute({required this.page})
      : super(builder: (context) => page);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // Nếu đang pop (vuốt-back), dùng hiệu ứng mặc định để giữ gesture gốc
     return super.buildTransitions(
          context, animation, secondaryAnimation, child);
    // if (animation.status == AnimationStatus.reverse ||
    //     animation.status == AnimationStatus.dismissed) {
    //   return super.buildTransitions(
    //       context, animation, secondaryAnimation, child);
    // }

    // // Khi push: kết hợp slide + fade
    // final slideIn = Tween<Offset>(
    //   begin: const Offset(1.0, 0.0), // từ phải sang
    //   end: Offset.zero,
    // ).animate(CurvedAnimation(
    //   parent: animation,
    //   curve: Curves.easeOut,
    // ));

    // final fadeIn = CurvedAnimation(
    //   parent: animation,
    //   curve: Curves.easeIn,
    // );

    // final transitionChild = SlideTransition(
    //   position: slideIn,
    //   child: FadeTransition(
    //     opacity: fadeIn,
    //     child: child,
    //   ),
    // );

    // // Truyền transitionChild vào super để giữ gesture vuốt-back
    // return super.buildTransitions(
    //     context, animation, secondaryAnimation, transitionChild);
  }
}
