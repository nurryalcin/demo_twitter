import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/ui/screens/homepage/followtweetcard/followtweetlist.dart';
import 'package:twitter/ui/screens/widgets/avatarprofile.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';
import 'package:twitter/ui/screens/addtweet/addtweet.dart';
import 'package:twitter/utils/provider.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/drawermen%C3%BC.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isOverlayVisible = false;
  IconData currentFabIcon = Icons.add;
  String currentFabText = "";

  void _toggleOverlay() {
    setState(() {
      if (isOverlayVisible) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddTweet()),
        );
      }
      isOverlayVisible = !isOverlayVisible;
      currentFabIcon = isOverlayVisible ? Icons.post_add : Icons.add;
      currentFabText = isOverlayVisible ? "Post" : "";
    });
  }
  @override
  void initstate(){
    super.initState();
    _refreshFollowTweetList();
  }

  Future<void> _refreshFollowTweetList() async {
    await Future.delayed(const Duration(seconds: 2));
    FollowTweetList();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshFollowTweetList,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: false,
                  floating: true,
                  delegate: CustomSliverDelegate(),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(2.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const FollowTweetList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (isOverlayVisible)
              GestureDetector(
                onTap: _toggleOverlay,
                child: Container(
                  color: Colors.white.withOpacity(0.8),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 280, top: 500),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            TextWidget(
                                titleText1: 'Spaces',
                                fontWeight: FontWeight.normal,
                                textSize: 15,
                                textColor: CardColor.titleColor),
                            const SizedBox(
                              width: 15,
                            ),
                            FloatingActionButton(
                              backgroundColor: CardColor.fullScreenTitleColor,
                              onPressed: () {},
                              child: Icon(
                                Icons.circle_outlined,
                                color: CardColor.iconColorblue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(children: [
                          TextWidget(
                              titleText1: 'Photos',
                              fontWeight: FontWeight.normal,
                              textSize: 15,
                              textColor: CardColor.titleColor),
                          const SizedBox(
                            width: 15,
                          ),
                          FloatingActionButton(
                            backgroundColor: CardColor.fullScreenTitleColor,
                            onPressed: () {},
                            child: Icon(
                              Icons.photo_outlined,
                              color: CardColor.iconColorblue,
                            ),
                          ),
                        ]),
                        const SizedBox(height: 16),
                        Row(children: [
                          TextWidget(
                              titleText1: 'GIF',
                              fontWeight: FontWeight.normal,
                              textSize: 15,
                              textColor: CardColor.titleColor),
                          const SizedBox(
                            width: 37,
                          ),
                          FloatingActionButton(
                            backgroundColor: CardColor.fullScreenTitleColor,
                            onPressed: () {},
                            child: Icon(
                              Icons.gif,
                              color: CardColor.iconColorblue,
                              size: 40,
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (currentFabText.isNotEmpty)
            Text(
              currentFabText,
              style: const TextStyle(fontSize: 16),
            ),
          const SizedBox(width: 25),
          FloatingActionButton(
            onPressed: () => _toggleOverlay(),
            child: Icon(
              currentFabIcon,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 120.0;

  @override
  double get minExtent => 15.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return AppBar(
      leading: GestureDetector(
        onTap: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Align(
                alignment: AlignmentDirectional.centerStart,
                child: DrawerMenu(),
              );
            },
          );
        },
        child: Consumer<UserProfileProvider>(
          builder: (context, userProfile, child) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: AvatarProfile(),
            );
          },
        ),
      ),
      centerTitle: true,
      title: const CircleAvatar(
        radius: 15,
        backgroundImage: AssetImage('assets/images/logo.jpg'),
      ),
    );
  }
}
