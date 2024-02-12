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

  ReportsCubit() : super(InvoicesInitial());

  // Future<bool> connectedToInternet() async {
  //   if (isConnected) {
  //     return false; // No internet connection
  //   } else {
  //     return true; // Internet connection available
  //   }
  // }

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
          await saveDataToSQLite(allInvoiceBeneficary);
        } else {
          emit(GetAllInvoicesErrorState("Error Data"));
        }
      } catch (e) {
        emit(GetAllInvoicesErrorState(e.toString()));
      }
    } else {
      // Fetch from SQLite
      try {
        var invoiceBeneficaryFromDB = await fetchDataFromSQLite();
        emit(GetAllInvoicesSuccessState(invoiceBeneficaryFromDB));
      } catch (e) {
        print(e.toString());
        emit(GetAllInvoicesErrorState(e.toString()));
      }
    }
  }

  Future<void> saveDataToSQLite(InvoiceBeneficary data) async {
    final db = await DatabaseHelper.instance.database;

    for (var beneficaryData in data.data!) {
      await db.insert('AllInvoiceBeneficaryData', {
        'invoiceNo': beneficaryData.invoiceNo,
        'date': beneficaryData.date,
        'total_price': beneficaryData.total_price.toString(),
        'accountId': beneficaryData.accountId,
        'fullName': beneficaryData.fullName,
        'vendorName': beneficaryData.vendorName,
        'cashOrCategory': beneficaryData.cashOrCategory,
      });
      for (var product in beneficaryData.product!) {
        await db.insert('ProductAllInvoice', {
          'invoiceNo': beneficaryData.invoiceNo,
          'name': product.name,
          'price': product.price,
          'barcode': product.barcode,
          'count': product.count,
          'category': product.category,
        });
      }

      emit(GetAllInvoicesSuccessState(allInvoiceBeneficary));
    }
  }

  Future<InvoiceBeneficary> fetchDataFromSQLite() async {
    final db = await DatabaseHelper.instance.database;
    List<Map> beneficaryDatas = await db.query('AllInvoiceBeneficaryData');
    List<InvoiceBeneficaryData> invoiceBeneficaryDataList = [];

    for (var beneficaryData in beneficaryDatas) {
      List<Map> products = await db.query('ProductAllInvoice',
          where: 'invoiceNo = ?', whereArgs: [beneficaryData['invoiceNo']]);
      List<Product> productList = products
          .map((product) => Product.fromJson(product.cast<String, dynamic>()))
          .toList();

      var beneficaryDataObj = InvoiceBeneficaryData.fromJson(
          beneficaryData.cast<String, dynamic>());
      beneficaryDataObj.product = productList;
      invoiceBeneficaryDataList.add(beneficaryDataObj);
    }

    return InvoiceBeneficary(data: invoiceBeneficaryDataList);
  }

  /////////////////////
  late InvoiceBeneficary invoiceBeneficary;

  Future<void> getInvoiceBeneficary({required int vendorId}) async {
    bool isConnected = await ApiHelper().connectedToInternet();

    if (isConnected) {
      try {
        emit(GetInvoicesLoadingState());

        print(vendorId);

        var loginURL = Uri.parse("${ApiHelper.invoiceBeneficary}$vendorId");

        Map<String, String> headers = {'Accept': 'application/json'};

        var response = await http.get(loginURL, headers: headers);

        var body = jsonDecode(response.body);

        if (body["data"] != null) {
          invoiceBeneficary = InvoiceBeneficary.fromJson(body);
          await saveInvoiceBeneficary(invoiceBeneficary);

          // emit(GetInvoicesSuccessState(invoiceBeneficary));
        } else {
          emit(GetInvoicesErrorState("لا توجد فواتير متاحة"));
        }
      } catch (e) {
        print(e.toString());
        emit(GetInvoicesErrorState(e.toString()));
      }
    } else {
      try {
        var invoiceBeneficaryFromDB = await fetchInvoiceBeneficary();
        emit(GetInvoicesSuccessState(invoiceBeneficaryFromDB));
      } catch (e) {
        print(e.toString());
        emit(GetInvoicesErrorState(e.toString()));
      }
    }
  }

  Future<void> saveInvoiceBeneficary(InvoiceBeneficary data) async {
    final db = await DatabaseHelper.instance.database;

    for (var beneficaryData in data.data!) {
      await db.insert('InvoiceBeneficaryData', {
        'invoiceNo': beneficaryData.invoiceNo,
        'date': beneficaryData.date,
        'total_price': beneficaryData.total_price.toString(),
        'accountId': beneficaryData.accountId,
        'fullName': beneficaryData.fullName,
        'vendorName': beneficaryData.vendorName,
        'cashOrCategory': beneficaryData.cashOrCategory,
      });
      for (var product in beneficaryData.product!) {
        await db.insert('ProductInvoice', {
          'invoiceNo': beneficaryData.invoiceNo,
          'name': product.name,
          'price': product.price,
          'barcode': product.barcode,
          'count': product.count,
          'category': product.category,
        });
      }

      emit(GetInvoicesSuccessState(invoiceBeneficary));
    }
  }

  Future<InvoiceBeneficary> fetchInvoiceBeneficary() async {
    final db = await DatabaseHelper.instance.database;
    List<Map> beneficaryDatas = await db.query('InvoiceBeneficaryData');
    List<InvoiceBeneficaryData> invoiceBeneficaryDataList = [];

    for (var beneficaryData in beneficaryDatas) {
      List<Map> products = await db.query('ProductInvoice',
          where: 'invoiceNo = ?', whereArgs: [beneficaryData['invoiceNo']]);
      List<Product> productList = products
          .map((product) => Product.fromJson(product.cast<String, dynamic>()))
          .toList();

      var beneficaryDataObj = InvoiceBeneficaryData.fromJson(
          beneficaryData.cast<String, dynamic>());
      beneficaryDataObj.product = productList;
      invoiceBeneficaryDataList.add(beneficaryDataObj);
    }

    return InvoiceBeneficary(data: invoiceBeneficaryDataList);
  }

