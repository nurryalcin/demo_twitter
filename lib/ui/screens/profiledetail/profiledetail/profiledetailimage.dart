import 'package:flutter/material.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/profiledetail/tweetcard/tweetcardprofile.dart';
import 'package:twitter/utils/class.dart';
import 'followbutton.dart';


class ProfileDetailImage extends StatelessWidget {
  const ProfileDetailImage({super.key, this.tweet});

  final TweetWithProfile? tweet;

  @override
  Widget build(BuildContext context) {
    if(tweet != null) {
      return Column(
        children: [
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 80, top: 10),
                width: 500,
                height: 150,
                color: Colors.grey[300],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 100,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: CardColor.fullScreenTitleColor,
                    ),
                    height: 100,
                    width: 100,
                    child: TweetCard(tweet: tweet,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: FollowButton(userId: tweet!.userId),
                  )

                ],
              ),
            ],
          ),
        ],

      );
    }
    return SizedBox();
  }
}
