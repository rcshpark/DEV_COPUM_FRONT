import 'package:copum_front_update/model/question_model.dart';
import 'package:copum_front_update/provider/question_provider.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';

class NewQuestionPage extends StatefulWidget {
  const NewQuestionPage({super.key});

  @override
  State<NewQuestionPage> createState() => _NewQuestionPageState();
}

class _NewQuestionPageState extends State<NewQuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionProvider>(builder: (_, p, child) {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    questionCard(
                        'park', '2023.11.11', 'title', "", "test content")
                  ],
                );
              },
              itemCount: 1,
            ),
          ),
        ],
      );
    });
  }
}

Widget questionCard(String nickname, String createdAt, String title,
    String imageURL, String content) {
  return Card(
    color: Colors.black,
    elevation: 4.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey),
                  child: const Text(''),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '$nickname\n$createdAt',
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 20),
            maxLines: 3,
          ),
          imageURL.isEmpty
              ? const SizedBox()
              : Container(
                  color: Colors.white,
                  width: 40,
                  height: 40,
                ),
          Text(
            content,
            style: const TextStyle(color: Colors.grey, fontSize: 20),
          )
        ],
      ),
    ),
  );
}
