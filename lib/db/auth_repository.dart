import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:pic_point/models/user_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  AuthRepository();
  final db = FirebaseDatabase.instance.ref();

  Future<UserModel> login(String email, String password) async {
    UserModel? userData;
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    )
        .then((d) async {
      var userReference = await db.child("users").child(d.user!.uid).once();
      userData = UserModel.fromJson(
          (userReference.snapshot.value as Map<dynamic, dynamic>));
      userData!.id = userReference.snapshot.key;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      const JsonEncoder encoder = JsonEncoder();
      prefs.setString("user", encoder.convert((userData!.toJson())));
      prefs.setBool("isLogined", true);

      return userData!;
    });
  }

  Future<UserModel> signup(
      String email, String password, UserModel user) async {
    UserModel newUser;

    try {
      UserCredential d =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      DatabaseReference databaseReference =
          db.child("users").child(d.user!.uid);
      await databaseReference.set(user.toJson());

      var userSnapshot = await databaseReference.once();
      newUser = UserModel.fromJson(
          (userSnapshot.snapshot.value as Map<dynamic, dynamic>));
      newUser.id = userSnapshot.snapshot.key;

      const JsonEncoder encoder = JsonEncoder();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("user", encoder.convert((newUser.toJson())));
      prefs.setBool("isLogined", true);

      return newUser;
    } catch (error) {
      throw Exception("Signup failed: ${error.toString()}");
    }
  }
}
