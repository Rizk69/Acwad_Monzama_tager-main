import 'package:flutter/material.dart';

PreferredSizeWidget defaultAppbar(
    {required String title, required BuildContext context}) {
  return AppBar(
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    title: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    leading: IconButton(
      onPressed: (){
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.arrow_back,
      color: Theme.of(context).primaryColor,
    )),
    centerTitle: true,
  );
}
