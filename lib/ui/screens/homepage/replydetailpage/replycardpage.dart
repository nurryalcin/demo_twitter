import 'dart:io';
import 'package:flutter/material.dart';
import 'package:twitter/model/tweetwithprofile.dart';
import 'package:twitter/ui/screens/profiledetail/tweetcard/tweetcardcontent.dart';
import 'package:twitter/ui/screens/profiledetail/tweetcard/tweetcardprofile.dart';
import 'package:twitter/ui/screens/widgets/avatarprofile.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';
import 'package:twitter/api_service/tweet_service.dart';
import 'package:twitter/utils/sharedpreferences.dart';

class ReplyCardPage extends StatefulWidget {
  ReplyCardPage(
      {Key? key,
      required this.tweetList,
      this.imageFile,
      required this.selectedTweetId})
      : super(key: key);
  final File? imageFile;
  int selectedTweetId;
  final TweetWithProfile tweetList;

  @override
  State<StatefulWidget> createState() => _ReplyCardPageState();
}

class _ReplyCardPageState extends State<ReplyCardPage> {
  final TextEditingController textEditingController = TextEditingController();
  bool isButtonEnabled = false;

  void updateButtonState() {
    setState(() {
      isButtonEnabled =
          textEditingController.text.isNotEmpty || widget.imageFile != null;
    });
  }

  void sendMessage(File? imageFile) async {
    final userPreferences = UserPreferences();
    bool isLoggedIn = await userPreferences.isLoggedIn();

    if (isLoggedIn) {
      int userId = await userPreferences.getUserId();
      String? message = textEditingController.text;

      print('Gönderilen Mesaj: $message');
      print('imageUrl: ${imageFile?.path}');

      textEditingController.clear();
      TweetService tweetService = TweetService();
      final parentTweetId = widget.selectedTweetId!;
      await tweetService.replyTweet(message, imageFile, userId, parentTweetId);
    } else {
      print('Kullanıcı giriş yapmamış.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ElevatedButton(
              onPressed: isButtonEnabled
                  ? () {
                      sendMessage(widget.imageFile);
                      Navigator.pop(context);
                    }
                  : null,
              style: ButtonStyle(
                  minimumSize: const MaterialStatePropertyAll(Size(100, 50)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  )),
                  backgroundColor: MaterialStatePropertyAll(
                    isButtonEnabled
                        ? CardColor.iconColorblue
                        : Colors.lightBlueAccent,
                  )),
              child: Text('Reply',
                  style: TextStyle(
                      fontSize: 20, color: CardColor.fullScreenTitleColor)),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TweetCardProfile(tweet: widget.tweetList,radius: 20),
                Expanded(child: TweetCardContent(tweet: widget.tweetList)),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 85, top: 20),
              child: Row(
                children: [
                  TextWidget(
                    titleText1: 'Replying to ',
                    fontWeight: FontWeight.normal,
                    textSize: 20,
                    textColor: CardColor.userColor,
                  ),
                  TextWidget(
                    titleText1: '@${widget.tweetList.username}',
                    fontWeight: FontWeight.normal,
                    textSize: 20,
                    textColor: CardColor.iconColorblue,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  const AvatarProfile(radius: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextField(
                        maxLines: null,
                        controller: textEditingController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Post your reply',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
