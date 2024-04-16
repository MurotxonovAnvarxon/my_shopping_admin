
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  /// if null pops
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final bool isForward;

  const AppBackButton(
      {this.isForward = false, super.key, this.onPressed, this.padding});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed ?? () => Navigator.of(context).pop(),
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Image.asset("assets/icons/back.png",height: 24,width: 24,),
        ),
      ),
    );
  }
}