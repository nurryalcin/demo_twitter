import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter/model/followusertweet.dart';
import 'package:twitter/model/tweetwithprofile.dart';

class CardTweetAvatar extends StatelessWidget{
  CardTweetAvatar({super.key, this.radius = 30, required this.tweetList,});

  final TweetWithProfile? tweetList;
  final double radius;


  @override
  Widget build(BuildContext context) {
    final imagePath=tweetList!.avatarPhotoUrl;
    Widget imageWidget;

    if (imagePath != null) {
      if (imagePath.isNotEmpty) {
        imageWidget = Image.network(
          "http://192.168.1.70:5169/Profile/$imagePath",
          fit: BoxFit.cover,
        );
      } else {
        imageWidget = SvgPicture.asset("assets/images/default_profile.svg");
      }
    } else {
      imageWidget = SvgPicture.asset("assets/images/default_profile.svg");
    }

    return ClipOval(
      child: SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: imageWidget,
      ),
    );
  }

}