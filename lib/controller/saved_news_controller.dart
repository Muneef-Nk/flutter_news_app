import 'package:flutter/material.dart';
import 'package:news_app/model/saved_news_model.dart';

class SavedNewsController with ChangeNotifier {
  List<SavedNewsModel> savedNewsListList = [];

  bool isSaved = false;

  // savedOrNot() {
  //   isSaved = !isSaved;
  //   notifyListeners();
  //   print('clickee');
  // }

  void checkNewsSavedOrNot(SavedNewsModel dataModel) {
    savedNewsListList.add(dataModel);

    isSaved = !isSaved;
    notifyListeners();

    print(savedNewsListList.length);
    notifyListeners();
  }
}
