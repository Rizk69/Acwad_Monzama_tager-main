import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartcard/app/network/app_api.dart';
import 'package:smartcard/app/screens/login.dart';

import '../../main.dart';
import '../app.dart';
import '../store/app_store.dart';
import '../utils/color_manager.dart';
import '../utils/database_helper.dart';
import '../utils/routes_manager.dart';

class DrawerData extends StatelessWidget {
  const DrawerData({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DrawerItem> drawer = [
      DrawerItem('معلوماتي', Icons.account_circle, () {
        Navigator.pushNamed(context, Routes.profileRoute);
      }),
      DrawerItem('الفواتير', Icons.message, () {
        Navigator.pushNamed(context, Routes.invoicesRoute);
      }),
      DrawerItem('الفواتير اليومية', Icons.notes, () {
        Navigator.pushNamed(context, Routes.dailySalesRoute);
      }),
      DrawerItem('التقارير', Icons.notes, () {
        Navigator.pushNamed(context, Routes.allInvoiceRoute);
      }),
      DrawerItem('تسجيل خروج', Icons.exit_to_app, () async {
        await logout(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
          (Route<dynamic> route) => false,
        );
        // Add onTap logic for 'تسجيل خروج'
      }),
    ];
    return Container(
      color: ColorManager.secondary,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 48, 24, 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.pt),
              child: SvgPicture.asset(
                "assets/images/icon.svg",
                width: 40.w,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            const Divider(
              color: Colors.white54,
            ),
            ListView.builder(
              itemCount: drawer.length,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20, right: 12),
                  child: InkWell(
                    onTap: drawer[index].onTap,
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              drawer[index].icon,
                              color: ColorManager.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              drawer[index].name,
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const Divider(
              color: Colors.white54,
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem {
  final String name;
  final IconData icon;
  final VoidCallback onTap;

  const DrawerItem(this.name, this.icon, this.onTap);
}
