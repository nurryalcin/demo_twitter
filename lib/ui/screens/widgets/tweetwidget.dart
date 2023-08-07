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

  static int userUniqueNameIndex = 0;
  static int userNameIndex = 0;
  static int avatarpictureIndex = 0;

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

    final List<String> avatarPictureUri = [
      'https://pbs.twimg.com/profile_images/1640331374400774145/c1oF1C6M_400x400.jpg',
      'https://pbs.twimg.com/profile_images/1683325380441128960/yRsRRjGO_400x400.jpg',
      'https://pbs.twimg.com/profile_images/1622557245950107648/jq2sqW7i_400x400.jpg',
    ];

    final List<String> userName = ['Fenerbahçe SK', 'Elon Musk', 'BBO Sports'];

    final List<String> userUniqueName = [
      '@Fenerbahce',
      '@elonmusk',
      '@bbosports'
    ];

    return Tweet(
      text: json['text'],
      avatarPictureUri:
          avatarPictureUri[avatarpictureIndex++ % avatarPictureUri.length],
      userName: userName[userNameIndex++ % userName.length],
      userUniqueName:
          userUniqueName[userUniqueNameIndex++ % userUniqueName.length],
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
