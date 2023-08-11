import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:twitter/model/user.dart';


class UserService {
  final String baseUrl = 'http://192.168.1.70:5169';

  Future<User?> login(String email, String password) async {
    var response = await http.post(Uri.parse("${baseUrl}/user/login"),
        body: json.encode({"email": email, "password": password}),
        headers: {"content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode != 200) return null;
    print(response.body);
    return User.fromJson(jsonDecode(response.body));
  }

  Future<User?> register(String email, String username, String fullname, String? avatarPhotoUrl, String password) async {
    try {
      print( Uri.parse("${baseUrl}/user/register"));
      var response = await http.post(
        Uri.parse("${baseUrl}/user/register"),
        body: json.encode({

          "username": username,
          "fullname": fullname,
          "avatarPhotoUrl": avatarPhotoUrl,
          "email": email,
          "password": password,

        }),
        headers: {"content-type": "application/json"},
      );

      print('API Yanıtı Kodu: ${response.statusCode}');
      print('API Yanıtı Gövdesi: ${response.body}');

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print('Hata: $e');
      return null;
    }
  }
}

