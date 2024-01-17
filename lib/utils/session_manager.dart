import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';

class SessionManager {
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUserId = 'userId';
  static const String _keyName = 'name';
  static const String _keyEmail = 'email';
  static const String _keyPhone = 'phone';
  static const String _keyAddress = 'address';
  static const String _keyAvatar = 'avatar';
  static const String _keyRole = 'role';
  static const String _keyStatus= 'status';
  // static const String _themeKey = 'theme';
  // static const Locale _languageKey = Locale('en', 'US');

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

  Future<void> saveUserInfo(Map<String, dynamic> userData) async {
    await _prefs.setString(_keyUserId, userData['id']);
    await _prefs.setString(_keyName, userData['name']);
    await _prefs.setString(_keyEmail, userData['email']);
    await _prefs.setString(_keyPhone, userData['phone']);
    await _prefs.setString(_keyAddress, userData['address']);
    await _prefs.setString(_keyAvatar, userData['avatar']);
    await _prefs.setString(_keyRole, userData['role']);
    await _prefs.setString(_keyStatus, userData['status']);
  }

  String? getUserId() {
    return _prefs.getString(_keyUserId);
  }

  String? getName() {
    return _prefs.getString(_keyName);
  }

  String? getEmail() {
    return _prefs.getString(_keyEmail);
  }

  String? getPhone() {
    return _prefs.getString(_keyPhone);
  }

  String? getAddress() {
    return _prefs.getString(_keyAddress);
  }

  String? getAvatar() {
    return _prefs.getString(_keyAvatar);
  }

  String? getRole() {
    return _prefs.getString(_keyRole);
  }
  
  String? getUserStatus() {
    return _prefs.getString(_keyStatus);
  }

  // String getTheme() {
  //   return _prefs.getString(_themeKey) ?? globalTheme;
  // }

  // Future<void> setTheme(String theme) async {
  //   await _prefs.setString(_themeKey, theme);
  // }

  // Locale getLanguage() {
  //   String storedLanguage = _prefs.getString(_languageKey.toString()) ?? globalLanguage.toString();
  //   List<String> languageParts = storedLanguage.split('_');
  //   return Locale(languageParts[0], languageParts.length > 1 ? languageParts[1] : '');
  // }

  // Future<void> setLanguage(Locale languageCode) async {
  //   await _prefs.setString(_languageKey.toString(), languageCode.toString());
  // }

  void logout() {
    _prefs.remove(_keyUserId);
    _prefs.remove(_keyName);
    _prefs.remove(_keyEmail);
    _prefs.remove(_keyPhone);
    _prefs.remove(_keyAddress);
    _prefs.remove(_keyAvatar);
    _prefs.remove(_keyRole);
    _prefs.remove(_keyStatus);
    setLoggedIn(false);
  }
}