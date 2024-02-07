import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcard/app/models/PaidProjectDetailsModel.dart';
import 'package:smartcard/app/models/invoice.dart';
import 'package:smartcard/app/network/api_end_points.dart';
import 'package:http/http.dart' as http;
import 'package:smartcard/app/widgets/print_beneficary_Invoice.dart';

import '../../../models/Paid_Reportis.dart';

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

  // late PaidBeneficaryModel paidBeneficary;

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

  late PaidReportis paidReportis;

  Future<void> getAllPaidProject({required int vendorId}) async {
    try {
      emit(GetAllPaidProjectLoadingState());

      print(vendorId);

      var loginURL = Uri.parse("${ApiHelper.getAllPaidProject}$vendorId");

      Map<String, String> headers = {'Accept': 'application/json'};

      var response = await http.get(loginURL, headers: headers);

      var body = jsonDecode(response.body);

      if (body["message"] == 'Success') {
        paidReportis = PaidReportis.fromJson(body);
        emit(GetAllPaidProjectSuccessState(paidReportis));
      } else {
        emit(GetAllPaidProjectErrorState("لا توجد فواتير متاحة"));
      }
    } catch (e) {
      print(e.toString());
      emit(GetAllPaidProjectErrorState(e.toString()));
    }
  }

  ///////////////////
  late PaidProjectDetails paidProjectDetails;
  Future<void> getPaidProjectDetails({required int paidBenficaryId}) async {
    try {
      emit(GetPaidProjectDetailsLoadingState());
      print(paidBenficaryId);
      var loginURL =
          Uri.parse("${ApiHelper.getPaidProjectDetails}$paidBenficaryId");

      Map<String, String> headers = {'Accept': 'application/json'};

      var response = await http.get(loginURL, headers: headers);

      var body = jsonDecode(response.body);

      if (body["message"] == 'Success') {
        paidProjectDetails = PaidProjectDetails.fromJson(body);
        emit(GetPaidProjectDetailsSuccessState(paidProjectDetails));
      } else {
        emit(GetPaidProjectDetailsErrorState("لا توجد فواتير متاحة"));
      }
    } catch (e) {
      print(e.toString());
      emit(GetPaidProjectDetailsErrorState(e.toString()));
    }
  }
}
