import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/homepage/replydetailpage/replytweetlist.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/ui/screens/widgets/tweetcard/tweetcarddd.dart';
import 'package:twitter/utils/provider.dart';

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
              textColor: Provider.of<UserProfileProvider>(context).titleColor,
        ),),
        body: Column(
          children: [
            TweetCardd(tweet: tweet!),
            ReplyTweetList(parentTweetId: tweet!.id)
          ],
        ));
  }
}
