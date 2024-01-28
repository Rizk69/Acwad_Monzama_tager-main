import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:smartcard/app/models/invoice_beneficary.dart';
import 'package:smartcard/app/network/api_end_points.dart';

import '../../../main.dart';
import '../../app.dart';
import '../../models/model_keys.dart';
import '../../network/app_api.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  static ReportsCubit get(context) => BlocProvider.of(context);

  late List<InvoiceData>? listData;
  late List<ReceiptData>? listReceiptData;

  ReportsCubit() : super(InvoicesInitial());

  Future<void> getInvoices() async {
    try {
      emit(
          InvoicesLoading()); // Emit a loading state before making the API call

      final response = await listInvoice();

      if (response.data != null) {
        listData = response.data;
        print(listData);
        emit(InvoicesDataLoaded(listData));
        appStore.setLoading(false);
      } else {
        emit(
            InvoicesError()); // Emit an error state if the data is null or empty
      }
    } catch (e) {
      print(e);
      emit(InvoicesError()); // Emit an error state with the error message
    }
  }

  Future<void> getReceipts() async {
    try {
      emit(
          InvoicesLoading()); // Emit a loading state before making the API call

      final response = await listReceipts();

      if (response.data != null) {
        listReceiptData = response.data;
        emit(ReceiptsDataLoaded(listReceiptData));
        appStore.setLoading(false);
      } else {
        emit(
            InvoicesError()); // Emit an error state if the data is null or empty
      }
    } catch (e) {
      emit(InvoicesError()); // Emit an error state with the error message
    }
  }

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
