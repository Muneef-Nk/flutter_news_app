import 'package:flutter/material.dart';
import 'package:news_app/api_config/api_config.dart';
import 'package:news_app/model/newapi_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomescreenController with ChangeNotifier {
  String? category;
  DataModel? dataModel;
  int selectedCategory = 0;
  bool isMainLoading = false;
  bool isDataLoading = false;

  List<String> categories = ["Trending", "apple", "sports", "laptop", "mobile"];

  fetchNews({String searchQuarry = "trending"}) async {
    isMainLoading = true;
    notifyListeners();
    final url =
        "https://newsapi.org/v2/everything?q=$searchQuarry&apiKey=${ApiConfig.api_key}";
    final response = await http.get(Uri.parse(url));
    var responseData = jsonDecode(response.body);
    dataModel = DataModel.fromJson(responseData);
    notifyListeners();

    category = searchQuarry;
    notifyListeners();

    isMainLoading = false;
    notifyListeners();
  }

  changeCategoryIndex(int index) {
    selectedCategory = index;
    print(selectedCategory);
    notifyListeners();
  }

  fetchCategoryNews({String searchQuarry = "trending"}) async {
    isDataLoading = true;
    notifyListeners();
    final url =
        "https://newsapi.org/v2/everything?q=$searchQuarry&apiKey=${ApiConfig.api_key}";
    final response = await http.get(Uri.parse(url));
    var responseData = jsonDecode(response.body);
    dataModel = DataModel.fromJson(responseData);
    notifyListeners();

    category = searchQuarry;
    notifyListeners();

    isMainLoading = false;
    isDataLoading = false;
    notifyListeners();
  }
}
