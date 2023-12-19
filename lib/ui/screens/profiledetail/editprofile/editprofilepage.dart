import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/api_service/user_service.dart';
import 'package:twitter/ui/screens/profiledetail/editprofile/editprofiletextfield.dart';
import 'package:twitter/ui/screens/profiledetail/editprofile/profileselectimage.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/provider.dart';
import 'package:twitter/utils/sharedpreferences.dart';
import 'package:twitter/model/tweetwithprofile.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key, required this.tweet, required this.imagePath});

  final TweetWithProfile? tweet;
  String imagePath;

  @override
  State<StatefulWidget> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  void _updateImagePath(String newPath) {
    setState(() {
      widget.imagePath = newPath;
    });
  }
  Future <void> saveImage(BuildContext context) async {
    final userPreferences = UserPreferences();
    bool isLoggedIn = await userPreferences.isLoggedIn();

    if (isLoggedIn) {
      int? userId = await userPreferences.getUserId();
      File imageFile = File(widget.imagePath);
      UserService().updateProfilePicture(userId!, imageFile);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          titleText1: 'Edit Profile',
          fontWeight: FontWeight.bold,
          textSize: 25,
          textColor: Provider.of<UserProfileProvider>(context).titleColor,
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                saveImage(context);

              },
              style: ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(Size(89, 40)),
                  elevation:MaterialStatePropertyAll(0),
                  backgroundColor:
                  MaterialStatePropertyAll(Provider.of<UserProfileProvider>(context).fullScreenTitleColor)),
              child: TextWidget(
                  titleText1: 'Save',
                  fontWeight: FontWeight.bold,
                  textSize: 20,
                  textColor: Provider.of<UserProfileProvider>(context).titleColor))
        ],

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  ProfileSelectImage(
                    selectedImagePath: widget.imagePath,
                    onUpdateSelectedImagePath: _updateImagePath,
                  ),
                  EditProfileTextFieldWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
