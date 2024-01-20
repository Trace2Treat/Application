import 'package:http/http.dart' as http;
import 'config.dart';
import 'dart:convert';
import '../utils/session_manager.dart';

class TrashService {
  bool isLoading = false;
  final accessToken = SessionManager().getAccess();

  Future<Map<String, dynamic>> getTrashList() async {
    final baseUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/trash-requests?user_id=2');

    final response = await http.get(
      baseUrl,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final trashData = json.decode(response.body);

      final filteredData = {
        'id': trashData['id'],
        'userid': trashData['user_id'],
        'trash_type': trashData['trash_type'],
        'trash_weight': trashData['trash_weight'],
        'latitude': trashData['latitude'],
        'longitude': trashData['longitude'],
        'status': trashData['status'],
        'driver_id': trashData['driver_id'],
        'thumb': trashData['thumb'],
        'created_at': trashData['created_at'],
        'updated_at': trashData['updated_at'],
      };

      return filteredData;
    } else {
      throw Exception('Failed to get trash request list');
    }
  }

  Future<void> postTrashRequest(String type, String weight, String latitude, String longitude, String photo) async {
    try {
      final Uri url = Uri.parse('${AppConfig.apiBaseUrl}/api/trash-requests/store');

      final response = await http.post(
        url,
        body: {
          'trash_type': type,
          'trash_weight': weight,
          'latitude': latitude,
          'longitude': longitude,
          'thumb': photo,
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        // success
      } else {
        // failed
      }
    } catch (error) {
      print('Error posting request: $error');
      rethrow;
    }
  }

  Future<void> postTrashUpdateStatus(String id, String status) async {
    try {
      final Uri url = Uri.parse('${AppConfig.apiBaseUrl}/api/trash-requests/change-status/$id');

      final response = await http.post(
        url,
        body: {
          'id': id,
          'status': status
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        // success
      } else {
        // failed
      }
    } catch (error) {
      print('Error posting request: $error');
      rethrow;
    }
  }
}