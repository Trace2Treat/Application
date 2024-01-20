import 'package:http/http.dart' as http;
import 'config.dart';
import 'dart:convert';
import '../utils/session_manager.dart';

class FoodService {
  bool isLoading = false;

  Future<Map<String, dynamic>> getFoodList() async {
    final baseUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/foods');
    final accessToken = SessionManager().getAccess();

    final response = await http.get(
      baseUrl,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final foodsData = json.decode(response.body);

      final filteredData = {
        'id': foodsData['id'],
        'name': foodsData['name'],
        'description': foodsData['description'],
        'price': foodsData['price'],
        'stock': foodsData['stock'],
        'thumb': foodsData['thumb'],
        'category_id': foodsData['category_id'],
        'restaurant_id': foodsData['restaurant_id'],
        'created_at': foodsData['created_at'],
        'updated_at': foodsData['updated_at'],
      };

      return filteredData;
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