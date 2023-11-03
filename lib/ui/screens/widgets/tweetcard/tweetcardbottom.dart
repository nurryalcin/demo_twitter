import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:twitter/ui/screens/homepage/followreplypage.dart';
import 'package:twitter/utils/provider.dart';

class TweetCardBottom extends StatefulWidget {
  const TweetCardBottom({super.key, this.tweet});

  final dynamic tweet;

  @override
  State<StatefulWidget> createState() => _TweetCardBottomState();
}

class _TweetCardBottomState extends State<TweetCardBottom> {
  int? selectedTweetId;

  final List<IconData> icons = [
    Icons.mode_comment_outlined,
    Icons.repeat,
    Icons.favorite_border,
    Icons.graphic_eq,
    Icons.share,
  ];

  void _shareTweet(dynamic tweet) {
    if (tweet != null) {
      final tweetJson = tweet.toJson();
      final tweetString = json.encode(tweetJson);

      Share.share(
        tweetString,
      );
    }
  }


  void _onCardTapped(BuildContext context) {
    if (widget.tweet != null && widget.tweet?.id != null) {
      setState(() {
        selectedTweetId = widget.tweet!.id;
      });

      final userProvider =
          Provider.of<UserProfileProvider>(context, listen: false);
      userProvider.selectedTweet(selectedTweetId!);
      print('selectedTweetId: $selectedTweetId');
    } else {
      print('tweet veya tweet id null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var iconData in icons)
          IconButton(
            onPressed: () {
              if (iconData == Icons.mode_comment_outlined) {
                _onCardTapped(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return FollowReplyPage(
                          followTweet: widget.tweet,
                          selectedTweetId: selectedTweetId!);
                    },
                  ),
                );
              }
              if (iconData == Icons.share) {
                _onCardTapped(context);
                _shareTweet(widget.tweet);
              }
            },
            icon: Icon(iconData),
          ),
      ],
    );
  }
}
