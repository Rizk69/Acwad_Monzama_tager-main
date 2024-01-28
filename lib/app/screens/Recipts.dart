import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcard/app/cubits/Reports/reports_cubit.dart';
import 'package:smartcard/app/models/invoice_beneficary.dart';
import 'package:smartcard/app/screens/Reciptdetails.dart';
import '../models/model_keys.dart';
import '../utils/color_manager.dart';
import '../utils/common.dart';
import 'invoicedetails.dart';

class Receipts extends StatelessWidget {
  void navigateToInvoiceDetails(
      BuildContext context, InvoiceBeneficaryData? item) {
    // You can use a Navigator to navigate to the invoice details page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InvoiceDetails(item: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: const Text(
          'اﻹيصالات',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => ReportsCubit()..getReceipts(),
        child: BlocConsumer<ReportsCubit, ReportsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ReceiptsDataLoaded) {
              final receipts = state.receipts;

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: receipts?.length,
                itemBuilder: (BuildContext context, int index) {
                  final ReceiptData? item = receipts?[index];
                  if (receipts != null) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: GestureDetector(
                        onTap: () {
                          // Handle navigation to a new screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Reciptdetails(item: item)),
                          );
                        },
                        child: buildInvoiceCard(
                          receipt: receipts[index],
                          index: index,
                        ),
                      ),
                    );
                  } else {
                    return Container(); // or any other placeholder widget
                  }
                },
              );
            } else {
              return const Center(child: Text('Loading...'));
            }
          },
        ),
      ),
    );
  }
}

Widget buildInvoiceCard({required ReceiptData receipt, index}) {
  return Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: receipt.status == 1 ? Colors.green : Colors.orange,
                width: 5,
              ),
            ),
            color: Colors.grey[200],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: buildInvoiceInfo(
                            label: 'اسم الموظف',
                            value: receipt.fullName.toString(),
                            isMultiline: true,
                          ),
                        ),
                        buildInvoiceInfo(
                          label: 'رقم اﻹيصال',
                          value: receipt.invoiceNo.toString(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  buildInvoiceInfo(
                                    label: 'التاريخ',
                                    value: formatDate(receipt.date.toString()),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  buildInvoiceInfo(
                                    label: 'المجموع',
                                    value:
                                        '${receipt.total} ${tr(receipt.currency!)}',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget buildInvoiceInfo(
    {required String label, required String value, bool isMultiline = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height:
            isMultiline ? null : 20, // Set a fixed height for multiline fields
        child: Text(
          value,
          maxLines:
              isMultiline ? 3 : 1, // Set the maximum number of lines to display
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14),
        ),
      ),
    ],
  );
}
