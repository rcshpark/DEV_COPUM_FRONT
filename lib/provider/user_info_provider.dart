import 'dart:convert';
import 'package:copum_front_update/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserInfoProvider with ChangeNotifier {
  UserModel userModel = UserModel(0, '', '', '');
  final storage = FlutterSecureStorage();
  insertUserData(
      int id, String? email, String? nickname, String? profileImage) async {
    Map<String, dynamic> data = {
      'id': id,
      'email': email,
      'nickname': nickname,
      'profileImage': profileImage
    };
    if (id != 0) {
      var jsonData = jsonEncode(data);
      await storage.write(key: 'user', value: jsonData);
    }
  }

  fetchData() async {
    String? userData = await storage.read(key: 'user');
    if (userData != null) {
      Map<String, dynamic> data = json.decode(userData);
      userModel = UserModel.fromJson(data);
    }
  }
}
