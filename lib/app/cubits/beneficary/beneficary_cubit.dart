import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smartcard/app/models/beneficary_model.dart';
import 'package:smartcard/app/network/api_end_points.dart';
import 'package:http/http.dart' as http;

part 'beneficary_state.dart';

class BeneficaryCubit extends Cubit<BeneficaryState> {
  BeneficaryCubit() : super(BeneficaryInitial());

  static BeneficaryCubit get(context) => BlocProvider.of(context);

  BeneficaryModel? beneficary;

  void getAllBeneficary() async {
    emit(GetAllBeneficaryLoadingState());

    var loginURL = Uri.parse(ApiHelper.getAllBeneficary);

    Map<String, String> headers = {'Accept': 'application/json'};

    await http.get(loginURL, headers: headers).then((value) {
      var body = jsonDecode(value.body);
      if (value.statusCode == 401) {
        emit(GetAllBeneficaryErrorState(body['error'].toString()));
      }
      beneficary = BeneficaryModel.fromJson(body);
      print(body);
      emit(GetAllBeneficarySuccessState());
    }).catchError((onError) {
      print(onError);
      emit(GetAllBeneficaryErrorState(onError.toString()));
    });
  }
}
