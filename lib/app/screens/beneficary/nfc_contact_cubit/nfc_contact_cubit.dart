import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcard/app/models/ProductModel.dart';
import 'package:smartcard/app/models/benficary_data_model.dart';
import 'package:smartcard/app/models/invoice.dart';
import 'package:smartcard/app/utils/SignatureScreen.dart';
import 'package:smartcard/app/widgets/print_beneficary_Invoice.dart';
import 'package:http/http.dart' as http;

import '../../../network/api_end_points.dart';

part 'nfc_contact_state.dart';

class NfcDataCubit extends Cubit<NfcDataState> {
  NfcDataCubit() : super(NfcDataInitial());
  ProductModel productModel = ProductModel(message: '', product: []);
  ProductBody productBody = ProductBody(id: 0, count: 0);

  static NfcDataCubit get(context) => BlocProvider.of(context);

  List<Product?> scannedItems = [];
  void addProduct(Product product) {
    emit(AddProductLoading());

    int index = scannedItems.indexWhere((p) => p?.id == product.id);
    if (index != -1) {
      scannedItems[index]?.count = (scannedItems[index]?.count ?? 0) + 1;
    } else {
      product.count = 1;
      scannedItems.add(product);
    }
    emit(AddProductSuccess());
  }

  removeProduct(int index) {
    emit(RemoveProductLoading());
    scannedItems.removeAt(index);
    emit(RemoveProductSuccess());
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (Product? product in scannedItems) {
      if (product != null && product.price != null) {
        totalPrice += product.price! * product.count!;
      }
    }
    return totalPrice;
  }

  List<ProductBody> productsBody = [];
  void convertScannedItemsToProductsBody({
    required int paidBeneficaryId,
    required int vendorId,
    required int beneficaryId,
    required int paidmoney,
    required String date,
  }) {
    productsBody = scannedItems.map((Product? product) {
      if (product != null) {
        return ProductBody(
          id: product.id ?? 0,
          count: product.count ?? 0,
        );
      } else {
        return ProductBody(id: 0, count: 0);
      }
    }).toList();
    invoiceBeneficaryCategory(
      date: date,
      paidBeneficaryId: paidBeneficaryId,
      beneficaryId: beneficaryId,
      vendorId: vendorId,
      paidmoney: paidmoney,
    );
  }

  Future<bool> getCategoryInvoiceShow({
    required int idCategory,
  }) async {
    try {
      emit(NfcDataLoading());
      var paidBeneficaryId =
          Uri.parse("${ApiHelper.getProductBeneficary}$idCategory");

      Map<String, String> headers = {'Accept': 'application/json'};

      var response = await http.get(paidBeneficaryId, headers: headers);
      var body = jsonDecode(response.body);

      if (response.statusCode == 200 && body['product'].length > 0) {
        productModel = ProductModel.fromJson(body);
        if (productModel.message == 'Success') {
          print(productModel.message);
          print(productModel.product?.first.name.toString());
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
    } catch (e) {
      emit(NfcDataError('Failed to load data: ${e.toString()}'));

      return false;
    }
  }

  Invoice? beneficaryInvoice;

  Future<void> invoiceBeneficaryCategory({
    required int paidBeneficaryId,
    required int vendorId,
    required int beneficaryId,
    required int paidmoney,
    required String date,
  }) async {
    emit(MakeCashLoadingState());
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
        printInvoice(beneficaryInvoice);
        emit(BuyProductsSuccessState());
      } else {
        emit(BuyProductsErrorState(
            "Statues code is ${response.statusCode}: and message is  ${body["message"]}"));
      }
    } catch (e) {
      emit(BuyProductsErrorState(e.toString()));
      print(e.toString());
    }
  }

  Invoice? cashInvoice;

  makeCashPayment(
      {required int paidBeneficaryId,
      required int vendorId,
      required int beneficaryId,
      required String date,
      required double paidMoney,
      required BuildContext context}) async {
    emit(MakeCashLoadingState());

    var cashURL = Uri.parse(
        "${ApiHelper.setInvoiceBeneficary}?PaidBeneficaryId=$paidBeneficaryId&vendorId=$vendorId&beneficaryId=$beneficaryId&date=$date&paidmoney=$paidMoney");

    Map<String, String> headers = {'Accept': 'application/json'};

    await http.post(cashURL, headers: headers).then((value) {
      var body = jsonDecode(value.body);
      cashInvoice = Invoice.fromJson(body);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignatureScreen(cashInvoice: cashInvoice!)),
      );
      emit(MakeCashSuccessState(cashInvoice!));

      // printInvoice(cashInvoice);
    }).catchError((onError) {
      print(onError);
      emit(MakeCashErrorState(onError.toString()));
    });
  }

  late PaidBeneficaryModel paidBeneficary;

  Future<void> getPaidBeneficary({required int beneficaryId}) async {
    try {
      emit(GetPaidBeneficaryLoadingState());

      var paidBeneficaryId =
          Uri.parse("${ApiHelper.getPaidBeneficary}$beneficaryId");

      Map<String, String> headers = {'Accept': 'application/json'};

      var response = await http.get(paidBeneficaryId, headers: headers);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        paidBeneficary = PaidBeneficaryModel.fromJson(body);
        print(paidBeneficary.beneficary?.fullName ?? 'No name available');
        if (paidBeneficary.message == 'Success') {
          emit(GetPaidBeneficarySuccessState());
        } else {
          emit(GetPaidBeneficaryErrorState(paidBeneficary.message.toString()));
        }
      } else {
        emit(GetPaidBeneficaryErrorState('Failed to load data'));
      }
    } catch (e) {
      print(e.toString());
      emit(GetPaidBeneficaryErrorState(e.toString()));
    }
  }
}

class ProductBody {
  int? id;
  int? count;

  ProductBody({this.id, this.count});
}
