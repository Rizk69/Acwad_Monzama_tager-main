import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcard/app/models/ProductModel.dart';
import 'package:smartcard/app/models/benficary_data_model.dart';
import 'package:smartcard/app/widgets/PaidBeneficaryScreen.dart';

import '../../models/model_keys.dart';
import '../../network/api_end_points.dart';

import 'package:http/http.dart' as http;

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
        totalPrice += product.price! *  product.count!;
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
          emit(NfcDataError('Failed to load data: ${productModel.message ?? 'Not Found'}'));
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

      var response = await http.post(paidBeneficaryUrl, body: jsonEncode(requestBody), headers: headers);
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(body);
        emit(BuyProductsSuccessState());
      } else {
        emit(BuyProductsErrorState("Statues code is ${response.statusCode}: and message is  ${body["message"]}"));
      }
    } catch (e) {
      emit(BuyProductsErrorState(e.toString()));
      print(e.toString());
    }
  }



  makeCashPayment({
    required int paidBeneficaryId,
    required int vendorId,
    required int beneficaryId,
    required String date,
  }) async {
    emit(MakeCashLoadingState());

    print(vendorId);
    print(beneficaryId);
    print(paidBeneficaryId);
    print(date);

    var cashURL = Uri.parse(
        "${ApiHelper.setInvoiceBeneficary}?PaidBeneficaryId=$paidBeneficaryId&vendorId=$vendorId&beneficaryId=$beneficaryId&date=$date");

    Map<String, String> headers = {'Accept': 'application/json'};

    await http.post(cashURL, headers: headers).then((value) {
      var body = jsonDecode(value.body);
      print(body['message']);
      emit(MakeCashSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(MakeCashErrorState(onError.toString()));
    });
  }

  late PaidBeneficaryModel paidBeneficary;

  Future<void> getPaidBeneficary(
      {required int beneficaryId, required BuildContext context}) async {
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PaidBeneficaryScreen(paidBeneficaryModel: paidBeneficary),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(paidBeneficary.message ?? 'Not Found'),
              backgroundColor: Colors.red,
            ),
          );
        }

        emit(GetPaidBeneficarySuccessState());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load data'),
            backgroundColor: Colors.red,
          ),
        );
        // في حالة فشل الاستجابة، يتم إصدار حالة خطأ
        emit(GetPaidBeneficaryErrorState('Failed to load data'));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );

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

// setInvoice(InvoiceData invoice) async {
//   if (!await isNetworkAvailable()) {
//     await dbHelper.saveInvoice(invoice);
//     final newBalance = savedContact.balance! - (invoice.total ?? 0);
//     await dbHelper.updateContactBalance(savedContact.id, newBalance);
//     emit(InvoiceDataLoaded(invoice, savedContact, ''));
//   } else {
//     Map request = invoice.toJson();
//     appStore.setLoading(true);
//     await addInvoice(request).then((res) async {
//       if (res.status == true) {
//         final newBalance = savedContact.balance! - (invoice.total ?? 0);
//         await dbHelper.updateContactBalance(savedContact.id, newBalance);
//         emit(InvoiceDataLoaded(invoice, savedContact, res.data ?? ''));
//         toast("تم تسجيل الفاتورة");
//       } else {
//         toast(res.message.toString());
//         await dbHelper.saveInvoice(invoice);
//         final newBalance = savedContact.balance! - (invoice.total ?? 0);
//         await dbHelper.updateContactBalance(savedContact.id, newBalance);
//       }
//     });
//   }
//   // Emit the NfcDataLoaded state with the contact data
// }
// static NfcDataCubit get(context) => BlocProvider.of(context);
//
// void setContact(ContactData contact) async {
//   // savedContact = contact;
//   // emit(NfcDataLoaded(contact));
//   // List<InvoiceData> data = await dbHelper.getAllInvoices();
// }
