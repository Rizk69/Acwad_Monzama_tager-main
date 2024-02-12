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
CREATE TABLE DailyInvoiceBeneficaryData (
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

//     await db.execute('''
// CREATE TABLE ProductDailyInvoice (
//   id INTEGER PRIMARY KEY AUTOINCREMENT,
//   invoiceNo TEXT,
//   name TEXT,
//   price TEXT,
//   barcode TEXT,
//   count INTEGER,
//   category TEXT,
//   FOREIGN KEY (invoiceNo) REFERENCES InvoiceBeneficaryData(invoiceNo)
// );
//   ''');
  }

  Future<void> resetDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'invoice.db');

    await close(); // إغلاق القاعدة إذا كانت مفتوحة
    await deleteDatabase(path); // حذف ملف القاعدة

    _database = null; // إعادة تعيين المتغير للتأكد من إعادة إنشائه

    await database; // إعادة فتح القاعدة لإنشائها من جديد
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
