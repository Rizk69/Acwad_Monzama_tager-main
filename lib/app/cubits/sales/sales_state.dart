part of 'sales_cubit.dart';

abstract class SalesState extends Equatable {
  const SalesState();

  @override
  List<Object> get props => [];
}

class SalesInitial extends SalesState {}

class SalesLoading extends SalesState {}

class SalesError extends SalesState {}

class SalesDataLoaded extends SalesState {
  final List<SalesItem>? sales;
  final String balance;
  final String currency;

  const SalesDataLoaded(this.sales, this.balance, this.currency);

  @override
  List<Object> get props => [sales ?? [], balance, currency];
}
