
import 'package:flutter/material.dart';
import 'package:my_shopping_admin/components/padding/overunderpadding.dart';

class CabinetActionTile extends StatelessWidget {
  final String title;
  final String icon;
  final Widget? trailing;
  final VoidCallback onPressed;

  const CabinetActionTile({
    super.key,
    required this.title,
    required this.icon,
    this.trailing,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(height: 16),
              Image.asset(icon,height: 24,width: 24,),
              const SizedBox(height: 25),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              trailing ?? const SizedBox.shrink(),
            ],
          ),
          OverUnderPaddingDivider(
            color: Colors.grey,
            // color: AppTheme.green,
            // topPadding: 18,
            topPadding: 16,
            // bottomPadding: 18,
            bottomPadding: 16,
          ),
        ],
      ),
    );
  }
}
