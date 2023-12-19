import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/profiledetail/editprofile/editprofilepage.dart';
import 'package:twitter/ui/screens/widgets/avatarprofile.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/provider.dart';

class MyProfileImageWidget extends StatelessWidget {
  const MyProfileImageWidget({super.key, this.tweet});

  final TweetWithProfile? tweet;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: CircleAvatar(
                backgroundColor: Provider.of<UserProfileProvider>(context).fullScreenTitleColor,
                radius: 45,
                child: AvatarProfile(radius: 40),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Provider.of<UserProfileProvider>(context).fullScreenTitleColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Provider.of<UserProfileProvider>(context).userColor),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProfilePage(
                                  tweet: tweet,
                                  imagePath: '',
                                )));
                  },
                  child: TextWidget(
                    titleText1: 'Edit Profile',
                    fontWeight: FontWeight.bold,
                    textSize: 18,
                    textColor: Provider.of<UserProfileProvider>(context).titleColor
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
