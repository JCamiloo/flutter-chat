import 'dart:convert';

class MessageResponse {
  bool success;
  List<Message> data;
  
  MessageResponse({
    this.success,
    this.data,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) => MessageResponse(
    success: json["success"],
    data: List<Message>.from(json["data"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

MessageResponse messageResponseFromJson(String str) => MessageResponse.fromJson(json.decode(str));

String messageResponseToJson(MessageResponse data) => json.encode(data.toJson());

class Message {
  String from;
  String to;
  String message;
  DateTime createdAt;
  DateTime updatedAt;

  Message({
    this.from,
    this.to,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    from: json["from"],
    to: json["to"],
    message: json["message"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to,
    "message": message,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
