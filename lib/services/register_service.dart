import 'package:http/http.dart' as http;
import 'api_config.dart';
import '../utils/session_manager.dart';

class RegisterService {
  bool isLoading = false;

  Future<void> postRegister(String name, String email, String password, String passwordConfirm, String phone, String address, String role, String avatar) async {
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
          'avatar': avatar,
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

  Future<void> postRestaurantRegister(String name, String description, String phone, String logo, String latitude, String longitude, String address) async {
    try {
      final Uri url = Uri.parse('${AppConfig.apiBaseUrl}/api/restaurant/store');
      final accessToken = SessionManager().getAccess();

      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
        body: {
          'name': name,
          'description': description,
          'phone': phone,
          'logo': logo,
          'latitude': latitude,
          'longitude': longitude,
          'address': address
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