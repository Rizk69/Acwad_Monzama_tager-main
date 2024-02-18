import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smartcard/app/models/ProductModel.dart';
import 'package:smartcard/app/models/benficary_data_model.dart';
import 'package:smartcard/app/models/invoice.dart';
import 'package:smartcard/app/models/invoice_beneficary.dart';
import 'package:smartcard/app/models/offline_model.dart';
import 'package:smartcard/app/utils/SignatureScreen.dart';
import 'package:smartcard/app/utils/helper/database_helper.dart';
import 'package:smartcard/app/widgets/print_beneficary_Invoice.dart';
import 'package:http/http.dart' as http;

import '../../../network/api_end_points.dart';

part 'nfc_contact_state.dart';

class NfcDataCubit extends Cubit<NfcDataState> {
  NfcDataCubit() : super(NfcDataInitial());
  ProductBody productBody = ProductBody(id: 0, count: 0);
  List<OffLineRequest> offLineRequest = [];

  static NfcDataCubit get(context) => BlocProvider.of(context);

  Map<int, ProductData?> scannedItemsMap = {};
  List<ProductData?> scannedItems = [];

  void addProduct(ProductData product) {
    emit(AddProductLoading());

    final existingProduct = scannedItemsMap[product.id];
    if (existingProduct != null && existingProduct.count == 0) {
      existingProduct.count = 1;
    } else if (existingProduct == null) {
      scannedItemsMap[product.id!] = product.copyWith(count: 1);
    }

    scannedItems = scannedItemsMap.values.toList();
    emit(AddProductSuccess());
  }

  void removeProduct(int index, ProductData product) {
    emit(RemoveProductLoading());
    scannedItemsMap.remove(product.id);
    scannedItems.remove(product);
    emit(RemoveProductSuccess());
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (ProductData? product in scannedItems) {
      if (product != null && product.price != null) {
        totalPrice += product.price! * product.count!;
      }
    }
    return totalPrice;
  }

  List<ProductBody> productsBody = [];

  void convertScannedItemsToProductsBody(
      {required int paidBeneficaryId,
      required int vendorId,
      required int beneficaryId,
      required double paidmoney,
      required InvoiceData data,
      required String date,
      required BuildContext context}) {
    productsBody = scannedItems.map((ProductData? product) {
      if (product != null) {
        return ProductBody(
          id: product.id ?? 0,
          count: product.count ?? 0,
        );
      } else {
        return ProductBody(id: 0, count: 0);
      }
    }).toList();
    sellProduct(
      context: context,
      date: date,
      paidBeneficaryId: paidBeneficaryId,
      beneficaryId: beneficaryId,
      vendorId: vendorId,
      paidmoney: paidmoney,
      data: data,
    );
  }

  ProductModel productModel = ProductModel(message: '', product: []);

  Future<bool> getCategoryInvoiceShow({
    required int idCategory,
  }) async {
    try {
      emit(NfcDataLoading());
      bool isConnected = await ApiHelper().connectedToInternet();

      if (isConnected) {
        var paidBeneficaryId =
            Uri.parse("${ApiHelper.getProductBeneficary}$idCategory");
        Map<String, String> headers = {'Accept': 'application/json'};

        var response = await http.get(paidBeneficaryId, headers: headers);
        var body = jsonDecode(response.body);

        if (response.statusCode == 200 && body['product'].length > 0) {
          productModel = ProductModel.fromJson(body);
          if (productModel.message == 'Success') {
            emit(NfcDataLoaded());
            return true;
          } else {
            emit(NfcDataError(
                'Failed to load data: ${productModel.message ?? 'Not Found'}'));
            return false;
          }
        } else {
          emit(const NfcDataError('Failed to load data'));
          return false;
        }
      } else {
        // Fetch data from OfflineCategoriesData table when there's no internet connection
        final db = await DatabaseHelper.instance.database;
        List<Map> results = await db.query(
          'OfflineCategoriesData',
          where: 'paidBeneficiaryId = ?',
          whereArgs: [idCategory],
        );

        if (results.isNotEmpty) {
          List<ProductData> productList = results
              .map((e) => ProductData.fromJson(e.cast<String, dynamic>()))
              .toList();
          productModel = ProductModel(
            message: 'Success',
            product: productList,
          );
          emit(NfcDataLoaded());
          return true;
        } else {
          emit(const NfcDataError('No offline data available'));
          return false;
        }
      }
    } catch (e) {
      emit(NfcDataError('Failed to load data: ${e.toString()}'));
      return false;
    }
  }

