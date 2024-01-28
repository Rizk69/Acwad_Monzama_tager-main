import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smartcard/app/models/model_keys.dart';

import '../../../main.dart';
import '../../network/app_api.dart';
import '../../utils/database_helper.dart';

part 'nfc_employee.state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  BalanceCubit() : super(BalanceInitial());
  late EmployeeData savedEmployee;

  static BalanceCubit get(context) => BlocProvider.of(context);

  void setEmployee(EmployeeData employee) {
    savedEmployee = employee;
    emit(BalanceLoaded(employee));
  }

  setReceipt(ReceiptData receipt) async {
    if (!await isNetworkAvailable()) {
      await dbHelper.saveReceipt(receipt);
      final newBalance = savedEmployee.balance! - (receipt.total ?? 0);
      await dbHelper.updateEmployeeBalance(savedEmployee.id, newBalance);
      emit(ReceiptDataLoaded(receipt, savedEmployee, ''));
    } else {
      Map request = receipt.toJson();
      appStore.setLoading(true);
      await addReceipt(request).then((res) async {
        if (res.status == true) {
          final newBalance = savedEmployee.balance! - (receipt.total ?? 0);
          await dbHelper.updateEmployeeBalance(savedEmployee.id, newBalance);
          emit(ReceiptDataLoaded(receipt, savedEmployee, res.data ?? ''));
          toast("تم تسجيل الدفعه");
        } else {
          toast(res.message.toString());
          await dbHelper.saveReceipt(receipt);
          final newBalance = savedEmployee.balance! - (receipt.total ?? 0);
          await dbHelper.updateEmployeeBalance(savedEmployee.id, newBalance);
        }
      });
    }

    // Emit the NfcDataLoaded state with the contact data
  }
}
