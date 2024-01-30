import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smartcard/app/cubits/Reports/reports_cubit.dart';
import 'package:smartcard/app/models/invoice_beneficary.dart';
import 'package:smartcard/app/widgets/backgrond_image.dart';
import 'package:smartcard/app/widgets/build_invoice_card.dart';
import 'package:smartcard/app/widgets/default_appbar.dart';
import 'package:smartcard/main.dart';
import '../utils/color_manager.dart';
import 'invoicedetails.dart';

class Invoices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ReportsCubit()..getInvoiceBeneficary(vendorId: appStore.userId),
      child: BlocConsumer<ReportsCubit, ReportsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            color: Colors.white,
            child: Stack(
              children: [
                imageBackground(context),
                Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar:defaultAppbar(title:"الفواتير" ),

                    body: state is GetInvoicesSuccessState &&
                            ReportsCubit.get(context)
                                .invoiceBeneficary
                                .data!
                                .isNotEmpty
                        ? ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: ReportsCubit.get(context)
                                .invoiceBeneficary
                                .data!
                                .length,
                            itemBuilder: (BuildContext context, int index) {
                              final InvoiceBeneficary item =
                                  ReportsCubit.get(context).invoiceBeneficary;
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
                                  ),
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
