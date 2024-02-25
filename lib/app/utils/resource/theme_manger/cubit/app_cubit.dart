import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smartcard/app/models/offline_model.dart';
import 'package:smartcard/app/network/api_end_points.dart';
import 'package:http/http.dart' as http;
import 'package:smartcard/app/screens/beneficary/nfc_contact_cubit/nfc_contact_cubit.dart';
import 'package:smartcard/app/utils/helper/database_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<ThemeState> {
  AppCubit() : super(ThemeInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  final db = DatabaseHelper.instance;

  late OfflineModel offlineModel;

  Future<void> getOfflineData(
      {required int vendorId, required BuildContext context}) async {
    try {
      emit(GetOfflineDataLoadingState());

      bool isConnected = await ApiHelper().connectedToInternet();

      if (isConnected) {
        var offlineUrl = Uri.parse("${ApiHelper.offline}$vendorId");
        print('"${ApiHelper.offline}$vendorId"');
        Map<String, String> headers = {'Accept': 'application/json'};
        var response = await http.get(offlineUrl, headers: headers);

        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          offlineModel = OfflineModel.fromJson(body);
          print("${body}____________");
          await db.saveOfflineData(offlineModel);

          if (offlineModel.message == 'Success') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.fixed,
                content: Text('تم مزامنه البيانات بنجاح'),
                backgroundColor: Colors.green,
              ),
            );
            emit(GetOfflineDataSuccessState());
          } else {
            print(offlineModel.message.toString());
            emit(GetOfflineDataErrorState(offlineModel.message.toString()));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(offlineModel.message.toString()),
                backgroundColor: Colors.red,
              ),
            );
          }
        } else {
          print('Failed to load data');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text('هناك خطا في اراسال البيانات'),
              backgroundColor: Colors.red,
            ),
          );
          emit(GetOfflineDataErrorState('Failed to load data'));
        }
      } else {
        // Retrieve the data from SQLite
        OfflineModel? offlineData = await db.getOfflineDataFromDB();
        if (offlineData != null) {
          offlineModel = offlineData;
          emit(GetOfflineDataSuccessState());
        } else {
          print('No internet connection and no local data available');
          emit(GetOfflineDataErrorState(
              'No internet connection and no local data available'));
        }
      }
    } catch (e) {
      print(e.toString());
      emit(GetOfflineDataErrorState(e.toString()));
    }
  }

  List<OffLineRequest> offLineRequest = [];

  Future<void> loadOffLineRequestsFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? offLineRequestStrings =
        prefs.getStringList('offLineRequests');
    if (offLineRequestStrings != null) {
      offLineRequest = offLineRequestStrings
          .map((e) => OffLineRequest.fromJson(jsonDecode(e)))
          .toList();
      print(offLineRequest.length);
      emit(GetRequestSuccessState());
    }
  }

  Future<void> sendPaidOfflineToOnline() async {
    List<Map<String, dynamic>> requestDataList = offLineRequest.map((request) {
      List<Map<String, dynamic>> productsList = request.products!
          .map((product) => {
                'pro_id': product.id,
                'count': product.count,
              })
          .toList();

      return {
        'PaidBeneficaryId': request.paidBeneficaryId,
        'vendorId': request.vendorId,
        'beneficaryId': request.beneficaryId,
        'paidmoney': request.paidMoney,
        'date': request.date,
        'product': productsList,
      };
    }).toList();

    var sendPaidUrl = Uri.parse(ApiHelper.sendPaidOfflineUrl);
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode(requestDataList);

    try {
      var response = await http.post(sendPaidUrl, headers: headers, body: body);
      if (response.statusCode == 200) {
        emit(SendOfflineDataSuccessState());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('offLineRequests');
      } else {
        emit(SendOfflineDataErrorState("Erorr"));
      }
    } catch (e) {
      print(e);
      emit(SendOfflineDataErrorState(e.toString()));
    }
  }

  // sendPaidOfflineToOnline() async {
  //   emit(SendOfflineDataLoadingState());
  //   bool isConnected = await ApiHelper().connectedToInternet();
  //   if (isConnected) {
  //     try {
  //       var sendPaidUrl = Uri.parse(ApiHelper.sendPaidOfflineUrl);
  //       Map<String, String> headers = {'Accept': 'application/json'};
  //
  //       print(offLineRequest.length);
  //
  //       var body = [
  //         {
  //           "paidBeneficaryId":1,
  //           "vendorId":1,
  //           "beneficaryId":1,
  //           "date":"2024-02-18",
  //           "paidMoney":40.0,
  //           "product":[]
  //         }
  //       ];
  //
  //       var response = await http.post(sendPaidUrl,body:body , headers: headers);
  //       if (response.statusCode == 200) {
  //         var body = jsonDecode(response.body);
  //         if (body['message'] == 'Success') {
  //           emit(SendOfflineDataSuccessState());
  //         } else {
  //           emit(SendOfflineDataErrorState("Erorr"));
  //         }
  //       } else {
  //         emit(SendOfflineDataErrorState('Failed to load data'));
  //       }
  //     } catch (e) {
  //       print(e);
  //       emit(SendOfflineDataErrorState(e.toString()));
  //     }
  //   }
  // }

  bool isDark = false;

  void changeAppMode() {
    isDark = !isDark;
    print("Is dark : $isDark");
    emit(AppChangeModeState());
  }
}
