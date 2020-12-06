import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat/models/login_response.dart';
import 'package:chat/models/user.dart';
import 'package:chat/global/environment.dart';

class AuthService with ChangeNotifier {
  User user;
  bool _isAuthenticating = false;

  bool get isAuthenticating => this._isAuthenticating;

  set isAuthenticating(bool value) {
    this._isAuthenticating = value;
    notifyListeners();
  }

  Future login(String email, String password) async {
    this.isAuthenticating = true;
    
    final data = {
      'email': email,
      'password': password
    };

    try {
      final response = await http.post('${Environment.apiUrl}/login', 
        body: jsonEncode(data),
        headers: { 'Content-Type': 'application/json' }
      );

      if (response.statusCode == 200) {
        final loginResponse = loginResponseFromJson(response.body);
        this.user = loginResponse.data.user;
      }

      this.isAuthenticating = false;
    } catch (error) {
      print(error);
      this.isAuthenticating = false;
    }
  }
}