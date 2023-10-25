import 'package:flutter/material.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import '../../../../utils/class.dart';
import '../../widgets/textwidget.dart';


class ProfileUsername extends StatelessWidget{
  const ProfileUsername({super.key, this.tweet});

  final TweetWithProfile? tweet;



  @override
  Widget build(BuildContext context) {
    if (tweet != null) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: TextWidget(
                titleText1: '@${tweet!.username} ',
                fontWeight: FontWeight.bold,
                textSize: 25,
                textColor: CardColor.userColor),
          ),

        ],
      );
    }
    else {
      return SizedBox();
    }
  }
}