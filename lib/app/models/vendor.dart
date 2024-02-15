import 'package:smartcard/app/models/offline_model.dart';

class VendorModel {
  VendorData? data;
  String? currency;

  // Constructor
  VendorModel({this.data, this.currency});

  VendorModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? VendorData.fromJson(json['data']) : null;
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['currency'] = currency;
    return data;
  }
}


