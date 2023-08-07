import 'package:copum_front_update/page/home_detail/new_question.dart';
import 'package:copum_front_update/provider/answer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionDetailPage extends StatefulWidget {
  int? questionId;
  String? nickname;
  String? createdAt;
  String? title;
  String? imageURL;
  String? content;
  String? viewCount;
  int? answerCount;

  QuestionDetailPage(
      {required this.questionId,
      required this.nickname,
      required this.createdAt,
      required this.title,
      required this.imageURL,
      required this.content,
      required this.viewCount,
      required this.answerCount,
      super.key});

  @override
  State<QuestionDetailPage> createState() => _QuestionDetailPageState();
}

class _QuestionDetailPageState extends State<QuestionDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('질문'),
      ),
      body: Column(
        children: [
          questionCard(
              widget.nickname,
              widget.createdAt,
              widget.title,
              widget.imageURL,
              widget.content,
              widget.viewCount,
              widget.answerCount),
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 20, right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      minimumSize: const Size(152, 44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 0.0,
                    ),
                    icon: const Icon(
                      Icons.question_answer,
                      color: Colors.white,
                    ),
                    label: const Text(
                      '궁금합니다!',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
                ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      minimumSize: const Size(160, 44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 0.0,
                    ),
                    icon: const Icon(
                      Icons.question_answer,
                      color: Colors.black,
                    ),
                    label: const Text(
                      '답변하기',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ))
              ],
            ),
          ),
          // Consumer<AnswerProvider>(builder: (_, p, child) {
          //   return Column(
          //     children: [
          //       SizedBox(
          //           height: 130,
          //           child: ListView.builder(itemBuilder: (context, index) {
          //             return Text(
          //                 "${p.answerModel.result!.aNSWER![index].cONTENT}");
          //           })),
          //     ],
          //   );
          // })
        ],
      ),
    );
  }
}
