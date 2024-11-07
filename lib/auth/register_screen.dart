import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pic_point/auth/login_screen.dart';
import 'package:pic_point/admin/home/admin_home_screen.dart';
import 'package:pic_point/app_theme.dart';
import 'package:pic_point/db/auth_repository.dart';
import 'package:pic_point/models/user_model.dart';
import 'package:pic_point/widgets/deafult_elevated_botton.dart';
import 'package:pic_point/widgets/deafult_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static String id = '/RegisterScreen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmEmailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool? isLoading = false;
  UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 64),
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 160,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'إنشاء حساب',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 26,
                          color: AppTheme.primary,
                        ),
                  ),
                  const SizedBox(height: 32),
                  DeafaultTextFormField(
                    controller: nameController,
                    hintText: 'الاسم',
                    validator: (value) {
                      if (value == null || value.trim().length < 6) {
                        return 'يجب أن يحتوي الاسم على 6 أحرف على الأقل';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DeafaultTextFormField(
                    controller: emailController,
                    hintText: 'البريد الإلكتروني',
                    validator: (value) {
                      if (value == null || value.trim().length < 8) {
                        return 'يجب أن يحتوي البريد الإلكتروني على 8 أحرف على الأقل';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DeafaultTextFormField(
                    controller: passwordController,
                    hintText: 'كلمة المرور',
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.trim().length < 8) {
                        return 'يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DeafaultTextFormField(
                    controller: confirmEmailController,
                    hintText: 'تأكيد كلمة المرور',
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'يجب إدخال تأكيد كلمة المرور';
                      }
                      if (value.trim() != passwordController.text.trim()) {
                        return 'كلمة المرور غير متطابقة';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  DeafaultElevetedBotton(
                    label: 'إنشاء حساب',
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (!isLoading!) {
                        setState(() {
                          isLoading = true;
                        });

                        userModel = UserModel(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        AuthRepository()
                            .signup(emailController.text,
                                passwordController.text, userModel!)
                            .then((value) {
                          setState(() {
                            isLoading =
                                false; // Set loading to false after receiving response
                            userModel = value;
                          });
                          Navigator.pushNamed(context, AdminHomeScreen.id);
                        }).catchError((error) {
                          Fluttertoast.showToast(
                            msg: error.toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          setState(() {
                            isLoading =
                                false; // Ensure loading state is reset on error
                          });
                        });
                      }
                    },
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Text(
                        'هل لديك حساب؟',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppTheme.primary,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
