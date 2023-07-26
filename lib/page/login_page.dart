import 'package:copum_front_update/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<KakaoLoginProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RichText(
              text: const TextSpan(
                text: 'Hello,',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Elice"),
                children: <TextSpan>[
                  TextSpan(
                    text: 'World!',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Elice"),
                  ),
                  TextSpan(
                    text: '_',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Elice"),
                  ),
                ],
              ),
            ),
          ),
          const Text(
            '코딩하다 꽉막힐땐 코품!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontFamily: "Elice",
            ),
          ),
          const SizedBox(
            height: 240,
          ),
          ElevatedButton.icon(
            icon: const Padding(
              padding: EdgeInsets.only(right: 80),
              child: Icon(
                Icons.chat_bubble,
                size: 18.0,
                color: Colors.black,
              ),
            ),
            label: const Padding(
              padding: EdgeInsets.only(right: 80),
              child: Text(
                "Kakao로 시작하기",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Elice",
                ),
              ),
            ),
            onPressed: () async {
              await loginProvider.kakaoLogin();
              print(loginProvider.targetPage);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              minimumSize: const Size(320, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 0.0,
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          ElevatedButton.icon(
            icon: const Padding(
              padding: EdgeInsets.only(right: 80),
              child: Icon(
                Icons.email,
                size: 15.0,
                color: Colors.black,
              ),
            ),
            label: const Padding(
              padding: EdgeInsets.only(right: 80),
              child: Text(
                "google로 시작하기",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Elice",
                ),
              ),
            ),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              minimumSize: const Size(320, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 0.0,
            ),
          ),
        ],
      ),
    );
  }
}
