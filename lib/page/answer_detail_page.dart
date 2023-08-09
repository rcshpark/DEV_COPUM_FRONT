import 'package:flutter/material.dart';

class AnswerDetailPage extends StatelessWidget {
  String? creator;
  String? time;
  String? content;
  String? answerImage;
  AnswerDetailPage(
      {required this.creator,
      required this.time,
      required this.content,
      required this.answerImage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          '답변',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: answerDetailCard(creator, time, content, answerImage),
    );
  }
}

Widget answerDetailCard(
    String? creator, String? time, String? content, String? answerImage) {
  return Card(
    color: Colors.black,
    elevation: 4.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
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
                '$creator\n$time',
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            content!,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            height: 5,
          ),
          answerImage == null
              ? const SizedBox()
              : Container(
                  color: Colors.white,
                  width: 40,
                  height: 40,
                ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blueGrey),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.question_answer_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.pinkAccent),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.check_circle_outline,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
