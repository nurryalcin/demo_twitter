import 'dart:math';
import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/widgets/titletext.dart';
// ignore: unused_import
import '../../../utils/class.dart';
import 'numberwidget.dart';

class RetweetWidget extends StatefulWidget {
  const RetweetWidget({
    super.key,
    required this.titleTextColor,
    required this.numberTextColor,
    required this.retweetsCount,
    required this.quotesCount,
    required this.likesCount,
    required this.bookmarksCount,
  });

  final Color titleTextColor;
  final Color numberTextColor;
  final int retweetsCount;
  final int quotesCount;
  final int likesCount;
  final int bookmarksCount;

  @override
  State<StatefulWidget> createState() => _RetweetWidgetState();
}

class _RetweetWidgetState extends State<RetweetWidget> {
  String getAbbreviatedNumber(int number) {
    if (number >= 1000000000) {
      return '${(number ~/ 1000000000)}B';
    } else if (number >= 1000000) {
      return '${(number ~/ 1000000)}M';
    } else if (number >= 1000) {
      return '${(number ~/ 1000)}K';
    } else {
      return '$number';
    }
  }

  final Random _random = Random();
  int prevRetweets = 0;
  int prevQuotes = 0;
  int prevLike = 0;
  int prevBookmark = 0;

  int getRandom(int prevValue) {
    int randomNumber;
    do {
      randomNumber = _random.nextInt(999999999);
    } while (randomNumber <= prevValue);

    return randomNumber;
  }

  int getBookmark(int prevBook) {
    int randomBooks;
    do {
      randomBooks = _random.nextInt(1000);
    } while (randomBooks <= prevBook);

    return randomBooks;
  }

  @override
  Widget build(BuildContext context) {
    int retweets = getRandom(prevRetweets);
    int quotes = getRandom(prevQuotes);
    int likes = getRandom(prevLike);
    int bookmarks = getBookmark(prevBookmark);

    prevRetweets = retweets;
    prevQuotes = quotes;
    prevLike = likes;
    prevBookmark = bookmarks;

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Row(
            children: [
              NumberWidget(
                titleText: '  ${getAbbreviatedNumber(widget.retweetsCount)} ',
                numberColor: widget.numberTextColor,
              ),
              TitleText(
                  textName: 'Retweets',
                  textColor: widget.titleTextColor,
                  textWeight: FontWeight.normal, textSize: 18,),
              NumberWidget(
                titleText: '  ${getAbbreviatedNumber(widget.quotesCount)}',
                numberColor: widget.numberTextColor,
              ),
              TitleText(
                  textName: ' Quotes',
                  textColor: widget.titleTextColor,
                  textWeight: FontWeight.normal, textSize: 18,),
              NumberWidget(
                titleText: '  ${getAbbreviatedNumber(widget.likesCount)}',
                numberColor: widget.numberTextColor,
              ),
              TitleText(
                  textName: ' Likes',
                  textColor: widget.titleTextColor,
                  textWeight: FontWeight.normal, textSize: 18,)
            ],
          ),
          Row(
            children: [
              NumberWidget(
                titleText: ' ${getAbbreviatedNumber(widget.bookmarksCount)}',
                numberColor: widget.numberTextColor,
              ),
              TitleText(
                  textName: ' Bookmarks',
                  textColor: widget.titleTextColor,
                  textWeight: FontWeight.normal, textSize: 18,)
            ],
          )
        ],
      ),
    );
  }
}
