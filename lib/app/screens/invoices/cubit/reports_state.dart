part of 'reports_cubit.dart';

abstract class ReportsState {}

class InvoicesInitial extends ReportsState {}



class GetInvoicesLoadingState extends ReportsState {}

class GetInvoicesSuccessState extends ReportsState {
  final InvoiceBeneficary invoiceBeneficary;
   GetInvoicesSuccessState(this.invoiceBeneficary);
}

class GetInvoicesErrorState extends ReportsState {
  final String error;
   GetInvoicesErrorState(this.error);
}



class SearchInvoicesLoadingState extends ReportsState {}

class SearchInvoicesSuccessState extends ReportsState {
  final InvoiceBeneficary invoiceBeneficary;
   SearchInvoicesSuccessState(this.invoiceBeneficary);
}

class SearchInvoicesErrorState extends ReportsState {
  final String error;
   SearchInvoicesErrorState(this.error);
}



class GetAllInvoicesLoadingState extends ReportsState {}

class GetAllInvoicesSuccessState extends ReportsState {}

class GetAllInvoicesErrorState extends ReportsState {}




class GetDailyInvoicesLoadingState extends ReportsState {}

class GetDailyInvoicesSuccessState extends ReportsState {}

class GetDailyInvoicesErrorState extends ReportsState {}
