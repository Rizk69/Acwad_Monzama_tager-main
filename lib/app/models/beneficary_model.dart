class BeneficaryModel {
  String? message;
  String? date;
  List<BeneficaryData>? data;

  BeneficaryModel({this.message, this.data});

  BeneficaryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    date = json['date'];
    if (json['data'] != null) {
      data = <BeneficaryData>[];
      json['data'].forEach((v) {
        data!.add(new BeneficaryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['date'] = this.date;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BeneficaryData {
  int? id;
  String? fullName;
  String? mobile;
  int? balance;
  String? city;

  BeneficaryData(
      {this.id, this.fullName, this.mobile, this.balance, this.city});

  BeneficaryData.fromJson(Map<String, dynamic> json) {
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
