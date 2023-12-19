import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/ui/screens/welcomepage/welcome.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/provider.dart';
import 'package:twitter/utils/sharedpreferences.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({super.key});

  @override
  State<StatefulWidget> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  String? email;

  Future<void> getEmail() async {
    UserPreferences userPreferences = UserPreferences();
    bool isLoggedIn = await userPreferences.isLoggedIn();

    if (isLoggedIn) {
      setState(() {
        email = userPreferences.getEmail();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    final String? username =
        ModalRoute.of(context)!.settings.arguments as String?;
    List<Map<String, dynamic>> list = [
      {
        'title': 'Username',
        'subtitle': '@$username',
      },
      {
        'title': 'Phone',
        'subtitle': 'Add',
      },
      {
        'title': 'Email',
        'subtitle': email,
      },
      {
        'title': 'Country',
        'subtitle': 'Türkiye',
      },
      {
        'title': 'Automation',
        'subtitle': 'Manage your automated account.',
      },
      {
        'title': 'Log out',
        'subtitle': '',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
                titleText1: 'Account information',
                fontWeight: FontWeight.bold,
                textSize: 20,
                textColor:Provider.of<UserProfileProvider>(context).titleColor),
            TextWidget(
                titleText1: '@$username',
                fontWeight: FontWeight.normal,
                textSize: 20,
                textColor:Provider.of<UserProfileProvider>(context).userColor),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              String title = list[index]['title'];
              if (title == 'Log out') {
                final userPreferences = UserPreferences();
                userPreferences.logOut().then((_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomePage()),
                  );
                });
              }
            },
            child: ListTile(
              title: Text(list[index]['title'],
                style: TextStyle(
                  color: list[index]['title'] == 'Log out' ? Colors.red :Provider.of<UserProfileProvider>(context).titleColor
                ),),

              subtitle: Text(
                list[index]['subtitle'] ?? 'Bilgi yok',

              ),
            ),
          );
        },
      ),
    );
  }
}
