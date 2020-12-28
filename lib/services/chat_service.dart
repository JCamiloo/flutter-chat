import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat/services/auth_service.dart';
import 'package:chat/models/messages_response.dart';
import 'package:chat/models/user.dart';
import 'package:chat/global/environment.dart';

class ChatService extends ChangeNotifier {
  User addressee;

  Future<List<Message>> getChat(String userId) async {
    try {
      final response = await http.get('${Environment.apiUrl}/v1/messages/$userId', 
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        }
      );

      final messageResponse = messageResponseFromJson(response.body);

      return messageResponse.data;
    } catch(error) {
      return [];
    }
  }
}