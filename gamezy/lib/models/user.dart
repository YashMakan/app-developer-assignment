class User {
  static const String cuIdKey = "cuid";
  static const String userNameKey = 'user_name';
  static const String userPasswordKey = 'user_password';

  String? cuId;
  String? userName;
  String? userPassword;

  User({this.cuId = '', this.userName = '', this.userPassword = ''});

  factory User.fromJson(Map<dynamic, dynamic> json) => User(
      cuId: json[cuIdKey],
      userName: json[userNameKey],
      userPassword: json[userNameKey]);

  Map<String, dynamic> toJson() =>
      {cuIdKey: cuId, userNameKey: userName, userPasswordKey: userPassword};
}
