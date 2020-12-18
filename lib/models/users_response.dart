import 'dart:convert';
import 'package:chat/models/user.dart';

UsersResponse usersResponseFromJson(String str) => UsersResponse.fromJson(json.decode(str));

String usersResponseToJson(UsersResponse data) => json.encode(data.toJson());

class UsersResponse {
  UsersResponse({
      this.success,
      this.data,
  });

  bool success;
  List<User> data;

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
    success: json["success"],
    data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}
