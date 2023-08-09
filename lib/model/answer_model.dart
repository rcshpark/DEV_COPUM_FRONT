class AnswerModel {
  int? statusCode;
  String? message;
  Result? result;

  AnswerModel({this.statusCode, this.message, this.result});

  AnswerModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  String? cATEGORY;
  String? tITLE;
  String? cONTENT;
  String? vIEWCOUNT;
  String? qUESTIONIMAGE;
  int? cOUNTANSWER;
  List<ANSWER>? aNSWER;
  String? cREATOR;
  String? cREATEDDTTM;
  String? uPDATEDDTTM;

  Result(
      {this.cATEGORY,
      this.tITLE,
      this.cONTENT,
      this.vIEWCOUNT,
      this.qUESTIONIMAGE,
      this.cOUNTANSWER,
      this.aNSWER,
      this.cREATOR,
      this.cREATEDDTTM,
      this.uPDATEDDTTM});

  Result.fromJson(Map<String, dynamic> json) {
    cATEGORY = json['CATEGORY'];
    tITLE = json['TITLE'];
    cONTENT = json['CONTENT'];
    vIEWCOUNT = json['VIEW_COUNT'];
    qUESTIONIMAGE = json['QUESTION_IMAGE'];
    cOUNTANSWER = json['COUNT_ANSWER'];
    if (json['ANSWER'] != null) {
      List<dynamic> answerList = json["ANSWER"];
      aNSWER = answerList.map((e) => ANSWER.fromJson(e)).toList();
      // for (var v in json["ANSWER"]) {
      //   aNSWER!.add(ANSWER.fromJson(v));
      // }
    }
    cREATOR = json['CREATOR'];
    cREATEDDTTM = json['CREATED_DTTM'];
    uPDATEDDTTM = json['UPDATED_DTTM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CATEGORY'] = cATEGORY;
    data['TITLE'] = tITLE;
    data['CONTENT'] = cONTENT;
    data['VIEW_COUNT'] = vIEWCOUNT;
    data['QUESTION_IMAGE'] = qUESTIONIMAGE;
    data['COUNT_ANSWER'] = cOUNTANSWER;
    if (aNSWER != null) {
      data['ANSWER'] = aNSWER!.map((v) => v.toJson()).toList();
    }
    data['CREATOR'] = cREATOR;
    data['CREATED_DTTM'] = cREATEDDTTM;
    data['UPDATED_DTTM'] = uPDATEDDTTM;
    return data;
  }
}

class ANSWER {
  int? aNSWERID;
  int? qUESTIONID;
  String? cONTENT;
  String? aNSWERIMAGE;
  String? cREATOR;
  String? cREATEDDTTM;
  String? uPDATEDDTTM;

  ANSWER(
      {this.aNSWERID,
      this.qUESTIONID,
      this.cONTENT,
      this.aNSWERIMAGE,
      this.cREATOR,
      this.cREATEDDTTM,
      this.uPDATEDDTTM});

  ANSWER.fromJson(Map<String, dynamic> json) {
    aNSWERID = json['ANSWER_ID'];
    qUESTIONID = json['QUESTION_ID'];
    cONTENT = json['CONTENT'];
    aNSWERIMAGE = json['ANSWER_IMAGE'];
    cREATOR = json['CREATOR'];
    cREATEDDTTM = json['CREATED_DTTM'];
    uPDATEDDTTM = json['UPDATED_DTTM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ANSWER_ID'] = aNSWERID;
    data['QUESTION_ID'] = qUESTIONID;
    data['CONTENT'] = cONTENT;
    data['ANSWER_IMAGE'] = aNSWERIMAGE;
    data['CREATOR'] = cREATOR;
    data['CREATED_DTTM'] = cREATEDDTTM;
    data['UPDATED_DTTM'] = uPDATEDDTTM;
    return data;
  }
}
