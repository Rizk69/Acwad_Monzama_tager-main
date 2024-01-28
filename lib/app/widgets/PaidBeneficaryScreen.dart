import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartcard/app/cubits/nfc_contact/nfc_contact_cubit.dart';
import 'package:smartcard/app/screens/addinvoice.dart';
import 'package:smartcard/app/utils/color_manager.dart';
import 'package:smartcard/main.dart';

import '../models/benficary_data_model.dart';

class PaidBeneficaryScreen extends StatelessWidget {
  PaidBeneficaryModel paidBeneficaryModel;

  PaidBeneficaryScreen({super.key, required this.paidBeneficaryModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage('assets/images/img_constraction.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: BlocProvider(
        create: (context) => NfcDataCubit(),
        child: BlocConsumer<NfcDataCubit, NfcDataState>(
          listener: (context, state) {
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: ColorManager.baseYellow,
                title: const Text(
                  'الدفعات',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.8,
                        ),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(11),
                      margin: const EdgeInsets.all(11),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              'fullName: ${paidBeneficaryModel.beneficary!.fullName ?? ''}'),
                          Text(
                              'mobile: ${paidBeneficaryModel.beneficary!.mobile ?? ''}'),
                          Text(
                              'balance: ${paidBeneficaryModel.beneficary!.balance ?? ''}'),
                          Text(
                              'city: ${paidBeneficaryModel.beneficary!.city ?? ''}'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: ListView.builder(
                        itemCount:
                            paidBeneficaryModel.paidBeneficary!.date?.length ??
                                0, // تحديد عدد العناصر
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: ColorManager.baseYellow,
                                width: 1,
                              ),
                              color: paidBeneficaryModel.paidBeneficary!
                                          .date![index].paidDone ==
                                      0
                                  ? Colors.white
                                  : Colors.greenAccent,
                            ),
                            padding: const EdgeInsets.all(11),
                            margin: EdgeInsets.all(11),
                            child: InkWell(
                              onTap: paidBeneficaryModel.paidBeneficary!
                                          .date![index].paidDone ==
                                      0
                                  ? () {
                                      if (paidBeneficaryModel.paidBeneficary!
                                              .date![index].type ==
                                          0) {
                                        _showConfirmationDialog(
                                          context: context,
                                          index: index,
                                          vendorId: appStore.userId,
                                          paidBeneficaryId: paidBeneficaryModel
                                              .paidBeneficary!.date![index].id!,
                                          beneficaryId: paidBeneficaryModel
                                              .beneficary!.id!,
                                        );
                                      } else {}
                                    }
                                  : null,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      'نوع الصرف: ${paidBeneficaryModel.paidBeneficary!.date![index].type == 0 ? "نقدا" : "مواد عينية" ?? ''}'),
                                  Text(
                                      'المبلغ المتاح: ${paidBeneficaryModel.paidBeneficary!.date![index].paidMoney ?? ''}'),
                                  Text(
                                      'حاله الصرف: ${paidBeneficaryModel.paidBeneficary!.date![index].paidDone == 0 ? "جاري" : "تم الصرف" ?? ''}'),
                                  Text(
                                      'التاريخ: ${paidBeneficaryModel.paidBeneficary!.date![index].date ?? ''}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showConfirmationDialog({
    required BuildContext context,
    required int index,
    required int paidBeneficaryId,
    required int vendorId,
    required int beneficaryId,
  }) {
    var now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd', 'en').format(now);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد'),
          content: const Text('هل متأكد من صرف هذه الدفعه ؟'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('الغاء'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            ElevatedButton(
              child: const Text('تأكيد'),
              onPressed: () {
                NfcDataCubit.get(context).makeCashPayment(
                    paidBeneficaryId: paidBeneficaryId,
                    vendorId: vendorId,
                    beneficaryId: beneficaryId,
                    date: formattedDate);
                // Put your code here for what happens after confirmation
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
