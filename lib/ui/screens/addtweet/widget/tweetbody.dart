import 'package:flutter/material.dart';
import 'package:twitter/utils/class.dart';
class TweetBody extends StatelessWidget {
  final TextEditingController textEditingController;

  TweetBody({Key? key, required this.textEditingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 65),
      child: Center(
        child: Container(
          width: double.infinity,
          child: TextField(
            controller: textEditingController,
            cursorColor: CardColor.userColor,
            cursorHeight: 30,
            maxLines: null,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
              hintText: 'What\'s happening?!',
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
