import 'dart:convert';
import 'package:copum_front_update/page/answer_detail_page.dart';
import 'package:copum_front_update/page/ask_page.dart';
import 'package:copum_front_update/page/home_detail/new_question_page.dart';
import 'package:copum_front_update/provider/answer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:provider/provider.dart';

class QuestionDetailPage extends StatefulWidget {
  final int? questionId;
  final String? nickname;
  final String? createdAt;
  final String? title;
  final String? imageURL;
  final String? content;
  final String? viewCount;
  final int? answerCount;

  const QuestionDetailPage(
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

String formatDate(String? time) {
  DateTime date = DateTime.parse(time!);
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inMinutes < 1) {
    return '방금 전';
  } else if (difference.inHours < 1) {
    return '${difference.inMinutes} 분전';
  } else if (difference.inDays < 1) {
    return '${difference.inHours} 시간 전';
  } else {
    return '${date.year}.${date.month}.${date.day}';
  }
}

double calculateCardHeight(String content, String imageUrl) {
  double contentHeight = content.length * 0.02;
  double imageHeight = imageUrl.isNotEmpty ? 100.0 : 0.0;
  return contentHeight + imageHeight + 20;
}

class _QuestionDetailPageState extends State<QuestionDetailPage> {
  QuillController _controller = QuillController.basic();
  String? test;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('질문'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AskPage(
                                    questionCreator: widget.nickname,
                                    title: widget.title,
                                    questionId: widget.questionId)));
                      },
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
            Consumer<AnswerProvider>(builder: (_, p, child) {
              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      // try {
                      //   dynamic formatContent =
                      //       p.answerModel.result!.aNSWER![index].cONTENT;
                      //   var myJSON = jsonDecode(formatContent);
                      //   Delta delta = Delta.fromJson(myJSON);
                      //   _controller = QuillController(
                      //       document: Document.fromDelta(delta),
                      //       selection:
                      //           const TextSelection.collapsed(offset: 0));
                      //   p.answerModel.result!.aNSWER![index].cONTENT =
                      //       delta.toString();
                      // } catch (e) {}
                      String formatTime = formatDate(
                          p.answerModel.result!.aNSWER![index].cREATEDDTTM);
                      return answerCard(
                        context,
                        p.answerModel.result!.aNSWER![index].cREATOR,
                        formatTime,
                        "작성자 프로필",
                        widget.title,
                        p.answerModel.result!.aNSWER![index].cONTENT,
                        p.answerModel.result!.aNSWER![index].aNSWERIMAGE,
                      );
                    },
                    itemCount: p.answerModel.result!.aNSWER!.length,
                  ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}

Widget answerCard(
    BuildContext context,
    String? answerCreator,
    String? time,
    String? questionCreator,
    String? questionTitle,
    String? answerContent,
    String? answerImage) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  final delta = Delta.fromJson(jsonDecode(answerContent!));
  final document = Document.fromDelta(delta);
  FocusNode focusNode = FocusNode();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 20, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("${answerCreator!} * ",
                style: const TextStyle(color: Colors.green, fontSize: 12)),
            Text(time!,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
            SizedBox(
              width: 50,
              height: 50,
              child: Image.asset('assets/images/Service_name.png'),
            ),
          ],
        ),
      ),
      Row(
        children: [
          SizedBox(
            width: screenWidth * 0.85,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => AnswerDetailPage(
                            creator: answerCreator,
                            time: time,
                            content: answerContent,
                            answerImage: answerImage))));
              },
              child: Card(
                  color: const Color.fromARGB(255, 224, 224, 220),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 15, bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 40,
                              width: 40,
                              child:
                                  Image.asset('assets/images/Service_name.png'),
                            ),
                            Text(questionCreator!,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 12))
                          ],
                        ),
                        IgnorePointer(
                          ignoring: true,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 224, 224, 220),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            constraints: const BoxConstraints(
                                minHeight: 100,
                                minWidth: double.infinity,
                                maxHeight: 200),
                            child: QuillEditor(
                              controller: QuillController(
                                  document: document,
                                  selection:
                                      const TextSelection.collapsed(offset: 0)),
                              scrollController: ScrollController(),
                              scrollable: true,
                              focusNode: focusNode,
                              autoFocus: false,
                              readOnly: true,
                              showCursor: true,
                              padding: const EdgeInsets.all(4),
                              expands: true,
                            ),
                          ),
                        )
                        // Text(
                        //   questionTitle!,
                        //   style:
                        //       const TextStyle(color: Colors.grey, fontSize: 12),
                        //   maxLines: 1,
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        //
                        // const Divider(
                        //   height: 1,
                        //   color: Colors.grey,
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // Text(
                        //   "Content : ${answerContent!}",
                        //   style: const TextStyle(
                        //       color: Colors.black, fontSize: 16),
                        //   maxLines: 2,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                      ],
                    ),
                  )),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz_outlined,
                color: Colors.grey,
              ))
        ],
      ),
      const SizedBox(
        height: 20,
      )
    ],
  );
}
