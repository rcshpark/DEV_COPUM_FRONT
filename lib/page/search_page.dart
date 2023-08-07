import 'package:copum_front_update/page/home_detail/new_question.dart';
import 'package:copum_front_update/provider/question_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keyword = '';
  @override
  Widget build(BuildContext context) {
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
                  child: p.searchModel.statusCode == 200
                      ? SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.black,
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "${p.searchModel.result![index].title}",
                                      style: TextStyle(
                                          color: p.searchModel.result![index]
                                                  .title!
                                                  .contains(keyword)
                                              ? Colors.white
                                              : Colors.white,
                                          fontSize: 20),
                                      maxLines: 3,
                                    ),
                                    p.searchModel.result![index].questionImage!
                                            .isEmpty
                                        ? const SizedBox()
                                        : Container(
                                            color: Colors.white,
                                            width: 40,
                                            height: 40,
                                          ),
                                    Text(
                                      "${p.searchModel.result![index].content}",
                                      style: TextStyle(
                                          color: p.searchModel.result![index]
                                                  .content!
                                                  .contains(keyword)
                                              ? Colors.white
                                              : Colors.white,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                              );
                            },
                            itemCount: p.searchModel.result!.length,
                          ),
                        )
                      : const SizedBox())
            ],
          ),
        ),
      ),
    );
  }
}
