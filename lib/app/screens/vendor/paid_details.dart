import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smartcard/app/screens/beneficary/addinvoice.dart';
import 'package:smartcard/app/screens/beneficary/beneficary_cubit/beneficary_cubit.dart';
import 'package:smartcard/app/utils/resource/color_manager.dart';
import 'package:smartcard/app/widgets/backgrond_image.dart';
import 'package:smartcard/main.dart';

class PaidDetailsScreen extends StatelessWidget {
  int paidBeneficaryId;

  PaidDetailsScreen({super.key, required this.paidBeneficaryId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Stack(
        children: [
          imageBackground(context),
          BlocProvider(
            create: (context) => BeneficaryCubit()
              ..getPaidProjectDetails(paidBenficaryId: paidBeneficaryId),
            child: BlocConsumer<BeneficaryCubit, BeneficaryState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is GetPaidProjectDetailsSuccessState &&
                    BeneficaryCubit.get(context)
                        .paidProjectDetails
                        .data!
                        .isNotEmpty) {
                  var paidProjectDetailsModel =
                      BeneficaryCubit.get(context).paidProjectDetails;

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
                      body: SingleChildScrollView(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await BeneficaryCubit.get(context)
                                .getAllPaidProject(vendorId: appStore.userId);
                          },
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              state is! GetPaidProjectDetailsLoadingState
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      color: Colors.transparent,
                                      child: ListView.builder(
                                        itemCount: paidProjectDetailsModel
                                                .data!.length ??
                                            0, // تحديد عدد العناصر
                                        itemBuilder: (context, index) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                  color:
                                                      ColorManager.baseYellow,
                                                  width: 1,
                                                ),
                                                color: Theme.of(context)
                                                    .primaryColorDark),
                                            padding: const EdgeInsets.all(11),
                                            margin: const EdgeInsets.all(11),
                                            child: InkWell(
                                              onTap: paidProjectDetailsModel
                                                          .data![index]
                                                          .uprove ==
                                                      1
                                                  ? () async {
                                                      if (paidProjectDetailsModel
                                                              .data![index]
                                                              .type ==
                                                          0) {}
                                                      if (paidProjectDetailsModel
                                                              .data![index]
                                                              .type ==
                                                          1) {}
                                                    }
                                                  : null,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'اسم المستفيد: ${paidProjectDetailsModel.data![index].beneficaryName}',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'نوع الصرف: ${paidProjectDetailsModel.data![index].type == 0 ? "نقدا" : "مواد عينية" ?? ''}',
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                      ),
                                                      const Spacer(),
                                                      paidProjectDetailsModel
                                                                  .data![index]
                                                                  .paidDone ==
                                                              1
                                                          ? const Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color:
                                                                  Colors.green,
                                                            )
                                                          : Container()
                                                    ],
                                                  ),
                                                  if (paidProjectDetailsModel
                                                              .data![index]
                                                              .name ==
                                                          '' ||
                                                      paidProjectDetailsModel
                                                              .data![index]
                                                              .name ==
                                                          null)
                                                    Text(
                                                      'اسم الدفعه: ${paidProjectDetailsModel.data![index].name ?? ''}',
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    ),
                                                  Text(
                                                    'اجمالي الدفعه: ${paidProjectDetailsModel.data![index].paidMoney ?? ''}',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                  Text(
                                                    'المبلغ المدفوع: ${paidProjectDetailsModel.data![index].amountIPay}',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                  Text(
                                                    'المبلغ المتبقي: ${paidProjectDetailsModel.data![index].residualMoney}',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                  Text(
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                      'حاله الصرف: ${paidProjectDetailsModel.data![index].uprove == 1 && paidProjectDetailsModel.data![index].paidDone == 0 ? "جاري" : paidProjectDetailsModel.data![index].paidDone == 0 && paidProjectDetailsModel.data![index].uprove == 0 ? "في انتظار الموافقة" : "تم الصرف" ?? ''}'),
                                                  Text(
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                      'التاريخ: ${paidProjectDetailsModel.data![index].date ?? ''}'),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator()),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
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
}
