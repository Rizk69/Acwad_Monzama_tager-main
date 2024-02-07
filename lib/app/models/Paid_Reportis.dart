class PaidReportis {
  String? message;
  List<Data>? data;

  PaidReportis({this.message, this.data});

  PaidReportis.fromJson(Map<String, dynamic> json) {
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
  String? cashOrCategory;
  int? uprove;
  int? totalPaid;
  int? type;
  String? name;

  Data(
      {this.id,
      this.date,
      this.cashOrCategory,
      this.uprove,
      this.totalPaid,
      this.type,
      this.name});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    cashOrCategory = json['cashOrCategory'];
    uprove = json['uprove'];
    totalPaid = json['total_paid'];
    type = json['type'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['cashOrCategory'] = this.cashOrCategory;
    data['uprove'] = this.uprove;
    data['total_paid'] = this.totalPaid;
    data['type'] = this.type;
    data['name'] = this.name;
    return data;
  }
}
