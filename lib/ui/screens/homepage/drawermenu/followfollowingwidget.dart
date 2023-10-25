import 'package:flutter/material.dart';
import 'package:twitter/api_service/followuser_service.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/followpage/followers/folllowingpage.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/followpage/followers/followerspage.dart';
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
  List<User> followedUsers = [];
  List<User> followUsers = [];
  int userCount = 0;
  int followedCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchFollowedUsers();
    _followUserList();
  }

  Future<void> _fetchFollowedUsers() async {
    try {
      final userPreferences = UserPreferences();
      bool isLoggedIn = await userPreferences.isLoggedIn();
      int userId;
      if (isLoggedIn) {
        userId = userPreferences.getUserId();
        List<User> users = await FollowUserService().getFollowedUsers(userId);
        setState(() {
          followedUsers = users;
          followedCount = followedUsers.length;
        });
      }
    } catch (e) {
      print('Error fetching followed users: $e');
    }
  }

  Future<void> _followUserList() async {
    try {
      final userPreferences = UserPreferences();
      bool isLoggedIn = await userPreferences.isLoggedIn();
      int userId;
      if (isLoggedIn) {
        userId = userPreferences.getUserId();
        List<User> users = await FollowUserService().getFollowingUsers(userId);
        setState(() {
          followUsers = users;
          userCount = followUsers.length;
        });
      }
    } catch (e) {
      print('Error fetching followed users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FollowingPage())),
            child: TextWidget(
                titleText1: '$userCount  Following',
                fontWeight: FontWeight.normal,
                textSize: 18,
                textColor: CardColor.userColor),
          ),
          SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) =>FollowersPage())),
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
