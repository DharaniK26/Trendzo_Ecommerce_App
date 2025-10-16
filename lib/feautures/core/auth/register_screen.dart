import 'package:ecommerce_app_using_flutter/config/app_assets.dart';
import 'package:ecommerce_app_using_flutter/config/app_layout.dart';
import 'package:ecommerce_app_using_flutter/config/app_route.dart';
import 'package:ecommerce_app_using_flutter/config/app_style.dart';
import 'package:ecommerce_app_using_flutter/utils/custom_button.dart';
import 'package:ecommerce_app_using_flutter/utils/custom_snackbar.dart';
import 'package:ecommerce_app_using_flutter/utils/custom_textformfield.dart';
import 'package:ecommerce_app_using_flutter/utils/text_validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<void> register(BuildContext context) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      showCustomSnackbar(
          text: "Registration Successful: ${credential.user?.email}",
          status: StatusTypes.success);

      Get.offAllNamed(AppRoutes.homeScreen);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showCustomSnackbar(
            text: "Password provided is too weak.", status: StatusTypes.error);
      } else if (e.code == 'email-already-in-use') {
        showCustomSnackbar(
            text: "An account already exists for that email",
            status: StatusTypes.error);
      } else if (e.code == 'invalid-email') {
        showCustomSnackbar(
            text: "Invalid email address.", status: StatusTypes.error);
      } else {
        showCustomSnackbar(
            text: "Registration failed. Please try again.",
            status: StatusTypes.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: AppStyle.titleTextStyle,
        ),
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: AppLayout.screenPadding,
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    AppAssets.register,
                  ),
                  AppLayout.spaceH10,
                  CustomTextFormfield(
                    controller: emailController,
                    hintText: "Enter Email",
                    textInputType: TextInputType.emailAddress,
                    maxLength: 25,
                    validator: (value) =>
                        TextFieldValidation.mailValidator(value),
                  ),
                  AppLayout.spaceH10,
                  CustomTextFormfield(
                    controller: passwordController,
                    hintText: "password",
                    textInputType: TextInputType.number,
                    maxLength: 15,
                    validator: (value) =>
                        value!.isEmpty ? "passoword required" : null,
                  ),
                  AppLayout.spaceH20,
                  CustomButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        register(context);
                      }
                    },
                    text: "Register",
                    width: width,
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
