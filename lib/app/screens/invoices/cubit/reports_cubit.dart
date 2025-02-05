import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:smartcard/app/models/invoice_beneficary.dart';
import 'package:smartcard/app/network/api_end_points.dart';

import '../../../models/CategoriesModel.dart';
import '../../../utils/helper/database_helper.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  static ReportsCubit get(context) => BlocProvider.of(context);
  final db =  DatabaseHelper.instance;

  ReportsCubit() : super(InvoicesInitial());


  late InvoiceBeneficary allInvoiceBeneficary;

  Future<void> getAllInvoiceBeneficary() async {
    emit(GetAllInvoiceBeneficaryLoadingState());
    bool isConnected = await ApiHelper().connectedToInternet();

    if (isConnected) {
      try {
        var allBeneficarySystemUrl = Uri.parse(ApiHelper.getAllBeneficary);
        Map<String, String> headers = {'Accept': 'application/json'};
        var response = await http.get(allBeneficarySystemUrl, headers: headers);

        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          allInvoiceBeneficary = InvoiceBeneficary.fromJson(body);

          // Save to SQLite
          await db.saveDataToSQLite(allInvoiceBeneficary);
          emit(GetAllInvoicesSuccessState(allInvoiceBeneficary));

        } else {
          emit(GetAllInvoicesErrorState("Error Data"));
        }
      } catch (e) {
        emit(GetAllInvoicesErrorState(e.toString()));
      }
    } else {
      // Fetch from SQLite
      try {
        var invoiceBeneficaryFromDB = await db.fetchDataFromSQLite();
        emit(GetAllInvoicesSuccessState(invoiceBeneficaryFromDB));
      } catch (e) {
        print(e.toString());
        emit(GetAllInvoicesErrorState(e.toString()));
      }
    }
  }

  /////////////////////
  late InvoiceBeneficary invoiceBeneficary;

  Future<void> getInvoiceBeneficary({required int vendorId}) async {
    bool isConnected = await ApiHelper().connectedToInternet();

    if (isConnected) {
      try {
        emit(GetInvoicesLoadingState());


        var loginURL = Uri.parse("${ApiHelper.invoiceBeneficary}$vendorId");

        Map<String, String> headers = {'Accept': 'application/json'};

        var response = await http.get(loginURL, headers: headers);

        var body = jsonDecode(response.body);

        if (body["data"] != null) {
          invoiceBeneficary = InvoiceBeneficary.fromJson(body);
          await db.saveInvoiceBeneficary(invoiceBeneficary);

          emit(GetInvoicesSuccessState(invoiceBeneficary));
        } else {
          emit(GetInvoicesErrorState("لا توجد فواتير متاحة"));
        }
      } catch (e) {
        print(e.toString());
        emit(GetInvoicesErrorState(e.toString()));
      }
    } else {
      try {
        var invoiceBeneficaryFromDB = await db.fetchInvoiceBeneficary();
        emit(GetInvoicesSuccessState(invoiceBeneficaryFromDB));
      } catch (e) {
        print(e.toString());
        emit(GetInvoicesErrorState(e.toString()));
      }
    }
  }


