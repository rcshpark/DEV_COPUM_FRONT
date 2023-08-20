import 'dart:convert';
import 'dart:io';
import 'package:copum_front_update/provider/question_provider.dart';
import 'package:copum_front_update/provider/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/user_model.dart';

enum TargetPage { main, login }

String baseUrl = Platform.isAndroid
    ? 'http://10.0.2.2:8000/users/login/kakao'
    : 'http://127.0.0.1:8000/users/login/kakao';

class KakaoLoginProvider with ChangeNotifier {
  final UserInfoProvider userP = UserInfoProvider();
  TargetPage _targetPage = TargetPage.login;
  TargetPage get targetPage => _targetPage;
  static final storage = FlutterSecureStorage();
  UserModel userModel = UserModel();

  kakaoLoginApi(String token) async {
    try {
      final url = Uri.parse("$baseUrl?AccessToken=$token");
      final response = await http.post(url);
      if (response.statusCode == 200) {
        var result = jsonDecode(utf8.decode(response.bodyBytes));
        return result;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future kakaoLogin() async {
    User user = await UserApi.instance.me();
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        dynamic result = await kakaoLoginApi(token.accessToken);
        if (result['status'] == 200) {
          await userP.insertUserData(
              user.id,
              user.kakaoAccount!.email,
              user.kakaoAccount!.profile!.nickname,
              user.kakaoAccount!.profile!.profileImageUrl);
          _targetPage = TargetPage.main;
        } else {
          _targetPage = TargetPage.login;
        }
      } catch (error) {
        _targetPage = TargetPage.login;
        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          _targetPage = TargetPage.login;
          return null;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          dynamic result = await kakaoLoginApi(token.accessToken);
          if (result['status'] == 200) {
            await userP.insertUserData(
                user.id,
                user.kakaoAccount!.email,
                user.kakaoAccount!.profile!.nickname,
                user.kakaoAccount!.profile!.profileImageUrl);
            _targetPage = TargetPage.main;
          } else {
            _targetPage = TargetPage.login;
          }
        } catch (error) {
          _targetPage = TargetPage.login;
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        dynamic result = await kakaoLoginApi(token.accessToken);
        if (result['status'] == 200) {
          await userP.insertUserData(
              user.id,
              user.kakaoAccount!.email,
              user.kakaoAccount!.profile!.nickname,
              user.kakaoAccount!.profile!.profileImageUrl);
          _targetPage = TargetPage.main;
        } else {
          _targetPage = TargetPage.login;
        }
      } catch (error) {
        _targetPage = TargetPage.login;
      }
    }
  }

  autoLogin() async {
    String? userData = await storage.read(key: 'user');
    if (userData != null) {
      Map<String, dynamic> data = json.decode(userData);
      userModel = UserModel.fromJson(data);
      _targetPage = TargetPage.main;
    } else {
      _targetPage = TargetPage.login;
    }
  }
}
