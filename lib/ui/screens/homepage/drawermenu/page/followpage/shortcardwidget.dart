import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/ui/screens/profiledetail/profiledetail/followbutton.dart';
import 'package:twitter/ui/screens/profiledetail/profiledetail/profiletweetdetailpage.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/ui/screens/widgets/tweetcard/tweetcardavatarprofile.dart';
import 'package:twitter/utils/provider.dart';

class ShortCardWidget extends StatelessWidget {
  const ShortCardWidget({
    Key? key,
    this.user,
    this.showFollowButton = false,
  }) : super(key: key);
  final User? user;
  final bool showFollowButton;

  void _onCardTapped(BuildContext context) {
    int? userId = user!.id;
    final userProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    userProvider.selectedProfileuserId(userId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileTweetDetailPage(index: 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TweetCardAvatarProfile(
          tweet: user,
        ),
        Column(
          children: [

          ],
        )
      ],
    );
  }
}
