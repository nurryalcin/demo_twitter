import 'package:flutter/material.dart';
import 'package:twitter/model/followusertweet.dart';
import 'package:twitter/ui/screens/homepage/followtweetcard/followcardtweet.dart';
import 'package:twitter/ui/screens/homepage/tweetdetailpage.dart';
import 'package:twitter/utils/sharedpreferences.dart';
import 'package:twitter/api_service/tweet_service.dart';

class FollowTweetList extends StatefulWidget {
  const FollowTweetList({super.key});

  @override
  State<StatefulWidget> createState() => _FollowTweetListState();
}

class _FollowTweetListState extends State<FollowTweetList> {
  List<FollowUserTweet> followTweets = [];
  int? userId;
  int? tweetId;




  @override
  void initState() {
    super.initState();
    followUserListTweet();

  }

  Future<void> followUserListTweet() async {
    UserPreferences userPreferences = UserPreferences();
    bool isLoggedIn = await userPreferences.isLoggedIn();
    if (isLoggedIn) {
      userId = userPreferences.getUserId();
    }

    if (userId != null) {
      final List<FollowUserTweet> getFollowUserTweets = await TweetService().getFollowUserTweets(userId!);

      setState(() {
        followTweets = getFollowUserTweets ?? [];
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final followTweet in followTweets)
          GestureDetector(
              onTap: () =>
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) =>
                      TweetDetailPage(
                        followTweet: followTweet, tweetId: followTweet.id,),)),
              child: FollowCardTweet(followTweet: followTweet))
      ],
    );
  }
}
