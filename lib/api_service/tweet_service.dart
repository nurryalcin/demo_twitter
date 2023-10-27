import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:twitter/model/followusertweet.dart';
import 'package:twitter/model/tweet.dart';
import 'package:twitter/model/tweetwithparent.dart';
import 'package:twitter/model/tweetwithprofile.dart';

class TweetService {

  final String baseUrl = 'http://192.168.1.70:5169';

  Future<Tweet?> sendTweet(String? message, File? imageUrl, int userId) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/tweet/sendtweet'),
      );

      request.fields['message'] = message!;
      request.fields['userId'] = userId.toString();
      if (imageUrl != null) {
        String fileName = imageUrl.path
            .split('/')
            .last;
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            imageUrl.path,
            filename: fileName,
          ),
        );
      }


      final response = await request.send();

      if (response.statusCode == 200) {
        String responseText = await response.stream.bytesToString();

        final Map<String, dynamic> responseData = json.decode(responseText);
        final tweetId = responseData!['tweetId'] as int;

        if (tweetId != null) {
          return Tweet.fromJson(responseData);
        } else {
          print('tweetId null olarak döndü.');
        }
      } else {
        print('Tweet gönderme başarısız: ${response.statusCode}');
      }
    } catch (error) {
      print('Tweet gönderme hatası: $error');
    }
    return null;
  }


  Future<List<FollowUserTweet>> getFollowUserTweets(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/tweet/gettweetfollowuser?userId=$userId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        if (responseData != null) {
          return responseData.map((data) => FollowUserTweet.fromJson(data)).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('HTTP isteği başarısız: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Bir hata oluştu: $e');
    }
  }



  Future<List<TweetWithProfile>> getTweetUser(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/tweet/gettweetuser?userId=$userId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        return responseData.map((data) => TweetWithProfile.fromJson(data))
            .toList();
      } else {
        throw Exception('HTTP isteği başarısız: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Bir hata oluştu: $e');
    }
  }


  Future<Tweet?> replyTweet(String? message, File? imageUrl, int userId,
      int? parentTweetId) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/tweet/replytweet'),
      );

      request.fields['message'] = message!;
      request.fields['userId'] = userId.toString();
      if (parentTweetId != null) {
        request.fields['parentTweetId'] = parentTweetId.toString();
      }
      if (imageUrl != null) {
        String fileName = imageUrl.path
            .split('/')
            .last;
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            imageUrl.path,
            filename: fileName,
          ),
        );
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        String responseText = await response.stream.bytesToString();
        final Map<String, dynamic> responseData = json.decode(responseText);
        print(responseData);
        return Tweet.fromJson(responseData);
      } else {
        print('Tweet gönderme başarısız: ${response.statusCode}');
      }
    } catch (error) {
      print('Tweet gönderme hatası: $error');
    }
    return null;
  }

  Future<List<TweetWithProfile>> getTweetsByParentTweetId(
      int parentTweetId) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/tweet/GetTweetsByParentTweetId?parentTweetId=$parentTweetId'));

    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      List<TweetWithProfile> tweets = jsonResponse
          .map((tweet) => TweetWithProfile.fromJson(tweet))
          .toList();
      return tweets;
    } else {
      throw Exception('Tweetler yüklenemedi');
    }
  }

  Future<List<TweetWithParent>> getUserRepliedTweets(int userId) async {
    final response = await http.get(
        Uri.parse('$baseUrl/tweet/userrepliedtweets/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => TweetWithParent.fromJson(data))
          .toList();
    } else {
      throw Exception('Yanıtlanan tweet\'ler yüklenemedi');
    }
  }

  Future<void> deleteTweet(int tweetId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/tweet/deletetweet/$tweetId'),
      );

      if (response.statusCode != 200) {
        throw Exception('Tweet silinemedi: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Tweet silinemedi: $e');
    }
  }
}
















