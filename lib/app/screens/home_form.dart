import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartcard/app/widgets/nfcccontactscreen.dart';

import '../../main.dart';
import '../utils/color_manager.dart';
import '../utils/database_helper.dart';
import '../utils/routes_manager.dart';
import '../widgets/MyConnectivityStatefulWidget.dart';
import '../widgets/default_button_widget.dart';
import 'drawerdata.dart';

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
    final count = await dbHelper.getAllInvoicesNote();
    setState(() {
      invoiceCount = count;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
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
    final rightSlide = MediaQuery.of(context).size.width * -0.65;
    // Define the currentIndex variable here
    return PopScope(
      onPopInvoked: _onWillPop,
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            double slide = rightSlide * _animationController.value;
            double scale = 1 - (_animationController.value * 0.3);

            return Stack(children: [
              MyConnectivityStatefulWidget(),
              Scaffold(
                backgroundColor: ColorManager.primary,
                body: DrawerData(),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      image: AssetImage('assets/images/img_constraction.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        centerTitle: true,
                        title: SvgPicture.asset(
                          "assets/images/icon.svg",
                          width: 40.w,
                        ),
                        leading: IconButton(
                          onPressed: () => _toggleAnimation(),
                          icon: AnimatedIcon(
                            color: ColorManager.baseYellow,
                            icon: AnimatedIcons.menu_close,
                            progress: _animationController,
                          ),
                        ),
                        actions: [
                          Stack(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await dbHelper.getAllInvoices();
                                  _getInvoiceCount();
                                },
                                color: ColorManager.baseYellow,
                                icon: const Icon(Icons.notifications),
                              ),
                              invoiceCount > 0
                                  ? Positioned(
                                      right: 10,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          invoiceCount.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ],
                      ),
                      body: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  child: const NfcContactCardScreen()),
                            ],
                          ),
                        ),
                      )),
                ),
              )
            ]);
          }),
    );
  }
}
// Padding(
//   padding: const EdgeInsets.all(15.0),
//   child: defaultButton(
//     background: ColorManager.secondary,
//       context: context,
//       text: "إصدار فاتورة",
//       function: () {
//
//         // Navigator.popAndPushNamed(
//         //     context, Routes.contactCardRoute);
//       }),
// ),
// Padding(
//   padding: const EdgeInsets.all(15.0),
//   child: defaultButton(
//       background: ColorManager.secondary,
//       context: context,
//       text: "سحب  رصيد",
//       function: () async {
//         Navigator.popAndPushNamed(
//             context, Routes.employeeCardRoute);
//       }),
// ),