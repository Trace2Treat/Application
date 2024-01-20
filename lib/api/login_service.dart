import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';
import '../utils/session_manager.dart';

class LoginService {
  bool isLoading = false;

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final loginUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/login');
    
    final response = await http.post(
      loginUrl,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final accessToken = responseData['access_token'];
      final userData = await getUserData(accessToken);

      SessionManager().saveAccess(
        accessToken: accessToken ?? '',
      );

      return userData;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>> getUserData(String accessToken) async {
    final userUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/user');

    final response = await http.get(
      userUrl,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final userData = json.decode(response.body);

      final filteredData = {
        'id': userData['id'],
        'name': userData['name'],
        'email': userData['email'],
        'phone': userData['phone'],
        'address': userData['address'],
        'avatar': userData['avatar'],
        'role': userData['role'],
        'balance_coin': userData['balance_coin'],
      };

      return filteredData;
    } else {
      throw Exception('Failed to get user data');
    }
  }
}