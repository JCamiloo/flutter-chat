import 'dart:convert';

class User {
  bool online;
  String name;
  String email;
  String uid;

  User({
    this.online,
    this.name,
    this.email,
    this.uid,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    online: json["online"],
    name: json["name"],
    email: json["email"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "online": online,
    "name": name,
    "email": email,
    "uid": uid,
  };
}

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());
