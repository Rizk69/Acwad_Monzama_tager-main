part of 'nfc_employee_cubit.dart';

abstract class BalanceState extends Equatable {
  const BalanceState();

  @override
  List<Object?> get props => [];
}

class BalanceInitial extends BalanceState {}

class BalanceLoaded extends BalanceState {
  final EmployeeData employee;

  const BalanceLoaded(this.employee);

  @override
  List<Object> get props => [employee];
}

class ReceiptDataLoaded extends BalanceState {
  final ReceiptData receipt;
  final EmployeeData employee;
  final String dataId;

  const ReceiptDataLoaded(this.receipt, this.employee, this.dataId);

  @override
  List<Object?> get props => [receipt, employee];
}
