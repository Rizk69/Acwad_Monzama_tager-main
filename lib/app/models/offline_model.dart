import 'package:smartcard/app/models/CategoriesModel.dart';
import 'package:smartcard/app/models/benficary_data_model.dart';
import 'package:smartcard/app/models/vendor.dart';

class OfflineModel {
  String? message;
  VendorData? vendor;
  List<Beneficiary>? beneficaries;

  OfflineModel({this.message, this.vendor, this.beneficaries});

  OfflineModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    vendor = json['vendor'] != null ?  VendorData.fromJson(json['vendor']) : null;

    if (json['beneficaries'] != null) {
      beneficaries = <Beneficiary>[];
      json['beneficaries'].forEach((v) {
        beneficaries!.add(Beneficiary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = message;
    if (vendor != null) {
      data['vendor'] = vendor!.toJson();
    }
    if (this.beneficaries != null) {
      data['beneficaries'] = this.beneficaries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Beneficiary {
  int? id;
  String? fullName;
  String? mobile;
  dynamic balance;
  dynamic nationalID;

  String? cardID;
  String? cardpassword;

  List<PaidBeneficaryData>? paidBeneficary;

  Beneficiary({this.id, this.fullName, this.mobile, this.balance});

  Beneficiary.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    fullName = json['fullName']??"";
    mobile = json['mobile']??"";
    balance = json['balance']??0;
    nationalID = json['nationalID']??0;
    cardID = json['cardID']??"";
    cardpassword = json['cardpassword']??"";

    if (json['paidBeneficary'] != null) {
      paidBeneficary = <PaidBeneficaryData>[];
      json['paidBeneficary'].forEach((v) {
        paidBeneficary!.add(PaidBeneficaryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id ??0;
    data['fullName'] = fullName ??'';
    data['mobile'] = mobile??'';
    data['balance'] = balance??0;
    data['nationalID'] = nationalID??0;
    data['cardID'] = cardID??"";
    data['cardpassword'] = cardpassword??"";

    if (paidBeneficary != null) {
      data['paidBeneficary'] = paidBeneficary!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class PaidBeneficaryData {
  int? id;
  String? date;
  String? cashOrCategory;
  String? name;
  int? uprove;
  dynamic paidMoney;
  dynamic residualMoney;
  int? paidDone;
  int? type;
  List<CategoriesData>? products;

  PaidBeneficaryData(
      {this.id,
        this.date,
        this.cashOrCategory,
        this.name,
        this.uprove,
        this.paidMoney,
        this.residualMoney,
        this.type,
        this.products,
        this.paidDone});

  PaidBeneficaryData.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    date = json['date']??'';
    cashOrCategory = json['cashOrCategory']??'';
    name = json['name']??'';
    uprove = json['uprove']??0;
    paidMoney = json['paid_money']??0;
    type = json['type']??0;
    residualMoney = json['residual_money']??0;
    paidDone = json['paidDone']??0;


    if (json['products'] != null) {
      products = <CategoriesData>[];
      json['products'].forEach((v) {
        products!.add(CategoriesData.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id??0;
    data['date'] = date??"";
    data['cashOrCategory'] = cashOrCategory??"";
    data['uprove'] = uprove??0;
    data['paid_money'] = paidMoney??0;
    data['residual_money'] = residualMoney??0;
    data['paidDone'] = paidDone??0;
    data['type'] = type??0;

    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}


class VendorData {
  int? id;
  String? name;
  String? username;
  String? nameAr;
  String? nameTr;
  String? address;
  String? phone;
  dynamic residualValue;
  String? position;
  String? accountID;
  String? description;
  dynamic balance;
  dynamic status;
  String? email;
  String? createdBy;
  String? token;
  dynamic cityId;
  dynamic categoryId;
  dynamic checkPassword;
  String? cardpassword;

  VendorData({
    this.id,
    this.name,
    this.username,
    this.nameAr,
    this.nameTr,
    this.address,
    this.phone,
    this.residualValue,
    this.position,
    this.accountID,
    this.description,
    this.balance,
    this.status,
    this.email,
    this.createdBy,
    this.cityId,
    this.categoryId,
    this.token,
    this.checkPassword,
    this.cardpassword,
  });

  VendorData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ??0;
    name = json['name']??"";
    username = json['username']??"";
    nameAr = json['nameAr']??"";
    nameTr = json['nameTr']??"";
    address = json['address']??"";
    phone = json['phone']??"";
    residualValue = json['residual_value']??0;
    position = json['position'??""];
    accountID = json['accountID']??0;
    description = json['description']??"";
    balance = json['balance']??0;
    status = json['status']??0;
    email = json['email']??"";
    cardpassword = json['cardpassword']??"";
    createdBy = json['createdBy']??"";
    cityId = json['city_id']??0;
    categoryId = json['category_id']??0;
    token = json['token']??"";
    checkPassword = json['check_password']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id??0;
    data['name'] = name??"";
    data['username'] = username??"";
    data['nameAr'] = nameAr??"";
    data['nameTr'] = nameTr??"";
    data['address'] = address??"";
    data['phone'] = phone??"";
    data['residual_value'] = residualValue??0;
    data['position'] = position??"";
    data['accountID'] = accountID??"";
    data['description'] = description??"";
    data['balance'] = balance??0;
    data['status'] = status??0;
    data['email'] = email??"";
    data['city_id'] = cityId??0;
    data['category_id'] = categoryId??0;
    data['token'] = token??"";
    data['check_password'] = checkPassword??0;
    data['cardpassword'] = cardpassword??"";
    return data;
  }
}
