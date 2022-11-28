import 'package:flutter/material.dart';

import '../home_screen.dart';



class LayoutController extends ChangeNotifier {
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
    // BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add Product"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.production_quantity_limits), label: "Sales"),
    // BottomNavigationBarItem(icon: Icon(Icons.report), label: "reports"),
  ];

  //NOTE: ---------------------------Screens and Titles----------------------------
  final screens = [HomeScreen(), HomeScreen()]; // ReportsScreen()

  final appbar_title = [
    'Home',
    'profile', /*'Report'*/
  ];

  // NOTE: --------------------- On Change Index Of Screens ------------------

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void onchangeIndex(int index) {
    _currentIndex = index;
    _issearching_InProducts = false;

    notifyListeners();
  }

  //NOTE on change Search Status in products
  bool _issearching_InProducts = false;

  bool get issearchingInProducts => _issearching_InProducts;
  onChangeSearchInProductsStatus(bool val) {
    _issearching_InProducts = val;
    _currentIndex = 0;
    notifyListeners();
  }
}

