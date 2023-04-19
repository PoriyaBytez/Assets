import 'package:assets/screens/home_screen.dart';
import 'package:assets/widgets/Common_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../api/servies/api_servies.dart';
import '../../utils/const_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool remember = false;
  bool hiddenPass = true;
  bool obSecureText = true;

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 35.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    width: 100.w,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("asset/top_login.png"))),
                  )),
                  Expanded(
                      flex: 3,
                      child: CircleAvatar(
                        radius: 95,
                        backgroundColor: loginPageBGColor,
                        child: Image.asset(height: 200, "asset/Asset_Logo.png"),
                      )),
                ],
              ),
            ),
            Container(
              height: 55.h,
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage("asset/BG_circle.png")),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Welcome back!",
                        style: TextStyle(
                            fontSize: 28,
                            color: loginPageTextColor,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),
                    Text("Login to your Account",
                        style: TextStyle(
                            fontSize: 14,
                            color: loginPageTextColor,
                            fontWeight: FontWeight.w400)),
                    const SizedBox(height: 20),
                    Common.loginTextField(
                        icon: Icons.person_outline,
                        HintText: "Email Address",
                        controller: emailController),
                    Common.loginTextField(
                      onPressed: () {
                        setState(() {
                          obSecureText = !obSecureText;
                        });
                      },
                      suffixIcon: obSecureText==true ? Icons.visibility_off : Icons.visibility,
                        passText: obSecureText,
                        icon: Icons.lock_outline_rounded,
                        HintText: "Password",
                        controller: passwordController),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Checkbox(
                            value: remember,
                            onChanged: (value) {
                              setState(() {
                                remember = value!;
                              });
                            },
                          ),
                          Text("Remember me",
                              style: TextStyle(
                                  fontSize: 14, color: loginPageTextColor)),
                          const Spacer(),
                          Text('Forgot Password?',
                              style: TextStyle(
                                  fontSize: 14, color: loginPageTextColor)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          validateFormLogin();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: submitButton,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text('Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }

  validateFormLogin() {
    if (emailController.text.isEmpty) {
      showSnackBar("Please Enter Your Email Address", context);
    } else if (passwordController.text.isEmpty) {
      showSnackBar("Please Enter Your Password", context);
    } else {
      loginDetailUpload(
              email: emailController.text, pass: passwordController.text)
          .then((value) async {
        if (value == true) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("email", emailController.text);
          // await prefs.setString("password", passwordController.text);
          Navigator.pushNamed(context, '/bottom');
        } else {
          showSnackBar(
              "Your account does not exist OR check you details", context);
        }
      });
    }
  }
}
