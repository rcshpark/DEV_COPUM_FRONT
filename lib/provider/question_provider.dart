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

  insertQuestion(String email, String title, String content, List? category,
      String? image) async {
    try {
      dynamic data = {
        "EMAIL": email,
        "TITLE": title,
        "CONTENT": content,
        "CATEGORY": category,
        "QUESTION_IMAGE": image,
      };
      final String jsonString = jsonEncode(data);
      http.Response response = await http.post(Uri.parse("$questionUrl/create"),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonString);
      dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
      print(body['status']);
      notifyListeners();
      if (body['status'] == 200) {
        return "success";
      }
    } catch (e) {
      return e;
    }
  }
}
