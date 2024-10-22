import 'package:flutter/material.dart';
import 'package:pic_point/admin/auth/login_screen.dart';
import 'package:pic_point/admin/home/admin_home_screen.dart';
import 'package:pic_point/app_theme.dart';
import 'package:pic_point/widgets/deafult_elevated_botton.dart';
import 'package:pic_point/widgets/deafult_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static String id = '/RegisterScreen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController passwordControler = TextEditingController();
  TextEditingController emailControler = TextEditingController();
  TextEditingController confirmEmailControler = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 64,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 160,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 26,
                        color: AppTheme.primary,
                      ),
                ),
                const SizedBox(
                  height: 32,
                ),
                DeafaultTextFormField(
                  controller: emailControler,
                  hintText: 'Email',
                  validator: (value) {
                    if (value == null || value.trim().length < 8) {
                      return 'email can not be less than 8 char';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                DeafaultTextFormField(
                  controller: passwordControler,
                  hintText: 'Password',
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.trim().length < 8) {
                      return 'password can not be less than 8 char';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                DeafaultTextFormField(
                  controller: passwordControler,
                  hintText: 'Confirm Password',
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.trim().length < 8) {
                      return 'password can not be less than 8 char';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 32,
                ),
                DeafaultElevetedBotton(
                  label: 'Sign Up',
                  onPressed: () {
                    Navigator.pushNamed(context, AdminHomeScreen.id);
                  },
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text(
                      'Have Account?',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppTheme.primary,
                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
