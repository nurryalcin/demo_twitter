import 'package:flutter/material.dart';
import 'package:twitter/utils/sharedpreferences.dart';

class UserProfileProvider extends ChangeNotifier {
   int? userId;
  int? selectedUserId;
  String? imagePath;
  int? profileUserId;
  String? selectedImagePath;
  int? selectedTweetId;
  int? parentTweetId;




  UserProfileProvider() {
    initUserProfile();
  }

  Future<void> initUserProfile() async {
    UserPreferences userPreferences = UserPreferences();
    bool loggedIn = await userPreferences.isLoggedIn();

    if (loggedIn) {
      imagePath = userPreferences.image;
      notifyListeners();
    }
  }

  void selectedProfileuserId(int selectedProfileUserId){
    profileUserId=selectedProfileUserId;
    notifyListeners();
  }



  void selectedTweet(int selectedTweet){
    selectedTweetId=selectedTweet;
    notifyListeners();
  }


  void setSelectedUserId(int senderId) {
    selectedUserId = senderId;
    print('selectedUserId');
    notifyListeners();
  }



  void updateImage(String newPath) {
    selectedImagePath = newPath;
    print('newpath:$newPath');
    UserPreferences().saveProfileImagePath(newPath);
    notifyListeners();
  }


}
