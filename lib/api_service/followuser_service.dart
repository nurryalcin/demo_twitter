import 'dart:convert';

import 'package:twitter/model/followuser.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

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

  Future<List<FollowUser>> getFollowedUser(int userId, int followedUserId) async {
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
        throw Exception('Failed to get followed users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching followed users: $e');
    }
  }

  Future<bool> isUserFollowed(int userId, int followedUserId) async {
    try {
      final followedUsers = await getFollowedUser(userId, followedUserId);
      return followedUsers.any((user) => user.followedUserId == followedUserId);
    } catch (e) {
      throw Exception('Takip edilenleri kontrol ederken bir hata oluştu: $e');
    }
  }

  Future<List<User>> getFollowedUsers(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/follow/getfollowedusers/$userId'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<User> followedUsers = data.map((item) => User.fromJson(item)).toList();
        return followedUsers;
      } else {
        throw Exception('Failed to load followed users');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<User>> getFollowingUsers(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/follow/getfollowingusers/$userId'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<User> followingUsers = data.map((item) => User.fromJson(item)).toList();
        return followingUsers;
      } else {
        throw Exception('Failed to load following users');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}






