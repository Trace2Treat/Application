import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';
import '../utils/session_manager.dart';

class LoginService {
  bool isLoading = false;
  Map<String, dynamic> userData = {};

  Future<http.Response> postLogin(String email, String password) async {
    try {
      final Uri url = Uri.parse('${AppConfig.apiBaseUrl}/api/login');

      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        this.userData = userData;
      }

      return response; 

    } catch (error) {
      print('Error login: $error');
      rethrow;
    }
  }
}