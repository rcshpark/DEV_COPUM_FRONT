import 'package:copum_front_update/page/home_page.dart';
import 'package:copum_front_update/page/main_page.dart';
import 'package:copum_front_update/provider/login_provider.dart';
import 'package:copum_front_update/provider/question_provider.dart';
import 'package:copum_front_update/provider/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider =
        Provider.of<KakaoLoginProvider>(context, listen: false);
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    final userProvider = Provider.of<UserInfoProvider>(context, listen: false);
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
              await questionProvider.fetchData();
              await userProvider.fetchData();
              // await questionProvider.myQuestionData(userProvider.userModel.id);
              if (TargetPage.main == loginProvider.targetPage) {
                // ignore: use_build_context_synchronously
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavigation()));
              } else {
                // ignore: use_build_context_synchronously
                showDialog(
                    context: context,
                    builder: (buildContext) {
                      return AlertDialog(
                        title: const Text('로그인 에러'),
                        content: const Text('에러가 발생했습니다. 다시시도해주세요!'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('확인'))
                        ],
                      );
                    });
              }
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
