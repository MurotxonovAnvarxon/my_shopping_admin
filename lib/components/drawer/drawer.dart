import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shopping_admin/components/cabinet/cabinet_item.dart';
import 'package:my_shopping_admin/components/exit_tile/exit.dart';
import 'package:my_shopping_admin/components/padding/overunderpadding.dart';

import '../back_button/back_button.dart';
import '../profil/profil.dart';

class UserCabinet extends StatefulWidget {
  const UserCabinet({super.key});

  @override
  State<UserCabinet> createState() => _UserCabinetState();
}

class _UserCabinetState extends State<UserCabinet> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(),
      elevation: 0,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.white,
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            16, MediaQuery.of(context).padding.top + 22, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserProfileTileCabinet(),
            const OverUnderPaddingDivider(
              color: Colors.grey,
              topPadding: 12.5,
              bottomPadding: 18,
            ),
            // CabinetActionTile(
            //   onPressed: () {
            //   },
            //   icon:"assets/icons/cashback.png" ,
            //   title: "Keshbek",
            //   trailing: const Text(
            //     "0 so'm",
            //     style: TextStyle(
            //
            //     fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
            // CabinetActionTile(
            //   onPressed: () {
            //   },
            //   icon:"assets/icons/user.png",
            //   title: "Shaxsiy ma'lumotlar",
            //   trailing: AppBackButton(
            //     isForward: true,
            //     onPressed: () {},
            //   ),
            // ),
            // CabinetActionTile(
            //   onPressed: () {
            //   },
            //   icon: "assets/icons/card.png",
            //   title: "Mening kartalarim",
            //   trailing: AppBackButton(
            //     isForward: true,
            //     onPressed: () {},
            //   ),
            // ),
            CabinetActionTile(
              onPressed: () {},
              icon: "assets/icons/locations.png",
              title: "Manzillar",
              trailing: AppBackButton(
                isForward: true,
                onPressed: () {},
              ),
            ),
            // CabinetActionTile(
            //   onPressed: () {
            //   },
            //   icon: "assets/icons/security.png",
            //   title: "Xavfsizlik",
            //   trailing: const Text(
            //     "O'chiq",
            //     style: TextStyle(
            //
            //     fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
            CabinetActionTile(
              onPressed: () {},
              icon: "assets/icons/settings.png",
              title: "Sozlamalar",
              trailing: AppBackButton(
                isForward: true,
                onPressed: () {},
              ),
            ),
            CabinetActionTile(
              onPressed: () {},
              icon: "assets/icons/about.png",
              title: "Biz haqimizda",
            ),
            CabinetActionTile(
              onPressed: () {
                Navigator.pushNamed(context, "sell");
              },
              icon: "assets/icons/help.png",
              title: "Buyurtmalar",
            ),
            CabinetActionTile(
              onPressed: () {},
              icon: "assets/icons/share.png",
              title: "Ulashish",
            ),
            ExitTile(
              onPressed: () {},
            ),
            const Spacer(),
            const Text('Versiya 1.1.0')
          ],
        ),
      ),
    );
  }
}
