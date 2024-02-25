import 'dart:convert';

import 'package:smartcard/app/models/CategoriesModel.dart';
import 'package:smartcard/app/models/benficary_data_model.dart';
import 'package:smartcard/app/models/invoice_beneficary.dart';
import 'package:smartcard/app/models/offline_model.dart';
import 'package:smartcard/app/models/vendor.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('invoice.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE InvoiceBeneficaryData (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  invoiceNo TEXT,
  date TEXT,
  total_price TEXT,
  accountId INTEGER,
  fullName TEXT,
  vendorName TEXT,
  cashOrCategory TEXT
);
  ''');

    await db.execute('''
CREATE TABLE ProductInvoice (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  invoiceNo TEXT,
  name TEXT,
  price TEXT,
  barcode TEXT,
  count INTEGER,
  category TEXT,
  FOREIGN KEY (invoiceNo) REFERENCES InvoiceBeneficaryData(invoiceNo)
);
  ''');
    await db.execute('''
CREATE TABLE AllInvoiceBeneficaryData (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  invoiceNo TEXT,
  date TEXT,
  total_price TEXT,
  accountId INTEGER,
  fullName TEXT,
  vendorName TEXT,
  cashOrCategory TEXT
);
  ''');

    await db.execute('''
CREATE TABLE ProductAllInvoice (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  invoiceNo TEXT,
  name TEXT,
  price TEXT,
  barcode TEXT,
  count INTEGER,
  category TEXT,
  FOREIGN KEY (invoiceNo) REFERENCES InvoiceBeneficaryData(invoiceNo)
);
  ''');

    await db.execute('''
CREATE TABLE OfflineVendorData (
  id INTEGER PRIMARY KEY,
  name TEXT,
  phone TEXT,
  accountID TEXT,
  balance REAL,
  status INTEGER,
  email TEXT
);
''');
    // Create table for Beneficary
    await db.execute('''
CREATE TABLE OfflineBeneficiary (
  id INTEGER PRIMARY KEY,
  fullName TEXT,
  mobile TEXT,
  balance REAL,
  cardID TEXT,
  cardpassword TEXT,
  nationalID REAL
);
''');

    await db.execute('''
CREATE TABLE OfflinePaidBeneficiary (
  id INTEGER PRIMARY KEY,
  date TEXT,
  cashOrCategory TEXT,
  name TEXT,
  paid_money INTEGER,
  paidDone INTEGER,
  residual_money REAL,
  type INTEGER,
  beneficiaryId INTEGER,
  FOREIGN KEY (beneficiaryId) REFERENCES OfflineBeneficiary(id)
);
''');

    await db.execute('''
