import 'package:flutter/material.dart';
import 'package:twitter/model/tweetwithparent.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/widgets/tweetcard/tweetcarddd.dart';

class MyProfileDetailTabbar extends StatelessWidget {
  const MyProfileDetailTabbar(
      {Key? key, required this.tweets, required this.tweetList})
      : super(key: key);

  final List<TweetWithProfile> tweets;
  final List<TweetWithParent> tweetList;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          TabBar(
            tabs: [
              Tab(text: "Sekme 1"),
              Tab(text: "Sekme 2"),
            ],
          ),
         


        ],
      ),
    );
  }
}
