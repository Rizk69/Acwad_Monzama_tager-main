import 'package:flutter/material.dart';
import 'package:smartcard/app/utils/resource/color_manager.dart';

Widget defaultButton(
        {double width = double.infinity,
        Color background = const Color(0xFF69B6C7),
        bool isUpperCase = true,
        double radius = 50.0,
        TextStyle? textStyle,
        required function,
        required text,
        required BuildContext context}) =>
    Container(
      width: width,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(text,
            style: textStyle ??
                Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: ColorManager.white)),
      ),
    );
