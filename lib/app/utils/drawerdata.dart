import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartcard/app/network/app_api.dart';
import 'package:smartcard/app/screens/auth/login.dart';
import 'package:smartcard/app/utils/resource/color_manager.dart';
import 'routes_manager.dart';

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

      // DrawerItem('تسجيل خروج', Icons.exit_to_app, () async {
      //   await logout(context);
      //   Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => SignInScreen()),
      //     (Route<dynamic> route) => false,
      //   );
      //   // Add onTap logic for 'تسجيل خروج'
      // }),
    ];
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).drawerTheme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.pt),
                  child: Image.asset(
                    "assets/images/icon.png",
                    width: 20.w,
                  )),
              const SizedBox(
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
                      child: SizedBox(
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
                                color: ColorManager.black,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                drawer[index].name,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColorLight,
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
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Color(0XFFEFBB4A),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    elevation: MaterialStateProperty.all<double>(0),
                  ),
                  onPressed: () async {
                    await logout(context).then((value){
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                            (Route<dynamic> route) => false,
                      );
                    });
                  },
                  child: Text(
                    'تسجيل الخروج',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              // const Divider(
              //   color: Colors.black,
              // ),
            ],
          ),
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
