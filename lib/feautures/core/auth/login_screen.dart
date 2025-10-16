import 'package:ecommerce_app_using_flutter/config/app_assets.dart';
import 'package:ecommerce_app_using_flutter/config/app_colours.dart';
import 'package:ecommerce_app_using_flutter/config/app_layout.dart';
import 'package:ecommerce_app_using_flutter/config/app_route.dart';
import 'package:ecommerce_app_using_flutter/config/app_sharedpref.dart';
import 'package:ecommerce_app_using_flutter/utils/custom_button.dart';
import 'package:ecommerce_app_using_flutter/utils/custom_snackbar.dart';
import 'package:ecommerce_app_using_flutter/utils/custom_textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey();
  late String password;
  late String email;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (credential.user != null) {
        await AppSharedpref.setBool(AppSharedkeys.userId, true);
        Get.offAllNamed(AppRoutes.homeScreen);
        showCustomSnackbar(
            text: "Login Successfull", status: StatusTypes.success);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showCustomSnackbar(text: "user not found", status: StatusTypes.error);
      } else if (e.code == 'wrong-password') {
        showCustomSnackbar(text: "wrong password", status: StatusTypes.error);
      } else {
        showCustomSnackbar(text: "Login Failed", status: StatusTypes.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: AppLayout.screenPadding,
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    AppAssets.login,
                  ),
                  AppLayout.spaceH10,
                  CustomTextFormfield(
                    hintText: "Enter Email",
                    textInputType: TextInputType.emailAddress,
                    maxLength: 25,
                    controller: emailController,
                  ),
                  AppLayout.spaceH10,
                  CustomTextFormfield(
                    hintText: "password",
                    controller: passwordController,
                    textInputType: TextInputType.number,
                    maxLength: 10,
                    validator: (value) =>
                        value!.isEmpty ? "password wrong" : null,
                  ),
                  AppLayout.spaceH20,
                  CustomButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        login(context);
                      }
                    },
                    text: "Login",
                    width: width,
                  ),
                  AppLayout.spaceH10,
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Dont have an account ?"),
                        TextButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.register);
                            },
                            child: Text("Register"))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
