import 'package:http/http.dart' as http;
import 'config.dart';

class LoginService {
  bool isLoading = false;
  Map<String, dynamic> userData = {};

  Future<void> postLogin(String email, String password) async {
    try {
      final Uri url = Uri.parse('${AppConfig.apiBaseUrl}/api/login');

      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        // success
      } else {
        // failed
      }
    } catch (error) {
      print('Error login: $error');
      rethrow;
    }
  }
}