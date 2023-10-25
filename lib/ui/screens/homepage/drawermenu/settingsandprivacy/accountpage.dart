import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String? username =
        ModalRoute.of(context)!.settings.arguments as String?;
    List<Map<String, dynamic>> list = [
      {
        'icon': Icons.perm_identity,
        'title': 'Account information',
        'subtitle':
            'See your account information like your phone number and email address.'
      },
      {
        'icon': Icons.lock_open,
        'title': 'Change your password',
        'subtitle': 'Change your password at any time.'
      },
      {
        'icon': Icons.download_outlined,
        'title': 'Download an archive of your data',
        'subtitle':
            'Get insights into the type of information stored for your account.'
      },
      {
        'icon': Icons.heart_broken_outlined,
        'title': 'Deactive Account',
        'subtitle': 'Find out how you can deactivate your account'
      }
    ];
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            TextWidget(
                titleText1: 'Your account',
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
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
            child: TextWidget(
                titleText1:
                    'See information about your account, download an archive of your data,or learn about your account deactivation options.',
                fontWeight: FontWeight.normal,
                textSize: 15,
                textColor: CardColor.userColor),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    String title = list[index]['title'];
                    if (title == 'Account information') {
                     Navigator.pushNamed(context, '/accountinformation',
                         arguments: username);
                    }
                  },
                  child: ListTile(
                    leading: Icon(list[index]['icon']),
                    title: Text(list[index]['title']),
                    subtitle: Text(list[index]['subtitle']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
