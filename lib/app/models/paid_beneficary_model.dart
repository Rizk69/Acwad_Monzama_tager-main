import 'package:smartcard/app/models/CategoriesModel.dart';

class PaidBeneficaryInfo {
  List<PaidBeneficaryDataInfo>? date;

  PaidBeneficaryInfo({this.date});

  PaidBeneficaryInfo.fromJson(Map<String, dynamic> json) {
    if (json['date'] != null) {
      date = <PaidBeneficaryDataInfo>[];
      json['date'].forEach((v) {
        date!.add(PaidBeneficaryDataInfo.fromJson(v));
      });
    }
  }
}

class PaidBeneficaryDataInfo {
  int? id;
  String? date;
  String? cashOrCategory;
  int? uprove;
  num? paidMoney;
  num? paidDone;
  num? name;
  CategoriesData? data;
  List<CategoriesData>? categories;


  PaidBeneficaryDataInfo(
      {this.id,
      this.date,
      this.cashOrCategory,
      this.uprove,
      this.paidMoney,
      this.paidDone});

  PaidBeneficaryDataInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cashOrCategory = json['cashOrCategory'];
    uprove = json['uprove'];
    paidMoney = json['paid_money'];
    date = json['date'];
    name = json['name'];
    if (json['products'] != null) {
      categories = <CategoriesData>[];
      json['products'].forEach((v) {
        categories!.add(CategoriesData.fromJson(v));
      });
    }
  }
}
