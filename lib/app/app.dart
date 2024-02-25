import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartcard/app/screens/Splash%20Screen.dart';
import 'package:smartcard/app/screens/beneficary/nfc_contact_cubit/nfc_contact_cubit.dart';
import 'package:smartcard/app/utils/helper/database_helper.dart';
import 'package:smartcard/app/utils/resource/constants_manager.dart';
import 'package:smartcard/app/utils/resource/theme_manger/theme_manager.dart';
import '../main.dart';
import 'utils/resource/theme_manger/cubit/app_cubit.dart';
import 'utils/routes_manager.dart';

class MyApp extends StatefulWidget {
  MyApp._internal();

  int appState = 0;
  static final MyApp _instance =
  MyApp._internal(); // singleton or single instance
  factory MyApp() => _instance; // factory

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late DateTime currentBackPressTime;

  @override
  void initState() {
    super.initState();
    getData().then((_) {
      setState(() {});
    });
  }

  Future<void> getData() async {
    await appStore.setLoggedIn(getBoolAsync(IS_LOGGED_IN, defaultValue: false));
    await appStore.setUserId(getIntAsync(USER_ID), isInitializing: true);
    await appStore.setName(getStringAsync(NAME), isInitializing: true);
    await appStore.setUserName(getStringAsync(USERNAME), isInitializing: true);
    await appStore.setPhone(getStringAsync(PHONE), isInitializing: true);
    await appStore.setAddress(getStringAsync(ADDRESS), isInitializing: true);
    await appStore.setContactName(getStringAsync(CONTACTNAME),
        isInitializing: true);
    await appStore.setUUID(getStringAsync(BRANCHUUID), isInitializing: true);
    await appStore.setToken(getStringAsync(TOKEN));
    printAllData();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return NfcDataCubit();
        }),

        BlocProvider(create: (context) {
          return AppCubit();
        }),
      ],
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return BlocConsumer<AppCubit, ThemeState>(
            listener: (context, state) {
            },
            builder: (context, state) {
              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                onGenerateRoute: RouteGenerator.getRoute,
                home: SplashScreen(),
                themeMode: AppCubit
                    .get(context).isDark
                    ? ThemeMode.dark
                    : ThemeMode.light,
                theme: lightTheme,
                darkTheme: darkTheme,
              );
            },
          );
        },
      ),
    );
  }

  Future<void> printAllData() async {
    final db = await DatabaseHelper.instance.database;

    // Print data from InvoiceBeneficaryData table
    List<Map<String, dynamic>> invoiceBeneficaryData =
        await db.query('InvoiceBeneficaryData');
    print('InvoiceBeneficaryData:');
    invoiceBeneficaryData.forEach((row) => print(row));

    // Print data from ProductInvoice table
    List<Map<String, dynamic>> productInvoice =
        await db.query('ProductInvoice');
    print('ProductInvoice:');
    productInvoice.forEach((row) => print(row));

    // Print data from AllInvoiceBeneficaryData table
    List<Map<String, dynamic>> allInvoiceBeneficaryData =
        await db.query('AllInvoiceBeneficaryData');
    print('AllInvoiceBeneficaryData:');
    allInvoiceBeneficaryData.forEach((row) => print(row));

    // Print data from ProductAllInvoice table
    List<Map<String, dynamic>> productAllInvoice =
        await db.query('ProductAllInvoice');
    print('ProductAllInvoice:');
    productAllInvoice.forEach((row) => print(row));

    // Print data from OfflineVendorData table
    List<Map<String, dynamic>> offlineVendorData =
        await db.query('OfflineVendorData');
    print('OfflineVendorData:');
    offlineVendorData.forEach((row) => print(row));

    // Print data from OfflineBeneficiary table
    List<Map<String, dynamic>> offlineBeneficiary =
        await db.query('OfflineBeneficiary');
    print('OfflineBeneficiary:');
    offlineBeneficiary.forEach((row) => print(row));

    // Print data from OfflinePaidBeneficiary table
    List<Map<String, dynamic>> offlinePaidBeneficiary =
        await db.query('OfflinePaidBeneficiary');
    print('OfflinePaidBeneficiary:');
    offlinePaidBeneficiary.forEach((row) => print(row));

    // Print data from OfflineCategoriesData table
    List<Map<String, dynamic>> offlineCategoriesData =
        await db.query('OfflineCategoriesData');
    print('OfflineCategoriesData:');
    offlineCategoriesData.forEach((row) => print(row));
  }
}
