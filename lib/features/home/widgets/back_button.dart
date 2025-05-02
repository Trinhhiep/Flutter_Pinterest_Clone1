import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoBackButton extends StatelessWidget {
  const CupertinoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        color: CupertinoColors.systemGrey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        onPressed: () => Navigator.of(context).pop(),
        child: const Icon(
          CupertinoIcons.back,
          size: 20,
          color: CupertinoColors.white,
        ),
      ),
    );
  }
}
