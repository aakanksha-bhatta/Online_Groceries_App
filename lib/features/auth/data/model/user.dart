class User {
  final String? username;
  final String? useremail;
  final String? userpassword;

  User({this.username, this.useremail, this.userpassword});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      useremail: json['useremail'],
      userpassword: json['userpassword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'useremail': useremail,
      'userpassword': userpassword,
    };
  }
}
