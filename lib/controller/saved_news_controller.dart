import 'package:flutter/material.dart';

class SavednewController with ChangeNotifier {
  List savedNews = [];

  addNews(int index) {
    savedNews.add(index);
    notifyListeners();
  }
}
