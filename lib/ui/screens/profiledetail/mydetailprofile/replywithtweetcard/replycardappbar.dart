import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twitter/model/tweetwithparent.dart';
import 'package:twitter/ui/screens/widgets/avatarprofile.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';

import 'package:twitter/utils/class.dart';

class ReplyCardAppbar extends StatelessWidget {
  const ReplyCardAppbar({Key? key, required this.tweet});

  final TweetWithParent? tweet;

  @override
  Widget build(BuildContext context) {
    DateTime createdAt = DateTime.parse(tweet!.repliedTweetCreatedAt);
    String formattedDate = DateFormat('dd.MM.yyyy').format(createdAt);
    if (tweet == null) {
      return Container();
    }

    String repliedFullname = tweet!.repliedFullname ?? '';
    String repliedUsername = tweet!.repliedUsername ?? '';

    return Row(
      children: [
        AvatarProfile(),
        const Padding(padding: EdgeInsets.only(left: 15)),
        TextWidget(
          titleText1:  repliedFullname,
          fontWeight: FontWeight.bold,
          textSize: 15,
          textColor: CardColor.titleColor,
        ),
        const Padding(padding: EdgeInsets.only(left: 15)),
        TextWidget(
          titleText1: '@$repliedUsername',
          fontWeight: FontWeight.bold,
          textSize: 15,
          textColor: CardColor.userColor,
        ),
        const Padding(padding: EdgeInsets.only(left: 15)),
        TextWidget(
            titleText1: formattedDate,
            fontWeight: FontWeight.normal,
            textSize: 15,
            textColor: CardColor.userColor)
      ],
    );
  }
}
