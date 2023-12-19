import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/widgets/tweetcard/tweetcardavatarprofile.dart';
import 'package:twitter/ui/screens/profiledetail/profiledetail/followbutton.dart';
import 'package:twitter/utils/provider.dart';


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
                margin:EdgeInsets.only(bottom: 60),
                width: 500,
                height: 100,
                color: Provider.of<UserProfileProvider>(context).iconColorlightBlue
              ),

              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Padding(
                     padding: const EdgeInsets.only(left: 15),
                     child: CircleAvatar(
                       backgroundColor: Provider.of<UserProfileProvider>(context).fullScreenTitleColor,
                       radius: 45,
                       child: TweetCardAvatarProfile(tweet: tweet,radius: 40),
                     ),
                   ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: FollowButton(userId: tweet!.userId),
                    )

                  ],
                ),
              ),
            ],
          ),
        ],

      );
    }
    return SizedBox();
  }
}
