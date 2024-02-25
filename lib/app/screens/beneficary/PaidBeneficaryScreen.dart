import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartcard/app/models/invoice.dart';
import 'package:smartcard/app/screens/beneficary/addinvoice.dart';
import 'package:smartcard/app/utils/resource/color_manager.dart';
import 'package:smartcard/app/widgets/backgrond_image.dart';
import 'package:smartcard/main.dart';
import 'nfc_contact_cubit/nfc_contact_cubit.dart';

class PaidBeneficaryScreen extends StatelessWidget {
  int paidBeneficaryId;
  int? beneficaryId;
  String? beneficaryName;

  PaidBeneficaryScreen(
      {super.key,
      required this.paidBeneficaryId,
      this.beneficaryId,
      this.beneficaryName});

  @override
  Widget build(BuildContext contextscreen) {
    return Container(
      color: Theme.of(contextscreen).canvasColor,
      child: Stack(
        children: [
          imageBackground(contextscreen),
          BlocProvider(
            create: (context) => NfcDataCubit()
              ..getPaidBeneficary(beneficaryId: paidBeneficaryId),
            child: BlocConsumer<NfcDataCubit, NfcDataState>(
              listener: (context, state) {
                if (state is MakeCashSuccessState) {
                  NfcDataCubit.get(context)
                      .getPaidBeneficary(beneficaryId: paidBeneficaryId);
                }
              },
              builder: (context, state) {
                if (state is GetPaidBeneficarySuccessState &&
                    NfcDataCubit.get(context)
                        .paidBeneficary
                        .paidBeneficary!
                        .date!
                        .isNotEmpty) {
                  var paidBeneficaryModel =
                      NfcDataCubit.get(context).paidBeneficary;
                  return Scaffold(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      appBar: AppBar(
                        backgroundColor:
                            Theme.of(context).appBarTheme.backgroundColor,
                        title: Text(
                          'الدفعات',
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        centerTitle: true,
                        leading: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context).primaryColor,
                            )),
                      ),
                      body: RefreshIndicator(
                        onRefresh: () async {
                          await NfcDataCubit.get(context).getPaidBeneficary(
                              beneficaryId: paidBeneficaryId);
                        },
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            if (state is! NfcDataLoading)
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: paidBeneficaryModel
                                          .paidBeneficary!.date?.length ??
                                      0, // تحديد عدد العناصر
                                  itemBuilder: (contextBuilder, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: ColorManager.baseYellow,
                                            width: 1,
                                          ),
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                      padding: const EdgeInsets.all(11),
                                      margin: const EdgeInsets.all(11),
                                      child: InkWell(
                                        onTap: paidBeneficaryModel
                                                        .paidBeneficary!
                                                        .date![index]
                                                        .paidDone ==
                                                    0 &&
                                                paidBeneficaryModel
                                                        .paidBeneficary!
                                                        .date![index]
                                                        .uprove ==
                                                    1
                                            ? () async {
                                                if (paidBeneficaryModel
                                                        .paidBeneficary!
                                                        .date![index]
                                                        .type ==
                                                    0) {
                                                  _showConfirmationDialog(
                                                    paidBeneficaryModel:
                                                        paidBeneficaryModel,
                                                    beneficaryName:
                                                        beneficaryName!,
                                                    contextscreen: context,
                                                    index: index,
                                                    vendorId: appStore.userId,
                                                    paidBeneficaryId:
                                                        paidBeneficaryModel
                                                            .paidBeneficary!
                                                            .date![index]
                                                            .id!,
                                                    beneficaryId:
                                                        paidBeneficaryModel
                                                                .beneficary
                                                                ?.id ??
                                                            beneficaryId!,
                                                  );
                                                }
                                                if (paidBeneficaryModel
                                                        .paidBeneficary!
                                                        .date![index]
                                                        .type ==
                                                    1) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => AddInvoice(
                                                          beneficaryId:
                                                              beneficaryId!,
                                                          paidBeneficaryModel:
                                                              paidBeneficaryModel,
                                                          beneficaryName:
                                                              paidBeneficaryModel
                                                                      .beneficary
                                                                      ?.fullName ??
                                                                  beneficaryName!,
                                                          index: index),
                                                    ),
                                                  );
                                                }
                                              }
                                            : null,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'نوع الصرف: ${paidBeneficaryModel.paidBeneficary!.date![index].type == 0 ? "نقدا" : "مواد عينية" ?? ''}',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                Spacer(),
                                                paidBeneficaryModel
                                                            .paidBeneficary!
                                                            .date![index]
                                                            .paidDone ==
                                                        1
                                                    ? Icon(
                                                        Icons.check_circle,
                                                        color: Colors.green,
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                            Text(
                                              'المبلغ الدفع: ${paidBeneficaryModel.paidBeneficary!.date![index].paidMoney ?? ''}',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            Text(
                                              'المبلغ المتبقي المتاح: ${paidBeneficaryModel.paidBeneficary!.date![index].residual_money ?? ''}',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            Text(
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                'حاله الصرف: ${paidBeneficaryModel.paidBeneficary!.date![index].uprove == 1 && paidBeneficaryModel.paidBeneficary!.date![index].paidDone == 0 ? "جاري" : paidBeneficaryModel.paidBeneficary!.date![index].paidDone == 0 && paidBeneficaryModel.paidBeneficary!.date![index].uprove == 0 ? "في انتظار الموافقة" : "تم الصرف" ?? ''}'),
                                            Text(
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                'التاريخ: ${paidBeneficaryModel.paidBeneficary!.date![index].date ?? ''}'),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            else
                              const Center(child: CircularProgressIndicator()),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ));
                }
                return Scaffold(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  appBar: AppBar(
                    backgroundColor:
                        Theme.of(context).appBarTheme.backgroundColor,
                    title: const Text(
                      'الدفعات',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    centerTitle: true,
                  ),
                  body: Center(
                    child: Lottie.asset(
                      'assets/images/empty_invoice.json',
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog({
    required BuildContext contextscreen,
    required int index,
    required int paidBeneficaryId,
    required int vendorId,
    required int beneficaryId,
    required paidBeneficaryModel,
    required String beneficaryName,
  }) {
    var now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd', 'en').format(now);
    TextEditingController paidMoneyController =
        TextEditingController(); // تمرير Controller كمعامل إضافي

    showDialog(
      context: contextscreen,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text('تأكيد',
              style: TextStyle(color: Theme.of(context).primaryColor)),
          content: IntrinsicHeight(
            child: Column(
              children: [
                Text('هل متأكد من صرف هذه الدفعه ؟',
                    style: TextStyle(color: Theme.of(context).primaryColor)),
                SizedBox(height: 2.h),
                TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                  ),
                  controller: paidMoneyController, // استخدم الـ Controller هنا
                  decoration: InputDecoration(
                      labelText: 'المبلغ المدفوع',
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                      )),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Theme.of(context).primaryColor)),
              child: Text('الغاء',
                  style: TextStyle(color: Theme.of(context).primaryColorDark)),
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق الحوار
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Theme.of(context).primaryColor)),
              child: Text('تأكيد',
                  style: TextStyle(color: Theme.of(context).primaryColorDark)),
              onPressed: () async {
                NfcDataCubit.get(context).makeCashPayment(
                  context: contextscreen,
                  residualMoney: paidBeneficaryModel
                      .paidBeneficary!.date![index].residual_money
                      .toDouble(),
                  paidBeneficaryId: paidBeneficaryId,
                  vendorId: vendorId,
                  beneficaryId: beneficaryId,
                  date: formattedDate,
                  paidMoney: double.tryParse(paidMoneyController.text)!,
                  data: InvoiceData(
                    vendorName: appStore.name,
                    invoiceNo: -1,
                    date: formattedDate,
                    residualMoney: paidBeneficaryModel
                            .paidBeneficary!.date![index].residual_money -
                        double.tryParse(paidMoneyController.text),
                    beneficaryName: beneficaryName,
                  ),
                );

                Navigator.of(context).pop();
              },
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }
}
