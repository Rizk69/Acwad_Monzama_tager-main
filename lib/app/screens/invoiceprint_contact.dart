import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcard/app/models/model_keys.dart';

import '../cubits/nfc_contact/nfc_contact_cubit.dart';
import '../utils/color_manager.dart';
import '../utils/routes_manager.dart';
import '../widgets/default_button_widget.dart';
import '../widgets/print_contact.dart';

class InvoicePrintContact extends StatelessWidget {
  const InvoicePrintContact({super.key});

  @override
  Widget build(BuildContext context) {
    final invoiceData = context.read<NfcDataCubit>().state is InvoiceDataLoaded
        ? (context.read<NfcDataCubit>().state as InvoiceDataLoaded).invoice
        : null;
    // final contactData = NfcDataCubit.get(context).savedContact;

    final invoiceId = context.read<NfcDataCubit>().state is InvoiceDataLoaded
        ? (context.read<NfcDataCubit>().state as InvoiceDataLoaded).dataId
        : null;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.primary,
          title: const Center(
            child: Text(
              'طباعة الفاتورة',
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
                      // generateAndPrintArabicPdf(
                      //     invoiceData, contactData, invoiceId!);
                    }),
              ),
            ],
          ),
        ));
  }
}
