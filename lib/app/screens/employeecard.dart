import 'package:flutter/material.dart';
import 'package:smartcard/app/utils/color_manager.dart';

import '../widgets/nfcemployeescreen.dart';

class EmployeeCard extends StatefulWidget {
  const EmployeeCard({super.key});

  @override
  State<EmployeeCard> createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "بطاقة الموظف",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorManager.primary,
      ),
      body: const NfcEmployeeScreen(),
    );
  }
}
