import 'dart:convert';
import 'dart:io';
import 'package:copum_front_update/model/question_model.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';

String questionUrl = Platform.isAndroid
    ? 'http://10.0.2.2:8000/question'
    : 'http://127.0.0.1:8000/question';

class QuestionProvider with ChangeNotifier {
  QuestionModel questionModel = QuestionModel();
  QuestionModel searchModel = QuestionModel();

  fetchData() async {
    try {
      http.Response response =
          await http.get(Uri.parse("$questionUrl/list/{category}"));
      dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
      questionModel = QuestionModel.fromJson(body);
      notifyListeners();
    } catch (e) {
      return e;
    }
  }

  searchData(String content) async {
    try {
      http.Response response =
          await http.get(Uri.parse("$questionUrl/search?content=$content"));
      dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
      searchModel = QuestionModel.fromJson(body);
      notifyListeners();
    } catch (e) {
      return e;
    }
  }
}
