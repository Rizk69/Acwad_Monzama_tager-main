part of 'nfc_contact_cubit.dart';

abstract class NfcDataState extends Equatable {
  const NfcDataState();

  @override
  List<Object?> get props => [];
}

class NfcDataError extends NfcDataState {
  final String message;

  const NfcDataError(this.message);

  @override
  List<Object?> get props => [message];
}

class NfcDataInitial extends NfcDataState {}

class AddProductSuccess extends NfcDataState {}
class RemoveProductSuccess extends NfcDataState {}



class AddProductLoading extends NfcDataState {}
class RemoveProductLoading extends NfcDataState {}


class NfcDataLoaded extends NfcDataState {}

class NfcDataLoading extends NfcDataState {}



class MakeCashErrorState extends NfcDataState {
  final error;

  const MakeCashErrorState(this.error);
}

class MakeCashSuccessState extends NfcDataState {
  Invoice invoice;

  MakeCashSuccessState(this.invoice);
}

class MakeCashLoadingState extends NfcDataState {}



class BuyProductsErrorState extends NfcDataState {
  final error;

  const BuyProductsErrorState(this.error);
}

class BuyProductsSuccessState extends NfcDataState {}

class BuyProductsLoadingState extends NfcDataState {}


class GetPaidBeneficaryLoadingState extends NfcDataState {}

class GetPaidBeneficarySuccessState extends NfcDataState {}

class GetPaidBeneficaryErrorState extends NfcDataState {
  final String error;

  GetPaidBeneficaryErrorState(this.error);
}
