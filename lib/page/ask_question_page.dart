import 'package:flutter/material.dart';

class AskQuestionPage extends StatefulWidget {
  const AskQuestionPage({super.key});

  @override
  State<AskQuestionPage> createState() => _AskQuestionPageState();
}

class _AskQuestionPageState extends State<AskQuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('질문하기'),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                '완료',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ))
        ],
      ),
    );
  }
}
