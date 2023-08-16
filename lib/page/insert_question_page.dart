import 'dart:convert';

import 'package:copum_front_update/page/home_page.dart';
import 'package:copum_front_update/page/main_page.dart';
import 'package:copum_front_update/provider/question_provider.dart';
import 'package:copum_front_update/provider/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class Category {
  final int id;
  final String name;

  const Category({required this.id, required this.name});
}

class AskQuestionPage extends StatefulWidget {
  const AskQuestionPage({super.key});

  @override
  State<AskQuestionPage> createState() => _AskQuestionPageState();
}

class _AskQuestionPageState extends State<AskQuestionPage> {
  static final List<Category> categories = [
    const Category(id: 1, name: 'Dart'),
    const Category(id: 2, name: 'Php'),
    const Category(id: 3, name: 'Python'),
    const Category(id: 4, name: 'Java'),
    const Category(id: 5, name: 'Go'),
    const Category(id: 6, name: 'MySQL'),
    const Category(id: 7, name: 'JavaScript')
  ];

  final items = categories.map((e) => MultiSelectItem(e, e.name)).toList();
  final List? selectedItems = [];
  final QuillController _controller = QuillController.basic();
  TextEditingController titleController = TextEditingController();

  FocusNode editorFocus = FocusNode();
  bool editorFocused = false;

  @override
  void initState() {
    super.initState();
    editorFocus.addListener(_onFocusedChanged);
  }

  @override
  void dispose() {
    super.dispose();
    editorFocus.removeListener(_onFocusedChanged);
  }

  void _onFocusedChanged() {
    setState(() {
      editorFocused = editorFocus.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuestionProvider>(context);
    final userProvider = Provider.of<UserInfoProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('질문하기'),
        actions: [
          TextButton(
              onPressed: () async {
                var content =
                    jsonEncode(_controller.document.toDelta().toJson());
                await userProvider.fetchData();
                if (titleController.text.isNotEmpty && content.isNotEmpty) {
                  String response = await provider.insertQuestion(
                      userProvider.userModel.email,
                      titleController.text,
                      content,
                      selectedItems,
                      "");
                  if (response == 'success') {
                    if (mounted) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('성공'),
                              content: const Text('질문 등록이 완료되었습니다! '),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      await provider.fetchData();
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  const BottomNavigation())));
                                    },
                                    child: const Text('확인')),
                              ],
                            );
                          });
                    }
                  } else {
                    if (mounted) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('오류'),
                              content: const Text('질문등록에 실패하였습니다. 다시 시도해 주새요!'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('확인')),
                              ],
                            );
                          });
                    }
                  }
                }
              },
              child: const Text(
                '완료',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MultiSelectDialogField(
                  items: items,
                  onConfirm: (value) {
                    if (value.length > 2) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('오류'),
                              content: const Text('카테고리는 최대 2개까지 설정 가능합니다!'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      value.clear();
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: const Text('확인')),
                              ],
                            );
                          });
                    } else {
                      for (var v in value) {
                        selectedItems!.add(v.name);
                      }
                    }
                  },
                  listType: MultiSelectListType.CHIP,
                  buttonIcon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  buttonText: const Text(
                    '카테고리',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onSelectionChanged: (value) {},
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text("제목",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLength: 60,
                  controller: titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      hintText: '제목 (60자 제한)',
                      hintStyle: TextStyle(color: Colors.white60),
                      filled: true,
                      fillColor: Color.fromARGB(255, 56, 59, 61),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(width: 0))),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text("내용",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 56, 59, 61),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  constraints: const BoxConstraints(
                      minHeight: 100,
                      minWidth: double.infinity,
                      maxHeight: 500),
                  child: QuillEditor(
                    controller: _controller,
                    scrollController: ScrollController(),
                    scrollable: true,
                    focusNode: editorFocus,
                    autoFocus: false,
                    readOnly: false,
                    showCursor: true,
                    padding: const EdgeInsets.all(4),
                    expands: true,
                  ),
                ),
              ],
            ),
          ),
          editorFocused
              ? Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      color: Colors.grey,
                      child: QuillToolbar.basic(
                        controller: _controller,
                        customButtons: [
                          QuillCustomButton(
                            icon: Icons.camera_alt_outlined,
                            onTap: () {},
                          )
                        ],
                      )),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
