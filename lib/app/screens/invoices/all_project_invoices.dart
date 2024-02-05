import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smartcard/app/models/invoice_beneficary.dart';
import 'package:smartcard/app/screens/invoices/cubit/reports_cubit.dart';
import 'package:smartcard/app/widgets/build_invoice_card.dart';
import 'package:smartcard/app/widgets/default_appbar.dart';
import '../../../main.dart';
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
          InvoiceBeneficary? currentData;

          if (state is GetAllInvoicesSuccessState) {
            currentData = state.allInvoiceBeneficary;
          }
          if (state is SearchAllInvoiceBeneficarySuccessState) {
            currentData = state.allInvoiceBeneficary;
          }

          bool hasData = currentData != null &&
              currentData.data != null &&
              currentData.data!.isNotEmpty;

          return Container(
            color: Theme.of(context).primaryColorDark,
            child: Stack(
              children: [
                imageBackground(context),
                Scaffold(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    appBar: defaultAppbar(title: "التقارير", context: context),
                    body: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Search',
                              hintText: 'Search for ',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(23)),
                            ),
                            onChanged: (value) {
                              ReportsCubit.get(context)
                                  .searchInvoiceBeneficaryNumber(value);
                            },
                          ),
                        ),
                        state is GetAllInvoiceBeneficaryLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : hasData
                                ? Expanded(
                                    child: ListView.builder(
                                      padding: const EdgeInsets.all(16),
                                      itemCount: currentData.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final item = currentData!.data![index];
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 15),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        InvoiceDetails(
                                                            item: item)),
                                              );
                                            },
                                            child: buildInvoiceCard(
                                                invoice: currentData,
                                                index: index,
                                                context: context),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Expanded(
                                    child: Center(
                                      child: Lottie.asset(
                                        'assets/images/empty_invoice.json',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                      ],
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
