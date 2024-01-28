import 'dart:io';

import 'package:flutter/material.dart';

import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smartcard/app/utils/color_manager.dart';

import 'constants_manager.dart';

InputDecoration inputDecoration(BuildContext context,
    {Widget? prefixIcon,
    String? hintText,
    double? borderRadius,
    Widget? preFixIcon,
    Widget? suffixIcon,
    bool labelText = true}) {
  return InputDecoration(
    fillColor: ColorManager.white,
    contentPadding: EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 10),
    labelText: labelText ? hintText : '',
    labelStyle: secondaryTextStyle(),
    alignLabelWithHint: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 0.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: ColorManager.primary, width: 0.0),
    ),
    filled: true,
    prefixIcon: preFixIcon,
    suffixIcon: suffixIcon ?? SizedBox(),
  );
}

String parseHtmlString(String? htmlString) {
  return parse(parse(htmlString).body!.text).documentElement!.text;
}

// String formatDate(String? dateTime,
//     {String format = DATE_FORMAT_4, String format2 = DATE_FORMAT_6}) {
//   if (dateTime.validate().isNotEmpty) {
//     final currentDate = DateTime.now();
//     int currentYear = currentDate.year;
//     int createdAtYear = DateTime.parse(dateTime.validate()).year;

//     if (currentYear == createdAtYear) {
//       return DateFormat(format).format(DateTime.parse(dateTime.validate()));
//     } else {
//       return DateFormat(format2).format(DateTime.parse(dateTime.validate()));
//     }
//   } else {
//     return '';
//   }
// }

String formatDate(String? dateTime) {
  if (dateTime.validate().isNotEmpty) {
    DateTime date = DateTime.parse(dateTime!);
    String formattedDate = DateFormat('EEE, d/M/y HH:mm', 'en').format(date);
    return formattedDate;
  } else {
    return '';
  }
}
