import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/ui/screens/profiledetail/profiledetail/profiletweetdetailpage.dart';
import 'package:twitter/ui/screens/profiledetail/tweetcard/tweetcardprofile.dart';
import 'package:twitter/ui/screens/profiledetail/tweetcard/tweetcardcontent.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/profiledetail/tweetcard/tweetcartbottom.dart';
import 'package:twitter/utils/provider.dart';

class TweetCard extends StatelessWidget {
  const TweetCard({
    Key? key,
    required this.tweet,
  }) : super(key: key);
  final TweetWithProfile tweet;

  void _onCardTapped(BuildContext context) {
    int? userId = tweet.userId;
    final userProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    userProvider.selectedProfileuserId(userId);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const ProfileTweetDetailPage(
                index: 0,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.only(
        top: 8,
        left: 8,
      ),
      child: Column(
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            InkWell(
              onTap: () => _onCardTapped(context),
              child: TweetCardProfile(tweet: tweet, radius: 20),
            ),
            Expanded(
                child: TweetCardContent(
              tweet: tweet,
            )),
          ]),
          TweetCardBottom(tweet: tweet)
        ],
      ),
    ));
  }
}