CREATE TABLE OfflineCategoriesData (
  id INTEGER PRIMARY KEY,
  name TEXT,
  price REAL,
  paidBeneficiaryId INTEGER,
  FOREIGN KEY (paidBeneficiaryId) REFERENCES OfflinePaidBeneficiary(id)
);
''');
  }

  Future<void> resetDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'invoice.db');

    await close(); // إغلاق القاعدة إذا كانت مفتوحة
    await deleteDatabase(path); // حذف ملف القاعدة

    _database = null; // إعادة تعيين المتغير للتأكد من إعادة إنشائه

    await database; // إعادة فتح القاعدة لإنشائها من جديد
  }

  Future<void> saveInvoiceBeneficary(InvoiceBeneficary data) async {
    final db = await DatabaseHelper.instance.database;

    for (var beneficaryData in data.data!) {
      // Check if the record already exists
      List<Map> existingRecords = await db.query('InvoiceBeneficaryData',
          where: 'invoiceNo = ?', whereArgs: [beneficaryData.invoiceNo]);

      if (existingRecords.isNotEmpty) {
        // Update the existing record
        await db.update(
            'InvoiceBeneficaryData',
            {
              'date': beneficaryData.date,
              'total_price': beneficaryData.total_price.toString(),
              'accountId': beneficaryData.accountId,
              'fullName': beneficaryData.fullName,
              'vendorName': beneficaryData.vendorName,
              'cashOrCategory': beneficaryData.cashOrCategory,
            },
            where: 'invoiceNo = ?',
            whereArgs: [beneficaryData.invoiceNo]);
      } else {
        // Insert a new record
        await db.insert('InvoiceBeneficaryData', {
          'invoiceNo': beneficaryData.invoiceNo,
          'date': beneficaryData.date,
          'total_price': beneficaryData.total_price.toString(),
          'accountId': beneficaryData.accountId,
          'fullName': beneficaryData.fullName,
          'vendorName': beneficaryData.vendorName,
          'cashOrCategory': beneficaryData.cashOrCategory,
        });
      }

      // Update or insert products for this invoice
      for (var product in beneficaryData.product!) {
        List<Map> existingProductRecords = await db.query('ProductInvoice',
            where: 'barcode = ? AND invoiceNo = ?',
            whereArgs: [product.barcode, beneficaryData.invoiceNo]);

        if (existingProductRecords.isNotEmpty) {
          // Update the existing product record
          await db.update(
              'ProductInvoice',
              {
                'name': product.name,
                'price': product.price,
                'count': product.count,
                'category': product.category,
              },
              where: 'barcode = ? AND invoiceNo = ?',
              whereArgs: [product.barcode, beneficaryData.invoiceNo]);
        } else {
          // Insert a new product record
          await db.insert('ProductInvoice', {
            'invoiceNo': beneficaryData.invoiceNo,
            'name': product.name,
            'price': product.price,
            'barcode': product.barcode,
            'count': product.count,
            'category': product.category,
          });
        }
      }
    }
  }

  Future<InvoiceBeneficary> fetchInvoiceBeneficary() async {
    final db = await DatabaseHelper.instance.database;
    List<Map> beneficaryDatas = await db.query('InvoiceBeneficaryData');
    List<InvoiceBeneficaryData> invoiceBeneficaryDataList = [];

    for (var beneficaryData in beneficaryDatas) {
      List<Map> products = await db.query('ProductInvoice',
          where: 'invoiceNo = ?', whereArgs: [beneficaryData['invoiceNo']]);
      List<Product> productList = products
          .map((product) => Product.fromJson(product.cast<String, dynamic>()))
          .toList();

      var beneficaryDataObj = InvoiceBeneficaryData.fromJson(
          beneficaryData.cast<String, dynamic>());
      beneficaryDataObj.product = productList;
      invoiceBeneficaryDataList.add(beneficaryDataObj);
    }

    return InvoiceBeneficary(data: invoiceBeneficaryDataList);
  }

  Future<void> saveDataToSQLite(InvoiceBeneficary data) async {
    final db = await DatabaseHelper.instance.database;

    for (var beneficaryData in data.data!) {
      // Check if the record already exists
      List<Map> existingRecords = await db.query('AllInvoiceBeneficaryData',
          where: 'invoiceNo = ?', whereArgs: [beneficaryData.invoiceNo]);

      if (existingRecords.isNotEmpty) {
        // Update the existing record
        await db.update(
            'AllInvoiceBeneficaryData',
            {
              'date': beneficaryData.date,
              'total_price': beneficaryData.total_price.toString(),
              'accountId': beneficaryData.accountId,
              'fullName': beneficaryData.fullName,
              'vendorName': beneficaryData.vendorName,
              'cashOrCategory': beneficaryData.cashOrCategory,
            },
            where: 'invoiceNo = ?',
            whereArgs: [beneficaryData.invoiceNo]);
      } else {
        // Insert a new record
        await db.insert('AllInvoiceBeneficaryData', {
          'invoiceNo': beneficaryData.invoiceNo,
          'date': beneficaryData.date,
          'total_price': beneficaryData.total_price.toString(),
          'accountId': beneficaryData.accountId,
          'fullName': beneficaryData.fullName,
          'vendorName': beneficaryData.vendorName,
          'cashOrCategory': beneficaryData.cashOrCategory,
        });
      }

      // Update or insert products for this invoice
      for (var product in beneficaryData.product!) {
        List<Map> existingProductRecords = await db.query('ProductAllInvoice',
            where: 'barcode = ? AND invoiceNo = ?',
            whereArgs: [product.barcode, beneficaryData.invoiceNo]);

        if (existingProductRecords.isNotEmpty) {
          // Update the existing product record
          await db.update(
              'ProductAllInvoice',
              {
                'name': product.name,
                'price': product.price,
                'count': product.count,
                'category': product.category,
              },
              where: 'barcode = ? AND invoiceNo = ?',
              whereArgs: [product.barcode, beneficaryData.invoiceNo]);
        } else {
          // Insert a new product record
          await db.insert('ProductAllInvoice', {
            'invoiceNo': beneficaryData.invoiceNo,
            'name': product.name,
            'price': product.price,
            'barcode': product.barcode,
            'count': product.count,
            'category': product.category,
          });
        }
      }
    }
  }

  Future<InvoiceBeneficary> fetchDataFromSQLite() async {
    final db = await DatabaseHelper.instance.database;
    List<Map> beneficaryDatas = await db.query('AllInvoiceBeneficaryData');
    List<InvoiceBeneficaryData> invoiceBeneficaryDataList = [];

    for (var beneficaryData in beneficaryDatas) {
      List<Map> products = await db.query('ProductAllInvoice',
          where: 'invoiceNo = ?', whereArgs: [beneficaryData['invoiceNo']]);
      List<Product> productList = products
          .map((product) => Product.fromJson(product.cast<String, dynamic>()))
          .toList();

      var beneficaryDataObj = InvoiceBeneficaryData.fromJson(
          beneficaryData.cast<String, dynamic>());
      beneficaryDataObj.product = productList;
      invoiceBeneficaryDataList.add(beneficaryDataObj);
    }

    return InvoiceBeneficary(data: invoiceBeneficaryDataList);
  }



  Future<void> saveOfflineData(OfflineModel data) async {
    final db = await database;

    try {
      if (data.vendor != null) {
        var vendorData = {
          'id': data.vendor!.id,
          'name': data.vendor!.name,
          'phone': data.vendor!.phone,
          'accountID': data.vendor!.accountID,
          'balance': data.vendor!.balance,
          'status': data.vendor!.status,
          'email': data.vendor!.email,
        };

        List<Map> existingVendorRecords = await db.query(
          'OfflineVendorData',
          where: 'id = ?',
          whereArgs: [data.vendor!.id],
        );

        if (existingVendorRecords.isNotEmpty) {
          await db.update(
            'OfflineVendorData',
            vendorData,
            where: 'id = ?',
            whereArgs: [data.vendor!.id],
          );
          print('Vendor data updated successfully');
        } else {
          await db.insert('OfflineVendorData', vendorData);
          print('Vendor data inserted successfully');
        }
      }

      for (var beneficiary in data.beneficaries ?? []) {
        var beneficiaryData = {
          'id': beneficiary.id,
          'fullName': beneficiary.fullName,
          'mobile': beneficiary.mobile,
          'balance': beneficiary.balance,
          'cardID': beneficiary.cardID,
          'cardpassword': beneficiary.cardpassword,
          'nationalID': beneficiary.nationalID,
        };

        List<Map> existingBeneficiaryRecords = await db.query(
          'OfflineBeneficiary',
          where: 'id = ?',
          whereArgs: [beneficiary.id],
        );

        if (existingBeneficiaryRecords.isNotEmpty) {
          await db.update(
            'OfflineBeneficiary',
            beneficiaryData,
            where: 'id = ?',
            whereArgs: [beneficiary.id],
          );
          print('Beneficiary data updated successfully');
        } else {
          await db.insert('OfflineBeneficiary', beneficiaryData);
          print('Beneficiary data inserted successfully');
        }

        for (var paidBeneficiary in beneficiary.paidBeneficary ?? []) {
          var paidBeneficiaryData = {
            'id': paidBeneficiary.id,
            'date': paidBeneficiary.date,
            'cashOrCategory': paidBeneficiary.cashOrCategory,
            'name': paidBeneficiary.name,
            'paid_money': paidBeneficiary.paidMoney,
            'paidDone': paidBeneficiary.paidDone,
            'residual_money': paidBeneficiary.residual_money,
            'type': paidBeneficiary.type,
            'beneficiaryId': beneficiary.id,
          };

          List<Map> existingPaidBeneficiaryRecords = await db.query(
            'OfflinePaidBeneficiary',
            where: 'id = ?',
            whereArgs: [paidBeneficiary.id],
          );

          if (existingPaidBeneficiaryRecords.isNotEmpty) {
            await db.update(
              'OfflinePaidBeneficiary',
              paidBeneficiaryData,
              where: 'id = ?',
              whereArgs: [paidBeneficiary.id],
            );
            print('Paid Beneficiary data updated successfully');
          } else {
            await db.insert('OfflinePaidBeneficiary', paidBeneficiaryData);
            print('Paid Beneficiary data inserted successfully');
          }

          for (var category in paidBeneficiary.products ?? []) {
            var categoryData = {
              'id': category.id,
              'name': category.name,
              'price': category.price,
              'paidBeneficiaryId': paidBeneficiary.id,
            };

            List<Map> existingCategoryRecords = await db.query(
              'OfflineCategoriesData',
              where: 'id = ?',
              whereArgs: [category.id],
            );

            if (existingCategoryRecords.isNotEmpty) {
              await db.update(
                'OfflineCategoriesData',
                categoryData,
                where: 'id = ?',
                whereArgs: [category.id],
              );
              print('Category data updated successfully');
            } else {
              await db.insert('OfflineCategoriesData', categoryData);
              print('Category data inserted successfully');
            }
          }
        }
      }
    } catch (e) {
      print('Error saving offline data: $e');
    }
  }

  Future<OfflineModel?> getOfflineDataFromDB() async {
    final db = await database;
    List<Map<String, dynamic>> beneficiariesData =
        await db.query('OfflineBeneficiary');

    List<Beneficiary> beneficiaries = [];
    for (var beneficiaryData in beneficiariesData) {
      List<PaidBeneficaryData> paidBeneficary =
          (jsonDecode(beneficiaryData['paidBeneficary']) as List)
              .map((e) => PaidBeneficaryData.fromJson(e))
              .toList();

      Beneficiary beneficiary = Beneficiary.fromJson(beneficiaryData);
      beneficiary.paidBeneficary = paidBeneficary;
      beneficiaries.add(beneficiary);
    }

    return OfflineModel(beneficaries: beneficiaries);
  }




  Future<Map<String, dynamic>> getBeneficiaryData(int beneficiaryId) async {
    Database db = await openDatabase('invoice.db');
    List<Map> beneficiaryData = await db.query(
      'OfflineBeneficiary',
      columns: ['fullName'],
      where: 'id = ?',
      whereArgs: [beneficiaryId],
    );

    List<Map> paidBeneficiaryData = await db.query(
      'OfflinePaidBeneficiary',
      columns: ['residual_money'],
      where: 'beneficiaryId = ?',
      whereArgs: [beneficiaryId],
      orderBy: 'date DESC',
      limit: 1,
    );

    String beneficiaryName =
        beneficiaryData.isNotEmpty ? beneficiaryData[0]['fullName'] : '';
    num residualMoney = paidBeneficiaryData.isNotEmpty
        ? paidBeneficiaryData[0]['residual_money']
        : 0.0;

    return {'fullName': beneficiaryName, 'residual_money': residualMoney};
  }

  Future<void> updateResidualMoney(
      int paidBeneficiaryId, double amountToSubtract) async {
    Database db = await openDatabase('invoice.db');
    // First, get the current residual_money for the given paidBeneficiaryId
    List<Map> result = await db.query(
      'OfflinePaidBeneficiary',
      columns: ['residual_money'],
      where: 'id = ?',
      whereArgs: [paidBeneficiaryId],
    );

    if (result.isNotEmpty) {
      double currentResidualMoney = result[0]['residual_money'];
      double newResidualMoney = currentResidualMoney - amountToSubtract;

      // Update the residual_money with the new value
      await db.update(
        'OfflinePaidBeneficiary',
        {'residual_money': newResidualMoney},
        where: 'id = ?',
        whereArgs: [paidBeneficiaryId],
      );
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
