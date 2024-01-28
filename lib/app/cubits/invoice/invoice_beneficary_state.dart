part of 'invoice_beneficary_cubit.dart';

@immutable
abstract class InvoiceBeneficaryState {}

class InvoiceBeneficaryInitial extends InvoiceBeneficaryState {}

class GetPaidBeneficaryLoadingState extends InvoiceBeneficaryState {}

class GetPaidBeneficarySuccessState extends InvoiceBeneficaryState {}

class GetPaidBeneficaryErrorState extends InvoiceBeneficaryState {
  final String error;

  GetPaidBeneficaryErrorState(this.error);
}
