import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/api_service/tweet_service.dart';
import 'package:twitter/ui/screens/addtweet/widget/mediaicon.dart';
import 'package:twitter/ui/screens/addtweet/widget/tweetbody.dart';
import 'package:twitter/ui/screens/homepage/homePage.dart';
import 'package:twitter/ui/screens/widgets/avatarprofile.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/provider.dart';
import 'package:twitter/utils/sharedpreferences.dart';

class AddTweet extends StatefulWidget {
  const AddTweet({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _AddTweetState();
}

class _AddTweetState extends State<AddTweet> {
  final TextEditingController textEditingController = TextEditingController();
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
      int userId = userPreferences.getUserId();
      String? message = textEditingController.text;
      textEditingController.clear();
      if (message.isNotEmpty || imageFile!.path.isNotEmpty) {
        await TweetService().sendTweet(message, imageFile, userId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    textEditingController.addListener(() {
      updateButtonState();
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, size: 25),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ElevatedButton(
                onPressed: isButtonEnabled
                    ? () async {
                        sendMessage(imageFile);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false,
                        );
                      }
                    : null,
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                    backgroundColor: MaterialStatePropertyAll(
                      isButtonEnabled
                          ? Provider.of<UserProfileProvider>(context).iconColorBlue
                          : Provider.of<UserProfileProvider>(context).iconColorlightBlue,
                    )),
                child: TextWidget(
                    titleText1: 'Post',
                    fontWeight: FontWeight.bold,
                    textSize: 20,
                    textColor: Provider.of<UserProfileProvider>(context).fullScreenTitleColor),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AvatarProfile(radius: 20 ),
              TweetBody(textEditingController: textEditingController),
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
