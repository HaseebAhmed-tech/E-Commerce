// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'dart:async';

import 'package:e_commerce/checks/checklist.dart';
import 'package:e_commerce/const/AppColors.dart';
import 'package:e_commerce/const/routes.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    late StreamSubscription<User?> user;
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.deepOrange,
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height - screenSize.height / 1.3,
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 30, bottom: 10),
                width: screenSize.width,
                constraints: BoxConstraints(
                    minHeight: screenSize.height / 1.3,
                    maxHeight: double.infinity),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const loginText(), //Login Text
                    SizedBox(
                      height: 50.sm,
                    ),
                    inputEmail(
                      // Email
                      email: _email,
                    ),
                    SizedBox(
                      height: 25.sm,
                    ),
                    inputPassword(
                      //Password
                      password: _password,
                    ),
                    SizedBox(
                      height: 15.sm,
                    ),
                    loginButton(
                      email: _email.text.trim(),
                      password: _password.text.trim(),
                    ), //Login Button
                    SizedBox(
                      height: 15.sm,
                    ),
                    const Center(
                      child: Text(
                        //Forgot Password
                        "Forgot Password?",
                        style: TextStyle(color: AppColors.deepOrange),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height / 13,
                    ),
                    const Center(
                      child: registerButton(),
                    ), //Register Button
                    SizedBox(
                      height: 20.sm,
                    ),
                    const Center(
                      child: Text(
                        "@Copyright E-commerce",
                        style: TextStyle(color: AppColors.deepOrange),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height / 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class registerButton extends StatelessWidget {
  const registerButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
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
          "Register",
          style: TextStyle(
            color: AppColors.deepOrange,
            fontSize: 18.sm,
          ),
        ),
        onPressed: () {
          Get.toNamed(signupRoute);
        },
      ),
    );
  }
}

class loginButton extends StatelessWidget {
  const loginButton({Key? key, required this.email, required this.password})
      : super(key: key);
  final String email;
  final String password;
  @override
  Widget build(BuildContext context) {
    AuthService auth = AuthService();
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.deepOrange,
          borderRadius: BorderRadius.circular(5.sm)),
      child: TextButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
                const Color.fromARGB(32, 171, 97, 97))),
        child: Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sm,
          ),
        ),
        onPressed: () async {
          final result =
              await auth.signinWithEmailAndPassword(email, password, context);

          if (!logCheck) {
            logCheck = false;
            if (result?.verified ?? false) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.greenAccent,
                  content: Text(
                    "Login Successful",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
              Get.offNamedUntil(bottomNavigator, ((route) => false));
            } else {
              await auth.sendVerificationCode();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.yellow,
                  content: Text(
                    "Account not Verified. Verification Email is sent",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}

class inputPassword extends StatelessWidget {
  const inputPassword({
    Key? key,
    required this.password,
  }) : super(key: key);
  final TextEditingController password;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: password,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.key_outlined,
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
}

class inputEmail extends StatelessWidget {
  const inputEmail({
    Key? key,
    required this.email,
  }) : super(key: key);
  final TextEditingController email;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: email,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.email,
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
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.black, fontSize: 18.sm),
      strutStyle: StrutStyle(
        fontSize: 18.sm,
      ),
      cursorColor: AppColors.deepOrange,
      cursorHeight: 22.sm,
    );
  }
}

class loginText extends StatelessWidget {
  const loginText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Login",
      style: TextStyle(
          color: AppColors.deepOrange,
          fontSize: 25.sm,
          fontWeight: FontWeight.bold),
    );
  }
}
