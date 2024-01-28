import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:smartcard/app/models/model_keys.dart';

import '../../main.dart';
import '../utils/common.dart';

Future<void> generateAndPrintEmployeePdf(
    ReceiptData? data, EmployeeData employee, String dataId) async {
  final pw.Document pdf = pw.Document();

  final balance = employee.balance! - (data?.total ?? 0);
  final List<List<dynamic>> tableData = data?.items?.map((item) {
        return [
          item.totalPrice, // Assuming `name` is a property in `item`
          item.productName, // Assuming `total` is a property in `item`
        ];
      }).toList() ??
      [];
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
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.SizedBox(
                        width: 170,
                        child: pw.Text(
                            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.',
                            style: pw.TextStyle(
                              fontSize: 10,
                            ))))),
          ]),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text(appStore.name,
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text('اسم المركز : ',
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
          ]),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text(
                        '${employee.firstNameAr} ${employee.lastNameAr}',
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text('اسم الموظف: ',
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
          ]),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text(employee.accountId.toString(),
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text('رقم الموظف : ',
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
          ]),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text(dataId,
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
                    child: pw.Text(balance.toString(),
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text(' رصيد الموظف المتبقي : ',
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
          ]),
          pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Text('', style: pw.TextStyle(fontSize: 13))),
          pw.Container(
            margin: pw.EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Table.fromTextArray(
                  headerStyle: pw.TextStyle(fontSize: 10),
                  headers: <dynamic>['المبلغ', 'البيان'],
                  cellAlignment: pw.Alignment.center,
                  cellStyle: pw.TextStyle(fontSize: 10),
                  data: tableData),
            ),
          ),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text('${data?.total} ${tr(data?.currency ?? '')}',
                        style: pw.TextStyle(
                          fontSize: 13,
                        )))),
            pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Center(
                    child: pw.Text('المجموع : ',
                        style: pw.TextStyle(
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
