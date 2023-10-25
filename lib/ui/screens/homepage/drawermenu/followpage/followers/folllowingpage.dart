import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/followpage/followers/followerslist.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';

class FollowingPage extends StatelessWidget {
  const FollowingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
            titleText1: 'Following',
            fontWeight: FontWeight.bold,
            textSize: 25,
            textColor: CardColor.titleColor),
        actions: [
          IconButton( icon: Icon(Icons.person_add_alt_sharp), onPressed: () {  },)
        ],
      ),
      body: FollowingList()


    );
  }
}
