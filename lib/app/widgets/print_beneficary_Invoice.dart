import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:smartcard/app/models/invoice.dart';
import 'package:smartcard/app/models/invoice_beneficary.dart';
import 'package:smartcard/app/models/model_keys.dart';
import 'package:smartcard/main.dart';

import '../utils/common.dart';

Future<void> printInvoice(Invoice? data) async {
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
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.SizedBox(
                        width: 170,
                        child: pw.Text(
                            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.',
                            style: const pw.TextStyle(
                              fontSize: 10,
                            ))))),
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
                    child: pw.Text('${data?.data?.invoiceNo}',
                        style: const pw.TextStyle(
                          fontSize: 13,
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
                    child: pw.Text("${data?.data?.date??""}",
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
                    child: pw.Text("${data?.data?.residualMoney??0}",
                        style: const pw.TextStyle(
                          fontSize: 13,
                        )))),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text(' رصيد المستفيد المتبقي : ',
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
