import 'dart:convert';
import 'package:twitter/model/followuser.dart';
import 'package:http/http.dart' as http;
import 'package:twitter/model/user.dart';

class FollowUserService {
  final String baseUrl = 'http://192.168.1.70:5169';

  Future<FollowUser> followUser(int userId, int followedUserId) async {
    var data = { "userId": userId, "followedUserId": followedUserId};
    final response = await http.post(
      Uri.parse('$baseUrl/follow/followuser'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return FollowUser.fromJson(responseData);
    } else {
      print(response.body);
      throw Exception('Takip etme işlemi başarısız: ${response.statusCode}');
    }
  }

  Future<List<FollowUser>> getFollowingUser(int userId, int followedUserId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/follow/getfolloweduser?userId=$userId&followedUserId=$followedUserId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);

        List<FollowUser> followedUsers = [];
        for (var data in responseData) {
          print(responseData);
          followedUsers.add(FollowUser.fromJson(data));
        }

        return followedUsers;
      } else {
        throw Exception('Takip edilen kullanıcılar alınamadı: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Takip edilen kullanıcılar getirilirken bir hata oluştu: $e');
    }
  }

  Future<bool> isUserFollowed(int userId, int followedUserId) async {
    try {
      final followedUsers = await getFollowingUser(userId, followedUserId);
      return followedUsers.any((user) => user.followedUserId == followedUserId);
    } catch (e) {
      throw Exception('Takip edilenleri kontrol ederken bir hata oluştu: $e');
    }
  }

  Future<List<User>> getFollowingUsers(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/follow/getfollowedusers/$userId'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<User> followedUsers = data.map((item) => User.fromJson(item)).toList();
        return followedUsers;
      } else {
        throw Exception('Takip edilen kullanıcılar yüklenemedi');
      }
    } catch (e) {
      throw Exception('Bir hata oluştu: $e');
    }
  }

  Future<List<User>> getFollowerUsers(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/follow/getfollowingusers/$userId'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<User> followingUsers = data.map((item) => User.fromJson(item)).toList();
        return followingUsers;
      } else {
        throw Exception('Takip edilen kullanıcılar yüklenemedi');
      }
    } catch (e) {
      throw Exception('Bir hata oluştu: $e');
    }
  }
}






