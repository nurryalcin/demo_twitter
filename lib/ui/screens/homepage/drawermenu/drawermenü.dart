import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/widget/drawermenuname.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/widget/drawermen%C3%BCmodebutton.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/widget/drwermen%C3%BClist.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/widget/followfollowingwidget.dart';
import 'package:twitter/ui/screens/widgets/avatarprofile.dart';
import 'package:twitter/ui/screens/widgets/titletext.dart';
import 'package:twitter/utils/provider.dart';

class DrawerMenu extends StatelessWidget {
  DrawerMenu({super.key});
  @override
  Widget build(BuildContext context) {
    final drawerMenuList = DrawerMenuList();
    final drawerItems = drawerMenuList.drawerItems;
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(right: 215),
              child: AvatarProfile(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10),
              child: DrawerMenuName(),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 10, bottom: 40),
              child: FollowFollowingWidget(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: drawerItems.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = drawerItems[index];
                  return Column(
                    children: <Widget>[
                      if (item['subItems'] == null)
                        ListTile(
                          leading: Icon(
                            item['icon'],
                            color: Provider.of<UserProfileProvider>(context).titleColor,
                            size: 25,
                          ),
                          title: TitleText(
                            textName: item['title'],
                            textColor: Provider.of<UserProfileProvider>(context).titleColor,
                            textWeight: FontWeight.bold,
                            textSize: 17,
                          ),
                          onTap: item['onTap'] != null
                              ? () {
                                  item['onTap'](context);
                                }
                              : null,
                        ),
                      if (item['subItems'] != null)
                        ExpansionTile(
                          title: TitleText(
                            textName: item['title'],
                            textColor: Provider.of<UserProfileProvider>(context).titleColor,
                            textWeight: FontWeight.bold,
                            textSize: 17,
                          ),
                          children: item['subItems']
                              .map<Widget>(
                                (subItem) => ListTile(
                                  leading: Icon(
                                    subItem['icon'],
                                    color: Provider.of<UserProfileProvider>(context).titleColor,
                                    size: 20,
                                  ),
                                  title: Text(
                                    subItem['title'],
                                    style: TextStyle(
                                      color:Provider.of<UserProfileProvider>(context).titleColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  onTap: subItem['onTap'] != null
                                      ? () {
                                          subItem['onTap'](context);
                                        }
                                      : null,
                                ),
                              )
                              .toList(),
                        ),
                      if (item['title'] == 'Monetization')
                        const Padding(
                          padding: EdgeInsets.only(
                              right: 20, left: 20, top: 10, bottom: 20),
                          child: Divider(
                            color: Colors.black,
                            height: 10.0,
                            thickness: 1,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),

            DrawerMenuModeButton()


          ],
        ),
      ),
    );
  }
}
