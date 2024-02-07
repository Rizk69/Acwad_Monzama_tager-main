import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcard/app/models/CategoriesModel.dart';
import 'package:smartcard/app/screens/invoices/beneficary_ivoices.dart';
import 'package:smartcard/main.dart';

import '../../widgets/backgrond_image.dart';
import '../../widgets/default_appbar.dart';
import 'cubit/reports_cubit.dart';

class DetailsDailyScreen extends StatelessWidget {
  CategoriesModel categoriesModel;
  int index;

  DetailsDailyScreen(
      {super.key, required this.categoriesModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportsCubit()
        ..getDetailsCategory(
            vendorId: appStore.userId,
            id: categoriesModel.categories?[index].id ?? 0),
      child: BlocConsumer<ReportsCubit, ReportsState>(
        listener: (context, state) {},
        builder: (context, state) {
          CategoriesDetailsModel? currentData;

          if (state is GetCategoryDetailsSuccessState) {
            currentData = state.categoriesDetailsModel;
          }
          return Container(
              color: Theme.of(context).canvasColor,
              child: Stack(children: [
                imageBackground(context),
                Scaffold(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    appBar: defaultAppbar(
                        title: categoriesModel.categories?[index].name ?? '',
                        context: context),
                    body: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        state is! GetCategoryDetailsLoadingState
                            ? Expanded(
                                child: ListView.builder(
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => BeneficaryInvoices(beneficary: currentData!.beneficary![index],)),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: Color(0XFFF0CF87),
                                              width: 1)),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                            Text('اسم المستفيد:  ',
                                                style: TextStyle(
                                                    color: Theme.of(context).primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17)),
                                            Text(
                                                  currentData
                                                          ?.beneficary?[index]
                                                          .beneficaryName ??
                                                      '',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColorLight)),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('قيمة المبيعات : ',
                                                style: TextStyle(
                                                    color: Theme.of(context).primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17)),
                                              Text(
                                                  "${currentData?.beneficary?[index].tprice ?? ''}",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColorLight)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  itemCount: currentData?.beneficary?.length,
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                  ),
                                  Align(
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator())
                                ],
                              )
                      ],
                    ))
              ]));
        },
      ),
    );
  }
}
