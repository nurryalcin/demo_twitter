import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static Future<SharedPreferences> get _instance async =>
      await SharedPreferences.getInstance();

  static const String _sessionKey = 'user_session';

  bool _isLoggedIn = false;
  String _username = "";
  int _userId=0;
  String _fullName = "";
  String _image = "";
  String _createdAt="";
  String _email="";
  String get image => _image;
  String get createdAt=> _createdAt;

  Future<void> logIn(String username, int userId, String fullName, String image,String createdAt,String email) async {
    final SharedPreferences prefs = await _instance;
    var user = jsonEncode({
      "userId": userId,
      "username": username,
      "fullName": fullName,
      "image": image,
      "createdAt":createdAt,
      "email": email});
    await prefs.setString(_sessionKey, user);

    _isLoggedIn = true;
    _userId = userId;
    _username = username;
    _fullName = fullName;
    _image = image;
    _createdAt=createdAt;
    _email=email;
  }

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await _instance;
    var userMap =  prefs.getString(_sessionKey);

    if (userMap == null || userMap.isEmpty) {
      _isLoggedIn = false;
      return false;
    }
    var user = jsonDecode(userMap);
    _isLoggedIn = true;
    _userId = user["userId"];
    _username = user["username"];
    _fullName = user["fullName"];
    _image = user["image"];
    _createdAt=user["createdAt"];
    _email=user["email"];

    return true;
  }

  Future<void> logOut() async {
    final SharedPreferences prefs = await _instance;
    await prefs.remove(_sessionKey);
    _isLoggedIn = false;
  }

  String? getFullname(){
    return _fullName;
  }
  String? getUsername(){
    return _username;
  }
  String? getDate(){
    return _createdAt;
  }

  int getUserId() {
    return _userId;
  }

  String? getEmail(){
    return _email;
  }

  Future<void> saveProfileImagePath(String imagePath) async {
    try {
      final SharedPreferences prefs = await _instance;
      var userMap = prefs.getString(_sessionKey);

      if (userMap != null && userMap.isNotEmpty) {
        var user = jsonDecode(userMap);
        user["image"] = imagePath;
        await prefs.setString(_sessionKey, jsonEncode(user));
        _image = imagePath;
      }
    } catch (e) {
      print('Error saving profile image path: $e');
      rethrow;
    }
  }

  Future <void> selectedImagePath(String selectedImagePath) async {

  }


}
