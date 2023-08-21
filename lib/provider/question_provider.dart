import 'dart:convert';
import 'dart:io';
import 'package:copum_front_update/model/question_model.dart';
import 'package:copum_front_update/provider/bottomNavigation_provider.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';

String questionUrl = Platform.isAndroid
    ? 'http://10.0.2.2:8000/question'
    : 'http://127.0.0.1:8000/question';

class QuestionProvider with ChangeNotifier {
  QuestionModel questionModel = QuestionModel();
  QuestionModel searchModel = QuestionModel();
  Result myQModel = Result();
  // 전체 데이터 불러오는 함수
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

  // 검색기능 함수
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

  // 질문하기 함수
  insertQuestion(String? email, String title, String content, List? category,
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
      notifyListeners();
      if (body['status'] == 200) {
        return "success";
      }
    } catch (e) {
      return e;
    }
  }

  // // 내 질문 검색 함수
  // myQuestionData(int? myId) async {
  //   for (var i in questionModel.result!) {
  //     String? creator = i.creator;
  //     if (myId.toString() == creator) {
  //       questionModel.result.where((e) {
  //           questionModel.result![e] =
  //       } )
  //     }
  //   }
  // }
}
