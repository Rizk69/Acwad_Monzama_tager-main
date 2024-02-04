import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartcard/app/utils/resource/constants_manager.dart';
import '../../main.dart';
import '../utils/routes_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    appStore.setToken(getStringAsync(TOKEN));
    Timer(const Duration(seconds: 2), () {
      (TOKEN.isNotEmpty && FIRSTLOGIN == 1)
          ? Navigator.of(context).popAndPushNamed(Routes.homeFormRoute)
          : Navigator.of(context).popAndPushNamed(Routes.loginFormRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/MBAG.png', height: 25.h),
          ),
        ],
      ),
    );
  }
}
