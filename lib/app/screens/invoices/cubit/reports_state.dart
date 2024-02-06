part of 'reports_cubit.dart';

abstract class ReportsState {}

class InvoicesInitial extends ReportsState {}

class SearchInvoicesLoadingState extends ReportsState {}

class SearchInvoiceBeneficaryLoadingState extends ReportsState {}

class SearchInvoicesSuccessState extends ReportsState {
  final InvoiceBeneficary invoiceBeneficary;

  SearchInvoicesSuccessState(this.invoiceBeneficary);
}

class SearchAllInvoiceBeneficarySuccessState extends ReportsState {
  final InvoiceBeneficary allInvoiceBeneficary;

  SearchAllInvoiceBeneficarySuccessState(this.allInvoiceBeneficary);
}

class SearchInvoicesErrorState extends ReportsState {
  final String error;

  SearchInvoicesErrorState(this.error);
}

class SearchAllInvoiceBeneficaryErrorState extends ReportsState {
  final String error;

  SearchAllInvoiceBeneficaryErrorState(this.error);
}

class GetInvoicesLoadingState extends ReportsState {}

class GetCategoryLoadingState extends ReportsState {}

class GetInvoicesSuccessState extends ReportsState {
  final InvoiceBeneficary invoiceBeneficary;

  GetInvoicesSuccessState(this.invoiceBeneficary);
}

class GetCategorySuccessState extends ReportsState {
  final CategoriesModel categoriesModel;

  GetCategorySuccessState(this.categoriesModel);
}

class GetInvoicesErrorState extends ReportsState {
  final String error;

  GetInvoicesErrorState(this.error);
}

class GetCategoryErrorState extends ReportsState {
  final String error;

  GetCategoryErrorState(this.error);
}

class GetAllInvoicesLoadingState extends ReportsState {}

class GetAllInvoiceBeneficaryLoadingState extends ReportsState {}

class GetAllInvoicesSuccessState extends ReportsState {
  final InvoiceBeneficary allInvoiceBeneficary;

  GetAllInvoicesSuccessState(this.allInvoiceBeneficary);
}

class GetAllInvoicesErrorState extends ReportsState {}

class GetDailyInvoicesLoadingState extends ReportsState {}

class GetDailyInvoicesSuccessState extends ReportsState {}

class GetDailyInvoicesErrorState extends ReportsState {}
