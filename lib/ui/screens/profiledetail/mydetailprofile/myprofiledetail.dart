import 'package:flutter/material.dart';
import 'package:twitter/model/tweetwithparent.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/widget/followfollowingwidget.dart';
import 'package:twitter/ui/screens/profiledetail/mydetailprofile/widget/myprofiledetailtabbar.dart';
import 'package:twitter/ui/screens/profiledetail/mydetailprofile/widget/myprofileimagewidget.dart';
import 'package:twitter/ui/screens/profiledetail/mydetailprofile/widget/myprofilenamedate.dart';
import 'package:twitter/utils/class.dart';
import 'package:twitter/utils/sharedpreferences.dart';
import 'package:twitter/api_service/tweet_service.dart';
import 'package:twitter/model/tweetwithprofile.dart';

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
          createdAt = userPreferences.getDate();
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 10.0,
            floating: false,
            pinned: false,
            backgroundColor: Colors.lightBlue,
            iconTheme: IconThemeData(color: CardColor.fullScreenTitleColor),
            actions: [
              CircleAvatar(
                backgroundColor: Colors.black38,
                maxRadius: 18,
                child: IconButton(onPressed:() {

                }, icon:Icon(Icons.search)),

              ),
              SizedBox(width: 15,),
              CircleAvatar(
                maxRadius: 18,
                backgroundColor: Colors.black38,

                child: IconButton(onPressed: () {

                }, icon: Icon(Icons.more_vert)),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              MyProfileImageWidget(
                tweet: tweets.isNotEmpty ? tweets[0] : null,
              ),
              if (fullname != null &&
                  username != null &&
                  createdAt != null)
                MyProfileNameDate(
                  fullname: fullname!,
                  username: username!,
                  createdAt: createdAt!,
                ),
              const Padding(
                padding: EdgeInsets.only(left: 30, top: 15, bottom: 15),
                child: FollowFollowingWidget(),
              ),
              MyProfileDetailTabbar(
                tweets: tweets,
                tweetList: tweetList,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
