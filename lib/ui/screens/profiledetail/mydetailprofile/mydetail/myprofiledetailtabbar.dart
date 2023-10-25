import 'package:flutter/material.dart';
import 'package:twitter/model/tweetwithparent.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/profiledetail/mydetailprofile/replywithtweetcard/replycard.dart';
import 'package:twitter/ui/screens/profiledetail/tweetcard/tweetcard.dart';

class MyProfileDetailTabbar extends StatelessWidget {
  const MyProfileDetailTabbar({Key? key, required this.tweets, required this.tweetList});

  final List<TweetWithProfile> tweets;
  final List <TweetWithParent> tweetList;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          Container(
            height: 500,
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: const TabBar(
                    indicator: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.blue,
                          width: 5.0,
                        ),
                      ),
                    ),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: [
                      Tab(text: 'Gönderiler'),
                      Tab(text: 'Yanıtlar'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ListView(
                        children: [
                          for (final tweet in tweets!)
                            DetailProfileTweet(tweet: tweet),
                        ],

                      ),
                      ListView(
                        children: [
                          for (final replyTweet in tweetList!)
                            ReplyCard(tweet: replyTweet,)


                        ],
                      )

                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
