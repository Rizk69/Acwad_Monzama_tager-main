import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smartcard/app/utils/helper/bloc_observer.dart';
import 'app/store/app_store.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'app/app.dart';
import 'app/utils/helper/cache_helper.dart';
import 'app/utils/helper/database_helper.dart';

late SharedPreferences sharedPreferences;
AppStore appStore = AppStore();
// final dbHelper = DatabaseHelper();

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  // await DatabaseHelper.instance.database; // Initialize the database

//  await dbHelper.deleteDatabaseFn();
//   await dbHelper.openDatabaseFn();
  await EasyLocalization.ensureInitialized();
  await initialize();
  runApp(EasyLocalization(
      supportedLocales: const [Locale("ar", "SA")],
      path: "assets/translations",
      fallbackLocale: const Locale("ar", "SA"),
      child: Phoenix(child: MyApp())));
}
