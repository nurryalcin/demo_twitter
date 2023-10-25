import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../model/followusertweet.dart';
import '../../../../utils/provider.dart';
import '../followreplypage.dart';

class FollowCardTweetBottom extends StatefulWidget {
  const FollowCardTweetBottom({super.key, required this.followTweet,});
  final FollowUserTweet followTweet;

  @override
  State<StatefulWidget> createState() => _FollowCardTweetBottomState();
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


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            IconButton(
              icon: const Icon(Icons.mode_comment_outlined),
              onPressed: () {
                _onCardTapped(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FollowReplyPage(
                        followTweet: widget.followTweet,
                        selectedTweetId: selectedTweetId!,
                      ),
                    ));
              },
            ),
          ],
        ),
        Column(
          children: [
            IconButton(
              icon: const Icon(Icons.repeat),
              onPressed: () {},
            )
          ],
        ),
        Column(
          children: [
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            )
          ],
        ),
        Column(
          children: [
            IconButton(
              icon: const Icon(Icons.graphic_eq),
              onPressed: () {},
            )
          ],
        ),
        Column(
          children: [
            IconButton(
              icon: const Icon(Icons.file_download_outlined),
              onPressed: () {},
            )
          ],
        ),

        IconButton(icon: Icon(Icons.share), onPressed: () { },)

      ],
    );
  }
}
