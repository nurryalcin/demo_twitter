import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/api_service/followuser_service.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/provider.dart';
import 'package:twitter/utils/sharedpreferences.dart';
import 'package:twitter/model/followuser.dart';

class FollowButton extends StatefulWidget {
  const FollowButton({super.key, required this.userId, });

  final int userId;

  @override
  State<StatefulWidget> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool _isFollowing = false;
  int? userId;
  int? followedUserId;

  @override
  void initState() {
    super.initState();
    _checkIfAlreadyFollowing();
  }

  Future<void> _checkIfAlreadyFollowing() async {
    try {
      final userPreferences = UserPreferences();
      bool isLoggedIn = await userPreferences.isLoggedIn();

      if (isLoggedIn) {
        final userId = await userPreferences.getUserId();
        followedUserId = widget.userId;
        print('followedUserId: $followedUserId');

        if (followedUserId != null) {
          final followUserService = FollowUserService();
          final isAlreadyFollowing =
          await followUserService.isUserFollowed(userId, followedUserId!);

          setState(() {
            _isFollowing = isAlreadyFollowing;
          });
        }
      }
    } catch (e) {
      print('Takip durumu kontrol edilemedi: $e');
    }
  }

  Future<void> followUser() async {
    try {
      final userPreferences = UserPreferences();
      bool isLoggedIn = await userPreferences.isLoggedIn();
      if (isLoggedIn) {
        final userId = userPreferences.getUserId();
        setState(() {
          this.userId = userId;
          this.followedUserId = followedUserId;
        });

        if (userId!= null) {
          final followUserService = FollowUserService();
          bool isAlreadyFollowing =
          await followUserService.isUserFollowed(userId, followedUserId!);

          setState(() {
            _isFollowing = isAlreadyFollowing;
          });

          if (!_isFollowing) {
            try {
              FollowUser followResponse =
              await followUserService.followUser(userId!, followedUserId!);
              print('Kullanıcı takip edildi: ${followResponse.followedUserId}');
              setState(() {
                _isFollowing = true;
              });
            } catch (e) {
              print('Takip işlemi gerçekleştirilemedi: $e');
            }
          }
        }
      }
    } catch (e) {
      print('Takip etme işlemi gerçekleştirilemedi. $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
        _isFollowing ? Provider.of<UserProfileProvider>(context).followButton: Provider.of<UserProfileProvider>(context).titleColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide(color: Provider.of<UserProfileProvider>(context).userColor)

        ),

      ),
      onPressed: () {
        followUser();
      },
      child: TextWidget(
        titleText1: _isFollowing ? 'Following' : 'Follow',
        fontWeight: FontWeight.bold,
        textSize: 18,
        textColor:
        _isFollowing ? Provider.of<UserProfileProvider>(context).fullScreenTitleColor : Provider.of<UserProfileProvider>(context).appbarColor,
      ),
    );
  }
}
