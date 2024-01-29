import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartcard/app/models/invoice_beneficary.dart';
import 'package:smartcard/app/utils/common.dart';

import '../models/model_keys.dart';
import '../utils/color_manager.dart';
import '../widgets/printInvoice.dart';
import '../widgets/printRecipt.dart';
import '../widgets/print_contact.dart';

class InvoiceDetails extends StatefulWidget {
  final InvoiceBeneficaryData? item;

  const InvoiceDetails({super.key, required this.item});

  @override
  State<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage('assets/images/img_constraction.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: ColorManager.baseYellow,
          title: Text(
            "فاتورة",
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
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(3.pt),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'اسم التاجر :',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Text(widget.item!.vendorName.toString() ?? ''),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            const Text(
                              ' رقم المستفيد  :',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Text(widget.item!.accountId.toString() ?? ''),
                          ],
                        ),

                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            const Text(
                              ' اسم المستفيد  :',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Text(widget.item?.fullName ?? ''),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
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
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            const Text(
                              ' نوع الفاتورة :',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Text("${widget.item?.cashOrCategory}"),
                          ],
                        ),

                        // Expanded(
                        //   child: SingleChildScrollView(
                        //     scrollDirection: Axis.horizontal,
                        //     child: SingleChildScrollView(
                        //       scrollDirection: Axis.vertical,
                        //       child: DataTable(
                        //         columns: const [
                        //           DataColumn(label: Text('الرقم')),
                        //           DataColumn(label: Text('المادة')),
                        //           DataColumn(label: Text('السعر')),
                        //           DataColumn(label: Text('الكمية')),
                        //           DataColumn(label: Text('اﻹجمالي')),
                        //         ],
                        //         rows: (widget.item?.items ?? []).map((product) {
                        //           int? index = widget.item?.items?.indexOf(product);
                        //           return DataRow(cells: [
                        //             DataCell(Text("${index! + 1}")),
                        //             DataCell(SizedBox(
                        //               width: 100, // Set a fixed width for the cell
                        //               child: Text(
                        //                 product.productName ?? '',
                        //                 maxLines:
                        //                     3, // Set the maximum number of lines to display
                        //                 overflow: TextOverflow
                        //                     .ellipsis, // Handle overflow with ellipsis
                        //               ),
                        //             )),
                        //             DataCell(Text(product.price.toString())),
                        //             const DataCell(Text("1")),
                        //             DataCell(Text(product.price.toString())),
                        //           ]);
                        //         }).toList(),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          "مجموع الفاتورة  :   ${widget.item?.totalPrice ?? 0}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          // Ad
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            printInvoice(widget.item);
                          },
                          child: const Text('طباعة'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
