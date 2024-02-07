class InvoiceBeneficary {
  String? message;
  num? sumCashPaid;
  num? sumCategoryPaid;
  List<InvoiceBeneficaryData>? data;

  InvoiceBeneficary({this.message, this.data});

  InvoiceBeneficary.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    sumCashPaid = json['sumCashPaid'];
    sumCategoryPaid = json['sumCategoryPaid'];
    if (json['data'] != null) {
      data = <InvoiceBeneficaryData>[];
      json['data'].forEach((v) {
        data!.add(new InvoiceBeneficaryData.fromJson(v));
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

class AllInvoiceBeneficaryModel {
  String? message;
  List<InvoiceBeneficaryData>? invoice;

  AllInvoiceBeneficaryModel({this.message, this.invoice});

  AllInvoiceBeneficaryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['invoice'] != null) {
      invoice = <InvoiceBeneficaryData>[];
      json['invoice'].forEach((v) {
        invoice!.add(new InvoiceBeneficaryData.fromJson(v));
      });
    }
  }
}

class InvoiceBeneficaryData {
  String? invoiceNo;
  String? date;
  int? totalPrice;
  int? accountId;
  String? fullName;
  String? cashOrCategory;
  String? vendorName;
  List<Product>? product;

  InvoiceBeneficaryData({
    this.invoiceNo,
    this.date,
    this.totalPrice,
    this.accountId,
    this.fullName,
    this.vendorName,
    this.cashOrCategory,
    this.product,
  });

  InvoiceBeneficaryData.fromJson(Map<String, dynamic> json) {
    invoiceNo = json['invoiceNo'];
    date = json['date'];
    totalPrice = json['total_price'];
    accountId = json['accountId'];
    fullName = json['fullName'];
    vendorName = json['vendorName'];
    cashOrCategory = json['cashOrCategory'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['invoiceNo'] = invoiceNo;
    data['date'] = date;
    data['total_price'] = totalPrice;
    data['accountId'] = accountId;
    data['fullName'] = fullName;
    data['vendorName'] = vendorName;
    data['cashOrCategory'] = cashOrCategory;
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? name;
  int? price;
  String? barcode;
  int? count;
  String? category;

  Product({this.name, this.price, this.barcode, this.count, this.category});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    barcode = json['barcode'];
    count = json['count'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['barcode'] = this.barcode;
    data['count'] = this.count;
    data['category'] = this.category;
    return data;
  }
}
