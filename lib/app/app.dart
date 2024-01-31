import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartcard/app/screens/Splash%20Screen.dart';
import 'package:smartcard/app/utils/theme_manger/cubit/theme_cubit.dart';
import '../main.dart';
import '/app/utils/constants_manager.dart';
import 'cubits/nfc_contact/nfc_contact_cubit.dart';
import 'utils/routes_manager.dart';
import 'utils/theme_manger/theme_manager.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return NfcDataCubit();
        }),

        BlocProvider(create: (context) {
          return ThemeCubit();
        }),
      ],
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return BlocConsumer<ThemeCubit, ThemeState>(
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
                // initialRoute:
                // (TOKEN.isNotEmpty && FIRSTLOGIN == 1)
                //     ? Routes.homeFormRoute
                //     : Routes.loginFormRoute,

                themeMode: ThemeCubit
                    .get(context)
                    .isDark ? ThemeMode.dark : ThemeMode.light,
                theme: lightTheme,
                darkTheme: darkTheme,
              );
            },
          );
        },
      ),
    );
  }
}
