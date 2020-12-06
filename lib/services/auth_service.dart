import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/user.dart';
import 'package:chat/global/environment.dart';
import 'package:chat/models/service_response.dart';

class AuthService with ChangeNotifier {
  User user;
  bool _isAuthenticating = false;
  final _storage = FlutterSecureStorage();

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<String> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }

  Future<ServiceResponse> login(String email, String password) async {
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
        await this._saveToken(loginResponse.data.token);
        this.isAuthenticating = false;
        return ServiceResponse(success: true, message: '');
      } else {
        this.isAuthenticating = false;
        final errorResponse = serviceResponseFromJson(response.body);
        return errorResponse;
      }
    } catch (error) {
      print(error);
      this.isAuthenticating = false;
      return ServiceResponse(success: false, message: 'No se pudo iniciar sesión');
    }
  }

  bool get isAuthenticating => this._isAuthenticating;

  set isAuthenticating(bool value) {
    this._isAuthenticating = value;
    notifyListeners();
  }
}