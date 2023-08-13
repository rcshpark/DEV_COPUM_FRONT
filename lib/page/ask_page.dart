import 'dart:convert';

import 'package:copum_front_update/provider/answer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class AskPage extends StatefulWidget {
  String? questionCreator;
  String? title;
  int? questionId;
  AskPage(
      {required this.questionCreator,
      required this.title,
      required this.questionId,
      super.key});

  @override
  State<AskPage> createState() => _AskPageState();
}

class _AskPageState extends State<AskPage> {
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

  static final storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AnswerProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('답변하기'),
        actions: [
          TextButton(
              onPressed: () async {
                var creator = await storage.read(key: 'id');
                var content =
                    jsonEncode(_controller.document.toDelta().toJson());
                if (content.isNotEmpty) {
                  String? response = await provider.insertAnswer(
                      widget.questionId.toString(), creator, content, null);
                  if (response == 'success') {
                    await provider.fetchData(widget.questionId);
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text(
                '완료',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                      '${widget.questionCreator}',
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "${widget.title}",
                  style: const TextStyle(color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
