import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../../models/model_keys.dart';
import '../../network/app_api.dart';
import '../../utils/database_helper.dart';

part 'nfc_contact_state.dart';

class NfcDataCubit extends Cubit<NfcDataState> {
  NfcDataCubit() : super(NfcDataInitial());
  late ContactData savedContact;

  List<ProductData?> scannedItems = [];

  void addProduct(ProductData product) {
    scannedItems.add(product);
    emit(AddProductScusses());
  }

  static NfcDataCubit get(context) => BlocProvider.of(context);

  void setContact(ContactData contact) async {
    savedContact = contact;
    emit(NfcDataLoaded(contact));
    //List<InvoiceData> data = await dbHelper.getAllInvoices();
  }

  setInvoice(InvoiceData invoice) async {
    if (!await isNetworkAvailable()) {
      await dbHelper.saveInvoice(invoice);
      final newBalance = savedContact.balance! - (invoice.total ?? 0);
      await dbHelper.updateContactBalance(savedContact.id, newBalance);
      emit(InvoiceDataLoaded(invoice, savedContact, ''));
    } else {
      Map request = invoice.toJson();
      appStore.setLoading(true);
      await addInvoice(request).then((res) async {
        if (res.status == true) {
          final newBalance = savedContact.balance! - (invoice.total ?? 0);
          await dbHelper.updateContactBalance(savedContact.id, newBalance);
          emit(InvoiceDataLoaded(invoice, savedContact, res.data ?? ''));
          toast("تم تسجيل الفاتورة");
        } else {
          toast(res.message.toString());
          await dbHelper.saveInvoice(invoice);
          final newBalance = savedContact.balance! - (invoice.total ?? 0);
          await dbHelper.updateContactBalance(savedContact.id, newBalance);
        }
      });
    }
    // Emit the NfcDataLoaded state with the contact data
  }
}
