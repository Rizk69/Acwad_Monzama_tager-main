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

class AddProductScusses extends NfcDataState {}

class NfcDataLoaded extends NfcDataState {
  final ContactData contact;

  const NfcDataLoaded(this.contact);

  @override
  List<Object?> get props => [contact];
}

class InvoiceDataLoaded extends NfcDataState {
  final InvoiceData invoice;
  final ContactData contact;
  final String dataId;

  const InvoiceDataLoaded(this.invoice, this.contact, this.dataId);

  @override
  List<Object?> get props => [invoice, contact];
}

class MakeCashErrorState extends NfcDataState {
  final error ;
  const MakeCashErrorState(this.error);
}
class MakeCashSuccessState extends NfcDataState {}
class MakeCashLoadingState extends NfcDataState {}

