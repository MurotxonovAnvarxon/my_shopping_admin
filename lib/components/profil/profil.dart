import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileTileCabinet extends StatelessWidget {
  const UserProfileTileCabinet({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/icons/user.png",
          height: 50,
          width: 50,
        ),
        const SizedBox(height: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Salom 👋',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
            Text(
              'Azizbek',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
          ],
        )
      ],
    );
  }
}
