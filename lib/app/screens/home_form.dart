import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smartcard/app/screens/beneficary/nfc_contact_cubit/nfc_contact_cubit.dart';
import 'package:smartcard/app/screens/beneficary/nfcccontactscreen.dart';
import 'package:smartcard/app/utils/resource/theme_manger/cubit/app_cubit.dart';
import '../../main.dart';
import '../network/api_end_points.dart';
import '../widgets/MyConnectivityStatefulWidget.dart';
import '../widgets/backgrond_image.dart';
import '../utils/drawerdata.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({super.key});

  @override
  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isFabEnabled = false;
  int invoiceCount = 0;

  @override
  void initState() {
    super.initState();
    _checkFirstTimeUser();

    _getInvoiceCount();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  void _toggleAnimation() {
    _animationController.isDismissed
        ? _animationController.forward()
        : _animationController.reverse();
  }

  Future<void> _getInvoiceCount() async {
    // final count = await dbHelper.getAllInvoicesNote();
    setState(() {
      // invoiceCount = count;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  void _checkFirstTimeUser() async {
    bool isConnected = await ApiHelper().connectedToInternet();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isConnected && isFirstTime) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("مرحباً بك"),
            content: Text("هل تريد مزامنه قاعده البيانات"),
            actions: <Widget>[
              TextButton(
                child: Text("موافق"),
                onPressed: () async {
                  await AppCubit.get(context).getOfflineData(
                      vendorId: appStore.userId, context: context);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

      // Set isFirstTime to false to prevent showing the alert again
      prefs.setBool('isFirstTime', false);
    }
  }

  _onWillPop(bool s) async {
    // Show an alert dialog to ask for confirmation
    final confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الخروج'),
        content: const Text('هل أنت متأكد أنك تريد الخروج من التطبيق؟'),
        actions: [
          TextButton(
            child: const Text('إلغاء'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text('خروج'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // User confirmed, exit the app
      return true;
    } else {
      // User canceled, continue app navigation
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final rightSlide = MediaQuery.of(context).size.width * -0.55;
    return PopScope(
      onPopInvoked: _onWillPop,
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            double slide = rightSlide * _animationController.value;
            double scale = 1 - (_animationController.value * 0.3);

            return Stack(children: [
              MyConnectivityStatefulWidget(),
              const Scaffold(
                backgroundColor: Colors.white,
                body: DrawerData(),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.center,
                child: BlocBuilder<AppCubit, ThemeState>(
                  builder: (context, state) {
                    return Container(
                      color: Theme.of(context).primaryColor,
                      child: Stack(
                        children: [
                          imageBackground(context),
                          Scaffold(
                              // floatingActionButton: FloatingActionButton(
                              //   onPressed: () async {
                              //     SharedPreferences prefs =
                              //         await SharedPreferences.getInstance();
                              //     List<String>? offLineRequestStrings =
                              //         prefs.getStringList('offLineRequests');
                              //     print(offLineRequestStrings);
                              //     AppCubit.get(context)
                              //         .sendPaidOfflineToOnline();
                              //   },
                              // ),
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              appBar: AppBar(
                                backgroundColor: Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor,
                                leading: IconButton(
                                  onPressed: () => _toggleAnimation(),
                                  icon: AnimatedIcon(
                                    color: Theme.of(context).primaryColor,
                                    icon: AnimatedIcons.menu_close,
                                    progress: _animationController,
                                  ),
                                ),
                                actions: [
                                  IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).getOfflineData(
                                          context: context,
                                          vendorId: appStore.userId);
                                    },
                                    icon: Icon(
                                      Icons.update,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).changeAppMode();
                                    },
                                    icon: Icon(
                                      Icons.brightness_4_outlined,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              body: Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            child:
                                                const NfcContactCardScreen()),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    );
                  },
                ),
              )
            ]);
          }),
    );
  }
}
