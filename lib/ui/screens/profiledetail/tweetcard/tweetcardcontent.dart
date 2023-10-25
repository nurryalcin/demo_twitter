import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/utils/class.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';

class TweetCardContent extends StatelessWidget {
  const TweetCardContent({super.key, required this.tweet});
  final TweetWithProfile tweet;

  @override
  Widget build(BuildContext context) {
    final username = tweet.username;
    final fullname = tweet.fullname;

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
    DateTime createdAt = DateTime.parse(tweet.createdAt);
    String formattedDate = formatTweetDate(createdAt);

    return Padding(
      padding: const EdgeInsets.only(left:20, right:15,bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(height: 5),
          if (tweet.message != null && tweet.message!.isNotEmpty)
            Text(
              tweet.message!,
              style: TextStyle(fontSize: 15),
            ),

          if (tweet.imageUrl != null && tweet.imageUrl!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                "http://192.168.1.70:5169/TweetImage/${tweet.imageUrl}",
                fit: BoxFit.fitWidth,

              ),
            ),


        ],
      ),
    );
  }
}
