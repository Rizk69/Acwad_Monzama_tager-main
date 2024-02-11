class VendorModel {
  Data? data;
  String? currency;

  // Constructor
  VendorModel({this.data, this.currency});

  VendorModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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


class Data {
  int? id;
  String? name;
  String? username;
  String? nameAr;
  String? nameTr;
  String? address;
  String? phone;
  num? residualValue;
  String? position;
  String? accountID;
  String? description;
  num? balance;
  num? status;
  String? email;
  String? createdBy;
  String? token;
  num? cityId;
  num? categoryId;
  num? checkPassword;

  Data({
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
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    nameAr = json['nameAr'];
    nameTr = json['nameTr'];
    address = json['address'];
    phone = json['phone'];
    residualValue = json['residual_value'];
    position = json['position'];
    accountID = json['accountID'];
    description = json['description'];
    balance = json['balance'];
    status = json['status'];
    email = json['email'];
    createdBy = json['createdBy'];
    cityId = json['city_id'];
    categoryId = json['category_id'];
    token = json['token'];
    checkPassword = json['check_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['nameAr'] = nameAr;
    data['nameTr'] = nameTr;
    data['address'] = address;
    data['phone'] = phone;
    data['residual_value'] = residualValue;
    data['position'] = position;
    data['accountID'] = accountID;
    data['description'] = description;
    data['balance'] = balance;
    data['status'] = status;
    data['email'] = email;
    data['city_id'] = cityId;
    data['category_id'] = categoryId;
    data['token'] = token;
    data['check_password'] = checkPassword;
    return data;
  }
}
