import 'package:flutter/material.dart';
import 'package:smartcard/app/widgets/nfcccontactscreen.dart';
import '../../main.dart';
import '../utils/color_manager.dart';
import '../widgets/MyConnectivityStatefulWidget.dart';
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
                child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      centerTitle: true,
                      elevation: 0,
                      leading: IconButton(
                        onPressed: () => _toggleAnimation(),
                        icon: AnimatedIcon(
                          color: ColorManager.black,
                          icon: AnimatedIcons.menu_close,
                          progress: _animationController,
                        ),
                      ),
                    ),
                    body: Container(
                      color: Colors.white,
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: const NfcContactCardScreen()),
                            ],
                          ),
                        ),
                      ),
                    )),
              )
            ]);
          }),
    );
  }
}
