import 'package:flutter/material.dart';
import 'package:pic_point/auth/register_screen.dart';
import 'package:pic_point/admin/home/admin_home_screen.dart';
import 'package:pic_point/db/auth_repository.dart';
import 'package:pic_point/models/user_model.dart';
import 'package:pic_point/user/home/home_screen.dart';
import 'package:pic_point/app_theme.dart';
import 'package:pic_point/widgets/deafult_elevated_botton.dart';
import 'package:pic_point/widgets/deafult_text_form_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  static String id = '/';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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
                    'تسجيل الدخول',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 26,
                          color: AppTheme.primary,
                        ),
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
                  DeafaultElevetedBotton(
                    label: 'تسجيل الدخول',
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (!isLoading!) {
                        setState(() {
                          isLoading = true;
                        });
                        AuthRepository()
                            .login(
                                emailController.text, passwordController.text)
                            .then((value) {
                          setState(() {
                            isLoading = false;
                            userModel = value;
                            Navigator.pushNamed(
                              context,
                              userModel!.role == 'admin'
                                  ? AdminHomeScreen.id
                                  : HomeScreen.id,
                            );
                          });
                        }).catchError((error) {
                          Fluttertoast.showToast(
                              msg: error.toString(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          setState(() {
                            isLoading = false;
                          });
                        });
                      }
                    },
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.id);
                      },
                      child: Text(
                        'ليس لديك حساب؟',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppTheme.primary,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
