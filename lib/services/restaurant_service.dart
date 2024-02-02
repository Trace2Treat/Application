import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'dart:convert';
import '../utils/session_manager.dart';

class RestaurantService {
  bool isLoading = false;

  Future<List<Map<String, dynamic>>> getRestaurantList() async {
    final String accessToken = SessionManager().getAccess() ?? '';

    final baseUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/restaurant');

    try {
      final response = await http.get(
        baseUrl,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final trashDataList = json.decode(response.body)['data'];

        return List<Map<String, dynamic>>.from(trashDataList.map((trashData) {
          return {
            'id': trashData['id'],
            'name': trashData['name'],
            'description': trashData['description'],
            'address': trashData['address'],
            'latitude': trashData['latitude'],
            'longitude': trashData['longitude'],
            'phone': trashData['phone'],
            'logo': trashData['logo'],
          };
        }));
      } else {
        print('Failed to get restaurant list - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Failed to get restaurant list');
      }
    } catch (e) {
      print('Exception: $e');
      print('aksessnya $accessToken');
      throw Exception('Failed to get restaurant list');
    }
  }
}