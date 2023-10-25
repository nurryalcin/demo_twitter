import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/homepage/tweetdetail/tweetcard/cardtweetavatar.dart';
import 'package:twitter/ui/screens/profiledetail/profiledetail/profiletweetdetailpage.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';

import '../../../../../utils/provider.dart';

class CardTweetAppbar extends StatelessWidget {
  const CardTweetAppbar({
    super.key,
    required this.tweetList,
  });

  final TweetWithProfile tweetList;

  void _onCardTapped(BuildContext context) {
    int? userId = tweetList.userId;
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

  @override
  Widget build(BuildContext context) {
    DateTime createdAt = DateTime.parse(tweetList!.createdAt);
    String formattedDate = DateFormat('dd.MM.yyyy').format(createdAt);

    return Row(
      children: [
        InkWell(
          onTap: () {
            _onCardTapped(context);
          },
          child: CardTweetAvatar(tweetList: tweetList,),
        ),
        const Padding(padding: EdgeInsets.only(left: 15)),
        GestureDetector(
          onTap: () {
            _onCardTapped(context);
          },
          child: TextWidget(
            titleText1: tweetList!.fullname.length > 9
                ? '${tweetList!.fullname.substring(0, 9)}...'
                : tweetList!.fullname,
            fontWeight: FontWeight.bold,
            textSize: 15,
            textColor: CardColor.titleColor,
          ),
        ),
        const Padding(padding: EdgeInsets.only(left: 15)),
        GestureDetector(
          onTap: () {
            _onCardTapped(context);
          },
          child: TextWidget(
              titleText1: '@${tweetList!.username}',
              fontWeight: FontWeight.bold,
              textSize: 15,
              textColor: CardColor.userColor),
        ),
        const Padding(padding: EdgeInsets.only(left: 15)),
        TextWidget(
          titleText1: '·$formattedDate',
          fontWeight: FontWeight.bold,
          textSize: 15,
          textColor: CardColor.userColor,
        )
      ],
    );
  }
}
