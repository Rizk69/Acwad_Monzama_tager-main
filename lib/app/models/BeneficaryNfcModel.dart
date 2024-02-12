class BeneficaryNfcModel {
  Data? data;
  String? message;

  BeneficaryNfcModel({this.data});

  BeneficaryNfcModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;

    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? mobile;
  int? balance;
  String? cardID;
  String? createdBy;
  String? updatedBy;
  String? firstNameAr;
  String? lastNameAr;
  String? firstNameTr;
  String? lastNameTr;
  String? motherName;
  String? fatherName;
  String? nickName;
  int? nationalID;
  String? address;
  String? birthday;
  int? idNumber;
  int? paidMoney;
  int? numberOfFamilyMembers;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.mobile,
      this.balance,
      this.cardID,
      this.createdBy,
      this.updatedBy,
      this.firstNameAr,
      this.lastNameAr,
      this.firstNameTr,
      this.lastNameTr,
      this.motherName,
      this.fatherName,
      this.nickName,
      this.nationalID,
      this.address,
      this.birthday,
      this.idNumber,
      this.paidMoney,
      this.numberOfFamilyMembers});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    balance = json['balance'];
    cardID = json['cardID'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    firstNameAr = json['firstNameAr'];
    lastNameAr = json['lastNameAr'];
    firstNameTr = json['firstNameTr'];
    lastNameTr = json['lastNameTr'];
    motherName = json['motherName'];
    fatherName = json['fatherName'];
    nickName = json['nickName'];
    nationalID = json['nationalID'];
    address = json['address'];
    birthday = json['birthday'];
    idNumber = json['idNumber'];
    paidMoney = json['paid_money'];
    numberOfFamilyMembers = json['numberOfFamilyMembers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobile'] = this.mobile;
    data['balance'] = this.balance;
    data['cardID'] = this.cardID;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['firstNameAr'] = this.firstNameAr;
    data['lastNameAr'] = this.lastNameAr;
    data['firstNameTr'] = this.firstNameTr;
    data['lastNameTr'] = this.lastNameTr;
    data['motherName'] = this.motherName;
    data['fatherName'] = this.fatherName;
    data['nickName'] = this.nickName;
    data['nationalID'] = this.nationalID;
    data['address'] = this.address;
    data['birthday'] = this.birthday;
    data['idNumber'] = this.idNumber;
    data['paid_money'] = this.paidMoney;
    data['numberOfFamilyMembers'] = this.numberOfFamilyMembers;
    return data;
  }
}
