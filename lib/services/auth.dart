// ignore_for_file: avoid_print

import 'package:e_commerce/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../checks/checklist.dart';

class AuthService {
//An instance for Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

//Create a User based on Sign-in Result
  IUser? _userfromResults(User? user) {
    return user != null
        ? IUser(uid: user.uid, verified: user.emailVerified)
        : null;
  }

  Future<void> sendVerificationCode() async {
    final user = FirebaseAuth.instance.currentUser;
    user?.sendEmailVerification();
  }

// Sign in
  Future<IUser?> signinWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential? result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      logCheck = false;

      return _userfromResults(result.user);
    } catch (e) {
      logCheck = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            e.toString().split("]")[1],
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
      return null;
    }
  }

  void verifyEmail(User? user) async {
    user?.sendEmailVerification();
  }

//Register with email and password

  Future<IUser?> createUserWithEmailandPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      print(regCheck);
      UserCredential? result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      regCheck = false;
      verifyEmail(result.user);
      return _userfromResults(result.user);
    } catch (e) {
      regCheck = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            e.toString().split("]")[1],
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return null;
  }

  //sign out
}
