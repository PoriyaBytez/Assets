import 'package:assets/screens/home_screen.dart';
import 'package:assets/widgets/Common_widget.dart';
import 'package:flutter/material.dart';

import '../utils/variables.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: size.height / 2.2,
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(height: 200, width: 200, "asset/Asset_Logo.png"),
                Text("LOGIN",style: TextStyle(fontSize: 36,color: Color(0xffE65913),fontWeight: FontWeight.w600)),
              ],
            ),
          ),

          Container(
            child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Common.Text_field(HintText:"Email Address",controller: EmailController),
              Common.Text_field(HintText:"Password",controller : PasswordController),
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text('Forgot Password?'),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
                },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Submit_button,
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
}
