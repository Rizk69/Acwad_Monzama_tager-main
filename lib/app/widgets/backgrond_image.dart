import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget imageBackground(context){
  return  Padding(
    padding:  EdgeInsets.all(3.pt),
    child: Center(
      child: Image.asset(
        'assets/images/img.png',
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
      ),
    ),
  );
}