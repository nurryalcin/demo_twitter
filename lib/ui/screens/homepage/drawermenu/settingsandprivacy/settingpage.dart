import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/settingsandprivacy/settinglist.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';
import 'package:twitter/utils/sharedpreferences.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String? username;

  Future<void> getUsername() async {
    UserPreferences userPreferences = UserPreferences();
    bool isLoggedIn = await userPreferences.isLoggedIn();
    if (isLoggedIn) {
      setState(() {
        username = userPreferences.getUsername()!;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
                titleText1: 'Settings',
                fontWeight: FontWeight.bold,
                textSize: 20,
                textColor: CardColor.titleColor),
            TextWidget(
                titleText1: '@$username',
                fontWeight: FontWeight.normal,
                textSize: 18,
                textColor: CardColor.userColor)
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.grey[200])),
                child: Container(
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: CardColor.userColor,
                      ),
                      TextWidget(
                          titleText1: 'Search settings',
                          fontWeight: FontWeight.normal,
                          textSize: 15,
                          textColor: CardColor.userColor)
                    ],
                  ),
                ),
              ),
            ],
          ),
          SettingList(
            username: username,
          )
        ],
      ),
    );
  }
}
