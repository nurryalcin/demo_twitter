import 'package:flutter/material.dart';

import '../../../../model/tweetwithprofile.dart';
import '../../../../model/user.dart';


class SearchProfileDetailPage extends StatelessWidget {
  SearchProfileDetailPage({Key? key, required this.user, this.tweets}) : super(key: key);
  final User user;
  final List<TweetWithProfile>? tweets;

  List<TweetWithProfile> getUserTweets() {
    return tweets!.where((tweet) => tweet.userId == user.id).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<TweetWithProfile> userTweets = getUserTweets();

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Detail'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(user.fullname),
            subtitle: Text('@${user.username}'),
            leading: CircleAvatar(
              backgroundImage: user.avatarPhotoUrl != null
                  ? NetworkImage(user.avatarPhotoUrl!)
                  : null,
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: userTweets.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(userTweets[index].message),
                  subtitle: Text(userTweets[index].createdAt),
                  leading: CircleAvatar(
                    backgroundImage: userTweets[index].avatarPhotoUrl != null
                        ? NetworkImage(userTweets[index].avatarPhotoUrl!)
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
