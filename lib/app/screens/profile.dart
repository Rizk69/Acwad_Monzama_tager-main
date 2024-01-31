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
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            "حسابي",
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: BackButton(
            color: Theme.of(context).primaryColor,
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 8, right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                    "assets/images/profile.png",
                  ),
                ),
                SizedBox(height: 2.h),
                const SizedBox(height: 20),
                buildTableRow("اسم المسؤول :", appStore.name,
                    Theme.of(context).primaryColorDark, context),
                buildTableRow("الهاتف :", appStore.phone,
                    Theme.of(context).canvasColor, context),
                buildTableRow("العنوان :", appStore.address,
                    Theme.of(context).primaryColorDark, context),
                const SizedBox(height: 20),
                Padding(
                    padding: EdgeInsets.all(5.pt),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Color(0XFFEFBB4A),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        elevation: MaterialStateProperty.all<double>(0),
                      ),
                      onPressed: () {},
                      child: Text(
                        'تغيير كلمة السر',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

Widget buildTableRow(
    String label, String value, Color color, BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: color, boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 3, spreadRadius: 0.3)
          ]),
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .primaryColor, // لون النص في خلفية العنصر
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Theme.of(context)
                      .primaryColorLight, // لون النص في خلفية العنصر
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}
