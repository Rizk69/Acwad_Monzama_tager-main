import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:smartcard/app/models/vendor.dart';
import 'package:smartcard/app/network/api_end_points.dart';
import 'package:smartcard/app/network/app_api.dart';
import 'package:smartcard/main.dart';

import '../../../utils/helper/cache_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  VendorModel? vendor;

  void login({required String email, required String password}) async {
    emit(LoginLoadingState());

    var loginURL = Uri.parse(ApiHelper.loginUrl);

    Map<String, String> headers = {'Accept': 'application/json'};

    Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };

    await http.post(loginURL, headers: headers, body: body).then((value) {
      var body = jsonDecode(value.body);
      if (value.statusCode == 401) {
        emit(LoginErrorState(body['error'].toString()));
      }
      vendor = VendorModel.fromJson(body);

      saveUserData(vendor!);
      CashHelper.saveData(
          key: "changePassword", value: vendor!.data!.checkPassword);

      if (vendor!.data!.checkPassword == 0) {
        emit(LoginFirstSuccessState());
      } else {
        emit(LoginSuccessState());
      }
    }).catchError((onError) {
      print(onError);
      emit(LoginErrorState(onError.toString()));
    });
  }

  void changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    emit(ChangePasswordLoadingState());

    var loginURL = Uri.parse(ApiHelper.changePasswordUrl);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${appStore.token}',
    };

    Map<String, dynamic> body = {
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': newPasswordConfirmation,
    };

    await http.post(loginURL, headers: headers, body: body).then((value) {
      var body = jsonDecode(value.body);
      print(body);
      if (value.statusCode == 401) {
        emit(ChangePasswordErrorState(body['message'].toString()));
      } else {
        emit(ChangePasswordSuccessState());
      }
    }).catchError((onError) {
      print(onError);
      emit(ChangePasswordErrorState(onError.toString()));
    });
  }

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility_outlined;

  void changePasswordIcon() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeVisibilityPasswordSate());
  }
}
