import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:twitter/ui/screens/widgets/picturewidget.dart';
import 'package:twitter/ui/screens/widgets/profilewidget.dart';
import 'package:twitter/ui/screens/widgets/retweetwidget.dart';
import 'package:twitter/utils/class.dart';
import 'datetimewidget.dart';
import 'dart:convert';

class Tweet {
  String? image;
  String text;
  String avatarPictureUri;
  String userName;
  String userUniqueName;
  DateTime twitDate;
  int likeCount;
  int viewCount;
  int retweetsCount;
  int quotesCount;
  int bookmarksCount;

  Tweet({
    this.image,
    required this.text,
    required this.avatarPictureUri,
    required this.userName,
    required this.userUniqueName,
    required this.twitDate,
    required this.likeCount,
    required this.viewCount,
    required this.retweetsCount,
    required this.quotesCount,
    required this.bookmarksCount,
  });

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "avatarPictureUri": avatarPictureUri,
      "userName": userName,
      "userUniqueName": userUniqueName,
      "likeCount": likeCount,
      "viewCount": viewCount,
      "retweetsCount": retweetsCount,
      "quotesCount": quotesCount,
      "bookmarksCount": bookmarksCount,
      "image": image,
      "twitDate": twitDate.toIso8601String(),
    };
  }

  Future<Tweet?> fetchUserDataFromJson() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/login.json';
      final file = File(filePath);

      if (!file.existsSync()) {
        print("Dosya bulunamadı.");
        return null;
      }

      String jsonString = await file.readAsString();
      Map<String, dynamic> userData = json.decode(jsonString);

      String username = userData['name'];
      String useruniquename = userData['userUniqueName'];
      String avatarpictureuri = userData['ProfileImage'];

      Tweet userTweet = Tweet(
        text: "",
        avatarPictureUri: avatarpictureuri,
        userName: username,
        userUniqueName: useruniquename,
        twitDate: DateTime.now(),
        likeCount: 0,
        viewCount: 0,
        retweetsCount: 0,
        quotesCount: 0,
        bookmarksCount: 0,
      );

      return userTweet;
    } catch (e) {
      print("Veri çekme hatası: $e");
      return null;
    }
  }


  Future<List<Tweet>> fetchTweetsDataFromJson() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/database.json');

    if (!file.existsSync()) {
      return [];
    }

    String jsonString = await file.readAsString();
    List<Map<String, dynamic>> jsonData =
        List<Map<String, dynamic>>.from(json.decode(jsonString));
    List<Tweet> tweets = jsonData.map((data) => Tweet.fromJson(data)).toList();

    return tweets;
  }

  factory Tweet.fromJson(Map<String, dynamic> json) {
    Random _random = Random();

    int _generateRandomCount() {
      return _random.nextInt(1000000000);
    }

    return Tweet(
      text: json['text'],
      avatarPictureUri: json['profileImage'],
      userName: json['name'],
      userUniqueName: json['userUniqueName'],
      likeCount: _generateRandomCount(),
      viewCount: _generateRandomCount(),
      retweetsCount: _generateRandomCount(),
      quotesCount: _generateRandomCount(),
      bookmarksCount: _generateRandomCount(),
      image: json['image'],
      twitDate: DateTime.parse(json['twitDate']),
    );
  }
}

class TweetWidget extends StatelessWidget {
  final Tweet tweet;

  const TweetWidget({required this.tweet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfileWidget(
              titleText: tweet.userName,
              titleTextColor: CardColor.titleColor,
              usernameText: tweet.userUniqueName,
              usernameTextColor: CardColor.userColor,
              avatarImage: tweet.avatarPictureUri,
              menuColor: CardColor.titleColor),
          const SizedBox(height: 20),
          Text(tweet.text),
          const SizedBox(height: 8),
          if (tweet.image?.isNotEmpty ?? false)
            PictureWidget(
              imagePath: tweet.image!,
              titleText: tweet.userName,
              avatar: tweet.avatarPictureUri,
              usernameText: tweet.userUniqueName,
              viewsCount: tweet.viewCount,
              retweetCount: tweet.viewCount,
              likeCount: tweet.likeCount,
              quotesCount: tweet.quotesCount,
              bookmarksCount: tweet.bookmarksCount,
              dateCount: tweet.twitDate,
            ),
          const SizedBox(height: 8),
          DateTimeWidget(
              views: tweet.viewCount,
              dateTime: tweet.twitDate,
              numberColor: CardColor.titleColor),
          RetweetWidget(
              titleTextColor: CardColor.titleColor,
              numberTextColor: CardColor.titleColor,
              retweetsCount: tweet.retweetsCount,
              quotesCount: tweet.quotesCount,
              likesCount: tweet.likeCount,
              bookmarksCount: tweet.bookmarksCount)
        ],
      ),
    );
  }
}
