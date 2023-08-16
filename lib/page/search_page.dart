import 'dart:convert';

import 'package:copum_front_update/provider/answer_provider.dart';
import 'package:copum_front_update/provider/question_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'home_detail/question_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keyword = '';
  @override
  Widget build(BuildContext context) {
    final answerProvider = Provider.of<AnswerProvider>(context, listen: false);
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text('찾기'),
      ),
      body: Consumer<QuestionProvider>(
        builder: (_, p, child) => Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            children: [
              TextField(
                controller: textEditingController,
                onSubmitted: (value) {
                  keyword = value;
                  p.searchData(value);
                },
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel_sharp),
                        onPressed: () {
                          textEditingController.clear();
                        }),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "제목/내용"),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: textEditingController.text.isEmpty
                      ? const SizedBox()
                      : p.searchModel.statusCode == 200 &&
                              p.searchModel.message != "검색할 단어에 일치하는 질문이 없습니다."
                          ? SingleChildScrollView(
                              physics: const ScrollPhysics(),
                              child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      await answerProvider.fetchData(p
                                          .searchModel
                                          .result![index]
                                          .questionId);
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
                                                        nickname: p
                                                            .questionModel
                                                            .result![index]
                                                            .creator,
                                                        createdAt: p
                                                            .questionModel
                                                            .result![index]
                                                            .createAt,
                                                        title: p
                                                            .questionModel
                                                            .result![index]
                                                            .title,
                                                        imageURL: p
                                                            .questionModel
                                                            .result![index]
                                                            .questionImage,
                                                        content: p
                                                            .questionModel
                                                            .result![index]
                                                            .content,
                                                        viewCount: p
                                                            .questionModel
                                                            .result![index]
                                                            .viewCount,
                                                        answerCount: p
                                                            .questionModel
                                                            .result![index]
                                                            .answerCount)));
                                      }
                                    },
                                    child: searchCard(
                                        p.searchModel.result![index].title,
                                        p.searchModel.result![index].content,
                                        p.searchModel.result![index].createAt,
                                        p.searchModel.result![index].viewCount,
                                        p.searchModel.result![index]
                                            .answerCount),
                                  );
                                },
                                itemCount: p.searchModel.result!.length,
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    height: 2,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  '검색할 단어에 일치하는 질문이 없습니다.',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ))
            ],
          ),
        ),
      ),
    );
  }
}

Widget searchCard(String? title, String? content, String? createdAt,
    String? viewCount, int? answerCount) {
  final delta = Delta.fromJson(jsonDecode(content!));
  final document = Document.fromDelta(delta);
  FocusNode focusNode = FocusNode();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
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
        height: 10,
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
      ),
      const SizedBox(
        height: 15,
      ),
    ],
  );
}
