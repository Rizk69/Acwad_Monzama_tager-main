import 'package:flutter/material.dart';

PreferredSizeWidget defaultAppbar({required String title , required BuildContext context}){
  return AppBar(
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    title:  Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,

  );
}