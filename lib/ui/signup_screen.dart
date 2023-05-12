// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:e_commerce/const/AppColors.dart';
import 'package:e_commerce/const/routes.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../checks/checklist.dart';
import '../database/data.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final TextEditingController _r_email;
  late final TextEditingController _r_password;
  late final TextEditingController _r_username;
  late final TextEditingController _r_contact;
  late final TextEditingController _r_con_password;

  @override
  void initState() {
    _r_email = TextEditingController();
    _r_password = TextEditingController();
    _r_username = TextEditingController();
    _r_contact = TextEditingController();
    _r_con_password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _r_email.dispose();
    _r_contact.dispose();
    _r_password.dispose();
    _r_username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.deepOrange,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height - screenSize.height / 1.3,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 30, bottom: 10),
                  constraints: BoxConstraints(
                    minHeight: screenSize.height / 1.3,
                    maxHeight: double.infinity,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RegisterText(), //Register Text
                      SizedBox(
                        height: 50.sm,
                      ),
                      RegisterUsername(_r_username), //Username
                      SizedBox(
                        height: 15.sm,
                      ),
                      RegisterEmail(_r_email), //Email
                      SizedBox(
                        height: 15.sm,
                      ),
                      RegisterPassword(_r_password), //Password
                      SizedBox(
                        height: 15.sm,
                      ),
                      RegisterConfirmPassword(
                          _r_con_password), // Confrim Password
                      SizedBox(
                        height: 15.sm,
                      ),
                      RegisterContact(_r_contact), //Cpntact Number
                      SizedBox(
                        height: screenSize.height / 15,
                      ),
                      SignupButton(
                        //Sign Up Button
                        _r_username.text,
                        _r_email.text.trim(),
                        _r_password.text,
                        _r_con_password.text,
                        _r_contact.text,
                        context,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget RegisterContact(TextEditingController contact) {
  return TextFormField(
    controller: contact,
    decoration: InputDecoration(
      prefixIcon: const Icon(
        Icons.contacts,
        size: 28,
        color: AppColors.deepOrange,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1.sm, color: AppColors.deepOrange),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.sm, color: AppColors.deepOrange),
      ),
      label: const Text("Enter Contact"),
      labelStyle: TextStyle(fontSize: 18.sm),
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    autocorrect: false,
    style: TextStyle(color: Colors.black, fontSize: 18.sm),
    strutStyle: StrutStyle(
      fontSize: 18.sm,
    ),
    cursorColor: AppColors.deepOrange,
    cursorHeight: 22.sm,
    keyboardType: TextInputType.number,
  );
}

Widget RegisterConfirmPassword(TextEditingController con_password) {
  return TextFormField(
    controller: con_password,
    decoration: InputDecoration(
      prefixIcon: const Icon(
        Icons.key_outlined,
        size: 28,
        color: AppColors.deepOrange,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1.sm, color: AppColors.deepOrange),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.sm, color: AppColors.deepOrange),
      ),
      label: const Text("Confirm Password"),
      labelStyle: TextStyle(fontSize: 18.sm),
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    autocorrect: false,
    enableSuggestions: false,
    obscureText: true,
    style: TextStyle(color: Colors.black, fontSize: 18.sm),
    strutStyle: StrutStyle(
      fontSize: 18.sm,
    ),
    cursorColor: AppColors.deepOrange,
    cursorHeight: 22.sm,
  );
}

Widget RegisterPassword(TextEditingController password) {
  return TextFormField(
    controller: password,
    decoration: InputDecoration(
      prefixIcon: const Icon(
        Icons.key_outlined,
        size: 28,
        color: AppColors.deepOrange,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1.sm, color: AppColors.deepOrange),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.sm, color: AppColors.deepOrange),
      ),
      label: const Text("Enter Password"),
      labelStyle: TextStyle(fontSize: 18.sm),
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    autocorrect: false,
    enableSuggestions: false,
    obscureText: true,
    style: TextStyle(color: Colors.black, fontSize: 18.sm),
    strutStyle: StrutStyle(
      fontSize: 18.sm,
    ),
    cursorColor: AppColors.deepOrange,
    cursorHeight: 22.sm,
  );
}

Widget RegisterEmail(TextEditingController email) {
  return TextFormField(
    controller: email,
    decoration: InputDecoration(
      prefixIcon: const Icon(
        Icons.email,
        size: 28,
        color: AppColors.deepOrange,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1.sm, color: AppColors.deepOrange),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.sm, color: AppColors.deepOrange),
      ),
      label: const Text("Enter Email"),
      labelStyle: TextStyle(fontSize: 18.sm),
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    autocorrect: false,
    keyboardType: TextInputType.emailAddress,
    style: TextStyle(color: Colors.black, fontSize: 18.sm),
    strutStyle: StrutStyle(
      fontSize: 18.sm,
    ),
    cursorColor: AppColors.deepOrange,
    cursorHeight: 22.sm,
  );
}

class RegisterText extends StatelessWidget {
  const RegisterText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Register",
      style: TextStyle(
          color: AppColors.deepOrange,
          fontSize: 25.sm,
          fontWeight: FontWeight.bold),
    );
  }
}

Widget RegisterUsername(TextEditingController name) {
  return TextFormField(
    controller: name,
    decoration: InputDecoration(
      prefixIcon: const Icon(
        Icons.account_circle_rounded,
        size: 28,
        color: AppColors.deepOrange,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1.sm, color: AppColors.deepOrange),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.sm, color: AppColors.deepOrange),
      ),
      label: const Text("Enter Username"),
      labelStyle: TextStyle(fontSize: 18.sm),
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    autocorrect: false,
    style: TextStyle(color: Colors.black, fontSize: 18.sm),
    strutStyle: StrutStyle(
      fontSize: 18.sm,
    ),
    cursorColor: AppColors.deepOrange,
    cursorHeight: 22.sm,
  );
}

Widget SignupButton(String name, String email, String password,
    String con_password, String number, BuildContext context) {
  AuthService _auth = AuthService();
  Data data;
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.deepOrange, width: 2),
      borderRadius: BorderRadius.circular(5.sm),
    ),
    child: TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          const Color.fromARGB(13, 255, 107, 107),
        ),
      ),
      child: Text(
        "Sign Up",
        style: TextStyle(
          color: AppColors.deepOrange,
          fontSize: 18.sm,
        ),
      ),
      onPressed: () async {
        if (password == con_password) {
          if (email.contains("@")) {
            if (name.length > 4) {
              final user = await _auth.createUserWithEmailandPassword(
                  email, password, context);
              data = Data(uid: user?.uid);

              if (!regCheck) {
                regCheck = false;
                data.createUserData(name, number);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.yellow,
                    content: Text(
                      "Verify Email to complete registration.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
                Get.offAllNamed(loginRoute);
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text(
                    "Username must be greater than 4 chars",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(
                  "Invalid Email",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "Passwords Do not Match Try Again",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      },
    ),
  );
}
