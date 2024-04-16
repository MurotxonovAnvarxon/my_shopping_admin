import 'package:flutter/widgets.dart';

class OverUnderPaddingDivider extends StatelessWidget {
  final double topPadding;
  final double bottomPadding;
  final Color? color;

  const OverUnderPaddingDivider({
    super.key,
    this.topPadding = 19,
    this.bottomPadding = 16,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, topPadding, 0, bottomPadding),
      width: double.maxFinite,
      height: 1,
      color: color,
    );
  }
}