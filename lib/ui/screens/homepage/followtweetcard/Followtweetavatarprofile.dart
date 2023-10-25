import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter/model/followusertweet.dart';

class FollowTweetAvatarProfile extends StatelessWidget{
  FollowTweetAvatarProfile({super.key, this.radius = 20, required this.followTweet,});

  final FollowUserTweet? followTweet;
  final double radius;


  @override
  Widget build(BuildContext context) {
    final imagePath=followTweet!.avatarPhotoUrl;
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