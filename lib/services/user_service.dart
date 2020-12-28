import 'package:chat/global/environment.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/models/user.dart';
import 'package:chat/models/users_response.dart';
import 'package:http/http.dart' as http;

class UserService {

  Future<List<User>> getUsers() async {
    try {
      final response = await http.get('${Environment.apiUrl}/v1/user',
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        }
      );

      final userResponse = usersResponseFromJson(response.body);
      
      return userResponse.data;
    } catch (error) {
      return [];
    }
  }
}