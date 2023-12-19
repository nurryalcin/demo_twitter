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

  //DARK MODE GÜNCELLEMELERİ

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  Color get titleColor {
    return _isDarkMode ? Colors.white : Colors.black;
  }
  Color? get followButton{
    return _isDarkMode ? Colors.blueGrey[900] : Colors.white;
  }

  Color get userColor {
    return _isDarkMode ? Colors.grey : Colors.grey;
  }
  Color get whiteColor {
    return _isDarkMode ? Colors.white : Colors.white;
  }
  Color get blackColor{
    return _isDarkMode ? Colors.black:Colors.black;
  }

  Color get fullScreenTitleColor {
    return _isDarkMode ? Colors.white : Colors.black;
  }
  Color get appbarColor{
    return _isDarkMode ? Colors.black : Colors.white;
  }

  Color get iconColorBlue {
    return _isDarkMode ? Colors.blue : Colors.blue;
  }

  Color get iconColorlightBlue {
    return _isDarkMode ? Colors.lightBlueAccent : Colors.lightBlueAccent;
  }
}




