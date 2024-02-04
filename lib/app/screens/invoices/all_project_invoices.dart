import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smartcard/app/models/invoice_beneficary.dart';
import 'package:smartcard/app/screens/invoices/cubit/reports_cubit.dart';
import 'package:smartcard/app/widgets/build_invoice_card.dart';
import 'package:smartcard/app/widgets/default_appbar.dart';
import '../../widgets/backgrond_image.dart';
import 'invoicedetails.dart';

class AllInvoicesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportsCubit()..getAllInvoiceBeneficary(),
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
                    appBar: defaultAppbar(title: "التقارير", context: context),
                    body: state is GetAllInvoicesSuccessState &&
                            ReportsCubit.get(context)
                                .allInvoiceBeneficary
                                .data!
                                .isNotEmpty
                        ? ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: ReportsCubit.get(context)
                                .allInvoiceBeneficary
                                .data!
                                .length,
                            itemBuilder: (BuildContext context, int index) {
                              final InvoiceBeneficary item =
                                  ReportsCubit.get(context)
                                      .allInvoiceBeneficary;
                              return Padding(
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
                                  child: buildInvoiceCard(
                                      invoice: item,
                                      index: index,
                                      context: context),
                                ),
                              );
                            },
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
