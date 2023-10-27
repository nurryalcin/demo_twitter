import 'package:flutter/material.dart';
import 'package:twitter/model/tweetwithparent.dart';
import 'package:twitter/ui/screens/profiledetail/mydetailprofile/replywithtweetcard/replycardbottom.dart';
import 'package:twitter/ui/screens/profiledetail/mydetailprofile/replywithtweetcard/replycardcontent.dart';
import 'package:twitter/ui/screens/widgets/avatarprofile.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({super.key, required this.tweet});

  final TweetWithParent tweet;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 8,left:8),
          child: (
              Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AvatarProfile(radius: 20),
              Expanded(child: ReplyCardContent(tweet: tweet)),
            ],
          ),
        ReplyCardBottom(tweet: tweet)
      ],
    )),
        ));
  }
}
