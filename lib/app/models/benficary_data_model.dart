import 'package:smartcard/app/models/CategoriesModel.dart';
import 'package:smartcard/app/models/offline_model.dart';

class PaidBeneficaryModel {
  String? message;
  Beneficiary? beneficary;
  PaidBeneficary? paidBeneficary;

  PaidBeneficaryModel({this.message, this.beneficary, this.paidBeneficary});

  PaidBeneficaryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    beneficary = json['beneficary'] != null
        ? Beneficiary.fromJson(json['beneficary'])
        : null;
    paidBeneficary = json['PaidBeneficary'] != null
        ? PaidBeneficary.fromJson(json['PaidBeneficary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    if (beneficary != null) {
      data['beneficary'] = beneficary!.toJson();
    }
    if (paidBeneficary != null) {
      data['PaidBeneficary'] = paidBeneficary!.toJson();
    }
    return data;
  }
}


class PaidBeneficary {
  List<PaidBeneficaryData>? date;

  PaidBeneficary({this.date});

  PaidBeneficary.fromJson(Map<String, dynamic> json) {
    if (json['date'] != null) {
      date = <PaidBeneficaryData>[];
      json['date'].forEach((v) {
        date!.add(PaidBeneficaryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (date != null) {
      data['date'] = date!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

