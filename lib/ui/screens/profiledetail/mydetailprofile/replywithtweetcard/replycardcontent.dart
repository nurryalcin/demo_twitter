import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twitter/api_service/tweet_service.dart';
import 'package:twitter/model/tweetwithparent.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';
import 'package:twitter/utils/sharedpreferences.dart';

class ReplyCardContent extends StatelessWidget{
  const ReplyCardContent({super.key, required this.tweet});
  final TweetWithParent tweet;
  void deletetweet() async {
    final userPreferences = UserPreferences();
    bool isLoggedIn = await userPreferences.isLoggedIn();

    if (isLoggedIn) {
      int userId = userPreferences.getUserId();
      await TweetService().deleteTweet(tweet.repliedTweetId);

    }
  }
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
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
                ListTile(
                  leading: Icon(Icons.pin_drop_outlined),
                  title: const Text('Pin to profile'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete_outline),
                  title: const Text('Delete post'),
                  onTap: () {
                    deletetweet();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.mode_comment_outlined),
                  title: const Text('Change who can reply'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.mode_edit_outline_outlined),
                  title: const Text('Edit with Premium'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
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
    String username = tweet.repliedUsername;
    final fullname = tweet.repliedFullname;

    DateTime createdAt = DateTime.parse(tweet.repliedTweetCreatedAt);
    String formattedDate = formatTweetDate(createdAt);

    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 10, bottom: 15),
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
                        textColor: CardColor.titleColor),
                  ),
                  TextWidget(
                      titleText1: '@$username ',
                      fontWeight: FontWeight.bold,
                      textSize: 15,
                      textColor: CardColor.userColor),
                  TextWidget(
                      titleText1: '·$formattedDate',
                      fontWeight: FontWeight.bold,
                      textSize: 15,
                      textColor: CardColor.userColor),
                ],
              ),
              IconButton(
                onPressed: () {
                  _showBottomSheet(context);
                },
                icon: Icon(Icons.more_vert, color: CardColor.userColor, size: 20),
              )
            ],
          ),
          const SizedBox(height: 5),
          if (tweet.repliedTweetMessage!= null && tweet.repliedTweetMessage!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Text(
                tweet.repliedTweetMessage!,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          if (tweet.repliedTweetImageUrl != null && tweet.repliedTweetImageUrl!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                "http://192.168.1.70:5169/TweetImage/${tweet.repliedTweetImageUrl}",
                fit: BoxFit.fitWidth,
              ),
            ),
        ],
      ),
    );
  }

}