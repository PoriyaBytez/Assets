import 'package:assets/screens/assets_edinting.dart';
import 'package:assets/widgets/Common_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                color: mainBackGroundColor,
                image: const DecorationImage(
                    fit: BoxFit.fill, image: AssetImage("asset/logo-top.png"))),
            height: size.height * .6,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: size.height * .3),
                  Container(decoration: const BoxDecoration(shape: BoxShape.circle),child: Image.asset("asset/logo.png",height: 80,)),
                  const Spacer(),
                  const Text("Login",
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.w400)),
                  const Spacer(),
                  const Text("Please confirm that asset back \nin location" ,
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff8990a1),
                          fontWeight: FontWeight.w500)),
                  const Spacer()
                ],
              ),
            ),
          ),
          Container(
            height: size.height * .4,
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text("Welcome back!",
                  //     style: TextStyle(
                  //         fontSize: 28,
                  //         color: loginPageTextColor,
                  //         fontWeight: FontWeight.w500)),
                  // const SizedBox(height: 10),
                  // Text("Login to your Account",
                  //     style: TextStyle(
                  //         fontSize: 14,
                  //         color: loginPageTextColor,
                  //         fontWeight: FontWeight.w400)),
                  // const SizedBox(height: 20),
                  SizedBox(height: 80,child: Common.loginTextField(
                      HintText: "Email Address",
                      controller: emailController),),
                  SizedBox(height: 80,child: Common.loginTextField(
                      onPressed: () {
                        setState(() {
                          obSecureText = !obSecureText;
                        });
                      },
                      suffixIcon: obSecureText == true
                          ? Icons.visibility_off
                          : Icons.visibility,
                      passText: obSecureText,
                      HintText: "Password",
                      controller: passwordController),),
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
