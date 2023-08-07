import 'dart:io';

import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/widgets/datetimewidget.dart';
import 'package:twitter/ui/screens/widgets/profilewidget.dart';
import 'package:twitter/ui/screens/widgets/retweetwidget.dart';

import '../../../utils/class.dart';

class FullScreen extends StatefulWidget {
  const FullScreen(
      {Key? key,
      required this.image,
      required this.titleText,
      required this.usernameText,
      required this.avatar,
      required this.retweetCount,
      required this.likeCount,
      required this.quotesCount,
      required this.bookmarksCount,
      required this.viewsCount,
      required this.dateCount})
      : super(key: key);

  final String image;
  final String titleText;
  final String usernameText;
  final String avatar;
  final int retweetCount;
  final int likeCount;
  final int quotesCount;
  final int bookmarksCount;
  final int viewsCount;
  final DateTime dateCount;

  @override
  State<StatefulWidget> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  get usernameText => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: CardColor.titleColor,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileWidget(
                    titleText: widget.titleText,
                    titleTextColor: CardColor.fullScreenTitleColor,
                    usernameText: widget.usernameText,
                    usernameTextColor: CardColor.userColor,
                    avatarImage: widget.avatar,
                    menuColor: CardColor.fullScreenTitleColor,
                  ),
                  Hero(
                    tag: 'fullScreenImage',
                    child:  Image.file(
                      File(widget.image),
                      fit: BoxFit.contain,
                      height: 590,
                    )
                  ),
                  DateTimeWidget(
                    views: widget.viewsCount,
                    dateTime: widget.dateCount,
                    numberColor: CardColor.fullScreenTitleColor,
                  ),
                  RetweetWidget(
                    titleTextColor: CardColor.userColor,
                    numberTextColor: CardColor.fullScreenTitleColor,
                    retweetsCount: widget.retweetCount,
                    quotesCount: widget.quotesCount,
                    likesCount: widget.likeCount,
                    bookmarksCount: widget.bookmarksCount,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
