import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smartcard/app/utils/common.dart';

import '../models/model_keys.dart';
import '../utils/color_manager.dart';
import '../widgets/printRecipt.dart';
import '../widgets/print_contact.dart';

class Reciptdetails extends StatefulWidget {
  final ReceiptData? item;

  const Reciptdetails({super.key, required this.item});

  @override
  State<Reciptdetails> createState() => _ReciptdetailsState();
}

class _ReciptdetailsState extends State<Reciptdetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: Text(
          "ايصال",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'رقم  الموظف  :',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Text(widget.item?.accountId.toString() ?? ''),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        ' اسم الموظف  :',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Text(widget.item?.fullName ?? ''),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        ' رقم اﻹيصال :',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Text(widget.item?.invoiceNo ?? ''),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        ' التاريخ :',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Text(formatDate(widget.item?.date.toString())),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('البيان')),
                      DataColumn(label: Text('المبلغ')),
                    ],
                    rows: (widget.item?.items ?? []).map((product) {
                      int? index = widget.item?.items?.indexOf(product);
                      return DataRow(cells: [
                        DataCell(SizedBox(
                          width: 100, // Set a fixed width for the cell
                          child: Text(
                            product.productName ?? '',
                            maxLines:
                                3, // Set the maximum number of lines to display
                            overflow: TextOverflow
                                .ellipsis, // Handle overflow with ellipsis
                          ),
                        )),
                        DataCell(Text(product.price.toString())),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
            Text(
              "المجموع : ${widget.item?.total ?? 0} ${tr(widget.item?.currency ?? '')}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              // Ad
            ),
            ElevatedButton(
              onPressed: () {
                printRecipt(widget.item);
                //// generateAndPrintArabicPdf(widget.item);
              },
              child: const Text('طباعة'),
            )
          ],
        ),
      ),
    ));
  }
}
