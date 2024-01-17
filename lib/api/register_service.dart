import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';

class LoginService {
  bool isLoading = false;
  //Map<String, dynamic> userData = {};

  Future<void> postRegister(String name, String email, String password, String passwordConfirm, String phone, String address, String role) async {
    try {
      final Uri url = Uri.parse('${AppConfig.apiBaseUrl}/api/register');

      final response = await http.post(
        url,
        body: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirm,
          'phone': phone,
          'address': address,
          'avatar': '-',
          'role': role,
          'status': 'active'
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        // success
      } else {
        // failed
      }
    } catch (error) {
      print('Error register: $error');
      rethrow;
    }
  }
}