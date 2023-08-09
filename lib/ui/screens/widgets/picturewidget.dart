import 'dart:io';
import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/widgets/fullscreen.dart';

class PictureWidget extends StatelessWidget {
  final String imagePath;
  final String titleText;
  final String usernameText;
  final String avatar;
  final int retweetCount;
  final int likeCount;
  final int quotesCount;
  final int bookmarksCount;
  final int viewsCount;
  final DateTime dateCount;

  const PictureWidget(
      {required this.imagePath, Key? key, required this.titleText, required this.usernameText, required this.avatar, required this.retweetCount, required this.likeCount, required this.quotesCount, required this.bookmarksCount, required this.viewsCount, required this.dateCount})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FullScreen(
                    image:imagePath,
                    titleText:titleText,
                    usernameText: usernameText,
                    avatar: avatar,
                    retweetCount: retweetCount,
                    likeCount: likeCount,
                    quotesCount: quotesCount,
                    bookmarksCount: bookmarksCount,
                    viewsCount: viewsCount,
                    dateCount: dateCount),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 25),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.file(
            File(imagePath!),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
