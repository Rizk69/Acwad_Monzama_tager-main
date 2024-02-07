part of 'beneficary_cubit.dart';

@immutable
abstract class BeneficaryState {}

class BeneficaryInitial extends BeneficaryState {}

class GetAllBeneficaryLoadingState extends BeneficaryState {}

class GetAllBeneficarySuccessState extends BeneficaryState {}

class GetAllBeneficaryErrorState extends BeneficaryState {
  final String error;

  GetAllBeneficaryErrorState(this.error);
}

class SendSignatureBeneficaryLoadingState extends BeneficaryState {}

class SendSignatureBeneficarySuccessState extends BeneficaryState {}

class SendSignatureBeneficaryErrorState extends BeneficaryState {
  final String error;

  SendSignatureBeneficaryErrorState(this.error);
}

class GetAllPaidProjectLoadingState extends BeneficaryState {}

class GetAllPaidProjectSuccessState extends BeneficaryState {
  final PaidReportis paidReportis;

  GetAllPaidProjectSuccessState(this.paidReportis);
}

class GetAllPaidProjectErrorState extends BeneficaryState {
  final String error;

  GetAllPaidProjectErrorState(this.error);
}

class GetPaidProjectDetailsLoadingState extends BeneficaryState {}

class GetPaidProjectDetailsSuccessState extends BeneficaryState {
  final PaidProjectDetails paidProjectDetails;

  GetPaidProjectDetailsSuccessState(this.paidProjectDetails);
}

class GetPaidProjectDetailsErrorState extends BeneficaryState {
  final String error;

  GetPaidProjectDetailsErrorState(this.error);
}