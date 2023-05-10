import 'package:assets/screens/check_in_screen.dart';
import 'package:assets/screens/assets_edinting.dart';
import 'package:assets/utils/const_colors.dart';
import 'package:flutter/material.dart';

import '../utils/static_function.dart';
import 'stock_count_screen.dart';
import 'home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  TextStyle? unselectedTextStyle = TextStyle(color: textCommonColor,fontSize: 14,fontWeight: FontWeight.w200);
  TextStyle? selectedTextStyle = TextStyle(color: mainBackGroundColor,fontSize: 16,fontWeight: FontWeight.w500);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationCategory();
    getOwnerCategory();
    getDepreciationCategory();
    getCategoriesList();
  }

  List<Widget> pagesBottom = [
    const HomeScreen(),
    const CheckInScreen(),
    const StockCountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                selectedIndexPage(
                  size: size,
                    onTap: () => setState(() => _selectedIndex = 0),
                    label: "Home",
                    textStyle: _selectedIndex == 0 ? selectedTextStyle : unselectedTextStyle,
                    suffixImage: _selectedIndex == 0 ? "home-blue.png" : "home.png"),
                selectedIndexPage(
                    size: size,
                    onTap: () => setState(() => _selectedIndex = 1),
                    label: "Check In",
                    textStyle: _selectedIndex == 1 ? selectedTextStyle : unselectedTextStyle,
                    suffixImage: _selectedIndex == 1 ? "checkin-blue.png" : "checkin.png"),

                selectedIndexPage(
                    size: size,
                    onTap: () => setState(() => _selectedIndex = 2),
                    label: "Stock Count",
                    textStyle: _selectedIndex == 2 ? selectedTextStyle : unselectedTextStyle,
                    suffixImage: _selectedIndex == 2 ? "stock-blue.png" : "stock.png"),
              ],
            ),
          ),
        ),
        body: pagesBottom[_selectedIndex]);
  }

  selectedIndexPage(
      {GestureTapCallback? onTap, String? label, String? suffixImage,TextStyle? textStyle,Size? size}) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(height: 50,
    child: Row(children: [
      Image.asset(
        fit: BoxFit.fill,
        "asset/$suffixImage",
        height: size!.height * .03,
        width: size.width * .06,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 3.0),
        child: SizedBox(width: size.width * .25,child: Text(label!,style: textStyle)),
      )
    ]),
      ),
    );
  }
}
