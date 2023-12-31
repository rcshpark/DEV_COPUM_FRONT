class QuestionModel {
  int? statusCode;
  String? message;
  List<Result>? result;

  QuestionModel({this.statusCode, this.message, this.result});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? questionId;
  String? category;
  String? title;
  String? content;
  String? viewCount;
  String? questionImage;
  int? answerCount;
  String? creator;
  String? createAt;
  String? updateAt;

  Result(
      {this.questionId,
      this.category,
      this.title,
      this.content,
      this.viewCount,
      this.questionImage,
      this.answerCount,
      this.creator,
      this.createAt,
      this.updateAt});

  Result.fromJson(Map<String, dynamic> json) {
    questionId = json['QUESTION_ID'];
    category = json['CATEGORY'];
    title = json['TITLE'];
    content = json['CONTENT'];
    viewCount = json['VIEW_COUNT'];
    questionImage = json['QUESTION_IMAGE'];
    answerCount = json['ANSWER_COUNT'];
    creator = json['CREATOR'];
    createAt = json['CREATED_DTTM'];
    updateAt = json['UPDATED_DTTM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['QUESTION_ID'] = questionId;
    data['CATEGORY'] = category;
    data['TITLE'] = title;
    data['CONTENT'] = content;
    data['VIEW_COUNT'] = viewCount;
    data['QUESTION_IMAGE'] = questionImage;
    data['ANSWER_COUNT'] = answerCount;
    data['CREATOR'] = creator;
    data['CREATED_DTTM'] = createAt;
    data['UPDATED_DTTM'] = updateAt;
    return data;
  }
}
