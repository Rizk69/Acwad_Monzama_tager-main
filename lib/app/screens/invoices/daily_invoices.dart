import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartcard/app/models/invoice_beneficary.dart';
import 'package:smartcard/app/screens/invoices/cubit/reports_cubit.dart';
import 'package:smartcard/app/widgets/backgrond_image.dart';
import 'package:smartcard/app/widgets/build_invoice_card.dart';
import 'package:smartcard/app/widgets/default_appbar.dart';
import 'package:smartcard/main.dart';
import 'invoicedetails.dart';

class DailyInvoices extends StatelessWidget {
  String type ;

  DailyInvoices({required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ReportsCubit()..getDailyInvoiceBeneficary(vendorID: appStore.userId),
      child: BlocConsumer<ReportsCubit, ReportsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            color: Theme.of(context).primaryColorDark,
            child: Stack(
              children: [
                imageBackground(context),
                Scaffold(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    appBar: defaultAppbar(
                        title: "تقارير اليومية", context: context),
                    body: state is GetDailyInvoicesSuccessState &&
                            ReportsCubit.get(context)
                                .dailyInvoiceBeneficary
                                .data!
                                .isNotEmpty
                        ? Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 5.pt),
                              child: Align(
                                alignment: AlignmentDirectional.topStart,
                                child: Text("مجموع النقدي المصروف : ${ReportsCubit.get(context).dailyInvoiceBeneficary.sumCashPaid}",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 18,
                                ),

                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  padding: const EdgeInsets.all(16),
                                  itemCount: ReportsCubit.get(context)
                                      .dailyInvoiceBeneficary
                                      .data!
                                      .length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final InvoiceBeneficary item = ReportsCubit.get(context).dailyInvoiceBeneficary;
                              
                                    return item.data![index].cashOrCategory=="cash"? Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 15),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => InvoiceDetails(
                                                        item: item.data![index])),
                                              );
                                            },
                                            child:buildInvoiceCard(
                                                invoice: item,
                                                index: index,
                                                context: context),
                                          ),
                                        ),
                                      ],
                                    ):Container();
                                  },
                                ),
                            ),
                          ],
                        )
                        : Center(
                            child: Lottie.asset(
                              'assets/images/empty_invoice.json',
                              fit: BoxFit.fill,
                            ),
                          )),
              ],
            ),
          );
        },
      ),
    );
  }
}
