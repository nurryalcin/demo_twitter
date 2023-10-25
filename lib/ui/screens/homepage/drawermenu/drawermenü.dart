import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/drawermenuname.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/followfollowingwidget.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/helpcenter/helpcenterpage.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/settingsandprivacy/settingpage.dart';
import 'package:twitter/ui/screens/profiledetail/mydetailprofile/myprofiledetail.dart';
import 'package:twitter/ui/screens/widgets/avatarprofile.dart';
import 'package:twitter/ui/screens/widgets/titletext.dart';
import 'package:twitter/utils/class.dart';

class DrawerMenu extends StatelessWidget {
  DrawerMenu({super.key});

  final List<Map<String, dynamic>> drawerItems = [
    {
      'icon': Icons.person_2_outlined,
      'title': 'Profile',
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyProfileDetailPage(),
          ),
        );
      },
    },
    {
      'icon':Icons.workspace_premium_outlined,
      'title': 'Premium',
    },
    {
      'icon': Icons.bookmark_border_outlined,
      'title': 'Bookmarks',
    },
    {
      'icon': Icons.list_alt_outlined,
      'title': 'Lists',

    },
    {
      'icon': Icons.circle_outlined,
      'title': 'Spaces',
    },
    {
      'icon': Icons.money,
      'title': 'Monetization',
    },
    {
      'title': 'Professional Tools',
      'subItems': [],
    },
    {
      'title': 'Settings & Support',
      'subItems': [
        {
          'icon': Icons.settings_outlined,
          'title': 'Settings and privacy',
          'onTap':(BuildContext context){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage(),));
          }
        },
        {
          'icon': Icons.help_outline,
          'title': 'Help Center',
          'onTap': (BuildContext context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  HelpCenterPage(),
              ),
            );
          },
        }
      ],
    }
  ];

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double maxPopupMenuItemWidth = deviceWidth * 0.7;
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10),
        child: Column(
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
                            color: CardColor.titleColor,
                            size: 25,
                          ),
                          title: TitleText(
                            textName: item['title'],
                            textColor: CardColor.titleColor,
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
                            textColor: CardColor.titleColor,
                            textWeight: FontWeight.bold,
                            textSize: 17,
                          ),
                          children: item['subItems']
                              .map<Widget>(
                                (subItem) => ListTile(
                              leading: Icon(
                                subItem['icon'],
                                color: CardColor.titleColor,
                                size: 20,
                              ),
                              title: Text(
                                subItem['title'],
                                style: TextStyle(
                                  color: CardColor.titleColor,
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
          ],
        ),
      ),
    );
  }
}