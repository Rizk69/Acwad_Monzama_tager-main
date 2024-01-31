import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartcard/app/models/invoice_beneficary.dart';
import 'package:smartcard/app/utils/common.dart';
import 'package:smartcard/app/widgets/backgrond_image.dart';
import 'package:smartcard/app/widgets/default_appbar.dart';

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
      color: Colors.white,
      child: Stack(
        children: [
          imageBackground(context),
          Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: defaultAppbar(title: "تفاصيل الفاتورة", context: context),
            body: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 3,
                      shadowColor: Colors.white,
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
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              "مجموع الفاتورة  :   ${widget.item?.totalPrice ?? 0}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                              // Ad
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.all(4.pt),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(8)),
                          backgroundColor: MaterialStateProperty.all(
                              ColorManager.baseYellow),
                        ),
                        onPressed: () {
                          printInvoice(widget.item);
                        },
                        child: const Text(
                          'طباعة',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
