import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smartcard/app/utils/color_manager.dart';

import '../cubits/nfc_contact/nfc_contact_cubit.dart';

import '../models/benficary_data_model.dart';
import '../utils/routes_manager.dart';

class AddInvoice extends StatelessWidget {
  PaidBeneficaryModel paidBeneficaryModel;

  AddInvoice({super.key, required this.paidBeneficaryModel});

  // TextEditingController passwordController = TextEditingController();
  // TextEditingController barcodeController = TextEditingController();
  //
  // FocusNode? passwordFocusNode = FocusNode();
  //
  // late ContactData contact;
  //
  // @override
  // void initState() {
  //   super.initState();
  // }
  //
  // double calculateTotalPrice() {
  //   double totalPrice = 0.0;
  //   for (var product in scannedItems) {
  //     totalPrice += (product?.price ?? 0.0) * (1);
  //   }
  //   return totalPrice;
  // }
  //
  // bool checkBalance(balance, total) {
  //   if (total > balance) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: ColorManager.primary,
          title: const Text(
            "إصدار فاتورة",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.popAndPushNamed(context, Routes.homeFormRoute);
            },
          ),
        ),
        body: BlocBuilder<NfcDataCubit, NfcDataState>(
          builder: (context, state) {
            if (state is NfcDataLoaded) {
              final contact = state.contact;
              // bool isButtonEnabled =
              //     checkBalance(contact.balance, calculateTotalPrice());
              return Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                'اسم المستفيد',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Text(
                                  '${contact.firstName!} ${contact.lastName!}'),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              const Text(
                                'الرصيد الحالي',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Text('${contact.balance}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          // Expanded(
                          //   child: AppTextField(
                          //       controller: barcodeController,
                          //       autoFocus: false,
                          //       textFieldType: TextFieldType.NUMBER,
                          //       keyboardType: TextInputType.number,
                          //       decoration: inputDecoration(context,
                          //           hintText: "اكتب الباركود"),
                          //       onFieldSubmitted: (value) async {
                          //         String barcode = value;
                          //
                          //         if (barcode.isNotEmpty) {
                          //           ProductData? product =
                          //               await dbHelper.getProductById(barcode);
                          //
                          //           if (product != null) {
                          //             NfcDataCubit.get(context)
                          //                 .scannedItems
                          //                 .add(product);
                          //
                          //             barcodeController.clear();
                          //           } else {
                          //             // Show an alert that no barcode was found
                          //             // ignore: use_build_context_synchronously
                          //             showDialog(
                          //               context: context,
                          //               builder: (BuildContext context) {
                          //                 return AlertDialog(
                          //                   title: const Text('لايوجد مادة   '),
                          //                   content: const Text(
                          //                       'لايوجد مادة مرتبطة بالكود المدخل'),
                          //                   actions: [
                          //                     TextButton(
                          //                       onPressed: () {
                          //                         Navigator.pop(context);
                          //                       },
                          //                       child: const Text('OK'),
                          //                     ),
                          //                   ],
                          //                 );
                          //               },
                          //             );
                          //             barcodeController.clear();
                          //           }
                          //         }
                          //       }),
                          // ),
                          IconButton(
                            onPressed: () async {
                              // String barcode = barcodeController.text;

                              // if (barcode.isNotEmpty) {
                              //   ProductData? product =
                              //       await dbHelper.getProductById(barcode);
                              //
                              //   if (product != null) {
                              //     scannedItems.add(product);
                              //     setState(() {});
                              //
                              //     barcodeController
                              //         .clear(); // Clear the barcode input
                              //   } else {
                              //     // Show an alert that no barcode was found
                              //     // ignore: use_build_context_synchronously
                              //     showDialog(
                              //       context: context,
                              //       builder: (BuildContext context) {
                              //         return AlertDialog(
                              //           title: const Text('لايوجد مادة   '),
                              //           content: const Text(
                              //               'لايوجد مادة مرتبطة بالكود المدخل'),
                              //           actions: [
                              //             TextButton(
                              //               onPressed: () {
                              //                 Navigator.pop(context);
                              //               },
                              //               child: const Text('OK'),
                              //             ),
                              //           ],
                              //         );
                              //       },
                              //     );
                              //     barcodeController.clear();
                              //   }
                              // }
                            },
                            icon: const Icon(Icons.add),
                            iconSize: 48.0,
                          ),
                          // IconButton(
                          //   onPressed: () async {
                          //     bool continueScanning = true;
                          //
                          //     while (continueScanning) {
                          //       var result = await BarcodeScanner.scan();
                          //
                          //       if (result.type == ResultType.Barcode) {
                          //         ProductData? product = await dbHelper
                          //             .getProductById(result.rawContent);
                          //         scannedItems.add(product);
                          //         setState(() {});
                          //
                          //         // ignore: use_build_context_synchronously
                          //         continueScanning = await showDialog(
                          //           context: context,
                          //           builder: (BuildContext context) =>
                          //               AlertDialog(
                          //             title: const Text('إضافة مادة اخرى'),
                          //             actions: [
                          //               TextButton(
                          //                 onPressed: () {
                          //                   Navigator.pop(context,
                          //                       true); // Continue scanning
                          //                 },
                          //                 child: const Text('نعم'),
                          //               ),
                          //               TextButton(
                          //                 onPressed: () {
                          //                   Navigator.pop(context,
                          //                       false); // Stop scanning
                          //                 },
                          //                 child: const Text('لا'),
                          //               ),
                          //             ],
                          //           ),
                          //         );
                          //       }
                          //     }
                          //   },
                          //   icon: const Icon(Icons.qr_code_scanner),
                          //   iconSize: 48.0,
                          // ),
                        ],
                      ),
                    ),
                    Text(
                      'مجموع الفاتورة  :    ${'calculateTotalPrice().toStringAsFixed(2)'}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      // Ad
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              DataTable(
                                columns: const [
                                  DataColumn(label: Text('الرقم')),
                                  DataColumn(label: Text('المادة')),
                                  DataColumn(label: Text('السعر')),
                                  DataColumn(label: Text('الكمية')),
                                  DataColumn(label: Text('')),
                                ],
                                rows: [],
                                // rows: scannedItems.map((product) {
                                //   int index = scannedItems.indexOf(product);
                                //   return DataRow(cells: [
                                //     DataCell(Text("${index + 1}")),
                                //     DataCell(Text(product?.nameAr ?? '')),
                                //     DataCell(
                                //         Text(product?.price.toString() ?? '')),
                                //     const DataCell(Text("1")),
                                //     DataCell(IconButton(
                                //       color: ColorManager.error,
                                //       onPressed: () {
                                //         setState(() {
                                //           scannedItems.removeAt(
                                //               index); // Remove item from the list
                                //         });
                                //       },
                                //       icon: const Icon(Icons.delete),
                                //     )),
                                //   ]);
                                // }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Display the total price of all items  9878

                    // Padding(
                    //   padding: const EdgeInsets.all(15.0),
                    //   child: SizedBox(
                    //       width: double.infinity,
                    //       height: 50,
                    //       child: isButtonEnabled
                    //           ? ElevatedButton(
                    //               onPressed: () {
                    //                 final currentContext = context;
                    //                 showDialog(
                    //                   context: context,
                    //                   builder: (BuildContext context) {
                    //                     return AlertDialog(
                    //                       title: const Text('ادخل كلمة المرور'),
                    //                       content: AppTextField(
                    //                         controller: passwordController,
                    //                         autoFocus: true,
                    //                         textFieldType:
                    //                             TextFieldType.PASSWORD,
                    //                         keyboardType: TextInputType.number,
                    //                         nextFocus: passwordFocusNode,
                    //                         decoration: inputDecoration(context,
                    //                             hintText: "كلمة السر"),
                    //                       ),
                    //                       actions: [
                    //                         ElevatedButton(
                    //                           onPressed: () {
                    //                             Navigator.pop(context,
                    //                                 passwordController.text);
                    //                           },
                    //                           child: const Text('التحقق'),
                    //                         ),
                    //                       ],
                    //                     );
                    //                   },
                    //                 ).then((value) async {
                    //                   // Handle the result of the dialog
                    //                   if (value != null) {
                    //                     final enteredPassword = value;
                    //                     final storedHashedPassword =
                    //                         contact.password ?? '';
                    //                     final passwordMatch =
                    //                         await FlutterBcrypt.verify(
                    //                             password: enteredPassword,
                    //                             hash: storedHashedPassword);
                    //                     if (passwordMatch) {
                    //                       // Passwords match, perform further operations
                    //                       final invoiceData = InvoiceData(
                    //                         // Initialize the InvoiceData object with relevant data
                    //                         customerId: contact.uuid.toString(),
                    //                         fullName:
                    //                             '${contact.firstName} ${contact.lastName}',
                    //                         invoiceNo:
                    //                             '${appStore.userName} - ?',
                    //                         supplierId:
                    //                             appStore.branchUUID.toString(),
                    //                         date: DateTime.now(),
                    //                         total: calculateTotalPrice(),
                    //                         items: scannedItems.map((product) {
                    //                           return InvoiceItem(
                    //                             itemId: product?.id,
                    //                             quantity: 1,
                    //                             price: product?.price,
                    //                             totalPrice: product?.price,
                    //                             productName: product?.nameAr,
                    //                           );
                    //                         }).toList(),
                    //                       );
                    //
                    //                       await NfcDataCubit.get(context)
                    //                           .setInvoice(invoiceData);
                    //                       Navigator.popAndPushNamed(context,
                    //                           Routes.invoicePrintContactRoute);
                    //                     } else {
                    //                       ScaffoldMessenger.of(context)
                    //                           .showSnackBar(
                    //                         const SnackBar(
                    //                           content:
                    //                               Text('كلمة المرور غير صحيحة'),
                    //                         ),
                    //                       );
                    //                       // Passwords do not match
                    //                     }
                    //                   } else {
                    //                     // The user canceled the dialog
                    //                     // Handle the cancellation, if needed
                    //                   }
                    //                 });
                    //               },
                    //               child: const Text('تثبيت'),
                    //             )
                    //           : ElevatedButton(
                    //               onPressed: () => {},
                    //               child: const Text("المجموع اكبر من الرصيد"),
                    //             )),
                    // ),
                    // Display the total price of all items
                  ],
                ),
              );
            }
            return const Center(child: Text('Loading...'));
          },
        ),
      ),
    );
  }
}
