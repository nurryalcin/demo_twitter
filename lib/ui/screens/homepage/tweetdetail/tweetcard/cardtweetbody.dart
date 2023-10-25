import 'package:flutter/material.dart';
import 'package:twitter/model/tweetwithprofile.dart';

class CardTweetBody extends StatelessWidget {
  const CardTweetBody({Key? key, required this.tweetList}) : super(key: key);

  final TweetWithProfile tweetList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (tweetList.message != null && tweetList.message!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 85,right: 10,bottom: 15),
            child: Text(
              tweetList.message!,
              style: TextStyle(fontSize: 15),
            ),
          ),
        if (tweetList.imageUrl != null && tweetList.imageUrl!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 85,right: 10,bottom: 15),
            child: Image.network(
              "http://192.168.1.70:5169/TweetImage/${tweetList.imageUrl}",
              fit: BoxFit.cover,

            ),
          ),

      ],
    );
  }
}
