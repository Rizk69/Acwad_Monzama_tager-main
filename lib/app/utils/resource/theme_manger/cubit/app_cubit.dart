import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smartcard/app/models/offline_model.dart';
import 'package:smartcard/app/network/api_end_points.dart';
import 'package:http/http.dart' as http;
import 'package:smartcard/app/utils/helper/database_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<ThemeState> {
  AppCubit() : super(ThemeInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  final db =  DatabaseHelper.instance;



  late OfflineModel offlineModel;

  Future<void> getOfflineData({required int vendorId}) async {
    try {
      emit(GetOfflineDataLoadingState());

      bool isConnected = await ApiHelper().connectedToInternet();

      if (isConnected) {
        var offlineUrl = Uri.parse("${ApiHelper.offline}$vendorId");
        Map<String, String> headers = {'Accept': 'application/json'};
        var response = await http.get(offlineUrl, headers: headers);

        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          offlineModel = OfflineModel.fromJson(body);

          // Save the data to SQLite
          await db.saveOfflineData(offlineModel);

          if (offlineModel.message == 'Success') {
            emit(GetOfflineDataSuccessState());
          } else {
            print(offlineModel.message.toString());
            emit(GetOfflineDataErrorState(offlineModel.message.toString()));
          }
        } else {
          print('Failed to load data');
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
          emit(GetOfflineDataErrorState('No internet connection and no local data available'));
        }
      }
    } catch (e) {
      print(e.toString());
      emit(GetOfflineDataErrorState(e.toString()));
    }
  }


  bool isDark = false;

  void changeAppMode() {
    isDark = !isDark;
    print("Is dark : $isDark");
    emit(AppChangeModeState());
  }

}
