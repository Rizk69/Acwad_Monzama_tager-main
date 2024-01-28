import 'package:flutter/material.dart';
import 'package:smartcard/app/models/vendor.dart';

import '../../main.dart';
import '../models/model_keys.dart';
import '../utils/database_helper.dart';
import 'package:nb_utils/nb_utils.dart';

import 'network_utils.dart';

Future<void> saveUserData(VendorModel data) async {
  if (data.data!.token.validate().isNotEmpty) {
    await appStore.setToken(data.data!.token.validate());
  }
  await appStore.setUserId(data.data!.id.validate());
  await appStore.setUserName(data.data!.username.toString().validate());
  await appStore.setName(data.data!.name.validate());
  await appStore.setAddress(data.data!.address.validate());
  await appStore.setPhone(data.data!.phone.validate());
  await appStore.setUserEmail(data.data!.email.validate());

  await appStore.setLoggedIn(true);
}

///logout api call
Future<void> logout(BuildContext context) async {
  appStore.setLoading(true);
  await clearPreferences();
  await dbHelper.deleteDatabaseFn();
  await dbHelper.openDatabaseFn();
  appStore.setLoading(false);
}

Future<void> clearPreferences() async {
  await appStore.setToken('');
  await appStore.setUserId(0);
  await appStore.setUserName('');
  await appStore.setName('');
  await appStore.setAddress('');
  await appStore.setContactName('');
  await appStore.setPhone('');
  await appStore.setUUID('');
  await appStore.setLoggedIn(false);
}

Future<VendorModel> login(Map request) async {
  return VendorModel.fromJson(await (handleResponse(await buildHttpResponse(
      'branch/login',
      request: request,
      method: HttpMethod.POST))));
}

Future<BaseResponse> changePassword(Map request) async {
  return BaseResponse.fromJson(await handleResponse(await buildHttpResponse(
      'branch/appchangepassword',
      request: request,
      method: HttpMethod.POST)));
}

Future<InvoicesResponse> listInvoice() async {
  return InvoicesResponse.fromJson(await handleResponse(await buildHttpResponse(
      'invoice/forbranch?filter=[["supplierId","=","' +
          appStore.branchUUID +
          '"],"and",["clientType","=","contact"]]',
      method: HttpMethod.GET)));
}

Future<DailySalesResponse> listSales() async {
  return DailySalesResponse.fromJson(await handleResponse(
      await buildHttpResponse('transactionsmaster/daily',
          method: HttpMethod.GET)));
}

Future<ReceiptsResponse> listReceipts() async {
  return ReceiptsResponse.fromJson(await handleResponse(await buildHttpResponse(
      'invoice/forbranch?filter=[["supplierId","=","' +
          appStore.branchUUID +
          '"],"and",["clientType","=","employee"]]',
      method: HttpMethod.GET)));
}

Future<BaseResponse> addInvoice(Map request) async {
  return BaseResponse.fromJson(await handleResponse(await buildHttpResponse(
      'transactionsmaster/addexpense',
      request: request,
      method: HttpMethod.POST)));
}

Future<BaseResponse> addReceipt(Map request) async {
  return BaseResponse.fromJson(await handleResponse(await buildHttpResponse(
      'transactionsmaster/addemployeeexpense',
      request: request,
      method: HttpMethod.POST)));
}
