import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';
import '../utils/session_manager.dart';

class ActorService {

  Future<List<ActorData>> fetchData() async {
    try {
      if (await SessionManager().isLoggedIn()) {
        final Uri url = Uri.parse('${AppConfig.apiBaseUrl}/api/user');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final List<dynamic> rawData = json.decode(response.body)['data'];

          final List<ActorData> actorDataList = rawData.map((data) => ActorData.fromJson(data)).toList();
          SessionManager().saveUserInfo(rawData[0]);

          return actorDataList;
        } else {
          throw Exception('Failed to load data');
        }
      } else {
        throw Exception('User not logged in');
      }
    } catch (error) {
      print('Error fetching data: $error');
      throw error;
    }
  }
}

class ActorData {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final String? avatar;
  final String? role;
  final int? poin;

  ActorData({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.avatar,
    this.role,
    this.poin,
  });

  factory ActorData.fromJson(Map<String, dynamic> json) {

    return ActorData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      avatar: json['avatar'],
      role: json['role'],
      poin: json['balance_coin'],
    );
  }
}