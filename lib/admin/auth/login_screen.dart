import 'package:flutter/material.dart';
import 'package:pic_point/admin/auth/register_screen.dart';
import 'package:pic_point/admin/home/admin_home_screen.dart';
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
  TextEditingController passwordControler = TextEditingController();
  TextEditingController emailControler = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(
                flex: 3,
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
                'Log In',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 26,
                      color: AppTheme.primary,
                    ),
              ),
              const SizedBox(
                height: 16,
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
              const Spacer(
                flex: 1,
              ),
              DeafaultElevetedBotton(
                label: 'Login',
                onPressed: () {
                  Navigator.pushNamed(context, AdminHomeScreen.id);
                },
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterScreen.id);
                  },
                  child: Text(
                    'Don\'t Have Account?',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppTheme.primary,
                        ),
                  ),
                ),
              ),
              const Spacer(
                flex: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
