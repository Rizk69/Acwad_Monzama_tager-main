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


class GetCategoryLoadingState extends ReportsState {}

class GetCategoryDetailsLoadingState extends ReportsState {}


class GetInvoicesLoadingState extends ReportsState {}

class GetInvoicesSuccessState extends ReportsState {
  final InvoiceBeneficary invoiceBeneficary;

  GetInvoicesSuccessState(this.invoiceBeneficary);
}

class GetInvoicesErrorState extends ReportsState {
  final String error;

  GetInvoicesErrorState(this.error);
}

class GetCategorySuccessState extends ReportsState {
  final CategoriesModel categoriesModel;

  GetCategorySuccessState(this.categoriesModel);
}

class GetCategoryDetailsSuccessState extends ReportsState {
  final CategoriesDetailsModel categoriesDetailsModel;

  GetCategoryDetailsSuccessState(this.categoriesDetailsModel);
}



class GetCategoryErrorState extends ReportsState {
  final String error;

  GetCategoryErrorState(this.error);
}

class GetCategoryDetailsErrorState extends ReportsState {
  final String error;

  GetCategoryDetailsErrorState(this.error);
}

class GetAllInvoicesLoadingState extends ReportsState {}

class GetAllInvoiceBeneficaryLoadingState extends ReportsState {}

class GetAllInvoicesSuccessState extends ReportsState {
  final InvoiceBeneficary allInvoiceBeneficary;

  GetAllInvoicesSuccessState(this.allInvoiceBeneficary);
}

class GetAllInvoicesErrorState extends ReportsState {
  final String error;

  GetAllInvoicesErrorState(this.error);
}

class GetDailyInvoicesLoadingState extends ReportsState {}

class GetDailyInvoicesSuccessState extends ReportsState {}

class GetDailyInvoicesErrorState extends ReportsState {
  final String error;

  GetDailyInvoicesErrorState(this.error);
}


class GetAllBeneficaryInvoicesLoadingState extends ReportsState {}

class GetAllBeneficaryInvoicesSuccessState extends ReportsState {
  final InvoiceBeneficary invoiceBeneficary;

  GetAllBeneficaryInvoicesSuccessState(this.invoiceBeneficary);
}

class GetAllBeneficaryInvoicesErrorState extends ReportsState {
  final String error;

  GetAllBeneficaryInvoicesErrorState(this.error);
}


class SearchBeneficaryAllInvoiceLoadingState extends ReportsState {}


class SearchBeneficaryAllInvoiceSuccessState extends ReportsState {
  final InvoiceBeneficary invoiceBeneficary;

  SearchBeneficaryAllInvoiceSuccessState(this.invoiceBeneficary);
}

class SearchBeneficaryAllInvoiceErrorState extends ReportsState {
  final String error;

  SearchBeneficaryAllInvoiceErrorState(this.error);
}