  Invoice? beneficaryInvoice;

  Future<void> sellProduct(
      {required int paidBeneficaryId,
      required int vendorId,
      required int beneficaryId,
      required InvoiceData data,
      required double paidmoney,
      required String date,
      required BuildContext context}) async {
    emit(BuyProductsLoadingState());
    bool isConnected = await ApiHelper().connectedToInternet();
    if (isConnected) {
      try {
        var paidBeneficaryUrl = Uri.parse(
            "${ApiHelper.setInvoiceBeneficary}?PaidBeneficaryId=$paidBeneficaryId&vendorId=$vendorId&beneficaryId=$beneficaryId&date=$date&paidmoney=$paidmoney");

        Map<String, String> headers = {'Accept': 'application/json'};

        Map<String, dynamic> requestBody = {
          'product': productsBody.map((product) {
            return {
              'pro_id': product.id.toString(),
              'count': product.count.toString(),
            };
          }).toList(),
        };

        var response = await http.post(paidBeneficaryUrl,
            body: jsonEncode(requestBody), headers: headers);
        var body = jsonDecode(response.body);

        if (response.statusCode == 200) {
          print(body);
          beneficaryInvoice = Invoice.fromJson(body);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SignatureScreen(cashInvoice: beneficaryInvoice!)),
          );

          // printInvoice(beneficaryInvoice);
          emit(BuyProductsSuccessState());
        } else {
          emit(BuyProductsErrorState(
              "Statues code is ${response.statusCode}: and message is  ${body["message"]}"));
        }
      } catch (e) {
        emit(BuyProductsErrorState(e.toString()));
        print(e.toString());
      }
    } else {
      // Offline mode
    //   Map<String, dynamic> requestBody = {
    //     'product': productsBody.map((product) {
    //       return {
    //         'pro_id': product.id.toString(),
    //         'count': product.count.toString(),
    //       };
    //     }).toList(),
    //   };
    //   OffLineRequest offLineRequestBody = OffLineRequest(
    //     product: [ProductBody()],
    //     paidBeneficaryId: paidBeneficaryId,
    //     vendorId: vendorId,
    //     beneficaryId: beneficaryId,
    //     date: date,
    //     paidMoney: paidmoney,
    //   );
    //
    //   offLineRequest.add(offLineRequestBody);
    //   await saveOffLineRequestsToSharedPreferences(
    //       data: data, context: context);
    //   // Handle offline UI or notification
     }
  }

  Invoice? cashInvoice;

  makeCashPayment(
      {required int paidBeneficaryId,
      required int vendorId,
      required int beneficaryId,
      required String date,
      required InvoiceData data,
      required double paidMoney,
      required double residualMoney,
      required BuildContext context}) async {
    emit(MakeCashLoadingState());

    bool isConnected = await ApiHelper().connectedToInternet();

    if (isConnected) {
      var cashURL = Uri.parse(
          "${ApiHelper.setInvoiceBeneficary}?PaidBeneficaryId=$paidBeneficaryId&vendorId=$vendorId&beneficaryId=$beneficaryId&date=$date&paidmoney=$paidMoney");
      print(
          "${ApiHelper.setInvoiceBeneficary}?PaidBeneficaryId=$paidBeneficaryId&vendorId=$vendorId&beneficaryId=$beneficaryId&date=$date&paidmoney=$paidMoney");
      Map<String, String> headers = {'Accept': 'application/json'};

      await http.post(cashURL, headers: headers).then((value) {
        var body = jsonDecode(value.body);
        cashInvoice = Invoice.fromJson(body);
        print("${cashInvoice?.message}");

        if (cashInvoice?.message == 'Success') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SignatureScreen(cashInvoice: cashInvoice!),
            ),
            (route) => false,
          );

          emit(MakeCashSuccessState(cashInvoice!));
        }

        // printInvoice(cashInvoice);
      }).catchError((onError) {
        print(onError);
        print(onError.toString());
        emit(MakeCashErrorState(onError.toString()));
      });
    } else {

      final db = DatabaseHelper.instance;

      Map<String, dynamic> beneficiaryData = await db.getBeneficiaryData(beneficaryId);

      // double residualMoney = beneficiaryData['residual_money'];


      print("paidBeneficaryId $paidBeneficaryId");
      print("beneficaryId $beneficaryId");
      print("vendorId $vendorId");
      print("paidMoney $paidMoney");
      print("residualMoney $residualMoney");


      if (paidMoney > residualMoney) {
        emit(SendOnlineErrorState('Paid money is greater than the residual money.'));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('المبلغ المراد سحبه اكبر من المتاح'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Update residual_money in the database

      await db.updateResidualMoney(beneficaryId, paidMoney);

      // Offline mode
      OffLineRequest offLineRequestBody = OffLineRequest(
        products: [],
        paidBeneficaryId: paidBeneficaryId,
        vendorId: vendorId,
        beneficaryId: beneficaryId,
        date: date,
        paidMoney: paidMoney,
      );

      offLineRequest.add(offLineRequestBody);
      await saveOffLineRequestsToSharedPreferences(
          data: data, context: context);
      emit(SendOnlineSuccessState());
     }
  }

  Future<void> saveOffLineRequestsToSharedPreferences(
      {required InvoiceData data, required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> offLineRequestStrings =
        offLineRequest.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('offLineRequests', offLineRequestStrings).then((value) {
      emit(SendOnlineSuccessState());
      printInvoice(
          Invoice(
            data: data,
          ),
          context);
    });

  }


  late PaidBeneficaryModel paidBeneficary;

  Future<void> getPaidBeneficary({required int beneficaryId}) async {
    try {
      emit(GetPaidBeneficaryLoadingState());

      // Fetch data from OfflinePaidBeneficiary table first
      final db = await DatabaseHelper.instance.database;
      List<Map> results = await db.query(
        'OfflinePaidBeneficiary',
        where: 'beneficiaryId = ?',
        whereArgs: [beneficaryId],
      );

      if (results.isNotEmpty) {
        List<PaidBeneficaryData> paidBeneficaryDataList = results
            .map((e) => PaidBeneficaryData.fromJson(e.cast<String, dynamic>()))
            .toList();
        paidBeneficary = PaidBeneficaryModel(
          beneficary: null, // Adjust this according to your model structure
          message: 'Success',
          paidBeneficary: PaidBeneficary(date: paidBeneficaryDataList),
        );
        emit(GetPaidBeneficarySuccessState());
      } else {
        emit(GetPaidBeneficaryErrorState('No offline data available'));
      }

      // Update data with API response if there is an internet connection
      bool isConnected = await ApiHelper().connectedToInternet();
      if (isConnected) {
        var paidBeneficaryUrl =
            Uri.parse("${ApiHelper.getPaidBeneficary}$beneficaryId");
        Map<String, String> headers = {'Accept': 'application/json'};

        var response = await http.get(paidBeneficaryUrl, headers: headers);
        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          paidBeneficary = PaidBeneficaryModel.fromJson(body);
          if (paidBeneficary.message == 'Success') {
            emit(GetPaidBeneficarySuccessState());
          } else {
            emit(
                GetPaidBeneficaryErrorState(paidBeneficary.message.toString()));
          }
        } else {
          emit(GetPaidBeneficaryErrorState('Failed to load data'));
        }
      }
    } catch (e) {
      emit(GetPaidBeneficaryErrorState(e.toString()));
    }
  }
}

class ProductBody {
  int? id;
  int? count;

  ProductBody({this.id, this.count});

  ProductBody.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['count'];
  }
}

class OffLineRequest {
  int? paidBeneficaryId;
  int? vendorId;
  int? beneficaryId;
  String? date;
  double? paidMoney;
  List<ProductBody>? products;

  OffLineRequest(
      {required this.paidBeneficaryId,
      required this.vendorId,
      required this.beneficaryId,
      required this.date,
      required this.products,
      required this.paidMoney});

  Map<String, dynamic> toJson() {
    return {
      'paidBeneficaryId': paidBeneficaryId,
      'vendorId': vendorId,
      'beneficaryId': beneficaryId,
      'date': date,
      'paidMoney': paidMoney,
      'product': products,
    };
  }



  OffLineRequest.fromJson(Map<String, dynamic> json) {
    paidBeneficaryId = json['paidBeneficaryId'];
    vendorId = json['vendorId'];
    beneficaryId = json['beneficaryId'];
    paidMoney = json['paid_money'];
    date = json['date'];
    paidMoney = json['paidMoney'];
    if (json['product'] != null) {
      products = <ProductBody>[];
      json['product'].forEach((v) {
        products!.add(ProductBody.fromJson(v));
      });
    }
  }

}
