import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smartcard/app/models/benficary_data_model.dart';
import 'package:smartcard/app/models/invoice.dart';
import 'package:smartcard/app/network/api_end_points.dart';
import 'package:http/http.dart' as http;
import 'package:smartcard/app/widgets/print_beneficary_Invoice.dart';
part 'beneficary_state.dart';

class BeneficaryCubit extends Cubit<BeneficaryState> {
  BeneficaryCubit() : super(BeneficaryInitial());

  static BeneficaryCubit get(context) => BlocProvider.of(context);

  Future<void> sendSignature(
      {required String invoiceNumber,
      required File file,
      required Invoice beneficaryInvoice}) async {
    var signatureUrl =
        Uri.parse("${ApiHelper.setBeneficarySignature}$invoiceNumber");

    var request = http.MultipartRequest('POST', signatureUrl)
      ..headers.addAll({'Accept': 'application/json'})
      ..files.add(await http.MultipartFile.fromPath('image', file.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Signature uploaded successfully');
      emit(SendSignatureBeneficarySuccessState());
      printInvoice(beneficaryInvoice);
    } else {
      print('Failed to upload signature');
      emit(SendSignatureBeneficaryErrorState('Error uploading signature'));
    }
  }


  late PaidBeneficaryModel paidBeneficary;

  // Future<void> getPaidBeneficary({required int beneficaryId}) async {
  //   try {
  //     emit(GetPaidBeneficaryLoadingState());
  //
  //     var paidBeneficaryId =
  //     Uri.parse("${ApiHelper.getPaidBeneficary}$beneficaryId");
  //
  //     Map<String, String> headers = {'Accept': 'application/json'};
  //
  //     var response = await http.get(paidBeneficaryId, headers: headers);
  //     if (response.statusCode == 200) {
  //       var body = jsonDecode(response.body);
  //       paidBeneficary = PaidBeneficaryModel.fromJson(body);
  //       print(paidBeneficary.beneficary?.fullName ?? 'No name available');
  //       if (paidBeneficary.message == 'Success') {
  //         emit(GetPaidBeneficarySuccessState());
  //       } else {
  //         emit(GetPaidBeneficaryErrorState(paidBeneficary.message.toString()));
  //       }
  //     } else {
  //       emit(GetPaidBeneficaryErrorState('Failed to load data'));
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     emit(GetPaidBeneficaryErrorState(e.toString()));
  //   }
  // }


}
