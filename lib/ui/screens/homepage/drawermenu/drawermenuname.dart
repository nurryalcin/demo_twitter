import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';
import '../../../../utils/sharedpreferences.dart';

class DrawerMenuName extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrawerMenuNameState();
}

class _DrawerMenuNameState extends State<DrawerMenuName> {
  String? fullname;
  String? username;

  Future<void> getFullname() async {
    UserPreferences userPreferences = UserPreferences();
    bool isLoggedIn = await userPreferences.isLoggedIn();

    if (isLoggedIn) {
      setState(() {
        fullname = userPreferences.getFullname();
        username=userPreferences.getUsername();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getFullname();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
              titleText1: fullname ?? "",
              fontWeight: FontWeight.bold,
              textSize: 25,
              textColor: CardColor.titleColor),
          TextWidget(
              titleText1: '@$username ',
              fontWeight: FontWeight.normal,
              textSize: 20,
              textColor: CardColor.userColor),
        ],
      ),
    );
  }
}
