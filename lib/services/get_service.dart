import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/newapi_model.dart';

class GetApi {
  DataModel? api;

  fetchNews(String? category) async {
    var url =
        "https://newsapi.org/v2/everything?q=sports&apiKey=fb5654a374744706990715eb03c18e94";
    var response = await http.get(Uri.parse(url));
    var responseData = jsonDecode(response.body);
    api = DataModel.fromJson(responseData);
  }
}
