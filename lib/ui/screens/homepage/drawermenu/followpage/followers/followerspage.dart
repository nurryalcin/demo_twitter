import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/followpage/followers/followinglist.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';

class FollowersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
            titleText1: 'Followers',
            fontWeight: FontWeight.bold,
            textSize: 25,
            textColor: CardColor.titleColor),
        actions: [
          IconButton( icon: Icon(Icons.more_vert), onPressed: () {  },)
        ],
      ),
      body: FollowingList(),
    );
  }
}
