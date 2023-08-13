import 'dart:convert';
import 'dart:io';
import 'package:copum_front_update/model/answer_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

String answerURL = Platform.isAndroid
    ? 'http://10.0.2.2:8000/answer'
    : 'http://127.0.0.1:8000/answer';

class AnswerProvider with ChangeNotifier {
  // AnswerModel answerModel = AnswerModel();
  AnswerModel answerModel = AnswerModel();
  fetchData(int? questionId) async {
    String answerUrl = Platform.isAndroid
        ? 'http://10.0.2.2:8000/question/$questionId'
        : 'http://127.0.0.1:8000/question/$questionId';
    try {
      http.Response response = await http.get(Uri.parse(answerUrl));
      dynamic body = jsonDecode(utf8.decode(response.bodyBytes));

      answerModel = AnswerModel.fromJson(body);
      print("####");
      notifyListeners();
    } catch (e) {
      return e;
    }
  }

  insertAnswer(String? questionId, String? creator, String? content,
      String? image) async {
    try {
      dynamic data = {
        "QUESTION_ID": questionId,
        "CONTENT": content,
        "CREATOR": creator,
        "ANSWER_IMAGE": image,
      };
      final String jsonString = jsonEncode(data);
      http.Response response = await http.post(Uri.parse("$answerURL/create"),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonString);
      dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
      notifyListeners();
      if (body['status_code'] == 200) {
        return "success";
      }
    } catch (e) {
      return e;
    }
  }
}
