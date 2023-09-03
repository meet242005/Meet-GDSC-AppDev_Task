import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:meet_gdsc_appdev_task/constants/colors.dart';
import 'package:meet_gdsc_appdev_task/screens/signup.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future logIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      //login into Firebase with entered email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());

      //If Login In is success go to HomePage else show Error Dialog
      Get.back(closeOverlays: true);
      Get.offAll(() => const Home(),
          transition: Transition.rightToLeftWithFade);
    } on FirebaseAuthException catch (e) {
      Get.back(closeOverlays: true);
      AwesomeDialog(
        descTextStyle:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: 'Error Occured',
        desc: e.toString().split("]")[1],
        dialogBorderRadius: const BorderRadius.all(Radius.circular(10)),
        btnOkColor: AppColors.primaryColor,
        btnOkOnPress: () {},
      ).show();
    }
  }

  Future forgotPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());
      AwesomeDialog(
        descTextStyle:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: 'Password Reset Link Sent!',
        desc:
            "A password reset instructions has been sent to your email please check your spam/inbox for further instructions.",
        dialogBorderRadius: const BorderRadius.all(Radius.circular(10)),
        btnOkColor: AppColors.primaryColor,
        btnOkOnPress: () {},
      ).show();
    } on FirebaseAuthException catch (e) {
      AwesomeDialog(
        descTextStyle:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: 'Error Occured',
        desc: e.toString().split("]")[1],
        dialogBorderRadius: const BorderRadius.all(Radius.circular(10)),
        btnOkColor: AppColors.primaryColor,
        btnOkOnPress: () {},
      ).show();
    }
  }

  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool showpassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              SvgPicture.asset(
                "assets/svg/gdsc_logo.svg",
                height: 20,
              ),
              SizedBox(
                height: 30,
                child: VerticalDivider(
                  color: Colors.grey.shade500,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Google Developer Student Clubs",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "D. J. Sanghvi College of Engineering",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ],
          ),
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(22, 50, 22, 50),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome back!",
                style: TextStyle(
                    fontSize: 28,
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
              ),
              const Text(
                "Glad to see you, Again!",
                style: TextStyle(
                    fontSize: 28,
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: const BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Center(
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: email,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (input) {
                      if (GetUtils.isEmail(input!)) {
                        return null;
                      } else {
                        return "Enter a valid email";
                      }
                    },
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                        hintText: "Enter Your Email ID.",
                        border: InputBorder.none,
                        prefixIconColor: AppColors.secondaryColor,
                        prefixIcon: Icon(Icons.email)),
                    onChanged: ((value) {}),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: const BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: password,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (input) {
                          if (input!.isNotEmpty && input.length >= 8) {
                            return null;
                          } else {
                            return "Enter a valid password";
                          }
                        },
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                            hintText: "Enter Your Password",
                            border: InputBorder.none,
                            prefixIconColor: AppColors.secondaryColor,
                            prefixIcon: Icon(Icons.lock)),
                        obscureText: showpassword,
                        onChanged: ((value) {}),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            showpassword = !showpassword;
                          });
                        },
                        child: Icon(
                          showpassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      forgotPassword();
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  logIn();
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(18, 5, 18, 5),
                  decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: const Center(
                      child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w900),
                  )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 48,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w900),
                  ),
                  InkWell(
                    onTap: () {
                      Get.off(const SignUp(),
                          transition: Transition.rightToLeftWithFade);
                    },
                    child: const Text(
                      " Sign Up",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "DJSCE GDSC'23 Task by Meet Chavan SY - 60004230269",
                style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 11,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
