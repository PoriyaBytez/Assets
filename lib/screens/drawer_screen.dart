import 'package:assets/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget drawerWidget(context) {
  return SafeArea(
    child: Drawer(
      backgroundColor: Colors.black,
      child: Column(children: [
        const Text("User Data",style: TextStyle(color: Colors.white,fontSize: 30)),
        const Spacer(),
        Center(
          child: ElevatedButton(onPressed: () async {
            SharedPreferences prefs =await SharedPreferences.getInstance();
            prefs.remove("email");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return const LoginScreen();
            },));
          }, child: Text("logout".toUpperCase())),
        )
      ]),
    ),
  );
}
