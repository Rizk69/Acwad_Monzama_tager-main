class CategoriesModel {
  String? message;
  List<CategoriesData>? categories;

  CategoriesModel({this.message, this.categories});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['Categories'] != null) {
      categories = <CategoriesData>[];
      json['Categories'].forEach((v) {
        categories!.add(new CategoriesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.categories != null) {
      data['Categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoriesData {
  int? id;
  String? name;
  num? price;

  CategoriesData({this.id, this.name, this.price});

  CategoriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}

class CategoriesDetailsModel {
  String? message;
  List<Beneficary>? beneficary;

  CategoriesDetailsModel({this.message, this.beneficary});

  CategoriesDetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['Beneficary'] != null) {
      beneficary = <Beneficary>[];
      json['Beneficary'].forEach((v) {
        beneficary!.add(new Beneficary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.beneficary != null) {
      data['Beneficary'] = this.beneficary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Beneficary {
  int? id;
  String? beneficaryName;
  int? tprice;
  String? date;

  Beneficary({this.id, this.beneficaryName, this.tprice, this.date});

  Beneficary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    beneficaryName = json['BeneficaryName'];
    tprice = json['Tprice'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['BeneficaryName'] = this.beneficaryName;
    data['Tprice'] = this.tprice;
    data['date'] = this.date;
    return data;
  }
}