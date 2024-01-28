import 'package:easy_localization/easy_localization.dart';

class UserKeys {
  static String token = 'token';
  static String userName = 'username';
  static String contactName = 'contactName';
  static String name = 'name';
  static String address = 'address';
  static String status = 'status';
  static String deviceId = 'device_id';
  static String emailVerifiedAt = 'email_verified_at';
  static String phone = 'phone';
  static String password = 'password';
  static String oldPassword = "oldPassword";
  static String newPassword = "newPassword";
  static String comment = "comment";
  static String dob = "dob";
  static String otp = "code";
  static String id = "id";
  static String uuid = "uuid";
}

class BaseResponse {
  String? message;
  bool? status;
  String? data;

  BaseResponse({this.message, this.status, this.data});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      message: json[CommonKeys.message],
      status: json[CommonKeys.status],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[CommonKeys.message] = this.message;
    data[CommonKeys.status] = this.status;
    return data;
  }
}

class InvoicesResponse {
  List<InvoiceData>? data;
  String? message;

  InvoicesResponse({this.data, this.message});

  factory InvoicesResponse.fromJson(Map<String, dynamic> json) {
    return InvoicesResponse(
      data: json['data'] != null
          ? List<InvoiceData>.from(
              json['data'].map((item) => InvoiceData.fromJson(item)))
          : null,
      message: json[CommonKeys.message] ?? "",
    );
  }
}

class ReceiptsResponse {
  List<ReceiptData>? data;
  String? message;

  ReceiptsResponse({this.data, this.message});

  factory ReceiptsResponse.fromJson(Map<String, dynamic> json) {
    return ReceiptsResponse(
      data: json['data'] != null
          ? List<ReceiptData>.from(
              json['data'].map((item) => ReceiptData.fromJson(item)))
          : null,
      message: json[CommonKeys.message] ?? "",
    );
  }
}

class CommonKeys {
  static String data = 'data';
  static String createdAt = 'created_at';
  static String deletedAt = 'deleted_at';
  static String updatedAt = 'updated_at';
  static String status = 'status';
  static String message = 'message';
  static String pagination = 'pagination';
  static String error = 'error';
  static String bookId = 'book_id';
  static String balance = "balance";
  static String idNumber = "idNumber";
}

class ContactData {
  int? id;
  String? firstName;
  String? lastName;
  int? username;
  String? password;
  num? balance;
  int? idNumber;
  String? uuid;

