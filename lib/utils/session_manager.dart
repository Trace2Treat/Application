import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String userIdKey = 'userId';
  static const String userNameKey = 'userName';
  static const String userEmailKey = 'userEmail';
  static const String userPoinKey = 'userPoin';
  static const String userPhoneKey = 'userPhone';
  static const String userRoleKey = 'userRole';
  static const String userAddressKey = 'userAddress';
  // static const String _keyAvatar = 'avatar';
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

  void saveUserData({
    required int userId,
    required String userName,
    required String userEmail,
    required int userPoin,
    required String userPhone,
    required String userRole,
    required String userAddress
    // additional user data
  }) {
    _prefs.setInt(userIdKey, userId);
    _prefs.setString(userNameKey, userName);
    _prefs.setString(userEmailKey, userEmail);
    _prefs.setInt(userPoinKey, userPoin);
    _prefs.setString(userPhoneKey, userPhone);
    _prefs.setString(userRoleKey, userRole);
    _prefs.setString(userAddressKey, userAddress);
    // Save additional user data here
  }

  String getUserId() {
    return _prefs.getString(userIdKey) ?? '';
  }

  String getUserName() {
    return _prefs.getString(userNameKey) ?? '';
  }

  String getUserEmail() {
    return _prefs.getString(userEmailKey) ?? '';
  }

  int getUserPoin() {
    return _prefs.getInt(userPoinKey) ?? 0;
  }

  String getUserPhone() {
    return _prefs.getString(userPhoneKey) ?? '';
  }

  String getUserRole() {
    return _prefs.getString(userRoleKey) ?? '';
  }

  String getUserAddress() {
    return _prefs.getString(userAddressKey) ?? '';
  }

  void logout() {
    // _prefs.remove(_keyUserId);
    setLoggedIn(false);
  }
}