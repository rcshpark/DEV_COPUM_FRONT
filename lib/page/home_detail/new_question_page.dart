import 'dart:convert';

import 'package:copum_front_update/page/home_detail/question_detail_page.dart';
import 'package:copum_front_update/provider/answer_provider.dart';
import 'package:copum_front_update/provider/question_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class NewQuestionPage extends StatefulWidget {
  const NewQuestionPage({super.key});

  @override
  State<NewQuestionPage> createState() => _NewQuestionPageState();
}

class _NewQuestionPageState extends State<NewQuestionPage> {
  QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    final answerP = Provider.of<AnswerProvider>(context);
    return Consumer<QuestionProvider>(builder: (_, p, child) {
      return Column(
        children: [
          Expanded(
              child: p.questionModel.message == "질문 조회 성공"
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                // 클릭한 질문에 대한 답변글들 조회 -> page 이동
                                await answerP.fetchData(
                                    p.questionModel.result![index].questionId);
                                if (mounted) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              QuestionDetailPage(
                                                  questionId: p
                                                      .questionModel
                                                      .result![index]
                                                      .questionId,
                                                  nickname: p.questionModel
                                                      .result![index].creator,
                                                  createdAt: p.questionModel
                                                      .result![index].createAt,
                                                  title: p.questionModel
                                                      .result![index].title,
                                                  imageURL: p
                                                      .questionModel
                                                      .result![index]
                                                      .questionImage,
                                                  content: p.questionModel
                                                      .result![index].content,
                                                  viewCount: p.questionModel
                                                      .result![index].viewCount,
                                                  answerCount: p
                                                      .questionModel
                                                      .result![index]
                                                      .answerCount)));
                                }
                              },
                              child: questionCard(
                                p.questionModel.result![index].creator,
                                p.questionModel.result![index].createAt,
                                p.questionModel.result![index].title,
                                p.questionModel.result![index].questionImage,
                                p.questionModel.result![index].content,
                                p.questionModel.result![index].viewCount,
                                p.questionModel.result![index].answerCount,
                              ),
                            )
                          ],
                        );
                      },
                      itemCount: p.questionModel.result!.length,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 1,
                          color: Colors.grey,
                        );
                      },
                    )
                  : const SizedBox()),
        ],
      );
    });
  }
}

// 질문 상세보기 Card UI
Widget questionCard(String? nickname, String? createdAt, String? title,
    String? imageURL, String? content, String? viewCount, int? answerCount) {
  final delta = Delta.fromJson(jsonDecode(content!));
  final document = Document.fromDelta(delta);
  FocusNode focusNode = FocusNode();
  DateTime dateTime = DateTime.parse(createdAt!);
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
                '$nickname\n${DateFormat.yMMMd().format(dateTime)}',
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title!,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 5,
          ),
          imageURL!.isEmpty
              ? const SizedBox()
              : Container(
                  color: Colors.white,
                  width: 40,
                  height: 40,
                ),
          const SizedBox(
            height: 5,
          ),
          IgnorePointer(
            ignoring: true,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 56, 59, 61),
                borderRadius: BorderRadius.circular(8.0),
              ),
              constraints: const BoxConstraints(
                  minHeight: 100, minWidth: double.infinity, maxHeight: 200),
              child: QuillEditor(
                controller: QuillController(
                    document: document,
                    selection: const TextSelection.collapsed(offset: 0)),
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
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '$viewCount 번의 조회 $answerCount 개의 답변',
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          )
        ],
      ),
    ),
  );
}
