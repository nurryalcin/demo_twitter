import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:twitter/model/user.dart';
import 'package:twitter/utils/provider.dart';

class UserService {
  final String baseUrl = 'http://192.168.1.70:5169';

  Future<User?> login(String email, String password) async {
    var response = await http.post(Uri.parse("${baseUrl}/user/login"),
        body: json.encode({"email": email, "password": password}),
        headers: {"content-type": "application/json"});
    if (response.statusCode != 200) return null;
    print(response.body);
    return User.fromJson(jsonDecode(response.body));
  }

  Future<User?> emailLogin(String email) async {
    var response = await http.post(Uri.parse("${baseUrl}/user/emailLogin"),
        body: json.encode({"email": email}),
        headers: {"content-type": "application/json"});
    if (response.statusCode != 200) return null;
    return User.fromJson(jsonDecode(response.body));
  }

  Future<User?> register(String username, String fullname,
      String? avatarPhotoUrl, String email, String password) async {
    var data = {
      "username": username,
      "fullname": fullname,
      "avatarPhotoUrl": avatarPhotoUrl,
      "email": email,
      "password": password,
    };

    try {
      print(Uri.parse("${baseUrl}/user/register"));
      print('Gönderilen JSON Verileri: ${json.encode(data)}');
      var response = await http.post(
        Uri.parse("${baseUrl}/user/register"),
        body: json.encode(data),
        headers: {"content-type": "application/json"},
      );
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

  Future<List<User>?> getUsername(String username) async {
    var response =
        await http.get(Uri.parse("${baseUrl}/user/getUser?username=$username"));

    if (response.statusCode != 200) {
      return null;
    }

    List<dynamic> userJsonList = jsonDecode(response.body);
    List<User> userList =
        userJsonList.map((json) => User.fromJson(json)).toList();

    return userList;
  }

  Future<void> updateProfilePicture(int userId, File imageFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl}/user/$userId/update-picture'),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
      ),
    );

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        final userProvider = UserProfileProvider();
        userProvider.updateImage(responseBody );

      } else {
        print('Hata: ${response.statusCode}');
      }
    } catch (e) {
      print('Ağ hatası: $e');
    }
  }
}
