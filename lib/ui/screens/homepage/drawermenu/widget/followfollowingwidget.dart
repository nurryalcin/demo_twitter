import 'package:flutter/material.dart';
import 'package:twitter/api_service/followuser_service.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/page/followpage/folllowpage.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';
import 'package:twitter/utils/sharedpreferences.dart';
import 'package:twitter/model/user.dart';

class FollowFollowingWidget extends StatefulWidget {
  const FollowFollowingWidget({
    super.key,
  });

  @override
  _FollowFollowingWidgetState createState() => _FollowFollowingWidgetState();
}

class _FollowFollowingWidgetState extends State<FollowFollowingWidget> {
  List<User> followingUsers = [];
  List<User> followedUsers = [];
  int followedCount = 0;
  int followingCount = 0;
  String? titleText;
  String? view;

  void _changeView( view) {
    if (mounted) {
      setState(() {
        if (view == 'Followers') {
          followingList();
        } else if (view == 'Following') {
          followedList();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    followingList();
    followedList();
  }





  Future<void> followingList() async {
    try {
      final userPreferences = UserPreferences();
      bool isLoggedIn = await userPreferences.isLoggedIn();
      int userId;
      if (isLoggedIn) {
        userId = userPreferences.getUserId();
        List<User> users = await FollowUserService().getFollowingUsers(userId);
        setState(() {
          followingUsers = users;
          followingCount = followingUsers.length;
        });
      }
    } catch (e) {
      print('Hata: $e');
    }
  }

  Future<void> followedList() async {
    try {
      final userPreferences = UserPreferences();
      bool isLoggedIn = await userPreferences.isLoggedIn();
      int userId;
      if (isLoggedIn) {
        userId = userPreferences.getUserId();
        List<User> users = await FollowUserService().getFollowerUsers(userId);
        setState(() {
          followedUsers = users;
          followedCount = followedUsers.length;
        });
      }
    } catch (e) {
      print('Hata: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            _changeView('Following');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FollowPage(
                      followerList: followingUsers,
                    )));
          },
          child: TextWidget(
              titleText1: '$followingCount  Following',
              fontWeight: FontWeight.normal,
              textSize: 18,
              textColor: CardColor.userColor),
        ),
        SizedBox(
          width: 15,
        ),
        GestureDetector(
          onTap: () {
            _changeView('Followers');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FollowPage(
                     followingList: followedUsers,
                    )));
          },
          child: TextWidget(
              titleText1: '$followedCount  Followers',
              fontWeight: FontWeight.normal,
              textSize: 18,
              textColor: CardColor.userColor),
        )
      ],
    );
  }
}
