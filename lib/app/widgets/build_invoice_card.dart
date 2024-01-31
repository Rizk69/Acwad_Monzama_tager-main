import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartcard/app/models/invoice_beneficary.dart';
import 'package:smartcard/app/screens/invoicedetails.dart';

Widget buildInvoiceCard({required InvoiceBeneficary invoice, index , required context}) {
  return Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(5.w),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: invoice.message == "Success" ? Colors.green : Colors.orange,
                width: 5,
              ),
            ),
            color: Colors.grey[200]?.withOpacity(0.5),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildInvoiceInfo(
                                label: 'اسم التاجر',
                                value: invoice.data![index].vendorName.toString(),
                                isMultiline: true,
                                  context: context

                              ),
                              SizedBox(height: 2.h,),
                              buildInvoiceInfo(
                                label: 'اسم المستفيد',
                                value: invoice.data![index].fullName.toString(),
                                isMultiline: true,
                                context: context
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        Column(
                          children: [
                             Center(
                                child: Text(
                                  "رقم الفاتورة",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                )),
                            Center(
                                child: Text(
                                  "${invoice.data![index].invoiceNo}",
                                  style:  TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h,),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildInvoiceInfo(
                                label: 'التاريخ',
                                value: invoice.data![index].date.toString(),
                                context: context,
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h,),
                    Center(
                        child: Text(
                          "المجموع ${invoice.data![index].totalPrice}",
                    style:  TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    )),
                    SizedBox(height: 2.h,),
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

// Widget buildInvoiceInfo(
//     {required String label, required String value, bool isMultiline = false}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         label,
//         style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
//       ),
//       SizedBox(
//         height:
//             isMultiline ? null : 20, // Set a fixed height for multiline fields
//         child: Text(
//           value,
//           maxLines:
//               isMultiline ? 3 : 1, // Set the maximum number of lines to display
//           overflow: TextOverflow.ellipsis,
//           style: const TextStyle(fontSize: 14),
//         ),
//       ),
//     ],
//   );
// }

Widget buildInvoiceInfo(
    {required String label, required String value, bool isMultiline = false , required BuildContext context}) {
  return Row(
    // crossAxisAlignment: CrossAxisAlignment.start,
    // mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        "${label} : ",
        style:  TextStyle(fontSize: 12, color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
      ),
      SizedBox(width: 2.w),
      Text(
        value,
        maxLines: isMultiline ? 3 : 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 14,color: Theme.of(context).primaryColor),
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
