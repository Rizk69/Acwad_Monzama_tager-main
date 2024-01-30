import 'package:flutter/material.dart';

PreferredSizeWidget defaultAppbar({required String title}){
  return AppBar(
    backgroundColor: Colors.transparent,
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