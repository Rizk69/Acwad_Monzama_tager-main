import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartcard/app/cubits/login/login_cubit.dart';
import 'package:smartcard/app/utils/constants_manager.dart';
import 'package:smartcard/app/widgets/default_button_widget.dart';
import '../../app/utils/color_manager.dart';
import '../../main.dart';
import '../app.dart';
import '../models/model_keys.dart';
import '../network/app_api.dart';
import '../store/app_store.dart';
import '../utils/common.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();
  FocusNode oldPasswordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          title: SvgPicture.asset(
            "assets/images/icon.svg",
            width: 40.w,
          ),
          actionsIconTheme: IconThemeData(color: ColorManager.baseYellow),
          leading: BackButton(
            color: ColorManager.baseYellow, // <-- SEE HERE
          ),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 8, right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
                SizedBox(height: 2.h),
                Text(
                  "حسابي",
                  style: TextStyle(
                    fontSize: 20,
                    color: ColorManager.baseYellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 45),
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: {
                    0: IntrinsicColumnWidth(),
                    1: FlexColumnWidth(),
                  },
                  children: [
                    buildTableRow("اسم المسؤول :", appStore.name),
                    buildTableRow("الهاتف :", appStore.phone),
                    buildTableRow("العنوان :", appStore.address),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(5.pt),
                  child: defaultButton(
                      background: ColorManager.baseYellow,
                      context: context,
                      text: "تغيير كلمة السر",
                      textStyle:
                          TextStyle(fontSize: 18.sp, color: Colors.white),
                      width: 40.w,
                      function: () async {}),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

TableRow buildTableRow(String label, String value) {
  return TableRow(
    children: [
      Container(
        padding: const EdgeInsets.all(10.0),
        color: ColorManager.baseYellow,
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black, // لون النص في خلفية العنصر
              ),
            ),
            Container(
              height: 1.h,
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        child: Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.black, // لون النص في خلفية العنصر
          ),
        ),
      ),
    ],
  );
}
