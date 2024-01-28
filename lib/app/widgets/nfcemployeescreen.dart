import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:typed_data';
import '../../main.dart';
import '../cubits/nfc_employee/nfc_employee_cubit.dart';
import '../models/model_keys.dart';
import '../utils/routes_manager.dart';

class NfcEmployeeScreen extends StatefulWidget {
  const NfcEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<NfcEmployeeScreen> createState() => _NfcEmployeeScreenState();
}

class _NfcEmployeeScreenState extends State<NfcEmployeeScreen> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  bool isNfcAvailable = false;

  @override
  void initState() {
    checkNfcAvailability();
    super.initState();
    _tagRead();
  }

  Future<void> checkNfcAvailability() async {
    try {
      isNfcAvailable = await NfcManager.instance.isAvailable();

      setState(() {});
    } catch (e) {
      // Handle the error when checking NFC availability
      setState(() {
        isNfcAvailable = false;
      });
      print('Error checking NFC availability: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isNfcAvailable
            ? Flex(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                direction: Axis.vertical,
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/card.png',
                    ),
                  )
                ],
              )
            : Center(child: Text('NFC is not available')),
      ),
    );
  }

  @override
  void dispose() {
    NfcManager.instance.stopSession();
    super.dispose();
  }

  void _tagRead() {
    final balanceCubit = context.read<BalanceCubit>();
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      try {
        result.value = tag.data;

        if (tag.data.containsKey('nfca')) {
          Uint8List identifier = tag.data['nfca']['identifier'];
          var idWithReverse = identifier.reversed
              .map((b) => b.toRadixString(16).padLeft(2, '0'))
              .join('')
              .toUpperCase();
          print('serial number (newHex): $idWithReverse');
          int serialNumberDec = int.parse(idWithReverse, radix: 16);
          print('serial number (dec): $serialNumberDec');
          EmployeeData? employee =
              await dbHelper.getEmployeeById(serialNumberDec.toString());
          if (employee != null) {
            balanceCubit.setEmployee(employee);
            Navigator.popAndPushNamed(context, Routes.balanceWithdrawalRoute);
          } else {
            toast("لايوجد حساب مرتبط بهذه البطاقة");
            setState(() {}); // Reload the page
          }
        }
      } catch (e) {
        // Handle the error that occurred during NFC tag read
        print('Error reading NFC tag: $e');
      } finally {
        NfcManager.instance.stopSession();
        _tagRead(); // Start a new session
      }
    });
  }
}
