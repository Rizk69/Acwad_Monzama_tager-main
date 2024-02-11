import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartcard/app/utils/default_snake_bar.dart';
import 'package:smartcard/app/utils/resource/color_manager.dart';
import 'package:smartcard/app/widgets/backgrond_image.dart';
import 'package:smartcard/app/widgets/default_appbar.dart';
import 'package:smartcard/main.dart';
import '../../models/ProductModel.dart';
import '../../models/benficary_data_model.dart';
import 'nfc_contact_cubit/nfc_contact_cubit.dart';

class AddInvoice extends StatelessWidget {
  PaidBeneficaryModel paidBeneficaryModel;
  int index;

  AddInvoice(
      {super.key, required this.paidBeneficaryModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => NfcDataCubit()
          ..getCategoryInvoiceShow(
              idCategory: paidBeneficaryModel.paidBeneficary!.date![index].id!),
        child: Container(
          color: Theme.of(context).canvasColor,
          child: Stack(
            children: [
              imageBackground(context),
              Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                appBar: defaultAppbar(title: "إصدار فاتورة", context: context),
                body: BlocConsumer<NfcDataCubit, NfcDataState>(
                  listener: (context, state) {
                    if (state is BuyProductsSuccessState) {
                      final snackBar = defaultSnakeBar(
                        title: "تم",
                        message: "تم صرف الفاتوره بنجاح!",
                        state: ContentType.success,
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    }
                    if (state is BuyProductsErrorState) {
                      final snackBar = defaultSnakeBar(
                        title: "هناك خطأ!",
                        message: state.error,
                        state: ContentType.failure,
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    }
                  },
                  builder: (context, state) {
                    if (state is! NfcDataError) {
                      return SingleChildScrollView(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 3.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'اسم المستفيد',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        const SizedBox(width: 16.0),
                                        Text(
                                          '${paidBeneficaryModel.beneficary?.fullName}',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'الرصيد الحالي',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        const SizedBox(width: 16.0),
                                        Text(
                                          '${paidBeneficaryModel.paidBeneficary?.date?[index].paidMoney}',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'الرصيد الدفعة المتبقي',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        const SizedBox(width: 16.0),
                                        Text(
                                          '${paidBeneficaryModel.paidBeneficary?.date?[index].residualMoney}',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "اختار منتج",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 16.0),
                                        DropdownButton(
                                          items: NfcDataCubit.get(context)
                                              .productModel
                                              .product!
                                              .map((product) {
                                            return DropdownMenuItem(
                                              value: product.name,
                                              child: Text(
                                                  product.name ?? 'notFound',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  )),
                                            );
                                          }).toList(),
                                          onChanged: (String? selectedValue) {
                                            if (selectedValue != null) {
                                              Product? selectedProduct =
                                                  NfcDataCubit.get(context)
                                                      .productModel
                                                      .product!
                                                      .firstWhere((product) =>
                                                          product.name ==
                                                          selectedValue);
                                              NfcDataCubit.get(context)
                                                  .addProduct(selectedProduct);
                                            }
                                          },
                                          icon: Icon(
                                            Icons.list_alt,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Text(
                                'مجموع الفاتورة  : ${NfcDataCubit.get(context).calculateTotalPrice().toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                                // Ad
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 3,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    children: [
                                      DataTable(
                                        columns: [
                                          DataColumn(
                                              label: Text('الرقم',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor))),
                                          DataColumn(
                                              label: Text('المادة',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor))),
                                          DataColumn(
                                              label: Text('السعر',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor))),
                                          DataColumn(
                                              label: Text('الكمية',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor))),
                                          DataColumn(
                                              label: Text('',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor))),
                                        ],
                                        rows: List<DataRow>.generate(
                                          NfcDataCubit.get(context)
                                              .scannedItems
                                              .length,
                                          (index) {
                                            final product =
                                                NfcDataCubit.get(context)
                                                    .scannedItems[index];
                                            return DataRow(cells: [
                                              DataCell(Text(
                                                  (index + 1).toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor))),
                                              DataCell(Text(
                                                  product?.name ?? 'Unknown',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor))),
                                              DataCell(Text(
                                                  product?.price.toString() ??
                                                      'Unknown',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor))),
                                              DataCell(
                                                TextFormField(
                                                  initialValue: product?.count
                                                          .toString() ??
                                                      '0',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  onChanged: (newValue) {
                                                    int newCount = int.tryParse(
                                                            newValue) ??
                                                        0;

                                                    // if (product != null) {
                                                    product?.count = newCount;
                                                    // }
                                                  },
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                              ),
                                              DataCell(IconButton(
                                                color: ColorManager.error,
                                                onPressed: () {
                                                  NfcDataCubit.get(context)
                                                      .removeProduct(
                                                          index, product!);
                                                },
                                                icon: const Icon(Icons.delete),
                                              )),
                                            ]);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.pt, vertical: 5.pt),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                ColorManager.baseYellow),
                                      ),
                                      onPressed: () {
                                        var now = DateTime.now();
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd', 'en')
                                                .format(now);
                                        NfcDataCubit.get(context)
                                            .convertScannedItemsToProductsBody(
                                                context: context,
                                                paidmoney: int.parse(
                                                    NfcDataCubit.get(context)
                                                        .calculateTotalPrice()
                                                        .toStringAsFixed(0)),
                                                vendorId: appStore.userId,
                                                paidBeneficaryId:
                                                    paidBeneficaryModel
                                                        .paidBeneficary!
                                                        .date![index]
                                                        .id!,
                                                beneficaryId:
                                                    paidBeneficaryModel
                                                        .beneficary!.id!,
                                                date: formattedDate);
                                      },
                                      child: const Text(
                                        'شراء',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: Lottie.asset(
                        'assets/images/empty_invoice.json',
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
