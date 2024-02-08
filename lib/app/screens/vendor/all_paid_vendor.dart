import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartcard/app/screens/beneficary/addinvoice.dart';
import 'package:smartcard/app/screens/beneficary/beneficary_cubit/beneficary_cubit.dart';
import 'package:smartcard/app/screens/vendor/paid_details.dart';
import 'package:smartcard/app/utils/resource/color_manager.dart';
import 'package:smartcard/app/widgets/backgrond_image.dart';
import 'package:smartcard/main.dart';

class PaidProjectsScreen extends StatelessWidget {
  const PaidProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Stack(
        children: [
          imageBackground(context),
          BlocProvider(
            create: (context) =>
                BeneficaryCubit()..getAllPaidProject(vendorId: appStore.userId),
            child: BlocConsumer<BeneficaryCubit, BeneficaryState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is GetAllPaidProjectSuccessState &&
                    BeneficaryCubit.get(context).paidReports.data!.isNotEmpty) {
                  var paidReportsModel =
                      BeneficaryCubit.get(context).paidReports;

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
                              state is! GetAllPaidProjectLoadingState
                                  ? Container(
                                      height: MediaQuery.of(context).size.height*0.8,
                                      color: Colors.transparent,
                                      child: ListView.builder(
                                        itemCount: paidReportsModel.data!.length ?? 0, // تحديد عدد العناصر
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
                                              onTap:  () async {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PaidDetailsScreen(paidBeneficaryId: paidReportsModel.data![index].id!),
                                                  ),
                                                );
                                                    },
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'نوع الصرف: ${paidReportsModel.data![index].type == 0 ? "نقدا" : "مواد عينية" ?? ''}',
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                      ),
                                                    ],
                                                  ),
                                                  if(paidReportsModel.data![index].name =='' ||paidReportsModel.data![index].name==null)
                                                  Text(
                                                    'اسم الدفعه: ${paidReportsModel.data![index].name ?? ''}',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                  Text(
                                                    'اجمالي الدفعه: ${paidReportsModel.data![index].totalPaid ?? ''}',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                  Text(
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                      'التاريخ: ${paidReportsModel.data![index].date ?? ''}'),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : const Center(child: CircularProgressIndicator()),


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
