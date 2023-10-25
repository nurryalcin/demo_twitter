import 'package:flutter/material.dart';
import 'package:twitter/model/tweetwithparent.dart';
import 'package:twitter/ui/screens/profiledetail/mydetailprofile/replywithtweetcard/replycardappbar.dart';
import 'package:twitter/ui/screens/profiledetail/mydetailprofile/replywithtweetcard/replycardbody.dart';

class ReplyCard extends StatelessWidget{
  const ReplyCard({super.key, required this.tweet});

  final TweetWithParent tweet;



  @override
  Widget build(BuildContext context) {
    return  Card(
      child: (
      Column(
        children: [
          ReplyCardAppbar(tweet:tweet ,),
          ReplyCardBody()

        ],
      )
      )

    );
  }

}