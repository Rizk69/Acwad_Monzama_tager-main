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
        color: Color(0XffF8F6F6),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "حسابي",
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: BackButton(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
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
                buildTableRow("اسم المسؤول :", appStore.name, Colors.white),
                buildTableRow("الهاتف :", appStore.phone, Color(0XffF8F6F6)),
                buildTableRow("العنوان :", appStore.address, Colors.white),
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
                      child: const Text(
                        'تغيير كلمة السر',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
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

Widget buildTableRow(String label, String value, Color color) {
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
                  color: Colors.black, // لون النص في خلفية العنصر
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.grey, // لون النص في خلفية العنصر
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}
