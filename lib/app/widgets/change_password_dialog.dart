import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smartcard/app/screens/auth/cubit/login_cubit.dart';
import 'package:smartcard/app/screens/home_form.dart';
import 'package:smartcard/app/utils/default_snake_bar.dart';
import 'package:smartcard/app/utils/resource/color_manager.dart';

class ChangePasswordDialog extends StatefulWidget {
  @override
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccessState) {
            final snackBar = defaultSnakeBar(
              title: "تم تغير كلمة السر بنجاح!",
              message: "مرحبا بعودتك ",
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

          if (state is ChangePasswordErrorState) {
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
          return SlideTransition(
            position: _slideAnimation,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              backgroundColor: Colors.transparent,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Change Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      TextFormField(
                        controller: passwordController,
                        obscureText: LoginCubit.get(context).isPassword,
                        decoration: InputDecoration(
                          labelText: 'Current Password',
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[200],
                          suffixIcon: IconButton(
                            icon: Icon(LoginCubit.get(context).suffixIcon),
                            onPressed: () {
                              LoginCubit.get(context).changePasswordIcon();
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      TextFormField(
                        controller: newPasswordController,
                        obscureText: LoginCubit.get(context).isPassword,
                        decoration: InputDecoration(
                          labelText: 'New Password',
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[200],
                          suffixIcon: IconButton(
                            icon: Icon(LoginCubit.get(context).suffixIcon),
                            onPressed: () {
                              LoginCubit.get(context).changePasswordIcon();
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      TextFormField(
                        controller: confirmNewPasswordController,
                        obscureText: LoginCubit.get(context).isPassword,
                        decoration: InputDecoration(
                          labelText: 'Confirm New Password',
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[200],
                          suffixIcon: IconButton(
                            icon: Icon(LoginCubit.get(context).suffixIcon),
                            onPressed: () {
                              LoginCubit.get(context).changePasswordIcon();
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      ElevatedButton(
                        onPressed: () {
                          LoginCubit.get(context).changePassword(
                              currentPassword: passwordController.text,
                              newPassword: newPasswordController.text,
                              newPasswordConfirmation:
                                  confirmNewPasswordController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.secondary,
                        ),
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
