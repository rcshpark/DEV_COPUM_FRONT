import 'package:copum_front_update/page/home_detail/new_question.dart';
import 'package:copum_front_update/page/login_page.dart';
import 'package:copum_front_update/provider/question_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 4, vsync: this);

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuestionProvider>(context);
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: const Text('코품'),
        ),
        body: Column(
          children: [
            TabBar(
              controller: tabController,
              tabs: const [
                Tab(
                  text: "NewQ",
                ),
                Tab(
                  text: "FAQ",
                ),
                Tab(
                  text: "My QnA",
                ),
                Tab(
                  text: "HardQ",
                ),
              ],
            ),
            Expanded(
                child: TabBarView(
              controller: tabController,
              children: [
                NewQuestionPage(),
                Text('data'),
                Text('data'),
                Text('data'),
              ],
            ))
          ],
        ));
  }
}
