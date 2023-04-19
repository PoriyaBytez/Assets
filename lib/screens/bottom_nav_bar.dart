import 'package:assets/screens/assets_screen.dart';
import 'package:assets/screens/map_screen.dart';
import 'package:assets/screens/stock_count.dart';
import 'package:flutter/material.dart';

import '../utils/static_fuction.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationCategory();
    getOwnerCategory();
    getDepreciationCategory();
    getCategoriesList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(label: "Home", icon: Icon(Icons.computer_outlined)),
            BottomNavigationBarItem(label: "Check In", icon: Icon(Icons.pin_drop)),
            BottomNavigationBarItem(label: "Stock Count", icon: Icon(Icons.pin_drop)),
          ]),
      body: _selectedIndex == 0 ? const AssetsScreen() : _selectedIndex == 1 ? const MapScreen() : const StockCount(),
    );
  }
}
