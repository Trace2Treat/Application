import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUserId = 'userId';
  static const String _keyName = 'name';
  static const String _keyEmail = 'email';
  // static const String _keyPhone = 'phone';
  // static const String _keyAddress = 'address';
  // static const String _keyAvatar = 'avatar';
  static const String _keyPoin = 'balance_coin';
  // static const String _keyRole = 'role';
  // static const String _keyStatus= 'status';

  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() {
    return _instance;
  }

  SessionManager._internal() {
    initPrefs();
  }

  late SharedPreferences _prefs;

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setLoggedIn(bool isLoggedIn) async {
    await _prefs.setBool(_keyIsLoggedIn, isLoggedIn);
  }

  Future<bool> isLoggedIn() async {
    return _prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  static Future<void> saveUserData(
    int id, String name, String email, 
    //String phone, String address, String avatar, String role, 
    String poin, 
    //String status
    ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyUserId, id);
    await prefs.setString(_keyName, name);
    await prefs.setString(_keyEmail, email);
    // await prefs.setString(_keyPhone, phone);
    // await prefs.setString(_keyAddress, address);
    // await prefs.setString(_keyAvatar, avatar);
    await prefs.setString(_keyPoin, poin);
    // await prefs.setString(_keyRole, role);
    // await prefs.setString(_keyStatus, status);
  }

  static Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt(_keyUserId);
    final name = prefs.getString(_keyName);
    final email = prefs.getString(_keyEmail);
    //final phone = prefs.getString(_keyPhone);
    // final address = prefs.getString(_keyAddress);
    // final avatar = prefs.getString(_keyAvatar);
    final poin = prefs.getString(_keyPoin);
    // final role = prefs.getString(_keyRole);
    // final status = prefs.getString(_keyStatus);

    return {
      'id': id,
      'name': name,
      'email': email,
      // 'phone': phone,
      // 'address': address,
      // 'avatar': avatar,
      'balance_coin': poin,
      // 'role': role,
      // 'status': status
    };
  }

  void logout() {
    _prefs.remove(_keyUserId);
    _prefs.remove(_keyName);
    _prefs.remove(_keyEmail);
   // _prefs.remove(_keyPhone);
    // _prefs.remove(_keyAddress);
    // _prefs.remove(_keyAvatar);
    _prefs.remove(_keyPoin);
    // _prefs.remove(_keyRole);
    // _prefs.remove(_keyStatus);
    setLoggedIn(false);
  }
}