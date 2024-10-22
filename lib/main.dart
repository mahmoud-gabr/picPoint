import 'package:flutter/material.dart';
import 'package:pic_point/admin/auth/login_screen.dart';
import 'package:pic_point/admin/auth/register_screen.dart';
import 'package:pic_point/admin/home/add_place_screen.dart';
import 'package:pic_point/admin/home/admin_home_screen.dart';
import 'package:pic_point/admin/home/home_screen.dart';
import 'package:pic_point/admin/home/place_details_screen.dart';
import 'package:pic_point/app_theme.dart';

void main() {
  runApp(const PicPoint());
}

class PicPoint extends StatelessWidget {
  const PicPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        AdminHomeScreen.id: (context) => const AdminHomeScreen(),
        AddPlaceScreen.id: (context) => const AddPlaceScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        PlaceDetailsScreen.id: (context) => const PlaceDetailsScreen(),
      },
      theme: AppTheme.lightTheme,
    );
  }
}
