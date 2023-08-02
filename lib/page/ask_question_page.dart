import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:multi_select_flutter/multi_select_flutter.dart';

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
  List _initialItems = [];
  QuillController _controller = QuillController.basic();
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
      body: Column(
        children: [
          MultiSelectDialogField(
            items: items,
            initialValue: _initialItems,
            onConfirm: (value) {
              print(value);
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
              }
            },
            listType: MultiSelectListType.CHIP,
            buttonIcon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            buttonText: const Text(
              '카테고리',
              style: TextStyle(color: Colors.white),
            ),
            onSelectionChanged: (value) {},
          ),
          // QuillToolbar.basic(controller: _controller),
          // QuillEditor.basic(controller: _controller, readOnly: false)
        ],
      ),
    );
  }
}
