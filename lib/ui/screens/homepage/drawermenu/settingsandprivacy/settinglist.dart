import 'package:flutter/material.dart';

class SettingList extends StatelessWidget {
   SettingList({super.key, this.username, });
   final String? username;



   @override
  Widget build(BuildContext context) {
     final String? username = this.username;
     List<Map<String, dynamic>> settings = [
      {
        'icon': Icons.perm_identity,
        'title': 'Your account',
        'subtitle':
            'See information about your account,download an archive of your data,of learn about your account deactivation options.'
      },
      {
        'icon': Icons.lock_open,
        'title': 'Security and account access',
        'subtitle':
            'Manage your account\'s security and keep track of your account\'s usage including apps your have connected to your account.'
      },
      {
        'icon': Icons.workspace_premium_outlined,
        'title': 'Premium',
        'subtitle': 'See what\'s included in Premium  and manage your settings.'
      },
      {
        'icon': Icons.money,
        'title': 'Monetization',
        'subtitle':
            'See how you can make money on X and manage your monetization options.'
      },
      {
        'icon': Icons.privacy_tip_outlined,
        'title': 'Privacy and safety',
        'subtitle': 'Manage what information you see ans share on X.'
      },
      {
        'icon': Icons.notifications_none_outlined,
        'title': 'Notifications',
        'subtitle':
            'Select the kinds of notifications you get about your activities, interests, and recommendations.'
      },
      {
        'icon': Icons.accessibility,
        'title': 'Accessibility, display and languages',
        'subtitle': ' Manage how X content is displayed to you'
      },
      {
        'icon': Icons.more_horiz,
        'title': 'Additional,display and languages',
        'subtitle':
            'Check out other places for helpful information to learn more about X products ans services.'
      },
      {'icon': Icons.remove_red_eye_outlined, 'title': 'Proxy', 'subtitle': ''}
    ];

    return Expanded(
      child: ListView.builder(
        itemCount: settings.length * 2 - 1,
        itemBuilder: (BuildContext context, int index) {
          if (index.isOdd) {
            return SizedBox(height: 16.0);
          }
          int settingIndex = index ~/ 2;

          return InkWell(
            onTap: () {
              String title = settings[settingIndex]['title'];
              if (title == 'Your account') {
                Navigator.pushNamed(
                  context,
                  '/account',
                  arguments: username

                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                leading: Icon(settings[settingIndex]['icon']),
                title: Text(settings[settingIndex]['title']),
                subtitle: Text(settings[settingIndex]['subtitle']),

              ),
            ),
          );
        },
      ),
    );
  }
}
