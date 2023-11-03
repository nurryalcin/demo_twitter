import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter/model/followusertweet.dart';
import 'package:twitter/model/tweetwithparent.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/model/user.dart';

class TweetCardAvatarProfile extends StatelessWidget {
  const TweetCardAvatarProfile({
    super.key,
    this.radius = 20,
    this.tweet,
  });

  final dynamic tweet;
  final double radius;

  @override
  Widget build(BuildContext context) {
    String? avatarProfile;
    if (tweet is TweetWithProfile) {
      final TweetWithProfile tweetWithProfile = tweet;
      avatarProfile = tweetWithProfile.avatarPhotoUrl!;
    } else if (tweet is FollowUserTweet) {
      final FollowUserTweet followTweet = tweet;
      avatarProfile = followTweet.avatarPhotoUrl!;
    } else if (tweet is TweetWithParent) {
      final TweetWithParent user = tweet;
      avatarProfile = user.parentTweetImageUrl!;
    } else if (tweet is User) {
      final User user = tweet;
      avatarProfile = user.avatarPhotoUrl!;
    }
    Widget imageWidget;

    if (avatarProfile != null ) {
      if (avatarProfile.isNotEmpty) {
        imageWidget = Image.network(
          "http://192.168.1.70:5169/Profile/$avatarProfile",
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
