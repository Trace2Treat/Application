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

  Future<void> createFood(String name, String description, String price, String stock, String thumb, String categoryid) async {
    try {
      final Uri url = Uri.parse('${AppConfig.apiBaseUrl}/api/foods/store');

      final response = await http.post(
        url,
        body: {
          'name': name,
          'description': description,
          'price': price,
          'stock': stock,
          'thumb': thumb,
          'category_id': categoryid
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