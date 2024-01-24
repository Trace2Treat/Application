import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'dart:convert';
import '../utils/session_manager.dart';

class FoodService {
  bool isLoading = false;

  Future<List<Map<String, dynamic>>> getFoodList() async {
    final baseUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/foods');
    final accessToken = SessionManager().getAccess();

    final response = await http.get(
      baseUrl,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final foodDataList = json.decode(response.body)['data'];

        return List<Map<String, dynamic>>.from(foodDataList.map((food) {
          return {
            'id': food['id'],
            'name': food['name'],
            'description': food['description'],
            'price': food['price'],
            'stock': food['stock'],
            'thumb': food['thumb'],
            'category_id': food['category_id'],
            'restaurant_id': food['restaurant_id'],
            'created_at': food['created_at'],
            'updated_at': food['updated_at'],
          };
        }));
    } else {
      throw Exception('Failed to get food list');
    }
  }

  Future<List<Map<String, dynamic>>> getFoodListRestaurant() async {
    final String accessToken = SessionManager().getAccess() ?? '';
    final int userid = SessionManager().getRestaurantId() ?? 0;

    final baseUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/foods?restaurant_id=$userid');

    try {
      final response = await http.get(
        baseUrl,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final foodDataList = json.decode(response.body)['data'];

        return List<Map<String, dynamic>>.from(foodDataList.map((food) {
          return {
            'id': food['id'],
            'name': food['name'],
            'description': food['description'],
            'price': food['price'],
            'stock': food['stock'],
            'thumb': food['thumb'],
            'category_id': food['category_id'],
            'restaurant_id': food['restaurant_id'],
            'created_at': food['created_at'],
            'updated_at': food['updated_at'],
          };
        }));
      } else {
        print('Failed to get food list - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Failed to get food list');
      }
    } catch (e) {
      print('Exception: $e');
      print('aksessnya $accessToken $userid');
      throw Exception('Failed to food list');
    }
  }

  Future<void> createFood(String name, String description, String price, String stock, String thumb) async {
    try {
      final Uri url = Uri.parse('${AppConfig.apiBaseUrl}/api/foods/store');
      final accessToken = SessionManager().getAccess();

      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
        body: {
          'name': name,
          'description': description,
          'price': price,
          'stock': stock,
          'thumb': thumb,
          'category_id': '1'
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        // success
      } else {
        // failed
      }
    } catch (error) {
      print('Error post food request: $error');
      rethrow;
    }
  }
}