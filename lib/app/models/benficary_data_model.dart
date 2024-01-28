class PaidBeneficaryModel {
  String? message;
  Beneficary? beneficary;
  PaidBeneficary? paidBeneficary;

  PaidBeneficaryModel({this.message, this.beneficary, this.paidBeneficary});

  PaidBeneficaryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    beneficary = json['beneficary'] != null
        ? new Beneficary.fromJson(json['beneficary'])
        : null;
    paidBeneficary = json['PaidBeneficary'] != null
        ? new PaidBeneficary.fromJson(json['PaidBeneficary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.beneficary != null) {
      data['beneficary'] = this.beneficary!.toJson();
    }
    if (this.paidBeneficary != null) {
      data['PaidBeneficary'] = this.paidBeneficary!.toJson();
    }
    return data;
  }
}

class Beneficary {
  int? id;
  String? fullName;
  String? mobile;
  int? balance;
  String? city;

  Beneficary({this.id, this.fullName, this.mobile, this.balance, this.city});

  Beneficary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    mobile = json['mobile'];
    balance = json['balance'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['mobile'] = this.mobile;
    data['balance'] = this.balance;
    data['city'] = this.city;
    return data;
  }
}

class PaidBeneficary {
  List<Date>? date;

  PaidBeneficary({this.date});

  PaidBeneficary.fromJson(Map<String, dynamic> json) {
    if (json['date'] != null) {
      date = <Date>[];
      json['date'].forEach((v) {
        date!.add(new Date.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.date != null) {
      data['date'] = this.date!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Date {
  int? id;
  String? date;
  String? cashOrCategory;
  int? uprove;
  int? paidMoney;
  int? paidDone;
  int? type;

  Date(
      {this.id,
      this.date,
      this.cashOrCategory,
      this.uprove,
      this.paidMoney,
      this.type,
      this.paidDone});

  Date.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    cashOrCategory = json['cashOrCategory'];
    uprove = json['uprove'];
    paidMoney = json['paid_money'];
    paidDone = json['paidDone'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['cashOrCategory'] = this.cashOrCategory;
    data['uprove'] = this.uprove;
    data['paid_money'] = this.paidMoney;
    data['paidDone'] = this.paidDone;
    data['type'] = this.type;
    return data;
  }
}
