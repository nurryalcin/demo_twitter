import 'package:flutter/material.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/widgets/bottomnavigationbarwidget.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';


class ProfileDetailAppbar extends StatelessWidget {
  ProfileDetailAppbar({super.key, required this.tweet, required this.index});
  final TweetWithProfile? tweet;
  final int index;

  List<Widget> _widgetOptions = <Widget>[
    BottomNavigationBarWidget(index: 0),
    BottomNavigationBarWidget(index: 1),
  ];



  @override
  Widget build(BuildContext context) {
    if (tweet != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30,
                color: CardColor.titleColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              }
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: TextWidget(
                titleText1: tweet!.fullname,
                fontWeight: FontWeight.bold,
                textSize: 25,
                textColor: CardColor.titleColor,
              ),
            ),
          ],
        ),
      );

    }
    else{
      return SizedBox();
    }
  }
}
