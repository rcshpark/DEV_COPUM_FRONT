import 'package:copum_front_update/page/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Intro());
  }
}

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(seconds: 2),
        (() => Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const LoginPage())))));
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
