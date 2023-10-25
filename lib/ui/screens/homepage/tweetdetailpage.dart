import 'package:flutter/material.dart';
import 'package:twitter/model/followusertweet.dart';
import 'package:twitter/ui/screens/homepage/followtweetcard/followcardtweet.dart';
import 'package:twitter/ui/screens/homepage/tweetdetail/tweetcard/replytweetlist.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';

class TweetDetailPage extends StatelessWidget {
  TweetDetailPage({Key? key, this.followTweet, required this.tweetId});

  final FollowUserTweet? followTweet;
  int tweetId;

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            FollowCardTweet(followTweet: followTweet!),
            ReplyTweetList(
              parentTweetId: tweetId,
            ),
          ],
        ),
      ),
    );
  }
}
