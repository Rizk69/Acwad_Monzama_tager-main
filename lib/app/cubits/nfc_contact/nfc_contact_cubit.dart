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
  List<Product?> scannedItems = [];
  ProductBody productBody = ProductBody(productId: 0, count: 0);

  static NfcDataCubit get(context) => BlocProvider.of(context);

  void addProduct(Product product) {
    scannedItems.add(product);
    emit(AddProductScusses());
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
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
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
