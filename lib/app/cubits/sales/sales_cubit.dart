import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../../models/model_keys.dart';
import '../../network/app_api.dart';

part 'sales_state.dart';

class SalesCubit extends Cubit<SalesState> {
  static SalesCubit get(context) => BlocProvider.of(context);

  late List<SalesItem>? listData;
  late String balance;
  late String currency;

  SalesCubit() : super(SalesInitial());

  Future<void> getSales() async {
    try {
      emit(SalesLoading()); // Emit a loading state before making the API call

      final response = await listSales();

      if (response.data != null) {
        listData = response.data;
        balance = response.balance.toString();
        currency = response.currency.toString();
        emit(SalesDataLoaded(listData, balance, currency));
        appStore.setLoading(false);
      } else {
        emit(SalesError()); // Emit an error state if the data is null or empty
      }
    } catch (e) {
      emit(SalesError()); // Emit an error state with the error message
    }
  }
}
