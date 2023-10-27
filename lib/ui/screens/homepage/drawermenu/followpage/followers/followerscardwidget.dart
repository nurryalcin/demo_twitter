import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/followpage/followers/followlistavatarprofile.dart';
import 'package:twitter/ui/screens/profiledetail/profiledetail/profiletweetdetailpage.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';
import 'package:twitter/utils/provider.dart';

class FollowerCardWidget extends StatelessWidget {
  const FollowerCardWidget({
    Key? key,
    this.user,
  }) : super(key: key);
  final User? user;

  void _onCardTapped(BuildContext context) {
    int? userId = user!.id;
    final userProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    userProvider.selectedProfileuserId(userId);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfileTweetDetailPage(
                index: 0,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _onCardTapped(context),
          child: ListTile(
            leading: SizedBox(
                width: 319,
                child: Row(
                  children: [
                    FollowListAvatarProfile(user: user),
                    Padding(padding: EdgeInsets.only(right: 15)),
                    TextWidget(
                      titleText1: user!.fullname,
                      fontWeight: FontWeight.bold,
                      textSize: 15,
                      textColor: CardColor.titleColor,
                    ),
                    const Padding(padding: EdgeInsets.only(left: 15)),
                    TextWidget(
                        titleText1: '@${user!.username}',
                        fontWeight: FontWeight.bold,
                        textSize: 15,
                        textColor: CardColor.userColor),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
