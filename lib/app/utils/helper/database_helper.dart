import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smartcard/app/models/model_keys.dart';
import 'package:sqflite/sqflite.dart';

import '../../network/app_api.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper.internal();
//
//   factory DatabaseHelper() => _instance;
//
//   late Database database;
//
//   DatabaseHelper.internal();
//
//   Future<void> openDatabaseFn() async {
//     final databasesPath = await getDatabasesPath();
//     final path = join(databasesPath, 'contacts.db');
//     database = await openDatabase(
//       path,
//       version: 1,
//       onCreate: _createDatabase,
//     );
//   }
//
//   Future<void> _createDatabase(Database db, int version) async {
//     await db.execute(
//       "CREATE TABLE Contacts ("
//       "id INTEGER PRIMARY KEY AUTOINCREMENT,"
//       "firstName TEXT,"
//       "lastName TEXT,"
//       "username INTEGER,"
//       "password TEXT,"
//       "balance REAL,"
//       "idNumber INTEGER,"
//       "accountId INTEGER,"
//       "uuid TEXT"
//       ")",
//     );
//     await db.execute(
//       "CREATE TABLE Products ("
//       "id INTEGER PRIMARY KEY AUTOINCREMENT,"
//       "nameAr TEXT,"
//       "price REAL,"
//       "categoryId INTEGER,"
//       "barcode TEXT"
//       ")",
//     );
//     await db.execute(
//       "CREATE TABLE Employees ("
//       "id INTEGER PRIMARY KEY AUTOINCREMENT,"
//       "firstNameAr TEXT,"
//       "lastNameAr TEXT,"
//       "code INTEGER,"
//       "password TEXT,"
//       "accountId INTEGER,"
//       "balance REAL,"
//       "uuid TEXT"
//       ")",
//     );
//     await db.execute(
//       "CREATE TABLE Master ("
//       "id INTEGER PRIMARY KEY AUTOINCREMENT,"
//       "customerId TEXT,"
//       "supplierId TEXT,"
//       "date TEXT,"
//       "total REAL,"
//       "currency TEXT,"
//       "status INTEGER,"
//       "fullName TEXT,"
//       "type TEXT,"
//       "invoiceNo TEXT"
//       ")",
//     );
//     await db.execute("CREATE TABLE Detail ("
//         "id INTEGER PRIMARY KEY AUTOINCREMENT,"
//         "itemId INTEGER,"
//         "quantity INTEGER,"
//         "productName TEXT,"
//         "price REAL,"
//         "totalPrice REAL,"
//         "masterId INTEGER,"
//         "FOREIGN KEY (masterId) REFERENCES master (id)"
//         ")");
//   }
//
//   Future<void> insertContacts(List<Map<String, dynamic>> contactsData) async {
//     final db = await database;
//     if (db != null && db.isOpen) {
//       // Insert each contact into the database.
//       for (final contact in contactsData) {
//         final int id = contact['username'];
//         // Check if the contact with the same id already exists
//         final existingContacts = await db.query(
//           'Contacts',
//           where: 'username = ?',
//           whereArgs: [id],
//         );
//
//         if (existingContacts != null && existingContacts.isNotEmpty) {
//           // Contact with the same id already exists, perform an update
//           await db.update(
//             'Contacts',
//             contact,
//             where: 'username = ?',
//             whereArgs: [id],
//           );
//         } else {
//           // Contact with the same id doesn't exist, perform an insert
//           await db.insert('Contacts', contact);
//         }
//       }
//     }
//   }
//
//   Future<void> insertProducts(List<Map<String, dynamic>> productData) async {
//     final db = await database;
//
//     // Insert each contact into the database.
//     for (final product in productData) {
//       final int id = product['id'];
//
//       // Check if the contact with the same id already exists
//       final existingProducts = await db.query(
//         'Products',
//         where: 'id = ?',
//         whereArgs: [id],
//       );
//
//       if (existingProducts != null && existingProducts.isNotEmpty) {
//         // Contact with the same id already exists, perform an update
//         await db.update(
//           'Products',
//           product,
//           where: 'id = ?',
//           whereArgs: [id],
//         );
//       } else {
//         // Contact with the same id doesn't exist, perform an insert
//         await db.insert('Products', product);
//       }
//     }
//   }
//
//   Future<List<Map<String, dynamic>>> getContacts() async {
//     final db = await database;
//     final List<Map<String, Object?>>? results = await db.query("Contacts");
//     return results?.cast<Map<String, dynamic>>() ?? [];
//   }
//
//   Future<List<Map<String, dynamic>>> getProducts() async {
//     final db = await database;
//     final List<Map<String, Object?>>? results = await db.query("Products");
//     return results?.cast<Map<String, dynamic>>() ?? [];
//   }
//
//   Future<ContactData?> getContactById(int idNumber) async {
//     final db = await database;
//     final existingContacts = await db.query(
//       'Contacts',
//       where: 'idNumber = ?',
//       whereArgs: [idNumber],
//     );
//
//     if (existingContacts != null && existingContacts.isNotEmpty) {
//       final contactMap = existingContacts.first;
//       return ContactData.fromJson(contactMap);
//     }
//     return null;
//   }
//
//   Future<ProductData?> getProductById(String barcode) async {
//     final db = await database;
//     final existingProducts = await db.query(
//       'Products',
//       where: 'barcode = ?',
//       whereArgs: [barcode],
//     );
//
//     if (existingProducts != null && existingProducts.isNotEmpty) {
//       final productMap = existingProducts.first;
//       return ProductData.fromJson(productMap);
//     }
//     return null;
//   }
//
//   Future<void> insertEmployee(List<Map<String, dynamic>> employeesData) async {
//     final db = await database;
//
//     // Insert each contact into the database.
//     for (final employee in employeesData) {
//       final int id = employee['accountId'];
//       // Check if the contact with the same id already exists
//       final existingEmployee = await db.query(
//         'Employees',
//         where: 'accountId = ?',
//         whereArgs: [id],
//       );
//
//       if (existingEmployee != null && existingEmployee.isNotEmpty) {
//         // Contact with the same id already exists, perform an update
//         await db.update(
//           'Employees',
//           employee,
//           where: 'accountId = ?',
//           whereArgs: [id],
//         );
//       } else {
//         // Contact with the same id doesn't exist, perform an insert
//         await db.insert('Employees', employee);
//       }
//     }
//   }
//
//   Future<List<Map<String, dynamic>>> getEmployees() async {
//     final db = await database;
//     final List<Map<String, Object?>>? results = await db.query("Employees");
//     return results?.cast<Map<String, dynamic>>() ?? [];
//   }
//
//   Future<EmployeeData?> getEmployeeById(String code) async {
//     final db = await database;
//     final existingEmployee = await db.query(
//       'Employees',
//       where: 'code = ?',
//       whereArgs: [code],
//     );
//
//     if (existingEmployee != null && existingEmployee.isNotEmpty) {
//       final employeeMap = existingEmployee.first;
//       return EmployeeData.fromJson(employeeMap);
//     }
//     return null;
//   }
//
//   Future<void> deleteDatabaseFn() async {
//     try {
//       print("Deleting database");
//       final documentsDirectory = await getApplicationDocumentsDirectory();
//       final path = join(documentsDirectory.path, "contacts.db");
//       await deleteDatabase(path);
//     } catch (e) {
//       print("Error deleting database: $e");
//     }
//   }
//
//   Future<int> getAllInvoicesNote() async {
//     final db = await database;
//     // Fetch all invoices
//     final invoiceRows = await db.query('Master');
//     return invoiceRows.length;
//   }
//
//   InvoiceItem mapInvoiceItem(Map<String, dynamic> row) {
//     return InvoiceItem(
//       itemId: row['itemId'],
//       quantity: row['quantity'],
//       productName: row['productName'],
//       price: row['price'],
//       totalPrice: row['totalPrice'],
//     );
//   }
//
//   ReceiptItem maReceiptItem(Map<String, dynamic> row) {
//     return ReceiptItem(
//       itemId: row['itemId'],
//       quantity: row['quantity'],
//       productName: row['productName'],
//       price: row['price'],
//       totalPrice: row['totalPrice'],
//     );
//   }
//
//   InvoiceData mapInvoiceData(Map<String, dynamic> row) {
//     return InvoiceData(
//       customerId: row['customerId'],
//       supplierId: row['supplierId'],
//       date: DateTime.parse(row['date']),
//       total: row['total'],
//       currency: row['currency'],
//       status: row['status'],
//       fullName: row['fullName'],
//       invoiceNo: row['invoiceNo'],
//       items: row['items'] != null
//           ? List<InvoiceItem>.from(jsonDecode(row['items'])
//               .map((item) => InvoiceItem.fromJson(item)))
//           : null,
//     );
//   }
//
//   ReceiptData mapReceiptData(Map<String, dynamic> row) {
//     return ReceiptData(
//       customerId: row['customerId'],
//       supplierId: row['supplierId'],
//       date: DateTime.parse(row['date']),
//       total: row['total'],
//       currency: row['currency'],
//       status: row['status'],
//       fullName: row['fullName'],
//       invoiceNo: row['invoiceNo'],
//       items: row['items'] != null
//           ? List<ReceiptItem>.from(jsonDecode(row['items'])
//               .map((item) => ReceiptItem.fromJson(item)))
//           : null,
//     );
//   }
//
//   Future<void> updateContactBalance(int? contactId, num? newBalance) async {
//     final db = await database;
//     await db.update(
//       'Contacts',
//       {'balance': newBalance},
//       where: 'id = ?',
//       whereArgs: [contactId],
//     );
//   }
//
//   Future<void> updateEmployeeBalance(int? employeeId, num? newBalance) async {
//     final db = await database;
//     await db.update(
//       'Employees',
//       {'balance': newBalance},
//       where: 'id = ?',
//       whereArgs: [employeeId],
//     );
//   }
//
//   Future<void> saveInvoice(InvoiceData invoice) async {
//     final db = await database;
//
//     await db.transaction((txn) async {
//       // Insert the master record
//       int masterId = await txn.rawInsert(
//         'INSERT INTO Master '
//         '(customerId, supplierId, date, total, currency, status, fullName, invoiceNo,type) '
//         'VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)',
//         [
//           invoice.customerId,
//           invoice.supplierId,
//           invoice.date?.toIso8601String(),
//           invoice.total,
//           invoice.currency,
//           invoice.status,
//           invoice.fullName,
//           invoice.invoiceNo,
//           "contact"
//         ],
//       );
//
//       // Insert the detail records
//       if (invoice.items != null) {
//         for (InvoiceItem item in invoice.items!) {
//           await txn.rawInsert(
//             'INSERT INTO Detail '
//             '(itemId, quantity, productName, price, totalPrice, masterId) '
//             'VALUES (?, ?, ?, ?, ?, ?)',
//             [
//               item.itemId,
//               item.quantity,
//               item.productName,
//               item.price,
//               item.totalPrice,
//               masterId,
//             ],
//           );
//         }
//       }
//     });
//   }
//
//   Future<void> saveReceipt(ReceiptData receipt) async {
//     final db = await database;
//
//     await db.transaction((txn) async {
//       // Insert the master record
//       int masterId = await txn.rawInsert(
//         'INSERT INTO Master '
//         '(customerId, supplierId, date, total, currency, status, fullName, invoiceNo,type) '
//         'VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)',
//         [
//           receipt.customerId,
//           receipt.supplierId,
//           receipt.date?.toIso8601String(),
//           receipt.total,
//           receipt.currency,
//           receipt.status,
//           receipt.fullName,
//           receipt.invoiceNo,
//           "employee"
//         ],
//       );
//
//       // Insert the detail records
//       if (receipt.items != null) {
//         for (ReceiptItem item in receipt.items!) {
//           await txn.rawInsert(
//             'INSERT INTO Detail '
//             '(itemId, quantity, productName, price, totalPrice, masterId) '
//             'VALUES (?, ?, ?, ?, ?, ?)',
//             [
//               item.itemId,
//               item.quantity,
//               item.productName,
//               item.price,
//               item.totalPrice,
//               masterId,
//             ],
//           );
//         }
//       }
//     });
//   }
//
//   Future<List<InvoiceData>> getAllInvoices() async {
//     final db = database;
//
//     final invoiceRows =
//         await db.query('Master', where: 'type = ?', whereArgs: ['contact']);
//     final receiptRows =
//         await db.query('Master', where: 'type = ?', whereArgs: ['employee']);
//     // Fetch items for each invoice
//     final invoices = <InvoiceData>[];
//     final receipts = <ReceiptData>[];
//
//     for (var invoiceRow in invoiceRows) {
//       final invoice = mapInvoiceData(invoiceRow);
//
//       final itemRows = await db.query(
//         'Detail',
//         where: 'masterId = ?',
//         whereArgs: [invoiceRow['id']],
//       );
//       invoice.items = itemRows.map(mapInvoiceItem).toList();
//
//       invoices.add(invoice);
//       final invoiceDataMap = invoice.toJson();
//       await addInvoice(invoiceDataMap).then((res) async {
//         if (res.status == true) {
//           await db.delete(
//             'Master',
//             where: 'id = ?',
//             whereArgs: [invoiceRow['id']],
//           );
//           await db.delete(
//             'Detail',
//             where: 'masterId = ?',
//             whereArgs: [invoiceRow['id']],
//           );
//         }
//       });
//     }
//
//     for (var receiptRow in receiptRows) {
//       final receipt = mapReceiptData(receiptRow);
//
//       // Fetch items for the current invoice
//       final itemRows = await db.query(
//         'Detail',
//         where: 'masterId = ?',
//         whereArgs: [receiptRow['id']],
//       );
//       receipt.items = itemRows.map(maReceiptItem).toList();
//
//       receipts.add(receipt);
//       final receiptDataMap = receipt.toJson();
//       await addReceipt(receiptDataMap).then((res) async {
//         if (res.status == true) {
//           await db.delete(
//             'Master',
//             where: 'id = ?',
//             whereArgs: [receiptRow['id']],
//           );
//           await db.delete(
//             'Detail',
//             where: 'masterId = ?',
//             whereArgs: [receiptRow['id']],
//           );
//         }
//       });
//     }
//
//     return invoices;
//   }
// }

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'invoice.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE InvoiceBeneficary(
        invoiceNo TEXT PRIMARY KEY,
        date TEXT,
        totalPrice INTEGER,
        accountId INTEGER,
        fullName TEXT,
        vendorName TEXT,
        cashOrCategory TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE Product(
        id INTEGER PRIMARY KEY,
        name TEXT,
        price INTEGER,
        barcode TEXT,
        count INTEGER,
        category TEXT,
        invoiceNo TEXT,
        FOREIGN KEY (invoiceNo) REFERENCES InvoiceBeneficary(invoiceNo)
      )
    ''');
  }

  Future<int> insertInvoiceBeneficary(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('InvoiceBeneficary', row);
  }

  Future<int> insertProduct(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('Product', row);
  }

  Future<int> updateInvoiceBeneficary(
      Map<String, dynamic> row, String invoiceNo) async {
    Database db = await instance.database;
    return await db.update('InvoiceBeneficary', row,
        where: 'invoiceNo = ?', whereArgs: [invoiceNo]);
  }

  Future<int> deleteInvoiceBeneficary(String invoiceNo) async {
    Database db = await instance.database;
    return await db.delete('InvoiceBeneficary',
        where: 'invoiceNo = ?', whereArgs: [invoiceNo]);
  }

  Future<int> deleteProductsByInvoiceNo(String invoiceNo) async {
    Database db = await instance.database;
    return await db
        .delete('Product', where: 'invoiceNo = ?', whereArgs: [invoiceNo]);
  }

  Future<List<Map<String, dynamic>>> getProductsByInvoiceNo(
      String invoiceNo) async {
    Database db = await instance.database;
    return await db
        .query('Product', where: 'invoiceNo = ?', whereArgs: [invoiceNo]);
  }

  Future<List<Map<String, dynamic>>> getAllInvoiceBeneficaries() async {
    Database db = await instance.database;
    return await db.query('InvoiceBeneficary');
  }

  Future<void> deleteAllInvoiceBeneficaries() async {
    Database db = await instance.database;
    await db.delete('InvoiceBeneficary');
  }
}