///////////////////////////////
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
        emit(GetDailyInvoicesErrorState("error "));
      }
    } catch (e) {
      emit(GetDailyInvoicesErrorState(e.toString()));
    }
  }



  ///////////////////////////////
  late CategoriesModel categoriesModel;

  Future<void> getCategory({required int vendorId}) async {
    try {
      emit(GetCategoryLoadingState());

      print(vendorId);

      var loginURL = Uri.parse("${ApiHelper.getCategory}$vendorId");

      Map<String, String> headers = {'Accept': 'application/json'};

      var response = await http.get(loginURL, headers: headers);

      var body = jsonDecode(response.body);

      if (body["message"] == 'Success') {
        categoriesModel = CategoriesModel.fromJson(body);
        emit(GetCategorySuccessState(categoriesModel));
      } else {
        emit(GetCategoryErrorState("لا توجد فواتير متاحة"));
      }
    } catch (e) {
      print(e.toString());
      emit(GetCategoryErrorState(e.toString()));
    }
  }

  late CategoriesDetailsModel categoriesDetailsModel;

  Future<void> getDetailsCategory(
      {required int vendorId, required int id}) async {
    try {
      emit(GetCategoryDetailsLoadingState());

      var loginURL = Uri.parse("${ApiHelper.getDetailsCategory}$id/$vendorId");

      Map<String, String> headers = {'Accept': 'application/json'};

      var response = await http.get(loginURL, headers: headers);

      var body = jsonDecode(response.body);

      if (body["message"] == 'Success') {
        categoriesDetailsModel = CategoriesDetailsModel.fromJson(body);
        emit(GetCategoryDetailsSuccessState(categoriesDetailsModel));
      } else {
        emit(GetCategoryDetailsErrorState("لا توجد فواتير متاحة"));
      }
    } catch (e) {
      print(e.toString());
      emit(GetCategoryDetailsErrorState(e.toString()));
    }
  }

  void searchInvoiceNumber(String query) async {
    emit(SearchInvoicesLoadingState());
    try {
      InvoiceBeneficary originalData = invoiceBeneficary;

      if (query.isEmpty) {
        emit(SearchInvoicesSuccessState(originalData));
        return;
      }

      final filteredData = originalData.data?.where((invoice) {
            final invoiceNo = invoice.invoiceNo;
            final name = invoice.fullName;
            final cash_Category = invoice.cashOrCategory;
            final vendor = invoice.vendorName;

            if (invoiceNo != null &&
                invoiceNo.toLowerCase().contains(query.toLowerCase())) {
              return true;
            }

            if (name != null &&
                name.toLowerCase().contains(query.toLowerCase())) {
              return true;
            }
            if (cash_Category != null &&
                cash_Category.toLowerCase().contains(query.toLowerCase())) {
              return true;
            }
            if (vendor != null &&
                vendor.toLowerCase().contains(query.toLowerCase())) {
              return true;
            }
            return false;
          }).toList() ??
          [];

      if (filteredData.isNotEmpty) {
        final resultModel =
            InvoiceBeneficary(message: "نتائج البحث", data: filteredData);
        emit(SearchInvoicesSuccessState(resultModel));
      } else {
        emit(SearchInvoicesErrorState("لم يتم العثور على فواتير مطابقة"));
      }
    } catch (e) {
      emit(SearchInvoicesErrorState(e.toString()));
    }
  }

  void searchInvoiceBeneficaryNumber(String query) async {
    emit(SearchInvoiceBeneficaryLoadingState());
    try {
      InvoiceBeneficary originalData = allInvoiceBeneficary;

      if (query.isEmpty) {
        emit(SearchAllInvoiceBeneficarySuccessState(originalData));
        return;
      }

      final filteredData = originalData.data?.where((invoice) {
            final invoiceNo = invoice.invoiceNo;
            final name = invoice.fullName;
            final cash_Category = invoice.cashOrCategory;
            final vendor = invoice.vendorName;

            if (invoiceNo != null &&
                invoiceNo.toLowerCase().contains(query.toLowerCase())) {
              return true;
            }

            if (name != null &&
                name.toLowerCase().contains(query.toLowerCase())) {
              return true;
            }
            if (cash_Category != null &&
                cash_Category.toLowerCase().contains(query.toLowerCase())) {
              return true;
            }
            if (vendor != null &&
                vendor.toLowerCase().contains(query.toLowerCase())) {
              return true;
            }
            return false;
          }).toList() ??
          [];

      if (filteredData.isNotEmpty) {
        final resultModel =
            InvoiceBeneficary(message: "نتائج البحث", data: filteredData);
        emit(SearchAllInvoiceBeneficarySuccessState(resultModel));
      } else {
        print("لم يتم العثور على فواتير مطابقة");
        emit(SearchAllInvoiceBeneficaryErrorState(
            "لم يتم العثور على فواتير مطابقة"));
      }
    } catch (e) {
      print(e.toString());
      emit(SearchAllInvoiceBeneficaryErrorState(e.toString()));
    }
  }

  late InvoiceBeneficary allBeneficaryInvoices;

  Future<void> getAllBeneficaryInvoices({required int beneficaryId}) async {
    try {
      emit(GetAllBeneficaryInvoicesLoadingState());

      print(beneficaryId);

      var loginURL =
          Uri.parse("${ApiHelper.invoiceBeneficaryDetails}$beneficaryId");

      Map<String, String> headers = {'Accept': 'application/json'};

      var response = await http.get(loginURL, headers: headers);

      var body = jsonDecode(response.body);
      print(body);

      if (body["data"] != null) {
        allBeneficaryInvoices = InvoiceBeneficary.fromJson(body);
        emit(GetAllBeneficaryInvoicesSuccessState(allBeneficaryInvoices));
      } else {
        print("لا توجد فواتير متاحة".toString());
        emit(GetAllBeneficaryInvoicesErrorState("لا توجد فواتير متاحة"));
      }
    } catch (e) {
      print(e.toString());
      emit(GetAllBeneficaryInvoicesErrorState(e.toString()));
    }
  }

  void searchAllInvoiceBeneficaryInvoiceNumber(String query) async {
    emit(SearchBeneficaryAllInvoiceLoadingState());
    try {
      InvoiceBeneficary originalData = allBeneficaryInvoices;

      if (query.isEmpty) {
        emit(SearchBeneficaryAllInvoiceSuccessState(originalData));
        return;
      }

      final filteredData = originalData.data?.where((invoice) {
            final invoiceNo = invoice.invoiceNo;
            final name = invoice.fullName;
            final cash_Category = invoice.cashOrCategory;
            final vendor = invoice.vendorName;

            if (invoiceNo != null &&
                invoiceNo.toLowerCase().contains(query.toLowerCase())) {
              return true;
            }

            if (name != null &&
                name.toLowerCase().contains(query.toLowerCase())) {
              return true;
            }
            if (cash_Category != null &&
                cash_Category.toLowerCase().contains(query.toLowerCase())) {
              return true;
            }
            if (vendor != null &&
                vendor.toLowerCase().contains(query.toLowerCase())) {
              return true;
            }
            return false;
          }).toList() ??
          [];

      if (filteredData.isNotEmpty) {
        final resultModel =
            InvoiceBeneficary(message: "نتائج البحث", data: filteredData);
        emit(SearchBeneficaryAllInvoiceSuccessState(resultModel));
      } else {
        emit(SearchBeneficaryAllInvoiceErrorState(
            "لم يتم العثور على فواتير مطابقة"));
      }
    } catch (e) {
      emit(SearchBeneficaryAllInvoiceErrorState(e.toString()));
    }
  }
}
