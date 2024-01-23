import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'dart:convert';
import '../utils/session_manager.dart';

class TransactionService {
  bool isLoading = false;

  Future<Map<String, dynamic>> getTransaction() async {
    final baseUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/transaction');
    final accessToken = SessionManager().getAccess();

    final response = await http.get(
      baseUrl,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final transactionData = json.decode(response.body);

      final filteredData = {
        'id': transactionData['id'],
        'transaction_code': transactionData['transaction_code'],
        'status': transactionData['status'],
        'total': transactionData['total'],
        'note': transactionData['note'],
        'transaction_date': transactionData['transaction_date'],
        'userid': transactionData['userid'],
        'driver_id': transactionData['driver_id'],
        'orders_id': transactionData['orders_id'],
        'created_at': transactionData['created_at'],
        'updated_at': transactionData['updated_at'],
      };

      return filteredData;
    } else {
      throw Exception('Failed to get transaction');
    }
  }

  Future<void> payTransaction(String code, String status, String total, String userid, String foodid, String driverid) async {
    try {
      final Uri url = Uri.parse('${AppConfig.apiBaseUrl}/api/transaction/purchase-food');

      final response = await http.post(
        url,
        body: {
          'transaction_code': code,
          'status': status,
          'total': total,
          'user_id': userid,
          'food_id': foodid,
          'driver_id': driverid
        },
      );

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