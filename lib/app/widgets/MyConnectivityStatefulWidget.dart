import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:smartcard/app/utils/resource/theme_manger/cubit/app_cubit.dart';

import '../../main.dart';

class MyConnectivityStatefulWidget extends StatefulWidget {
  @override
  _MyConnectivityStatefulWidgetState createState() =>
      _MyConnectivityStatefulWidgetState();
}

class _MyConnectivityStatefulWidgetState
    extends State<MyConnectivityStatefulWidget> {
  var previousConnectivityResult;
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    // Get the current connectivity state.
    previousConnectivityResult = await Connectivity().checkConnectivity();

    // Listen for changes in the connectivity state.
    subscription =
        Connectivity().onConnectivityChanged.listen((connectivityResult) async {
      // Handle the connectivity state change.
      if (connectivityResult != previousConnectivityResult) {
        if (connectivityResult == ConnectivityResult.wifi) {
          print("hon");
          print("Connected to WiFi!");
          AppCubit.get(context).sendPaidOfflineToOnline();
          // await dbHelper.getAllInvoices();
        } else if (connectivityResult == ConnectivityResult.mobile) {
          print("Connected to Mobile Data!");
        } else {
          print("Disconnected from the internet!");
        }

        previousConnectivityResult = connectivityResult;
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
