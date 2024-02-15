class Invoice {
  String? message;
  InvoiceData? data;

  Invoice({this.message, this.data});

  Invoice.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? InvoiceData.fromJson(json['data']) : null;
  }

}

class InvoiceData {
  String? vendorName;
  String? beneficaryName;
  int? invoiceNo;
  String? date;
  num? residualMoney;

  InvoiceData(
      {this.vendorName,
        this.beneficaryName,
        this.invoiceNo,
        this.date,
        this.residualMoney});

  InvoiceData.fromJson(Map<String, dynamic> json) {
    vendorName = json['vendorName'];
    beneficaryName = json['BeneficaryName'];
    invoiceNo = json['invoiceNo'];
    date = json['date'];
    residualMoney = json['residual_money'];
  }

}
