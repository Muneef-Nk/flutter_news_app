import 'package:flutter/material.dart';
import 'package:news_app/model/newapi_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataController with ChangeNotifier {
  String? category;
  DataModel? api;
  int selectedCategory = 0;
  bool isMainLoading = false;
  bool isDataLoading = false;

  List<String> categories = ["Trending", "apple", "sports", "laptop", "mobile"];

  Future<void> fetchNews({String searchQuarry = "trending"}) async {
    isMainLoading = true;
    isDataLoading = true;

    notifyListeners();
    final url =
        "https://newsapi.org/v2/everything?q=$searchQuarry&apiKey=fb5654a374744706990715eb03c18e94";
    final response = await http.get(Uri.parse(url));
    var responseData = jsonDecode(response.body);
    api = DataModel.fromJson(responseData);
    notifyListeners();

    category = searchQuarry;
    notifyListeners();

    isMainLoading = false;
    isDataLoading = false;
    notifyListeners();
  }

  Future<void> fetchCategoryNews({String searchQuarry = "trending"}) async {
    isDataLoading = true;

    notifyListeners();
    final url =
        "https://newsapi.org/v2/everything?q=$searchQuarry&apiKey=fb5654a374744706990715eb03c18e94";
    final response = await http.get(Uri.parse(url));
    var responseData = jsonDecode(response.body);
    api = DataModel.fromJson(responseData);
    notifyListeners();

    category = searchQuarry;
    notifyListeners();

    isDataLoading = false;
    notifyListeners();
  }

  changeCategoryIndex(int index) {
    selectedCategory = index;
    notifyListeners();
  }
}