///////////////////////////////
  late InvoiceBeneficary dailyInvoiceBeneficary;

  Future<void> getDailyInvoiceBeneficary({required int vendorID}) async {
    bool isConnected = await ApiHelper().connectedToInternet();
    if (isConnected) {
      try {
        emit(GetDailyInvoicesLoadingState());

        var dailyBeneficarySystemUrl =
            Uri.parse("${ApiHelper.getDailyBeneficary}$vendorID");

        Map<String, String> headers = {'Accept': 'application/json'};

        var response =
            await http.get(dailyBeneficarySystemUrl, headers: headers);
        print(response.statusCode);

        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          dailyInvoiceBeneficary = InvoiceBeneficary.fromJson(body);
          saveDailyInvoiceBeneficary(dailyInvoiceBeneficary);
        } else {
          emit(GetDailyInvoicesErrorState("error "));
        }
      } catch (e) {
        emit(GetDailyInvoicesErrorState(e.toString()));
      }
    } else {
      try {
        var invoiceBeneficaryFromDB = await fetchDailyInvoiceBeneficary();
        emit(GetDailyInvoicesSuccessState(invoiceBeneficaryFromDB));
      } catch (e) {
        print(e.toString());
        emit(GetDailyInvoicesErrorState(e.toString()));
      }
    }
  }

  Future<void> saveDailyInvoiceBeneficary(InvoiceBeneficary data) async {
    final db = await DatabaseHelper.instance.database;

    for (var beneficaryData in data.data!) {
      await db.insert('DailyInvoiceBeneficaryData', {
        'invoiceNo': beneficaryData.invoiceNo,
        'date': beneficaryData.date,
        'total_price': beneficaryData.total_price.toString(),
        'accountId': beneficaryData.accountId,
        'fullName': beneficaryData.fullName,
        'vendorName': beneficaryData.vendorName,
        'cashOrCategory': beneficaryData.cashOrCategory,
      });
      for (var product in beneficaryData.product!) {
        await db.insert('ProductDailyInvoice', {
          'invoiceNo': beneficaryData.invoiceNo,
          'name': product.name,
          'price': product.price,
          'barcode': product.barcode,
          'count': product.count,
          'category': product.category,
        });
      }

      emit(GetDailyInvoicesSuccessState(dailyInvoiceBeneficary));
    }
  }

  Future<InvoiceBeneficary> fetchDailyInvoiceBeneficary() async {
    final db = await DatabaseHelper.instance.database;
    List<Map> beneficaryDatas = await db.query('DailyInvoiceBeneficaryData');
    List<InvoiceBeneficaryData> invoiceBeneficaryDataList = [];

    for (var beneficaryData in beneficaryDatas) {
      List<Map> products = await db.query('ProductDailyInvoice',
          where: 'invoiceNo = ?', whereArgs: [beneficaryData['invoiceNo']]);
      List<Product> productList = products
          .map((product) => Product.fromJson(product.cast<String, dynamic>()))
          .toList();

      var beneficaryDataObj = InvoiceBeneficaryData.fromJson(
          beneficaryData.cast<String, dynamic>());
      beneficaryDataObj.product = productList;
      invoiceBeneficaryDataList.add(beneficaryDataObj);
    }

    return InvoiceBeneficary(data: invoiceBeneficaryDataList);
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
      emit(
          GetAllBeneficaryInvoicesLoadingState()); // Emit a loading state before making the API call

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
