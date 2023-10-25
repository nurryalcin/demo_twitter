import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/profiledetail/tweetcard/tweetcardprofile.dart';
import 'package:twitter/ui/screens/profiledetail/tweetcard/tweetcardcontent.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/profiledetail/tweetcard/tweetcartbottom.dart';

class DetailProfileTweet extends StatelessWidget {
  const DetailProfileTweet({
    Key? key,
    required this.tweet,
  }) : super(key: key);
  final TweetWithProfile tweet;


  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                TweetCard(tweet: tweet, radius: 20),
                Expanded(
                    child: TweetCardContent(
                  tweet: tweet,
                )),
              ])
            ],
          ),
        ),
        TweetCardBottom(tweet: tweet)
      ],
    ));
  }
}
