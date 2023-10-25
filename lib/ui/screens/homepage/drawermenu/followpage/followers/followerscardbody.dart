import 'package:flutter/material.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/followpage/followers/followlistavatarprofile.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';

class FollowersCardBody extends StatefulWidget {
  const FollowersCardBody({super.key, required this.user,});
  final User? user;

  @override
  State<StatefulWidget> createState()=>_FollowersCardBodyState();


}

class _FollowersCardBodyState extends State<FollowersCardBody>{


    @override
  Widget build(BuildContext context) {


    return Row(
      children: [
        FollowListAvatarProfile(user: widget.user),
        Padding(padding: EdgeInsets.only(right: 15)),
        TextWidget(
          titleText1:widget.user!.fullname,
          fontWeight: FontWeight.bold,
          textSize: 15,
          textColor: CardColor.titleColor,
        ),
        const Padding(padding: EdgeInsets.only(left: 15)),
        TextWidget(
            titleText1: '@${widget.user!.username}',
            fontWeight: FontWeight.bold,
            textSize: 15,
            textColor: CardColor.userColor),


      ],
    );
  }
}
