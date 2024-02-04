import 'package:flutter/material.dart';
import 'package:smartcard/app/utils/resource/font_manager.dart';
import 'package:smartcard/app/utils/resource/styles_manager.dart';
import '../color_manager.dart';

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    primaryColor: ColorManager.black,
    drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
    appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: getRegularStyle(fontSize: FontSize.s16, color: ColorManager.white)
    ),
    primaryColorLight: const Color(0XFF6A6969),
    primaryColorDark: Colors.white,
    canvasColor: const Color(0XffF8F6F6));

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.transparent,
  primaryColor: Colors.white,
  primaryColorLight: Colors.white,
  primaryColorDark: Colors.black,
  canvasColor: Colors.black,
  drawerTheme: const DrawerThemeData(backgroundColor: Colors.black),
  appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.black,
      elevation: 0,
      titleTextStyle:
          getRegularStyle(fontSize: FontSize.s16, color: ColorManager.white)),
);
