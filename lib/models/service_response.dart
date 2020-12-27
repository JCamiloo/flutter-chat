import 'dart:convert';

class ServiceResponse {
  bool success;
  String message;

  ServiceResponse({
    this.success,
    this.message,
  });

  factory ServiceResponse.fromJson(Map<String, dynamic> json) => ServiceResponse(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}

ServiceResponse serviceResponseFromJson(String str) => ServiceResponse.fromJson(json.decode(str));

String serviceResponseToJson(ServiceResponse data) => json.encode(data.toJson());
