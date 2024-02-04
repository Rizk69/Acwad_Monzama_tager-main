import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:smartcard/app/models/invoice.dart';
import 'package:smartcard/app/models/invoice_beneficary.dart';
import 'package:smartcard/app/models/model_keys.dart';
import 'package:smartcard/app/network/api_end_points.dart';
import 'package:smartcard/app/network/app_api.dart';
import 'package:smartcard/main.dart';
part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  static ReportsCubit get(context) => BlocProvider.of(context);



  ReportsCubit() : super(InvoicesInitial());


  late InvoiceBeneficary invoiceBeneficary;

  Future<void> getInvoiceBeneficary({required int vendorId}) async {
    try {
      emit(
          GetInvoicesLoadingState()); // Emit a loading state before making the API call

      print(vendorId);

      var loginURL = Uri.parse("${ApiHelper.invoiceBeneficary}$vendorId");

      Map<String, String> headers = {'Accept': 'application/json'};

      var response = await http.get(loginURL, headers: headers);

      var body = jsonDecode(response.body);

      if (body["data"] != null) {
        invoiceBeneficary = InvoiceBeneficary.fromJson(body);
        emit(GetInvoicesSuccessState());
      } else {
        emit(GetInvoicesErrorState("لا توجد فواتير متاحة"));
      }
    } catch (e) {
      print(e.toString());
      emit(GetInvoicesErrorState(e.toString()));
    }
  }

  late InvoiceBeneficary allInvoiceBeneficary;

  Future<void> getAllInvoiceBeneficary() async {
    try {
      emit(GetAllInvoicesLoadingState());

      var allBeneficarySystemUrl = Uri.parse(ApiHelper.getAllBeneficary);

      Map<String, String> headers = {'Accept': 'application/json'};

      var response = await http.get(allBeneficarySystemUrl, headers: headers);
      print(response.statusCode);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        allInvoiceBeneficary = InvoiceBeneficary.fromJson(body);
        emit(GetAllInvoicesSuccessState());
      } else {
        emit(GetAllInvoicesErrorState());
      }
    } catch (e) {
      emit(GetAllInvoicesErrorState());
    }
  }

  late InvoiceBeneficary dailyInvoiceBeneficary;

  Future<void> getDailyInvoiceBeneficary({required int vendorID}) async {
    try {
      emit(GetDailyInvoicesLoadingState());

      var dailyBeneficarySystemUrl =
          Uri.parse("${ApiHelper.getDailyBeneficary}$vendorID");

      Map<String, String> headers = {'Accept': 'application/json'};

      var response = await http.get(dailyBeneficarySystemUrl, headers: headers);
      print(response.statusCode);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        dailyInvoiceBeneficary = InvoiceBeneficary.fromJson(body);
        emit(GetDailyInvoicesSuccessState());
      } else {
        emit(GetDailyInvoicesErrorState());
      }
    } catch (e) {
      emit(GetDailyInvoicesErrorState());
    }
  }
}
