import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smartcard/app/utils/color_manager.dart';

import '../cubits/nfc_contact/nfc_contact_cubit.dart';

import '../models/benficary_data_model.dart';

class AddInvoice extends StatelessWidget {
  PaidBeneficaryModel paidBeneficaryModel;
  int index;

  AddInvoice(
      {super.key, required this.paidBeneficaryModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => NfcDataCubit()
          ..getCategoryInvoiceShow(
              idCategory: paidBeneficaryModel.paidBeneficary!.date![index].id!),
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
                Navigator.of(context).pop();
              },
            ),
          ),
          body: BlocBuilder<NfcDataCubit, NfcDataState>(
            builder: (context, state) {
              if (state is! NfcDataLoaded) {
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
                                    '${paidBeneficaryModel.beneficary?.fullName}'),
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
                                Text(
                                    '${paidBeneficaryModel.paidBeneficary?.date?[index].paidMoney}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            // DropdownButtonFormField<String>(
                            //     onChanged: (value) {
                            //     },
                            //     items: ['دولار', 'ليرة'].map<DropdownMenuItem<String>>(
                            //           (String value) {
                            //         return DropdownMenuItem<String>(
                            //           value: value,
                            //           child: Text(value),
                            //         );
                            //       },
                            //     ).toList(),
                            //     decoration: const InputDecoration(
                            //       labelText: 'العملة',
                            //       prefixIcon: Icon(Icons.account_balance_wallet),
                            //     ),
                            //     ),
                            DropdownButton(
                              items: NfcDataCubit.get(context)
                                  .productModel
                                  .product!
                                  .map((product) {
                                return DropdownMenuItem(
                                  value: product.name,
                                  child: Text(product.name ?? 'notFound'),
                                );
                              }).toList(),
                              onChanged: (value) {},
                              icon: const Icon(Icons.list_alt),
                            ),
                            IconButton(
                              onPressed: () async {},
                              icon: const Icon(Icons.add),
                              iconSize: 48.0,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'مجموع الفاتورة  :    ${''}',
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
      ),
    );
  }
}
