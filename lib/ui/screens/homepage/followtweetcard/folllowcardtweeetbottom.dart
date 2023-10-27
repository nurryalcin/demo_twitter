import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:twitter/model/followusertweet.dart';
import 'package:twitter/utils/class.dart';
import 'package:twitter/utils/provider.dart';
import 'package:twitter/ui/screens/homepage/followreplypage.dart';

class FollowCardTweetBottom extends StatefulWidget {
  const FollowCardTweetBottom({Key? key, required this.followTweet})
      : super(key: key);

  final FollowUserTweet followTweet;

  @override
  State<FollowCardTweetBottom> createState() => _FollowCardTweetBottomState();
}

class _FollowCardTweetBottomState extends State<FollowCardTweetBottom> {
  int? selectedTweetId;

  void _onCardTapped(BuildContext context) {
    setState(() {
      selectedTweetId = widget.followTweet.id;
    });
    final userProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProvider.selectedTweet(selectedTweetId!);
    print('selectedTweetId: $selectedTweetId');
  }

  void _shareFollowTweet() {
    final tweetContent = widget.followTweet.message;
    if (tweetContent.isNotEmpty) {
      Share.share(tweetContent);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<IconData, VoidCallback> iconButtons = {
      Icons.mode_comment_outlined: () {
        _onCardTapped(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FollowReplyPage(
              followTweet: widget.followTweet,
              selectedTweetId: selectedTweetId!,
            ),
          ),
        );
      },
      Icons.repeat: () {},
      Icons.favorite_border: () {},
      Icons.graphic_eq: () {},
      Icons.file_download_outlined: () {},
      Icons.share: _shareFollowTweet,
    };
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: iconButtons.entries.map((entry) {
        final icon = entry.key;
        final onPressed = entry.value;
        return Column(
          children: [
            IconButton(
              icon: Icon(
                icon,
                size: 20,
                color: CardColor.userColor,
              ),
              onPressed: onPressed,
            ),
          ],
        );
      }).toList(),
    );
  }
}
