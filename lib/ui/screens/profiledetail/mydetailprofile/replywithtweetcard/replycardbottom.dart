import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/model/tweetwithparent.dart';
import 'package:twitter/utils/class.dart';
import 'package:twitter/utils/provider.dart';

class ReplyCardBottom extends StatefulWidget {
  const ReplyCardBottom({super.key, required this.tweet, });
  final TweetWithParent tweet;

  @override
  State<StatefulWidget> createState() => _ReplyCardBottomState();
}

class _ReplyCardBottomState extends State<ReplyCardBottom> {
  int? selectedTweetId;

  void _onCardTapped(BuildContext context) {
    setState(() {
      selectedTweetId = widget.tweet.repliedTweetId;
    });
    final userProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProvider.selectedTweet(selectedTweetId!);
    print('selectedTweetId: $selectedTweetId');
  }


  @override
  Widget build(BuildContext context) {
    final Map<IconData, VoidCallback> iconButtons = {
      Icons.mode_comment_outlined: () {},
      Icons.repeat: () {},
      Icons.favorite_border: () {},
      Icons.graphic_eq: () {},
      Icons.file_download_outlined: () {},
      Icons.share: (){},
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
