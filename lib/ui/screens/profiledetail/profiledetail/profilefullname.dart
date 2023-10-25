import 'package:flutter/material.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';

class ProfileFullname extends StatelessWidget {
  const ProfileFullname({super.key, this.tweet});

  final TweetWithProfile? tweet;

  @override
  Widget build(BuildContext context) {
    if (tweet != null) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20,top:20),
            child: TextWidget(
              titleText1: tweet!.fullname,
              fontWeight: FontWeight.bold,
              textSize: 25,
              textColor: CardColor.titleColor,
            ),
          ),
        ],
      );
    }
    return SizedBox();
  }
}
