import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/homepage/tweetdetail/tweetcard/replycardpage.dart';
import 'package:twitter/utils/provider.dart';

class CardTweetBottom extends StatefulWidget {
  const CardTweetBottom({super.key, required this.tweetList,});
  final TweetWithProfile tweetList;

  @override
  State<StatefulWidget> createState() => _CardTweetBottomState();
}

class _CardTweetBottomState extends State<CardTweetBottom> {
  int? selectedTweetId;


  void _onCardTapped(BuildContext context) {
    setState(() {
      selectedTweetId = widget.tweetList.id;
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
                      builder: (context) => ReplyCardPage(
                        tweetList: widget.tweetList,
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
        )
      ],
    );
  }
}
