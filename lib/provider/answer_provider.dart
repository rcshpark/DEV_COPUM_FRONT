import 'dart:convert';
import 'dart:io';
import 'package:copum_front_update/model/answer_model.dart';
import 'package:copum_front_update/provider/login_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AnswerProvider with ChangeNotifier {
  AnswerModel answerModel = AnswerModel();

  fetchData(int? questionId) async {
    String answerUrl = Platform.isAndroid
        ? 'http://10.0.2.2:8000/question/$questionId'
        : 'http://127.0.0.1:8000/question/$questionId';
    try {
      http.Response response = await http.get(Uri.parse(answerUrl));
      dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
      answerModel = AnswerModel.fromJson(body);
      notifyListeners();
    } catch (e) {
      return e;
    }
  }
}
