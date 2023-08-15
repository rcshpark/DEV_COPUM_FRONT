class UserModel {
  int? id;
  String? email;
  String? nickname;
  String? profileImage;

  UserModel({this.id, this.email, this.nickname, this.profileImage});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    nickname = json['nickname'];
    profileImage = json['profileImage'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['nickname'] = nickname;
    data['profileImage'] = profileImage;
    return data;
  }
}
