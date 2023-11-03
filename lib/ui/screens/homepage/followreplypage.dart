import 'dart:io';
import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/addtweet/widget/mediaicon.dart';
import 'package:twitter/ui/screens/widgets/avatarprofile.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/ui/screens/widgets/tweetcard/tweetcardavatarprofile.dart';
import 'package:twitter/ui/screens/widgets/tweetcard/tweetcardcontent.dart';
import 'package:twitter/utils/class.dart';
import 'package:twitter/api_service/tweet_service.dart';
import 'package:twitter/model/followusertweet.dart';
import 'package:twitter/utils/sharedpreferences.dart';

class FollowReplyPage extends StatefulWidget {
  FollowReplyPage({Key? key, required this.followTweet, this.imageFile, required this.selectedTweetId})
      : super(key: key);

  final File? imageFile;
  int selectedTweetId;
  final FollowUserTweet followTweet;

  @override
  State<StatefulWidget> createState() => _FollowReplyPageState();
}

class _FollowReplyPageState extends State<FollowReplyPage> {
  final TextEditingController textEditingController = TextEditingController();
  bool isRowVisible = true;
  File? imageFile;
  bool isButtonEnabled = false;

  void updateButtonState() {
    setState(() {
      isButtonEnabled =
          textEditingController.text.isNotEmpty || imageFile != null;
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
    }
  }

  @override
  Widget build(BuildContext context) {
    textEditingController.addListener(() {
      updateButtonState();
    });
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
            child: ElevatedButton(
              onPressed: isButtonEnabled
                  ? () {
                sendMessage(imageFile);
                Navigator.pop(context);
              }
                  : null,
              style: ButtonStyle(
                minimumSize: const MaterialStatePropertyAll(Size(100, 50)),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                )),
                backgroundColor: MaterialStatePropertyAll(isButtonEnabled
                    ? CardColor.iconColorblue
                    : Colors.lightBlueAccent,)
              ),

              child: Text('Reply',
                  style: TextStyle(
                    fontSize: 20,
                    color:  CardColor.fullScreenTitleColor
                  )),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TweetCardAvatarProfile(tweet: widget.followTweet,),
                  Expanded(
                      child: TweetCardContent(tweet: widget.followTweet,))
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
                      titleText1: '@${widget.followTweet.username}',
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
                    const AvatarProfile(),
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
              MediaIcon(
                onImageSelected: (File? file) {
                  setState(() {
                    imageFile = file;
                    updateButtonState();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
