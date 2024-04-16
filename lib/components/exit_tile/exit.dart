import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class ExitTile extends StatelessWidget {
  final VoidCallback onPressed;

  const ExitTile({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          const SizedBox(height: 16),
          Transform.rotate(
            angle: -math.pi, // Rasmni 90 gradusda aylanib chiqarish
            child: Image.asset(
              "assets/icons/exit.png",
              height: 40,
              width: 40,
            ),
          ),
          const SizedBox(height: 25),
          Expanded(
            child: Text(
              'Chiqish',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
