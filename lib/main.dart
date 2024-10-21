import 'package:flutter/material.dart';
import 'package:pic_point/login_screen.dart';

void main() {
  runApp(const PicPoint());
}

class PicPoint extends StatelessWidget {
  const PicPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      routes: {
        LoginScreen.id:(context) => const LoginScreen(),
      }
      
    );
  }
}