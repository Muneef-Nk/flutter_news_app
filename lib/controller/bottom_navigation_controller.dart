import 'package:flutter/material.dart';
import 'package:news_app/view/screens/homescreen/homescreen.dart';
import 'package:news_app/view/screens/saved_news_screen/saved_news_screen.dart';

class BottomNavigationController with ChangeNotifier {
  int currentIndex = 0;

  List screens = [
    HomeScreen(),
    HomeScreen(),
    SavedNews(),
    HomeScreen(),
  ];

  changeBottomItem(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
