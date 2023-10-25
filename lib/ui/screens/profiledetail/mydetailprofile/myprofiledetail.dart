import 'package:flutter/material.dart';
import 'package:twitter/model/tweetwithparent.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/followfollowingwidget.dart';
import 'package:twitter/ui/screens/profiledetail/mydetailprofile/mydetail/myprofileimagewidget.dart';
import 'package:twitter/ui/screens/profiledetail/mydetailprofile/mydetail/myprofilenamedate.dart';
import 'package:twitter/utils/class.dart';
import 'package:twitter/utils/sharedpreferences.dart';
import 'package:twitter/api_service/tweet_service.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import '../profiledetail/profiledate.dart';
import 'mydetail/myprofiledetailtabbar.dart';

class MyProfileDetailPage extends StatefulWidget {
  const MyProfileDetailPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyProfileDetailPageState();
}

class _MyProfileDetailPageState extends State<MyProfileDetailPage> {
  List<TweetWithProfile> tweets = [];
  int? userId;
  List<TweetWithParent> tweetList = [];
  String? fullname;
  String? username;
  String? createdAt;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getuser(userId);
    userListTweet();
  }

  Future<void> getuser(userId) async {
    try {
      final userPreferences = UserPreferences();
      bool isLoggedIn = await userPreferences.isLoggedIn();

      if (isLoggedIn) {
        final userId = userPreferences.getUserId();
        setState(() {
          fullname = userPreferences.getFullname();
          username = userPreferences.getUsername();
          createdAt=userPreferences.getDate();
        });
        if (userId != null) {
          loadUserTweets(userId);
        }
      }
    } catch (e) {
      print('İşlem gerçekleştirilemedi. ${e}');
    }
  }

//yanıtlar ve parenttweet
  Future<void> userListTweet() async {
    int? userId;
    final userPreferences = UserPreferences();
    bool isLoggedIn = await userPreferences.isLoggedIn();
    if (isLoggedIn) {
      userId = userPreferences.getUserId();
    }
    if (userId != null) {
      final List<TweetWithParent> getUserTweets =
          await TweetService().getUserRepliedTweets(userId);
      setState(() {
        tweetList = getUserTweets;
      });
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
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {},
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MyProfileImageWidget(
                    tweet: tweets.isNotEmpty ? tweets[0] : null,
                  ),
                  if(fullname!=null && username!=null && createdAt != null)
                  MyProfileNameDate(fullname: fullname!, username: username!, createdAt: createdAt!,),
                  const Padding(
                    padding: EdgeInsets.only(left: 30, top: 15, bottom: 15),
                    child: FollowFollowingWidget(),
                  ),
                  MyProfileDetailTabbar(
                    tweets: tweets,
                    tweetList: tweetList,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
