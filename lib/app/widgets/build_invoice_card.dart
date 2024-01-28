import 'package:flutter/material.dart';
import 'package:smartcard/app/models/invoice_beneficary.dart';
import 'package:smartcard/app/screens/invoicedetails.dart';
import 'package:smartcard/app/utils/common.dart';
import 'package:smartcard/app/utils/extenstion.dart';

Widget buildInvoiceCard({required InvoiceBeneficary invoice, index}) {
  return Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:
                    invoice.message == "Success" ? Colors.green : Colors.orange,
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
                            label: 'اسم المستفيد',
                            value: invoice.data![index].fullName.toString(),
                            isMultiline: true,
                          ),
                        ),
                        buildInvoiceInfo(
                          label: 'رقم الفاتورة',
                          value: invoice.data![index].invoiceNo
                              .toString()
                              .orEmpty(),
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
                                    value: formatDate(invoice.data![index].date
                                        .toString()
                                        .orEmpty()),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  buildInvoiceInfo(
                                    label: 'المجموع',
                                    value: '${invoice.data![index].totalPrice}',
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
          style: const TextStyle(fontSize: 14),
        ),
      ),
    ],
  );
}

void navigateToInvoiceDetails(
    BuildContext context, InvoiceBeneficaryData? item) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => InvoiceDetails(item: item)),
  );
}
