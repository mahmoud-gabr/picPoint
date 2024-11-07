import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pic_point/auth/login_screen.dart';
import 'package:pic_point/auth/register_screen.dart';
import 'package:pic_point/admin/home/add_place_screen.dart';
import 'package:pic_point/admin/home/admin_home_screen.dart';
import 'package:pic_point/user/home/home_screen.dart';
import 'package:pic_point/user/home/place_details_screen.dart';
import 'package:pic_point/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const PicPoint());
}

class PicPoint extends StatelessWidget {
  const PicPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'), 
      supportedLocales: const [
        Locale('ar'), 
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
