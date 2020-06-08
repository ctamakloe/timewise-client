import 'dart:convert';

class User {
  int id;
  String name;
  String email;
  String authToken;
  String password;

  User({this.id, this.email, this.authToken, this.password}) {}

  String toCreateUserJson() {
    var data = Map();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    return jsonEncode(data);
  }

  User.fromJson(Map<String, dynamic> json) {
    authToken = json['auth_token'];
    email = json['email'];
    name = json['name'];
  }
}
