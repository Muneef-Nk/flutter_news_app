import 'package:flutter/material.dart';
import 'package:news_app/view/screens/homescreen/homescreen.dart';
import 'package:news_app/view/screens/saved_news_screen/saved_news_screen.dart';
import 'package:news_app/view/screens/search_screen/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavigationController with ChangeNotifier {
  int currentIndex = 0;

  List screens = [
    HomeScreen(),
    SearchScreen(),
    SavedNews(),
    Center(
      child: ElevatedButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.clear();
          },
          child: Text("logOut")),
    ),
  ];

  changeBottomItem(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
