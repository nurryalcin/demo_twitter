import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/page/helpcenter/helpcenterpage.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/settingsandprivacy/settingpage.dart';
import 'package:twitter/ui/screens/profiledetail/mydetailprofile/myprofiledetail.dart';

class DrawerMenuList{

  final List<Map<String, dynamic>> drawerItems = [
    {
      'icon': Icons.person_2_outlined,
      'title': 'Profile',
      'onTap': (BuildContext context) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyProfileDetailPage(),
          ),
        );
      },
    },
    {
      'icon': Icons.workspace_premium_outlined,
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
          'onTap': (BuildContext context) {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingPage(),
                ));
          }
        },
        {
          'icon': Icons.help_outline,
          'title': 'Help Center',
          'onTap': (BuildContext context) {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HelpCenterPage(),
              ),
            );
          },
        }
      ],
    }
  ];
}