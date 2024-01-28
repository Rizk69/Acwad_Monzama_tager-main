part of 'reports_cubit.dart';

abstract class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object> get props => [];
}

class InvoicesInitial extends ReportsState {}

class InvoicesLoading extends ReportsState {}

class InvoicesError extends ReportsState {}

class InvoicesDataLoaded extends ReportsState {
  final List<InvoiceData>? invoices;

  const InvoicesDataLoaded(this.invoices);

  @override
  List<Object> get props => [invoices ?? []];
}

class ReceiptsDataLoaded extends ReportsState {
  final List<ReceiptData>? receipts;

  const ReceiptsDataLoaded(this.receipts);

  @override
  List<Object> get props => [receipts ?? []];
}

class GetInvoicesLoadingState extends ReportsState {}

class GetInvoicesSuccessState extends ReportsState {}

class GetInvoicesErrorState extends ReportsState {
  final String error;

  const GetInvoicesErrorState(this.error);
}

class GetAllInvoicesLoadingState extends ReportsState {}

class GetAllInvoicesSuccessState extends ReportsState {}

class GetAllInvoicesErrorState extends ReportsState {}

class GetDailyInvoicesLoadingState extends ReportsState {}

class GetDailyInvoicesSuccessState extends ReportsState {}

class GetDailyInvoicesErrorState extends ReportsState {}
