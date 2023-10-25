import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/model/followusertweet.dart';
import 'package:twitter/ui/screens/homepage/followtweetcard/Followtweetavatarprofile.dart';
import 'package:twitter/ui/screens/homepage/followtweetcard/folllowcardtweeetbottom.dart';
import 'package:twitter/ui/screens/homepage/followtweetcard/followtweetcontent.dart';
import 'package:twitter/ui/screens/profiledetail/profiledetail/profiletweetdetailpage.dart';
import 'package:twitter/utils/provider.dart';

class FollowCardTweet extends StatelessWidget {
  const FollowCardTweet({
    Key? key,
    required this.followTweet,
  }) : super(key: key);

  final FollowUserTweet followTweet;

  void _onCardTapped(BuildContext context) {
    int? userId = followTweet.followedUserId;
    final userProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    userProvider.selectedProfileuserId(userId);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const ProfileTweetDetailPage(
                index: 0,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () => _onCardTapped(context),
                    child: FollowTweetAvatarProfile(followTweet: followTweet)),
                Expanded(
                  child: FollowTweetContent(followTweet: followTweet),
                ),
              ],
            ),
          ),
          FollowCardTweetBottom(followTweet: followTweet)

        ],
      ),
    );
  }
}
