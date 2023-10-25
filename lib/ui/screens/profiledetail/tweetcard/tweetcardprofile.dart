import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter/model/tweetwithprofile.dart';

class TweetCard extends StatelessWidget {
  const TweetCard({Key? key, this.radius = 30, required this.tweet}) : super(key: key);
  final double radius;
  final TweetWithProfile? tweet;

  @override
  Widget build(BuildContext context) {
    final imagePath = tweet!.avatarPhotoUrl;

    Widget imageWidget;

    if (imagePath != null && imagePath.isNotEmpty) {
      final avatarUrl = "http://192.168.1.70:5169/Profile/$imagePath";

      imageWidget = Image.network(
        avatarUrl,
        fit: BoxFit.cover,
      );
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
