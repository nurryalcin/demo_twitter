import 'package:flutter/material.dart';
import 'package:twitter/api_service/followuser_service.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/followpage/followers/followerscardwidget.dart';
import 'package:twitter/utils/sharedpreferences.dart';

class FollowingList extends StatefulWidget {
  const FollowingList({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _FollowingListState();
}

class _FollowingListState extends State<FollowingList> {
  List<User> followingList = [];

  @override
  void initState() {
    super.initState();
    _followedUsers();
  }

  Future<void> _followedUsers() async {
    try {
      final userPreferences = UserPreferences();
      bool isLoggedIn = await userPreferences.isLoggedIn();
      int userId;
      if (isLoggedIn) {
        userId = userPreferences.getUserId();
        List<User> users = await FollowUserService().getFollowedUsers(userId);
        setState(() {
          followingList = users;
        });
      }
    } catch (e) {
      print('Error fetching followed users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final user in followingList)
          FollowerCardWidget(
            user: user,
          ),
      ],
    );
  }
}
