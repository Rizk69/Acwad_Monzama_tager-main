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
