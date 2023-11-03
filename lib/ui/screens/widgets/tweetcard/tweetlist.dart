import 'package:flutter/material.dart';
import 'package:twitter/model/followusertweet.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/homepage/tweetdetailpage.dart';
import 'package:twitter/ui/screens/widgets/tweetcard/tweetcarddd.dart';
import 'package:twitter/utils/sharedpreferences.dart';
import 'package:twitter/api_service/tweet_service.dart';

class TweetList extends StatefulWidget {
  TweetList({Key? key, this.parentTweetId});

  int? parentTweetId;

  @override
  State<StatefulWidget> createState() => _TweetListState();
}

class _TweetListState extends State<TweetList> {
  List<dynamic> tweetList = [];
  int? userId;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    UserPreferences userPreferences = UserPreferences();
    bool isLoggedIn = await userPreferences.isLoggedIn();

    if (isLoggedIn) {
      userId = userPreferences.getUserId();
    }

    if (userId != null) {
      followUserListTweet();
    } else {
      replyuserlist();
    }
  }

  Future<void> replyuserlist() async {
    final List<TweetWithProfile> getFollowUserTweets =
    await TweetService().getTweetsByParentTweetId(widget.parentTweetId!);
    setState(() {
      tweetList = getFollowUserTweets;
    });
  }

  Future<void> followUserListTweet() async {
    final List<FollowUserTweet> getFollowUserTweets =
    await TweetService().getFollowUserTweets(userId!);

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
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TweetDetailPage(
                  followTweet: tweet is FollowUserTweet ? tweet : null,
                  tweetId: tweet! is FollowUserTweet ? tweet.id : null,
                ),
              ),
            ),
            child: TweetCardd(tweet: tweet),
          ),
      ],
    );
  }
}
