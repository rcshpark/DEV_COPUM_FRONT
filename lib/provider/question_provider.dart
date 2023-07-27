import 'dart:convert';
import 'dart:io';
import 'package:copum_front_update/model/question_model.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';

String questionUrl = Platform.isAndroid
    ? 'http://10.0.2.2:8000/question/list/{category}'
    : 'http://127.0.0.1:8000/question/list/{category}';

class QuestionProvider with ChangeNotifier {
  QuestionModel questionModel = QuestionModel();

  fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse(questionUrl));
      dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
      questionModel = QuestionModel.fromJson(body);
      notifyListeners();
    } catch (e) {
      return e;
    }
  }
}
