import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/ui/screens/profiledetail/profiledetail/profiledetailimage.dart';
import 'package:twitter/ui/screens/profiledetail/profiledetail/profiledetailtabbar.dart';
import 'package:twitter/ui/screens/profiledetail/profiledetail/profilenamedate.dart';
import 'package:twitter/ui/screens/widgets/tweetcard/tweetcarddd.dart';
import 'package:twitter/utils/provider.dart';
import 'package:twitter/api_service/tweet_service.dart';
import 'package:twitter/model/tweetwithprofile.dart';

class ProfileTweetDetailPage extends StatefulWidget {
  const ProfileTweetDetailPage({Key? key, required this.index})
      : super(key: key);
  final int index;

  @override
  State<StatefulWidget> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileTweetDetailPage> {
  List<TweetWithProfile> tweets = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userIdProvider = Provider.of<UserProfileProvider>(context);
    final userId = userIdProvider.profileUserId;

    if (userId != null) {
      loadUserTweets(userId);
    }
  }

  Future<void> loadUserTweets(int userId) async {
    try {
      final userTweets = await TweetService().getTweetUser(userId);

      setState(() {
        tweets = userTweets.cast<TweetWithProfile>();
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {  },),
          IconButton( icon: Icon(Icons.search), onPressed: () {  },)
        ],

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            ProfileDetailImage(
              tweet: tweets.isNotEmpty ? tweets[0] : null,
            ),
            ProfileNameDate(tweet: tweets.isNotEmpty ? tweets[0] : null),


            ProfileDetailTabbar(),
            for (final tweet in tweets) TweetCardd(tweet: tweet)
          ],
        ),
      ),
    );
  }
}
