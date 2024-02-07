class PaidProjectDetails {
  String? message;
  List<Data>? data;

  PaidProjectDetails({this.message, this.data});

  PaidProjectDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? date;
  String? name;
  String? cashOrCategory;
  int? uprove;
  int? paidMoney;
  int? residualMoney;
  int? amountIPay;
  int? paidDone;
  int? type;
  String? beneficaryName;

  Data(
      {this.id,
      this.date,
      this.name,
      this.cashOrCategory,
      this.uprove,
      this.paidMoney,
      this.residualMoney,
      this.amountIPay,
      this.paidDone,
      this.type,
      this.beneficaryName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    name = json['name'];
    cashOrCategory = json['cashOrCategory'];
    uprove = json['uprove'];
    paidMoney = json['paid_money'];
    residualMoney = json['residual_money'];
    amountIPay = json['amount I pay'];
    paidDone = json['paidDone'];
    type = json['type'];
    beneficaryName = json['beneficaryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['name'] = this.name;
    data['cashOrCategory'] = this.cashOrCategory;
    data['uprove'] = this.uprove;
    data['paid_money'] = this.paidMoney;
    data['residual_money'] = this.residualMoney;
    data['amount I pay'] = this.amountIPay;
    data['paidDone'] = this.paidDone;
    data['type'] = this.type;
    data['beneficaryName'] = this.beneficaryName;
    return data;
  }
}
