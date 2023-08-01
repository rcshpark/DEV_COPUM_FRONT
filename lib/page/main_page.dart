import 'package:copum_front_update/page/ask_question_page.dart';
import 'package:copum_front_update/page/home_page.dart';
import 'package:copum_front_update/page/profile.dart';
import 'package:copum_front_update/page/search_page.dart';
import 'package:copum_front_update/provider/bottomNavigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationProvider>(builder: (_, p, child) {
      return Scaffold(
        body: IndexedStack(
          index: p.currentPage,
          children: const [
            HomePage(),
            SearchPage(),
            ProfilePage(),
            AskQuestionPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "찾기"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "프로필"),
            BottomNavigationBarItem(
                icon: Icon(Icons.question_answer_outlined), label: "질문하기"),
          ],
          currentIndex: p.currentPage,
          selectedItemColor: Colors.greenAccent,
          onTap: (index) {
            p.updateCurrentPage(index);
          },
        ),
      );
    });
  }
}
