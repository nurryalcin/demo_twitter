import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:twitter/api_service/tweet_service.dart';
import 'package:twitter/model/followusertweet.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/provider.dart';
import 'package:twitter/utils/sharedpreferences.dart';

class TweetCardContent extends StatelessWidget {
  const TweetCardContent({Key? key, this.tweet});

  final dynamic tweet;

  void deletetweet() async {
    final userPreferences = UserPreferences();
    bool isLoggedIn = await userPreferences.isLoggedIn();
    if (isLoggedIn) {
      if (tweet is TweetWithProfile) {
        final TweetWithProfile tweetWithProfile = tweet;
        await TweetService().deleteTweet(tweetWithProfile.id);
      } else if (tweet is FollowUserTweet) {
        final FollowUserTweet followTweet = tweet;
        await TweetService().deleteTweet(followTweet.id);
      }
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        if (tweet is TweetWithProfile) {
          return Container(
          color: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(80),
                topRight: Radius.circular(80),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildListTile(context, Icons.pin_drop_outlined, 'Pin to profile', () {
                  Navigator.pop(context);
                }),
                _buildListTile(context, Icons.delete_outline, 'Delete post', deletetweet),
                _buildListTile(context, Icons.mode_comment_outlined, 'Change who can reply', () {
                  Navigator.pop(context);
                }),
                _buildListTile(context, Icons.mode_edit_outline_outlined, 'Edit with Premium', () {
                  Navigator.pop(context);
                }),
              ],
            ),
          ),
        );
        }
        return SizedBox();
      },
    );
  }
  ListTile _buildListTile(BuildContext context, IconData leadingIcon, String title, Function onTap) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(title),
      onTap: () {
        onTap();
      },
    );
  }
  String formatTweetDate(DateTime createdAt) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(createdAt);

    if (difference.inDays >= 365) {
      return DateFormat('MM.dd.yy').format(createdAt);
    } else if (difference.inDays >= 7) {
      String day = DateFormat('dd').format(createdAt);
      String month = DateFormat('MMMM').format(createdAt);
      if (month.length > 3) {
        month = month.substring(0, 3);
      }
      return '$day $month';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays}d';
    }
    return '${difference.inHours}h ';
  }

  @override
  Widget build(BuildContext context) {
    String username = '';
    String fullname = '';
    DateTime createdAt = DateTime.now();
    String? tweetMessage = '';
    String? tweetImageUrl = '';

    if (tweet is TweetWithProfile) {
      final TweetWithProfile tweetWithProfile = tweet;
      username = tweetWithProfile.username;
      fullname = tweetWithProfile.fullname;
      createdAt = DateTime.parse(tweetWithProfile.createdAt);
      tweetMessage = tweetWithProfile.message;
      tweetImageUrl = tweetWithProfile.imageUrl;
    } else if (tweet is FollowUserTweet) {
      final FollowUserTweet followTweet = tweet;
      username = followTweet.username;
      fullname = followTweet.fullname;
      createdAt = DateTime.parse(followTweet.createdAt);
      tweetMessage = followTweet.message;
      tweetImageUrl = followTweet.imageUrl;
    }

    String formattedDate = formatTweetDate(createdAt);

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 10, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: TextWidget(
                      titleText1: '$fullname ',
                      fontWeight: FontWeight.bold,
                      textSize: 15,
                      textColor: Provider.of<UserProfileProvider>(context).titleColor,
                    ),
                  ),
                  TextWidget(
                    titleText1: '@$username ',
                    fontWeight: FontWeight.bold,
                    textSize: 15,
                    textColor:  Provider.of<UserProfileProvider>(context).userColor,
                  ),
                  TextWidget(
                    titleText1: '·$formattedDate',
                    fontWeight: FontWeight.bold,
                    textSize: 15,
                    textColor:  Provider.of<UserProfileProvider>(context).userColor,
                  ),
                ],
              ),
              IconButton(
                onPressed: () {

                    _showBottomSheet(context);

                  },
                icon:
                    Icon(Icons.more_vert, color: Provider.of<UserProfileProvider>(context).userColor,
                        size: 20),
              ),
            ],
          ),
          const SizedBox(height: 5),

          if (tweetMessage!= null && tweetMessage!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Text(
                tweetMessage!,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          if (tweetImageUrl != null && tweetImageUrl!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                "http://192.168.1.70:5169/TweetImage/${tweetImageUrl}",
                fit: BoxFit.fitWidth,
              ),
            ),
        ],
      ),
    );
  }
}
