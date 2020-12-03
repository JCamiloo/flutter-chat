import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat/global/environment.dart';

class AuthService with ChangeNotifier {

  Future login(String email, String password) async {
    final data = {
      'email': email,
      'password': password
    };

    final response = await http.post('${Environment.apiUrl}/login', 
      body: jsonEncode(data)
    );

    print(response.body);
  }
}