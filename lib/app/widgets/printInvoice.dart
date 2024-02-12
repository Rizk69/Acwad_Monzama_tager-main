import 'dart:io';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:smartcard/app/models/invoice_beneficary.dart';
import 'package:smartcard/app/models/model_keys.dart';
import 'package:smartcard/main.dart';

import '../utils/common.dart';
import '../utils/routes_manager.dart';

Future<void> printInvoice(
    InvoiceBeneficaryData? data, BuildContext context) async {
  Navigator.pushNamedAndRemoveUntil(
      context, Routes.homeFormRoute, (route) => false);
  final pw.Document pdf = pw.Document();

  // final List<List<dynamic>> tableData = data?.items?.map((item) {
  //       return [
  //         item.totalPrice, // Assuming `name` is a property in `item`
  //         item.price, // Assuming `oil` is a property in `item`
  //         item.quantity, // Assuming `sugar` is a property in `item`
  //         item.productName, // Assuming `total` is a property in `item`
  //       ];
  //     }).toList() ??
  //     [];

  var arabicFont =
      pw.Font.ttf(await rootBundle.load("assets/fonts/HacenTunisia.ttf"));
  pdf.addPage(pw.Page(
      theme: pw.ThemeData.withFont(
        base: arabicFont,
      ),
      pageFormat: PdfPageFormat.roll80,
      build: (pw.Context context) {
        return pw.Center(
            child: pw.Column(children: [
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text('MBAG',
                        style: pw.TextStyle(
                          fontSize: 30,
                        )))),
          ]),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text("${data?.vendorName}",
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text('اسم التاجر : ',
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
          ]),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    //'${contact.firstName} ${contact.lastName}'
                    child: pw.Text('${data?.fullName}',
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text('اسم المستفيد: ',
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
          ]),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text('${data?.accountId}',
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text('رقم المستفيد : ',
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
          ]),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text('${data?.invoiceNo}',
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text('رقم الفاتورة : ',
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
          ]),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text(formatDate(data?.date.toString()),
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text('التاريخ : ',
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
          ]),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text("${data?.total_price ?? 0}",
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text(' رصيد المستفيد المتبقي : ',
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
          ]),
          pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Text('المشتريات', style: pw.TextStyle(fontSize: 13))),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Text(
                  'سعر ',
                  style: pw.TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Text(
                  'كمية',
                  style: pw.TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Text(
                  'منتج',
                  style: pw.TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          pw.Container(
            margin: pw.EdgeInsets.all(5),
            decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.8)),
          ),
          pw.SizedBox(
            child: pw.ListView.builder(
                itemBuilder: (context, index) => pw.Column(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(horizontal: 4),
                          child: pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Directionality(
                                textDirection: pw.TextDirection.rtl,
                                child: pw.Text(
                                  "${data?.product?[index].price}",
                                  style: pw.TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              pw.Directionality(
                                textDirection: pw.TextDirection.rtl,
                                child: pw.Text(
                                  "${data?.product?[index].count}",
                                  style: pw.TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              pw.Directionality(
                                textDirection: pw.TextDirection.rtl,
                                child: pw.Text(
                                  "${data?.product?[index].name}",
                                  style: pw.TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.Container(
                          margin: pw.EdgeInsets.all(5),
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(width: 0.8)),
                        )
                      ],
                    ),
                itemCount: data?.product?.length ?? 0),
          )
          // pw.Container(
          //   margin: pw.EdgeInsets.fromLTRB(0, 10, 0, 10),
          //   child: pw.Directionality(
          //     textDirection: pw.TextDirection.rtl,
          //     child: pw.Table.fromTextArray(
          //       headerStyle: pw.TextStyle(fontSize: 10),
          //       headers: <dynamic>['اجمالي', 'السغر', 'الغدد', 'المادة'],
          //       cellAlignment: pw.Alignment.center,
          //       cellStyle: pw.TextStyle(fontSize: 10),
          //       data: tableData,
          //     ),
          //   ),
          // ),
          // pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
          //   pw.Directionality(
          //       textDirection: pw.TextDirection.rtl,
          //       child: pw.Center(
          //           child: pw.Text('${data?.total} ${tr(data?.currency ?? '')}',
          //               style: pw.TextStyle(
          //                 fontSize: 13,
          //               )))),
          //   pw.Directionality(
          //       textDirection: pw.TextDirection.rtl,
          //       child: pw.Center(
          //           child: pw.Text('المجموع : ',
          //               style: pw.TextStyle(
          //                 fontSize: 13,
          //               )))),
          // ]),
        ]));
      }));
  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/1.pdf';
  final File file = File(path);

  final Uint8List pdfBytes = await pdf.save();
  await file.writeAsBytes(pdfBytes);

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async {
      await file.writeAsBytes(pdfBytes);
      return Uint8List.fromList(await file.readAsBytes());
    },
  );
}
