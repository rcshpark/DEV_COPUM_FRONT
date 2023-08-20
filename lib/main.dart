import 'package:copum_front_update/page/login_page.dart';
import 'package:copum_front_update/page/main_page.dart';
import 'package:copum_front_update/provider/answer_provider.dart';
import 'package:copum_front_update/provider/bottomNavigation_provider.dart';
import 'package:copum_front_update/provider/login_provider.dart';
import 'package:copum_front_update/provider/question_provider.dart';
import 'package:copum_front_update/provider/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';

void main() {
  KakaoSdk.init(nativeAppKey: "ed5535e02148446b7b2068a4c04bed78");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: ((context) => KakaoLoginProvider())),
      ChangeNotifierProvider(create: ((context) => QuestionProvider())),
      ChangeNotifierProvider(create: ((context) => BottomNavigationProvider())),
      ChangeNotifierProvider(create: ((context) => AnswerProvider())),
      ChangeNotifierProvider(create: ((context) => UserInfoProvider())),
    ], child: const MaterialApp(home: Intro()));
  }
}

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider =
        Provider.of<KakaoLoginProvider>(context, listen: false);
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    final userProvider = Provider.of<UserInfoProvider>(context, listen: false);
    Future.delayed(const Duration(seconds: 2), (() async {
      await loginProvider.autoLogin();
      if (TargetPage.main == loginProvider.targetPage) {
        await questionProvider.fetchData();
        await userProvider.fetchData();
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const BottomNavigation()));
      } else {
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const LoginPage())));
      }
    }));
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.only(right: 30, bottom: 100),
        child: Center(
          child: Image(image: AssetImage('assets/images/Service_name.png')),
        ),
      ),
    );
  }
}
