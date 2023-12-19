import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/model/followusertweet.dart';
import 'package:twitter/ui/screens/homepage/replydetailpage/replytweetlist.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/ui/screens/widgets/tweetcard/tweetcarddd.dart';
import 'package:twitter/utils/provider.dart';

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
            textColor:Provider.of<UserProfileProvider>(context).titleColor,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TweetCardd(tweet: followTweet),
            ReplyTweetList(
              parentTweetId: tweetId,
            ),
          ],
        ),
      ),
    );
  }
}
