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
        final restaurantDataList = json.decode(response.body)['data'];

        return List<Map<String, dynamic>>.from(restaurantDataList.map((restaurantData) {
          return {
            'id': restaurantData['id'],
            'name': restaurantData['name'],
            'description': restaurantData['description'],
            'address': restaurantData['address'],
            'latitude': restaurantData['latitude'],
            'longitude': restaurantData['longitude'],
            'phone': restaurantData['phone'],
            'logo': restaurantData['logo'],
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

  Future<List<Map<String, dynamic>>> getFoodEachRestaurant(String id) async {
    final String accessToken = SessionManager().getAccess() ?? '';

    final baseUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/foods?restaurant_id=$id');

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
      throw Exception('Failed to food list');
    }
  }
}