import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/nfc_employee/nfc_employee_cubit.dart';
import '../utils/color_manager.dart';
import '../utils/routes_manager.dart';
import '../widgets/default_button_widget.dart';
import '../widgets/print_employee.dart';

class InvoicePrintEmployee extends StatelessWidget {
  const InvoicePrintEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    final receiptData = context.read<BalanceCubit>().state is ReceiptDataLoaded
        ? (context.read<BalanceCubit>().state as ReceiptDataLoaded).receipt
        : null;
    final employeeData = BalanceCubit.get(context).savedEmployee;

    final receiptId = context.read<BalanceCubit>().state is ReceiptDataLoaded
        ? (context.read<BalanceCubit>().state as ReceiptDataLoaded).dataId
        : null;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: const Center(
          child: Text(
            'طباعة الوصل',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: defaultButton(
                  context: context,
                  text: "عودة",
                  function: () {
                    Navigator.popAndPushNamed(context, Routes.homeFormRoute);
                  }),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: defaultButton(
                  context: context,
                  text: "طباعة",
                  function: () {
                    generateAndPrintEmployeePdf(
                        receiptData, employeeData, receiptId!);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
