import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:smartcard/app/models/invoice.dart';
import 'package:smartcard/app/utils/routes_manager.dart';

Future<void> printInvoice(
    Invoice? data, context, String paid, String balance) async {
  Navigator.pushNamedAndRemoveUntil(
      context, Routes.homeFormRoute, (route) => false);

  final pw.Document pdf = pw.Document();

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
                        style: const pw.TextStyle(
                          fontSize: 30,
                        )))),
          ]),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text("${data?.data?.vendorName}",
                        style: const pw.TextStyle(
                          fontSize: 13,
                        )))),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text('اسم التاجر : ',
                        style: const pw.TextStyle(
                          fontSize: 13,
                        )))),
          ]),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    //'${contact.firstName} ${contact.lastName}'
                    child: pw.Text('${data?.data?.beneficaryName}',
                        style: const pw.TextStyle(
                          fontSize: 13,
                        )))),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text('اسم المستفيد: ',
                        style: const pw.TextStyle(
                          fontSize: 13,
                        )))),
          ]),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text(
                        '${data?.data?.invoiceNo != -1 ? data?.data?.invoiceNo : 'تمت عملية البيع في وضع الاوفلاين'}',
                        style: pw.TextStyle(
                          fontSize: data?.data?.invoiceNo != -1 ? 13 : 11,
                        )))),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text('رقم الفاتورة : ',
                        style: const pw.TextStyle(
                          fontSize: 13,
                        )))),
          ]),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text("${data?.data?.date ?? ""}",
                        style: const pw.TextStyle(
                          fontSize: 13,
                        )))),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text('التاريخ : ',
                        style: const pw.TextStyle(
                          fontSize: 13,
                        )))),
          ]),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text(
                        "${data?.data?.invoiceNo != -1 ? data?.data?.totalPriceInvoice : paid}",
                        style: const pw.TextStyle(
                          fontSize: 13,
                        )))),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text(' رصيد المسحوب : ',
                        style: const pw.TextStyle(
                          fontSize: 13,
                        )))),
          ]),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text("${data?.data?.residualMoney ?? ''}",
                        style: const pw.TextStyle(
                          fontSize: 13,
                        )))),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text(' رصيد المستفيد المتبقي لدفعه: ',
                        style: const pw.TextStyle(
                          fontSize: 13,
                        )))),
          ]),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text(
                        "${data?.data?.invoiceNo != -1 ? data?.data?.balance : balance}",
                        style: const pw.TextStyle(
                          fontSize: 13,
                        )))),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text(' رصيد الاجمالى : ',
                        style: const pw.TextStyle(
                          fontSize: 13,
                        )))),
          ]),
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
