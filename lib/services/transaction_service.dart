import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'dart:convert';
import '../utils/session_manager.dart';

class TransactionService {
  bool isLoading = false;

  Future<List<Map<String, dynamic>>> getTransaction() async {
    final String accessToken = SessionManager().getAccess() ?? '';
    final int userid = SessionManager().getUserId() ?? 0;

    final baseUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/transaction?user_id=$userid');

    try {
      final response = await http.get(
        baseUrl,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final transactionDataList = json.decode(response.body)['data'];

        return List<Map<String, dynamic>>.from(transactionDataList.map((transactionData) {
          return {
            'id': transactionData['id'],
            'transaction_code': transactionData['transaction_code'],
            'status': transactionData['status'],
            'total': transactionData['total'],
            'note': transactionData['note'],
            'transaction_date': transactionData['transaction_date'],
            'userid': transactionData['user_id'],
            'restaurant_id': transactionData['restaurant_id'],
            'created_at': transactionData['created_at'],
            'updated_at': transactionData['updated_at'],
            'items': List<Map<String, dynamic>>.from(
              transactionData['items'].map((item) => {
                'qty': item['qty'],
                'food': {
                  'name': item['food']['name'],
                  'thumb': item['food']['thumb'],
                },
              },
              ),
            ),
          };
        }));
      } else {
        print('Failed to get transaction - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Failed to get transaction');
      }
    } catch (e) {
      print('Exception: $e');
      print('aksessnya $accessToken');
      throw Exception('Failed to get transaction');
    }
  }

  Future<List<Map<String, dynamic>>> getTransactionList() async {
    final String accessToken = SessionManager().getAccess() ?? '';
    final int userid = SessionManager().getUserId() ?? 0;

    final baseUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/transaction?restaurant_id=$userid&status=pending');

    try {
      final response = await http.get(
        baseUrl,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final transactionDataList = json.decode(response.body)['data'];

        return List<Map<String, dynamic>>.from(transactionDataList.map((transactionData) {
          return {
            'id': transactionData['id'],
            'transaction_code': transactionData['transaction_code'],
            'status': transactionData['status'],
            'total': transactionData['total'],
            'note': transactionData['note'],
            'transaction_date': transactionData['transaction_date'],
            'userid': transactionData['user_id'],
            'restaurant_id': transactionData['restaurant_id'],
            'created_at': transactionData['created_at'],
            'updated_at': transactionData['updated_at'],
            'items': List<Map<String, dynamic>>.from(
              transactionData['items'].map((item) => {
                'qty': item['qty'],
                'food': {
                  'name': item['food']['name'],
                  'thumb': item['food']['thumb'],
                },
              },
              ),
            ),
          };
        }));
      } else {
        print('Failed to get transaction - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Failed to get transaction');
      }
    } catch (e) {
      print('Exception: $e');
      print('aksessnya $accessToken');
      throw Exception('Failed to get transaction');
    }
  }

  Future<List<Map<String, dynamic>>> getHistoryList() async {
    final String accessToken = SessionManager().getAccess() ?? '';
    final int userid = SessionManager().getUserId() ?? 0;

    final baseUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/transaction?restaurant_id=$userid&status=success');

    try {
      final response = await http.get(
        baseUrl,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final transactionDataList = json.decode(response.body)['data'];

        return List<Map<String, dynamic>>.from(transactionDataList.map((transactionData) {
          return {
            'id': transactionData['id'],
            'transaction_code': transactionData['transaction_code'],
            'status': transactionData['status'],
            'total': transactionData['total'],
            'note': transactionData['note'],
            'transaction_date': transactionData['transaction_date'],
            'userid': transactionData['user_id'],
            'restaurant_id': transactionData['restaurant_id'],
            'created_at': transactionData['created_at'],
            'updated_at': transactionData['updated_at'],
            'items': List<Map<String, dynamic>>.from(
              transactionData['items'].map((item) => {
                'qty': item['qty'],
                'food': {
                  'name': item['food']['name'],
                  'thumb': item['food']['thumb'],
                },
              },
              ),
            ),
          };
        }));
      } else {
        print('Failed to get transaction - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Failed to get transaction');
      }
    } catch (e) {
      print('Exception: $e');
      print('aksessnya $accessToken');
      throw Exception('Failed to get transaction');
    }
  }

  Future<void> purchaseFood(String restoId, List<Map<String, dynamic>> purchaseList) async {
    try {
      final String accessToken = SessionManager().getAccess() ?? '';
      final String address = SessionManager().getUserAddress() ?? '';
      final Uri url = Uri.parse('${AppConfig.apiBaseUrl}/api/transaction/purchase-food');

      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
        body: {
          'address': address,
          'restaurant_id': restoId,
          'items': purchaseList.toString()
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        // success
      } else {
        // failed
      }
    } catch (error) {
      print('Error purchase request: $error');
      rethrow;
    }
  }

  Future<void> payTransaction(String code) async {
    try {
      final Uri url = Uri.parse('${AppConfig.apiBaseUrl}/api/transaction/pay/$code');

      final response = await http.post(url);

      print(response.body);

      if (response.statusCode == 200) {
        // success
      } else {
        // failed
      }
    } catch (error) {
      print('Error pay request: $error');
      rethrow;
    }
  }

  Future<void> transactionUpdateStatus(String id, String status) async {
    try {
      final Uri url = Uri.parse('${AppConfig.apiBaseUrl}/api/transaction/change-status/$id');

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
      print('Error update request: $error');
      rethrow;
    }
  }
}