  ContactData(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.password,
      this.balance,
      this.idNumber,
      this.uuid});

  factory ContactData.fromJson(Map<String, dynamic> json) {
    return ContactData(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      password: json['password'],
      balance: json['balance'],
      idNumber: json['idNumber'],
      uuid: json['uuid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'password': password,
      'balance': balance,
      'idNumber': idNumber,
      'uuid': uuid
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }
}

class ProductData {
  int? id;
  String? nameAr;

  num? price;

  ProductData({
    this.id,
    this.nameAr,
    this.price,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
        id: json['id'], nameAr: json['name'], price: json['price']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nameAr,
      'price': price,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }
}

class EmployeeData {
  int? id;
  String? firstNameAr;
  String? lastNameAr;
  int? code;
  String? password;
  num? balance;
  String? uuid;
  int? accountId;

  EmployeeData(
      {this.id,
      this.firstNameAr,
      this.lastNameAr,
      this.code,
      this.password,
      this.balance,
      this.uuid,
      this.accountId});

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
        id: json['id'],
        firstNameAr: json['firstNameAr'],
        lastNameAr: json['lastNameAr'],
        code: json['code'],
        accountId: json['accountId'],
        password: json['password'],
        balance: json['balance'],
        uuid: json['uuid']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstNameAr': firstNameAr,
      'lastNameAr': lastNameAr,
      'code': code,
      'password': password,
      'balance': balance,
      'uuid': uuid,
      'accountId': accountId
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }
}

class InvoiceData {
  String? customerId;
  String? supplierId;
  DateTime? date;
  num? total;
  String? currency;
  int? status;
  String? fullName;
  String? invoiceNo;
  String? supplierAccount;
  List<InvoiceItem>? items;
  String? clientType;
  int? accountId;

  InvoiceData(
      {this.customerId,
      this.supplierId,
      this.date,
      this.total,
      this.currency,
      this.items,
      this.status,
      this.invoiceNo,
      this.clientType,
      this.accountId,
      this.fullName});

  factory InvoiceData.fromJson(Map<String, dynamic> json) {
    return InvoiceData(
      customerId: json['customerId'],
      supplierId: json['supplierId'],
      date: DateTime.parse(json['date']),
      total: json['total'],
      currency: json['currency'],
      status: json['status'],
      fullName: json['fullName'],
      accountId: json['accountId'],
      invoiceNo: json['invoiceNo'],
      clientType: json['clientType'],
      items: json['items'] != null
          ? List<InvoiceItem>.from(
              json['items'].map((item) => InvoiceItem.fromJson(item)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'supplierId': supplierId,
      'supplierAccount': supplierAccount,
      'date': formatDateTime(date),
      'total': total,
      'currency': currency,
      'fullName': fullName,
      'invoiceNo': invoiceNo,
      'items': items?.map((item) => item.toJson()).toList(),
    };
  }
}

String formatDateTime(DateTime? dateTime) {
  final formatter = DateFormat('yyyy-MM-dd HH:mm:ss', 'en');
  return formatter.format(dateTime!);
}

class InvoiceItem {
  int? itemId;
  int? quantity;
  String? productName;
  num? price;
  num? totalPrice;

  InvoiceItem(
      {this.itemId,
      this.quantity,
      this.price,
      this.totalPrice,
      this.productName});

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      itemId: json['itemId'],
      quantity: json['quantity'],
      productName: json['productName'],
      price: json['price'],
      totalPrice: json['total_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'quantity': quantity,
      'price': price,
      'productName': productName,
      'total_price': totalPrice,
    };
  }
}

class ReceiptData {
  String? customerId;
  String? supplierId;
  DateTime? date;
  num? total;
  String? currency;
  int? status;
  String? fullName;
  String? invoiceNo;
  String? supplierAccount;
  String? clientType;
  int? accountId;
  List<ReceiptItem>? items;

  ReceiptData(
      {this.customerId,
      this.supplierId,
      this.date,
      this.total,
      this.currency,
      this.items,
      this.status,
      this.invoiceNo,
      this.clientType,
      this.accountId,
      this.fullName});

  factory ReceiptData.fromJson(Map<String, dynamic> json) {
    return ReceiptData(
      customerId: json['customerId'],
      supplierId: json['supplierId'],
      date: DateTime.parse(json['date']),
      total: json['total'],
      currency: json['currency'],
      status: json['status'],
      fullName: json['fullName'],
      invoiceNo: json['invoiceNo'],
      accountId: json['accountId'],
      clientType: json['clientType'],
      items: json['items'] != null
          ? List<ReceiptItem>.from(
              json['items'].map((item) => ReceiptItem.fromJson(item)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'supplierId': supplierId,
      'supplierAccount': supplierAccount,
      'date': formatDateTime(date),
      'total': total,
      'currency': currency,
      'fullName': fullName,
      'invoiceNo': invoiceNo,
      'items': items?.map((item) => item.toJson()).toList(),
    };
  }
}

class ReceiptItem {
  int? itemId;
  int? quantity;
  String? productName;
  num? price;
  num? totalPrice;

  ReceiptItem(
      {this.itemId,
      this.quantity,
      this.price,
      this.totalPrice,
      this.productName});

  factory ReceiptItem.fromJson(Map<String, dynamic> json) {
    return ReceiptItem(
      itemId: json['itemId'],
      quantity: json['quantity'],
      productName: json['productName'],
      price: json['price'],
      totalPrice: json['total_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'quantity': quantity,
      'price': price,
      'productName': productName,
      'total_price': totalPrice,
    };
  }
}

class DailySalesResponse {
  List<SalesItem>? data;
  String? message;
  num? balance;
  String? currency;

  DailySalesResponse({this.data, this.message, this.balance, this.currency});

  factory DailySalesResponse.fromJson(Map<String, dynamic> json) {
    return DailySalesResponse(
      data: json['data'] != null
          ? List<SalesItem>.from(
              json['data'].map((item) => SalesItem.fromJson(item)))
          : null,
      message: json[CommonKeys.message] ?? "",
      balance: json['balance'],
      currency: json['currency'],
    );
  }
}

class SalesItem {
  String? paymentDate;
  num? totalInvoiceAmount;
  int? invoiceCount;
  String? currency;

  SalesItem(
      {this.paymentDate,
      this.totalInvoiceAmount,
      this.invoiceCount,
      this.currency});

  factory SalesItem.fromJson(Map<String, dynamic> json) {
    return SalesItem(
        paymentDate: json['paymentDate'],
        totalInvoiceAmount: json['totalInvoiceAmount'],
        invoiceCount: json['invoiceCount'],
        currency: json['currency']);
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentDate': paymentDate,
      'totalInvoiceAmount': totalInvoiceAmount,
      'invoiceCount': invoiceCount,
      'currency': currency
    };
  }
}
