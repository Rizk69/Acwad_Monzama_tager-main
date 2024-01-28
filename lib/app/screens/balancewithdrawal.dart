import 'package:flutter/material.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smartcard/app/utils/color_manager.dart';

import '../../main.dart';
import '../cubits/nfc_employee/nfc_employee_cubit.dart';
import '../models/model_keys.dart';
import '../utils/common.dart';
import '../utils/database_helper.dart';
import '../utils/routes_manager.dart';

class BalanceWithdrawal extends StatefulWidget {
  const BalanceWithdrawal({super.key});

  @override
  State<BalanceWithdrawal> createState() => _BalanceWithdrawalState();
}

class _BalanceWithdrawalState extends State<BalanceWithdrawal> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  FocusNode? passwordFocusNode = FocusNode();

  bool checkBalance(num? balance, num? total) {
    return total! <= balance!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "سحب رصيد",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: ColorManager.primary,
        ),
        body: BlocBuilder<BalanceCubit, BalanceState>(
          builder: (context, state) {
            if (state is BalanceLoaded) {
              final employee = state.employee;
              bool isButtonEnabled = true;
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
                                'اسم الموظف',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Text(
                                  '${employee.firstNameAr!} ${employee.lastNameAr!}'),
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
                              Text('${employee.balance}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              controller: amountController,
                              autoFocus: false,
                              textFieldType: TextFieldType.NUMBER,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  isButtonEnabled = checkBalance(
                                      employee.balance, value.toDouble());
                                });
                              },
                              decoration: inputDecoration(context,
                                  hintText: "اكتب المبلغ"),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Display the total price of all items

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: isButtonEnabled
                              ? ElevatedButton(
                                  onPressed: () {
                                    final currentContext = context;
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('ادخل كلمة المرور'),
                                          content: AppTextField(
                                            controller: passwordController,
                                            autoFocus: true,
                                            textFieldType:
                                                TextFieldType.PASSWORD,
                                            keyboardType: TextInputType.number,
                                            nextFocus: passwordFocusNode,
                                            decoration: inputDecoration(context,
                                                hintText: "كلمة السر"),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context,
                                                    passwordController.text);
                                              },
                                              child: const Text('التحقق'),
                                            ),
                                          ],
                                        );
                                      },
                                    ).then((value) async {
                                      // Handle the result of the dialog
                                      if (value != null) {
                                        final enteredPassword = value;
                                        final storedHashedPassword =
                                            employee.password ?? '';
                                        final passwordMatch =
                                            await FlutterBcrypt.verify(
                                                password: enteredPassword,
                                                hash: storedHashedPassword);
                                        if (passwordMatch) {
                                          //     // Passwords match, perform further operations
                                          final receiptItem = ReceiptItem(
                                            itemId: 1,
                                            quantity: 1,
                                            price: amountController.text
                                                .toDouble(),
                                            totalPrice: amountController.text
                                                .toDouble(),
                                          );

                                          final receiptData = ReceiptData(
                                            customerId:
                                                employee.uuid.toString(),
                                            supplierId:
                                                appStore.branchUUID.toString(),
                                            date: DateTime.now(),
                                            total: amountController.text
                                                .toDouble(),
                                            items: <ReceiptItem>[receiptItem],
                                          );

                                          await BalanceCubit.get(context)
                                              .setReceipt(receiptData);
                                          Navigator.popAndPushNamed(
                                              currentContext,
                                              Routes.invoicePrintEmployeeRoute);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text('كلمة المرور غير صحيحة'),
                                            ),
                                          );
                                        }
                                      } else {
                                        //   // The user canceled the dialog
                                        //   // Handle the cancellation, if needed
                                      }
                                    });
                                  },
                                  child: const Text('تثبيت'),
                                )
                              : ElevatedButton(
                                  onPressed: () => {},
                                  child: const Text("المبلغ اكبر من الرصيد"),
                                )),
                    ),
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
