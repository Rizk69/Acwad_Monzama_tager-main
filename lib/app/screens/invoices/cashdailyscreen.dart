import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../main.dart';
import '../../models/CategoriesModel.dart';
import '../../utils/routes_manager.dart';
import '../../widgets/backgrond_image.dart';
import '../../widgets/default_appbar.dart';
import 'cubit/reports_cubit.dart';
import 'detailsDailyScreen.dart';

class CashDailyScreen extends StatelessWidget {
  const CashDailyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ReportsCubit()..getCategory(vendorId: appStore.userId),
        child: BlocConsumer<ReportsCubit, ReportsState>(
            listener: (BuildContext context, ReportsState state) {},
            builder: (context, state) {
              CategoriesModel? currentData;

              if (state is GetCategorySuccessState) {
                currentData = state.categoriesModel;
              }
              return state is! GetCategoryLoadingState
                  ? Container(
                      color: Theme.of(context).canvasColor,
                      child: Stack(children: [
                        imageBackground(context),
                        Scaffold(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            appBar: defaultAppbar(
                                title: "المبيعات", context: context),
                            body: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailsDailyScreen(
                                              categoriesModel: currentData!,
                                              index: index,
                                            ),
                                          ),
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                    currentData
                                                            ?.categories?[index]
                                                            .name ??
                                                        '',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17)),
                                                Text(
                                                    "${currentData?.categories?[index].price ?? ''}",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColorLight)),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Image.asset(
                                              'assets/images/Rectangle 3343.png',
                                              height: 60,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    itemCount: currentData?.categories?.length,
                                  ),
                                )
                              ],
                            ))
                      ]))
                  : const Center(child: CircularProgressIndicator());
            }));
  }
}
