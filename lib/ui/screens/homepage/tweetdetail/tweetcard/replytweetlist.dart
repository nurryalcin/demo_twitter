import 'package:flutter/material.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/homepage/tweetdetail/tweetcard/cardtweet.dart';
import 'package:twitter/api_service/tweet_service.dart';
import 'package:twitter/ui/screens/homepage/tweetdetail/replydetailpage/replydetailpage.dart';

class ReplyTweetList extends StatefulWidget {
  ReplyTweetList({super.key,required this.parentTweetId});
  int parentTweetId;

  @override
  State<StatefulWidget> createState() => _ReplyTweetListState();
}

class _ReplyTweetListState extends State<ReplyTweetList> {
  List<TweetWithProfile> tweetList = [];

  @override
  void initState() {
    super.initState();
    followUserListTweet();
  }

  Future<void> followUserListTweet() async {
    final List<TweetWithProfile> getFollowUserTweets =
    await TweetService().getTweetsByParentTweetId(widget.parentTweetId!);
    setState(() {
      tweetList = getFollowUserTweets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final tweet in tweetList)
          GestureDetector(
            onTap: () =>
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ReplyDetailPage(tweet: tweet,))),
            child: CardTweet(tweetList: tweet),
          ),
      ],
    );
  }
}
