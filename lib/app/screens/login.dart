import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:smartcard/app/cubits/login/login_cubit.dart';
import 'package:smartcard/app/utils/Styles.dart';
import 'package:smartcard/app/utils/default_snake_bar.dart';
import 'package:smartcard/app/widgets/custom_text_form_field.dart';

import '../app.dart';
import '../models/model_keys.dart';
import '../network/app_api.dart';
import '../store/app_store.dart';
import '../utils/color_manager.dart';
import '../utils/common.dart';
import '../utils/constants_manager.dart';
import '../utils/database_helper.dart';
import '../widgets/app_loader_widget.dart';
import '../widgets/change_password_dialog.dart';
import 'home_form.dart';
import '../../main.dart';

class SignInScreen extends StatefulWidget {
  static String tag = '/SignInScreen';

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode? emailFocusNode = FocusNode();
  FocusNode? passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //  checkDatabaseStatus();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(transparentColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark);
  }

  @override
  void setState(fn) async {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            final snackBar = defaultSnakeBar(
              title: "تم التسجيل الدخول بنجاح!",
              message: "مرحبا بعودتك",
              state: ContentType.success,
            );
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeForm()),
              (Route<dynamic> route) => false,
            );
          }

          if (state is LoginFirstSuccessState) {
            final snackBar = defaultSnakeBar(
              title: "تم التسجيل الدخول بنجاح!",
              message: "يرجو تغير كلمه السر ",
              state: ContentType.warning,
            );
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);

            showDialog(
                context: context, builder: (context) => ChangePasswordDialog());
          }

          if (state is LoginErrorState) {
            final snackBar = defaultSnakeBar(
              title: "هناك خطأ!",
              message: state.error,
              state: ContentType.failure,
            );
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Animate(
                  effects: const [FadeEffect(), ScaleEffect()],
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/img_constraction.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.pt),
                                child:
                                    SvgPicture.asset("assets/images/icon.svg"),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                'الاميل',
                                style: Styles.textStyleTitle18,
                              ),
                              SizedBox(height: 1.h),
                              CustomTextFormField(
                                  hintText: 'acwad@gmail.com',
                                  prefix: const Icon(Icons.email_outlined,
                                      color: Color(0xffC19843)),
                                  textInputType: TextInputType.emailAddress,
                                  controller: emailController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'email is  empty';
                                    } else {
                                      return null;
                                    }
                                  }),
                              SizedBox(height: 4.h),
                              Text(
                                'كلمة المرور',
                                style: Styles.textStyleTitle18,
                              ),
                              SizedBox(height: 1.h),
                              TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password is to short';
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  controller: passwordController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    focusColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    hintText: '********',
                                    hintStyle: Styles.textStyleTitle16
                                        .copyWith(color: Colors.white),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                        color: Color(0xffEEBB49),
                                        width: 2.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                        color: Color(0xffC19843),
                                        width: 2.0,
                                      ),
                                    ),
                                    prefixIcon: const Icon(Icons.lock_outline,
                                        color: Color(0xffEEBB49)),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        LoginCubit.get(context).suffixIcon,
                                        color: ColorManager.baseYellow,
                                      ),
                                      onPressed: () {
                                        LoginCubit.get(context)
                                            .changePasswordIcon();
                                      },
                                    ),
                                  ),
                                  obscureText:
                                      LoginCubit.get(context).isPassword),
                              SizedBox(height: 5.h),
                              AppButton(
                                width: context.width(),
                                text: "تسجيل دخول",
                                textStyle:
                                    boldTextStyle(color: ColorManager.white),
                                color: ColorManager.baseYellow,
                                enableScaleAnimation: false,
                                onTap: () async {
                                  LoginCubit.get(context).login(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  // loginApi(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
