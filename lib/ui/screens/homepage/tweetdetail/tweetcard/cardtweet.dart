import 'package:flutter/material.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/homepage/tweetdetail/tweetcard/cardtweetappbar.dart';
import 'package:twitter/ui/screens/homepage/tweetdetail/tweetcard/cardtweetbody.dart';
import 'cardtweetbottom.dart';

class CardTweet extends StatelessWidget {
  const CardTweet({Key? key, required this.tweetList, }) : super(key: key);

  final TweetWithProfile tweetList;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
          child: Column(
            children: [

              Padding(
                  padding: const EdgeInsets.only(top:10,bottom:10),
                  child: CardTweetAppbar( tweetList: tweetList,)
              ),
              CardTweetBody(tweetList: tweetList),
              CardTweetBottom(tweetList: tweetList, )
            ],
          ),
        )


    );
  }
}
