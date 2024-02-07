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

  InvoiceBeneficaryData(
      {this.invoiceNo,
      this.date,
      this.totalPrice,
      this.accountId,
      this.vendorName,
      this.fullName});

  InvoiceBeneficaryData.fromJson(Map<String, dynamic> json) {
    invoiceNo = json['invoiceNo'];
    date = json['date'];
    totalPrice = json['total_price'];
    accountId = json['accountId'];
    fullName = json['fullName'];
    vendorName = json['vendorName'];
    cashOrCategory = json['cashOrCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoiceNo'] = this.invoiceNo;
    data['date'] = this.date;
    data['total_price'] = this.totalPrice;
    data['accountId'] = this.accountId;
    data['fullName'] = this.fullName;
    data['vendorName'] = this.vendorName;
    data['cashOrCategory'] = this.cashOrCategory;
    return data;
  }
}
