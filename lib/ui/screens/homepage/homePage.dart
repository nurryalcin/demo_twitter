import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/widgets/addtweetbutton.dart';
import 'package:twitter/ui/screens/widgets/tweetcard/tweetlist.dart';
import 'package:twitter/ui/screens/homepage/widget/sliverappbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initstate() {
    super.initState();
    _refreshFollowTweetList();
  }

  Future<void> _refreshFollowTweetList() async {
    await Future.delayed(const Duration(seconds: 2));
    TweetList();
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
                          TweetList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: AddTweetButton());
  }
}
