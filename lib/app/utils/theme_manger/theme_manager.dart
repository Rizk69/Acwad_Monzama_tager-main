import 'package:flutter/material.dart';
import 'package:smartcard/app/utils/font_manager.dart';
import 'package:smartcard/app/utils/styles_manager.dart';
import '../color_manager.dart';


ThemeData lightTheme =  ThemeData(
  // main colors
  scaffoldBackgroundColor: Colors.transparent,
  primaryColor: ColorManager.white,

  appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: getRegularStyle(fontSize: FontSize.s16, color: ColorManager.white)
  ),


  // primaryColorLight: ColorManager.lightPrimary,
  // primaryColorDark: ColorManager.darkPrimary,
  // disabledColor: ColorManager.grey1,
  // splashColor: ColorManager.lightPrimary,
  // fontFamily: GoogleFonts.cairo().fontFamily,
  // cardTheme: CardTheme(
  //     color: Colors.transparent,
  //     shadowColor: ColorManager.grey,
  //     elevation: AppSize.s4),
  // // app bar theme
  // appBarTheme: AppBarTheme(
  //     centerTitle: true,
  //     backgroundColor: Colors.transparent,
  //     elevation: 0,
  //     // shadowColor: ColorManager.secondary,
  //     titleTextStyle:
  //     getRegularStyle(fontSize: FontSize.s16, color: ColorManager.white)),
  // // button theme
  // buttonTheme: ButtonThemeData(
  //     shape: const StadiumBorder(),
  //     disabledColor: ColorManager.grey1,
  //     buttonColor: ColorManager.primary,
  //     splashColor: ColorManager.lightPrimary),
  // // elevated button them
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //     style: ElevatedButton.styleFrom(
  //         textStyle: getRegularStyle(
  //             color: ColorManager.white, fontSize: FontSize.s17),
  //         primary: ColorManager.primary,
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(AppSize.s12)))),
  // bottomSheetTheme: BottomSheetThemeData(
  //   backgroundColor: Colors.black.withOpacity(0),
  // ),
  // textTheme: GoogleFonts.cairoTextTheme(),
  // // input decoration theme (text form field)
  // inputDecorationTheme: InputDecorationTheme(
  //     filled: true,
  //     fillColor: ColorManager.input,
  //     // content padding
  //     contentPadding: const EdgeInsets.all(AppPadding.p8),
  //     // hint style
  //     hintStyle:
  //     getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s17),
  //     labelStyle: getMediumStyle(
  //         color: ColorManager.lightGrey, fontSize: FontSize.s17),
  //     errorStyle:
  //     getRegularStyle(color: ColorManager.error, fontSize: FontSize.s12),
  //
  //     // enabled border style
  //     enabledBorder: const OutlineInputBorder(
  //         borderSide:
  //         BorderSide(color: Colors.transparent, width: AppSize.s1_5),
  //         borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
  //
  //     // // focused border style
  //     focusedBorder: const OutlineInputBorder(
  //         borderSide:
  //         BorderSide(color: Colors.transparent, width: AppSize.s1_5),
  //         borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
  //
  //     // // error border style
  //     errorBorder: OutlineInputBorder(
  //         borderSide:
  //         BorderSide(color: ColorManager.error, width: AppSize.s1_5),
  //         borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
  //     // // focused border style
  //     focusedErrorBorder: OutlineInputBorder(
  //         borderSide:
  //         BorderSide(color: ColorManager.error, width: AppSize.s1_5),
  //         borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)))),
  // // label style


);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.red,
  primaryColor: Colors.black,
  appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.black,
      elevation: 0,
      titleTextStyle: getRegularStyle(fontSize: FontSize.s16, color: ColorManager.white)
  ),

);