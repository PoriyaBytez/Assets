// SDK version 3.7.7

import 'package:assets/screens/stock_count_screen.dart';
import 'package:assets/screens/bottom_nav_bar.dart';
import 'package:assets/screens/filter_screen.dart';
import 'package:assets/screens/assets_edinting.dart';
import 'package:assets/screens/auth/login_screen.dart';
import 'package:assets/screens/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString("email");
  runApp(MyApp(email));
}

class MyApp extends StatelessWidget {
  MyApp(this.email, {super.key});

  String? email;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

          return MaterialApp(
            routes: {
              '/assetEditing': (context) =>  AssetEditing(),
              '/login': (context) => const LoginScreen(),
              '/bottom': (context) => const BottomNavBar(),
              '/stockCount': (context) => const StockCountScreen(),
              '/QRscanner': (context) => const QRCodeScanner(),
              '/filter': (context) => const FilterScreen(),
            },
            debugShowCheckedModeBanner: false,
            home: email == null ? const LoginScreen() : const BottomNavBar(),
          );

  }
}
