import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/images/lottie/app_loader.json',
        height: 100, width: 100, fit: BoxFit.cover);
  }
}
