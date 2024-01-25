import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'dart:convert';
import '../utils/session_manager.dart';

class TrashService {
  bool isLoading = false;

  Future<List<Map<String, dynamic>>> getTrashList() async {
    final String accessToken = SessionManager().getAccess() ?? '';
    final int userid = SessionManager().getUserId() ?? 0;

    final baseUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/trash-requests?user_id=$userid');

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
            'user_id': trashData['user_id'],
            'trash_type': trashData['trash_type'],
            'trash_weight': trashData['trash_weight'],
            'latitude': trashData['latitude'],
            'longitude': trashData['longitude'],
            'status': trashData['status'],
            'driver_id': trashData['driver_id'],
            'thumb': trashData['thumb'],
            'created_at': trashData['created_at'],
            'updated_at': trashData['updated_at'],
            'date': trashData['date'],
          };
        }));
      } else {
        print('Failed to get trash request list - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Failed to get trash request list');
      }
    } catch (e) {
      print('Exception: $e');
      print('aksessnya $accessToken');
      throw Exception('Failed to get trash request list');
    }
  }

  Future<List<Map<String, dynamic>>> getTrashListForDriver() async {
    final String accessToken = SessionManager().getAccess() ?? '';

    final baseUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/trash-requests?status=Pending');

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
            'user_id': trashData['user_id'],
            'trash_type': trashData['trash_type'],
            'trash_weight': trashData['trash_weight'],
            'latitude': trashData['latitude'],
            'longitude': trashData['longitude'],
            'status': trashData['status'],
            'driver_id': trashData['driver_id'],
            'thumb': trashData['thumb'],
            'created_at': trashData['created_at'],
            'updated_at': trashData['updated_at'],
            'date': trashData['date'],
            'place_name': trashData['place_name'],
            'user_name': trashData['user']['name'],
          };
        }));
      } else {
        print('Failed to get trash request list - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Failed to get trash request list');
      }
    } catch (e) {
      print('Exception: $e');
      print('aksessnya $accessToken');
      throw Exception('Failed to get trash request list');
    }
  }

  Future<List<Map<String, dynamic>>> getTrashListOngoing() async {
    final String accessToken = SessionManager().getAccess() ?? '';
    final int userid = SessionManager().getUserId() ?? 0;

    final baseUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/trash-requests?driver_id=$userid');

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
            'user_id': trashData['user_id'],
            'trash_type': trashData['trash_type'],
            'trash_weight': trashData['trash_weight'],
            'latitude': trashData['latitude'],
            'longitude': trashData['longitude'],
            'status': trashData['status'],
            'driver_id': trashData['driver_id'],
            'proof_payment': trashData['proof_payment'],
            'created_at': trashData['created_at'],
            'updated_at': trashData['updated_at'],
            'date': trashData['date'],
            'place_name': trashData['place_name'],
            'user_name': trashData['user']['name'],
            'phone': trashData['user']['phone'],
            'avatar': trashData['user']['avatar'],
            'address': trashData['user']['address'],
          };
        }));
      } else {
        print('Failed to get trash request list - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Failed to get trash request list');
      }
    } catch (e) {
      print('Exception: $e');
      print('aksessnya $accessToken');
      throw Exception('Failed to get trash request list');
    }
  }

  Future<void> postTrashRequest(String type, String weight, String latitude, String longitude, String locationName) async {
    try {
      final String accessToken = SessionManager().getAccess() ?? '';
      final Uri url = Uri.parse('${AppConfig.apiBaseUrl}/api/trash-requests/store');

      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
        body: {
          'trash_type': type,
          'trash_weight': weight,
          'latitude': latitude,
          'longitude': longitude,
          'place_name': locationName,
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

  Future<void> postTrashUpdateStatus(int id, String status) async {
    try {
      final Uri url = Uri.parse('${AppConfig.apiBaseUrl}/api/trash-requests/change-status/$id');
      final String accessToken = SessionManager().getAccess() ?? '';

      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
        body: {
          'status': status,
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          print(responseData['message']);
        } else {
          print('Failed to update status: ${responseData['message']}');
        }
      } else {
        print('Failed to update status - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (error) {
      print('Error posting request: $error');
      rethrow;
    }
  }

  Future<void> postTrashFinished(int id, String status, String thumb) async {
    try {
      final Uri url = Uri.parse('${AppConfig.apiBaseUrl}/api/trash-requests/change-status/$id');
      final String accessToken = SessionManager().getAccess() ?? '';

      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
        body: {
          'status': status,
          'proof_payment': thumb
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          print(responseData['message']);
        } else {
          print('Failed to update status: ${responseData['message']}');
        }
      } else {
        print('Failed to update status - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (error) {
      print('Error posting request: $error');
      rethrow;
    }
  }
}

