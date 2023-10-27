import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:twitter/model/followusertweet.dart';
import 'package:twitter/ui/screens/profiledetail/profiledetail/profiletweetdetailpage.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';
import 'package:twitter/utils/provider.dart';

class FollowTweetContent extends StatelessWidget {
  const FollowTweetContent({Key? key, required this.followTweet}) : super(key: key);

  final FollowUserTweet followTweet;

  void _onCardTapped(BuildContext context) {
    int? userId = followTweet.followedUserId;
    final userProvider =
    Provider.of<UserProfileProvider>(context, listen: false);
    userProvider.selectedProfileuserId(userId);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfileTweetDetailPage(
            index: 0,
          )),
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
    DateTime createdAt = DateTime.parse(followTweet.createdAt);
    String formattedDate = formatTweetDate(createdAt);

    return Padding(
      padding: const EdgeInsets.only(left:20, right:15,bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _onCardTapped(context);
                    },
                    child: TextWidget(
                      titleText1: followTweet.fullname,
                      fontWeight: FontWeight.bold,
                      textSize: 15,
                      textColor: CardColor.titleColor,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 5)),
                  GestureDetector(
                    onTap: () {
                      _onCardTapped(context);
                    },
                    child: TextWidget(
                        titleText1: '@${followTweet.username}',
                        fontWeight: FontWeight.bold,
                        textSize: 15,
                        textColor: CardColor.userColor),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 5)),
                  TextWidget(
                    titleText1: '·$formattedDate',
                    fontWeight: FontWeight.bold,
                    textSize: 15,
                    textColor: CardColor.userColor,
                  ),
                ],
              ),

              IconButton(onPressed: () {

              }, icon: Icon(Icons.more_vert,size: 20,color:CardColor.userColor,))
            ],
          ),
          SizedBox(height: 5,),
          if (followTweet.message != null && followTweet.message!.isNotEmpty)
            Text(
              followTweet.message!,
              style: TextStyle(fontSize: 15),
            ),
          if (followTweet.imageUrl != null && followTweet.imageUrl!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                "http://192.168.1.70:5169/TweetImage/${followTweet.imageUrl}",
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }
}
