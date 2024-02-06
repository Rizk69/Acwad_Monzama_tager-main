import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smartcard/app/models/invoice_beneficary.dart';
import 'package:smartcard/app/screens/invoices/cubit/reports_cubit.dart';
import 'package:smartcard/app/widgets/backgrond_image.dart';
import 'package:smartcard/app/widgets/build_invoice_card.dart';
import 'package:smartcard/app/widgets/default_appbar.dart';
import 'package:smartcard/main.dart';
import 'invoicedetails.dart';

class Invoices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportsCubit()..getInvoiceBeneficary(vendorId: appStore.userId),
      child: BlocConsumer<ReportsCubit, ReportsState>(
        listener: (context, state) {},
        builder: (context, state) {
          InvoiceBeneficary? currentData;

          if (state is GetInvoicesSuccessState) {
            currentData = state.invoiceBeneficary;
          }
          if (state is SearchInvoicesSuccessState) {
            currentData = state.invoiceBeneficary;
          }

          bool hasData = currentData != null && currentData.data != null && currentData.data!.isNotEmpty;

          return Container(
            color: Theme.of(context).primaryColorDark,
            child: Stack(
              children: [
                imageBackground(context),
                Scaffold(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  appBar: defaultAppbar(title: "الفواتير", context: context),
                  body: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                          ),
                          decoration: InputDecoration(

                            labelText: 'Search',
                            hintText: 'Search for ',
                            labelStyle: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                            ),
                            prefixIcon:  Icon(Icons.search,color : Theme.of(context).primaryColorLight),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(23)),
                          ),
                          onChanged: (value) {
                            ReportsCubit.get(context).searchInvoiceNumber(value);
                          },
                        ),
                      ),
                      state is GetInvoicesLoadingState
                          ? const Center(child: CircularProgressIndicator())
                          : hasData
                          ? Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: currentData.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = currentData!.data![index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
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
                                              context:
                                                  context), // تأكد من أن لديك هذه الوظيفة معرفة بشكل صحيح
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
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
