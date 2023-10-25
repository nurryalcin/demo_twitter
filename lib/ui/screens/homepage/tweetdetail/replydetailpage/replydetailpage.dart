import 'package:flutter/material.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/homepage/tweetdetail/tweetcard/cardtweet.dart';
import 'package:twitter/ui/screens/homepage/tweetdetail/tweetcard/replytweetlist.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';

class ReplyDetailPage extends StatelessWidget {
  ReplyDetailPage({super.key, this.tweet});

  final TweetWithProfile? tweet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextWidget(
              titleText1: 'Post',
              fontWeight: FontWeight.bold,
              textSize: 25,
              textColor: CardColor.titleColor),
        ),
        body: Column(
          children: [
            CardTweet(tweetList: tweet!),
            ReplyTweetList(parentTweetId: tweet!.id)
          ],
        ));
  }
}
