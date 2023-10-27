import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/homepage/replydetailpage/replycardpage.dart';
import 'package:twitter/utils/provider.dart';

class TweetCardBottom extends StatefulWidget {
  const TweetCardBottom({super.key, required this.tweet, });
  final TweetWithProfile tweet;

  @override
  State<StatefulWidget> createState() => _TweetCardBottomState();
}

class _TweetCardBottomState extends State<TweetCardBottom> {
  int? selectedTweetId;
  
  void _onCardTapped(BuildContext context) {
    setState(() {
      selectedTweetId = widget.tweet.id;
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
                      builder: (context) => ReplyCardPage(tweetList: widget.tweet, selectedTweetId: selectedTweetId!)
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
