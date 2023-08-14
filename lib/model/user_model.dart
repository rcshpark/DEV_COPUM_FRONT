class UserModel {
  final int id;
  final String email;
  final String nickname;
  final String profileImage;

  UserModel(this.id, this.email, this.nickname, this.profileImage);

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        nickname = json['nickname'],
        profileImage = json['profileImage'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'nickname': nickname,
        'profileImage': profileImage
      };
}
