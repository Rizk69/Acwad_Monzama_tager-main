import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcard/app/models/ProductModel.dart';

import '../../models/model_keys.dart';
import '../../network/api_end_points.dart';

import 'package:http/http.dart' as http;

part 'nfc_contact_state.dart';

class NfcDataCubit extends Cubit<NfcDataState> {
  NfcDataCubit() : super(NfcDataInitial());

  List<Product?> scannedItems = [];
  ProductBody productBody = ProductBody(productId: 0, count: 0);

  void addProduct(Product product) {
    scannedItems.add(product);
    emit(AddProductScusses());
  }

  Future<void> getCategoryInvoiceShow({
    required int idCategory,
    required BuildContext context,
  }) async {
    try {
      var paidBeneficaryId =
          Uri.parse("${ApiHelper.getProductBeneficary}$idCategory");

      Map<String, String> headers = {'Accept': 'application/json'};

      var response = await http.get(paidBeneficaryId, headers: headers);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        ProductModel productModel = ProductModel.fromJson(body);
        if (productModel.message == 'Success') {
        } else {
          emit(NfcDataError(
              'Failed to load data: ${productModel.message ?? 'Not Found'}'));
        }
      } else {
        emit(const NfcDataError('Failed to load data'));
      }
    } catch (e) {
      emit(NfcDataError('Failed to load data: ${e.toString()}'));
    }
  }

  Future<void> invoiceBeneficaryCategory({
    required int paidBeneficaryId,
    required int vendorId,
    required int beneficaryId,
    required int date,
  }) async {
    try {
      var paidBeneficaryId = Uri.parse(ApiHelper.setInvoiceBeneficary);

      Map<String, String> headers = {'Accept': 'application/json'};

      Map<String, List<String>> body = {
        'Product': ["$productBody"]
      };

      var response =
          await http.post(paidBeneficaryId, body: body, headers: headers);

      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }


  makeCashPayment({
    required int paidBeneficaryId,
    required int vendorId,
    required int beneficaryId,
  }) async {
    emit(MakeCashLoadingState());

    var cashURL = Uri.parse("${ApiHelper.setInvoiceBeneficary}?PaidBeneficaryId=$paidBeneficaryId&vendorId=$vendorId&beneficaryId=$beneficaryId&date=2024-1-28");

    Map<String, String> headers = {'Accept': 'application/json'};

    await http.post(cashURL, headers: headers).then((value) {
      if (value.statusCode == 200) {
        emit(MakeCashSuccessState());
      }
    }).catchError((onError) {
      print(onError);
      emit(MakeCashErrorState(onError.toString()));
    });
  }

}

class ProductBody {
  int? productId;
  int? count;

  ProductBody({this.productId, this.count});
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
