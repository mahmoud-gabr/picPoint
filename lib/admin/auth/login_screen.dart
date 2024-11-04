import 'package:flutter/material.dart';
import 'package:pic_point/admin/auth/register_screen.dart';
import 'package:pic_point/admin/home/admin_home_screen.dart';
import 'package:pic_point/admin/home/home_screen.dart';
import 'package:pic_point/app_theme.dart';
import 'package:pic_point/widgets/deafult_elevated_botton.dart';
import 'package:pic_point/widgets/deafult_text_form_field.dart';

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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 3),
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
                const Spacer(flex: 1),
                DeafaultElevetedBotton(
                  label: 'تسجيل الدخول',
                  onPressed: () {
                    Navigator.pushNamed(context, HomeScreen.id);
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
                const Spacer(flex: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
