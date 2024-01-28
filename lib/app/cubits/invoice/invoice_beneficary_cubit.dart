import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcard/app/models/benficary_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:smartcard/app/network/api_end_points.dart';
import 'package:smartcard/app/widgets/PaidBeneficaryScreen.dart';

part 'invoice_beneficary_state.dart';

class InvoiceBeneficaryCubit extends Cubit<InvoiceBeneficaryState> {
  InvoiceBeneficaryCubit() : super(InvoiceBeneficaryInitial());

  late PaidBeneficaryModel paidBeneficary;

  Future<void> getPaidBeneficary(
      {required int beneficaryId, required BuildContext context}) async {
    try {
      emit(GetPaidBeneficaryLoadingState());

      var paidBeneficaryId = Uri.parse(
          "${ApiHelper.getPaidBeneficary}$beneficaryId");

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

// Future<void> invoiceBeneficary({
//   required int paidBeneficaryId,
//   required int vendorId,
//   required int beneficaryId,
//   required int date,
//   required int productId,
//   required int productPrice,
// }) async {
//   try {
//     emit(GetPaidBeneficaryLoadingState());
//
//     var paidBeneficaryId = Uri.parse(ApiHelper.setInvoiceBeneficary);
//
//     Map<String, String> headers = {'Accept': 'application/json'};
//
//     Map<String, String> body = {
//       'paidBeneficaryId': 'paidBeneficaryId',
//       'vendorId': 'vendorId',
//       'beneficaryId': 'beneficaryId',
//       'date': 'date',
//       'productId': 'date',
//       'productPrice': 'date',
//     };
//
//     var response =
//     await http.post(paidBeneficaryId, body: body, headers: headers);
//
//     if (response.statusCode == 200) {
//       emit(GetPaidBeneficarySuccessState());
//     } else {
//       emit(GetPaidBeneficaryErrorState("Error"));
//     }
//   } catch (e) {
//     print(e.toString());
//     emit(GetPaidBeneficaryErrorState(e.toString()));
//   }
// }
