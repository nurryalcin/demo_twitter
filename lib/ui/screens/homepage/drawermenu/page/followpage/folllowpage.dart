import 'package:flutter/material.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/page/followpage/shortcardwidget.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';

class FollowPage extends StatelessWidget {
  FollowPage({super.key, this.followingList, this.followerList});

  List<User>? followingList;
  List<User>? followerList;

  @override
  Widget build(BuildContext context) {
    String titleText = followerList != null ? 'Following' : 'Followers';
    Icon icon = followingList != null
        ? Icon(Icons.more_vert)
        : Icon(Icons.person_add_alt_sharp);
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          titleText1: titleText,
          fontWeight: FontWeight.bold,
          textSize: 25,
          textColor: CardColor.titleColor,
        ),
        actions: [
          IconButton(
            icon: icon,
            onPressed: () {},
          )
        ],
      ),
      body: ListView.builder(
        itemCount: (followingList?.length ?? 0) + (followerList?.length ?? 0),
        itemBuilder: (BuildContext context, int index) {
          if (index < (followingList?.length ?? 0)) {
            final user = followingList?[index];
            return ShortCardWidget(user: user!);
          } else {
            final followerIndex = index - (followingList?.length ?? 0);
            final user =followerList?[followerIndex];
            return ShortCardWidget(user: user!);
          }
        },
      )
    );
  }
}