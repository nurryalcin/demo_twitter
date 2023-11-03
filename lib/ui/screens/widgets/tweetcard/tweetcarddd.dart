import 'package:flutter/material.dart';
import 'package:twitter/model/followusertweet.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/model/tweetwithparent.dart';
import 'package:twitter/ui/screens/widgets/tweetcard/tweetcardavatarprofile.dart';
import 'package:twitter/ui/screens/widgets/tweetcard/tweetcardbottom.dart';
import 'package:twitter/ui/screens/widgets/tweetcard/tweetcardcontent.dart';

class TweetCardd extends StatelessWidget {
  const TweetCardd({Key? key, required this.tweet});

  final dynamic tweet;

  @override
  Widget build(BuildContext context) {
    Widget tweetContentWidget;
    Widget tweetAvatar;

    if (tweet is TweetWithProfile) {
      tweetContentWidget = TweetCardContent(tweet: tweet! as TweetWithProfile);
      tweetAvatar=TweetCardAvatarProfile(tweet: tweet! as TweetWithProfile);
    } else if (tweet is TweetWithParent) {
      tweetContentWidget = TweetCardContent(tweet: tweet! as TweetWithParent);
      tweetAvatar=TweetCardAvatarProfile(tweet: tweet! as TweetWithParent);
    } else if (tweet is FollowUserTweet) {
      tweetContentWidget=TweetCardContent(tweet: tweet! as FollowUserTweet);
      tweetAvatar=TweetCardAvatarProfile(tweet: tweet! as FollowUserTweet);
    }
    else {
      tweetContentWidget = Text("Bilinmeyen tweet türü");
      tweetAvatar=Text("Bilinmeyen avatar türü");

    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tweetAvatar,
                Expanded(child: tweetContentWidget),

              ],
            ),
            TweetCardBottom(tweet: tweet,)


          ],
        ),
      ),
    );
  }
}
