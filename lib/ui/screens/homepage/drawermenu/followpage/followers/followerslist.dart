import 'package:flutter/material.dart';
import 'package:twitter/api_service/followuser_service.dart';
import 'package:twitter/utils/sharedpreferences.dart';
import 'package:twitter/model/user.dart';
import 'followerscardwidget.dart';

class FollowingList extends StatefulWidget {
  const FollowingList({super.key});

  @override
  _FollowingListState createState() => _FollowingListState();
}

class _FollowingListState extends State<FollowingList> {

  List<User> followingUsers = [];


  @override
  void initState() {
    super.initState();
    _followingUserList();
  }




  Future<void> _followingUserList() async {
    try {
      final userPreferences = UserPreferences();
      bool isLoggedIn = await userPreferences.isLoggedIn();
      int userId;
      if (isLoggedIn) {
        userId = userPreferences.getUserId();
        List<User> users = await FollowUserService().getFollowingUsers(userId);
        setState(() {
          followingUsers = users;
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
        for (final user in followingUsers) FollowerCardWidget(user: user, ),
      ],
    );
  }
}