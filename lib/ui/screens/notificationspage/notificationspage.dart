import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/drawermen%C3%BC.dart';
import 'package:twitter/ui/screens/widgets/addtweetbutton.dart';
import 'package:twitter/ui/screens/widgets/avatarprofile.dart';
import 'package:twitter/ui/screens/widgets/titletext.dart';
import 'package:twitter/utils/provider.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<StatefulWidget> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: GestureDetector(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: DrawerMenu(),
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AvatarProfile(),
                ),
              ),
            ),
            title: TitleText(
              textName: 'Notifications',
              textColor: Provider.of<UserProfileProvider>(context).titleColor,
              textWeight: FontWeight.bold,
              textSize: 23,
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.settings_outlined,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ],
          )

        ],
      ),

      floatingActionButton: AddTweetButton(),
    );
  }
}
