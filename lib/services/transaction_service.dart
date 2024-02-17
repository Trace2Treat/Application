import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'dart:convert';
import '../utils/session_manager.dart';
import '../utils/globals.dart';

class TransactionService {
  bool isLoading = false;

  Future<List<Transaction>> getTransactions() async {
    final String accessToken = SessionManager().getAccess() ?? '';
    final int userid = SessionManager().getUserId() ?? 0;
    final baseUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/transaction?user_id=$userid');

    final response = await http.get(
      baseUrl,
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((item) => Transaction.fromJson(item)).toList();
    } else {
      statusCode = response.statusCode;
      throw Exception('Failed to load transactions');
    }
  }

  Future<List<Map<String, dynamic>>> getTransactionList() async {
    final String accessToken = SessionManager().getAccess() ?? '';
    final int restoid = SessionManager().getRestaurantId() ?? 0;

    final baseUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/transaction?restaurant_id=$restoid');

    try {
      final response = await http.get(
        baseUrl,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final transactionDataList = json.decode(response.body)['data'];

        return List<Map<String, dynamic>>.from(transactionDataList.map((transactionData) {
          final user = transactionData['user'];

          return {
            'id': transactionData['id'],
            'transaction_code': transactionData['transaction_code'],
            'status': transactionData['status'],
            'total': transactionData['total'],
            'note': transactionData['note'],
            'transaction_date': transactionData['transaction_date'],
            'userid': transactionData['user_id'],
            'userName': user['name'],
            'userPhone': user['phone'],
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
    final int restoid = SessionManager().getRestaurantId() ?? 0;

    final baseUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/transaction?restaurant_id=$restoid&status=success');

    try {
      final response = await http.get(
        baseUrl,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final transactionDataList = json.decode(response.body)['data'];

        return List<Map<String, dynamic>>.from(transactionDataList.map((transactionData) {
          final user = transactionData['user'];

          return {
            'id': transactionData['id'],
            'transaction_code': transactionData['transaction_code'],
            'status': transactionData['status'],
            'total': transactionData['total'],
            'note': transactionData['note'],
            'transaction_date': transactionData['transaction_date'],
            'userid': transactionData['user_id'],
            'userName': user['name'],
            'userPhone': user['phone'],
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

  Future<void> purchaseFood(String address, String restoId, String purchaseList) async {
    try {
      final String accessToken = SessionManager().getAccess() ?? '';
      final Uri url = Uri.parse('${AppConfig.apiBaseUrl}/api/transaction/purchase-food');

      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
        body: {
          'address': address,
          'restaurant_id': restoId,
          'items': purchaseList
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

  Future<void> transactionUpdateStatus(int id, String status) async {
    final String accessToken = SessionManager().getAccess() ?? '';

    try {
      final Uri url = Uri.parse('${AppConfig.apiBaseUrl}/api/transaction/change-status/$id');

      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
        body: {
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

  Future<Uint8List> getQrCode(String id) async {
    final String accessToken = SessionManager().getAccess() ?? '';

    final baseUrl = Uri.parse('${AppConfig.apiBaseUrl}/api/transaction/generate-qr-code/$id');

    try {
      final response = await http.get(
        baseUrl,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
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

  Future<void> payTransaction(String code) async {
    final String accessToken = SessionManager().getAccess() ?? '';

    try {
      final Uri url = Uri.parse(code);

      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
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
}

class Transaction {
  late int id;
  late String transactionCode;
  late String status;
  late double total;
  late String createdAt;
  late int restoId;
  late List<Map<String, dynamic>> items;

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    transactionCode = json['transaction_code'];
    status = json['status'];
    total = double.parse(json['total']);
    createdAt = json['created_at'];
    restoId = json['restaurant_id'];
    items = (json['items'] as List<dynamic>).cast<Map<String, dynamic>>();
  }

  bool operator >(Transaction other) {
    return id > other.id;
  }
}