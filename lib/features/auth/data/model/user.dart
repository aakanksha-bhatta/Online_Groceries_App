class User {
  final String? username;
  final String? useremail;
  final String? userpassword;
  final String? phoneNumber;

  User({this.username, this.useremail, this.userpassword, this.phoneNumber});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      useremail: json['useremail'],
      userpassword: json['userpassword'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'useremail': useremail,
      'userpassword': userpassword,
      'phoneNumber': phoneNumber,
    };
  }
}
