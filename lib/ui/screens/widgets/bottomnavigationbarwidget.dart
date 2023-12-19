import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/ui/screens/peoples/communities.dart';
import 'package:twitter/ui/screens/searchpage/searcpage.dart';
import 'package:twitter/ui/screens/homepage/homePage.dart';
import 'package:twitter/ui/screens/messagepage/messagestartpage.dart';
import 'package:twitter/ui/screens/notificationspage/notificationspage.dart';
import 'package:twitter/utils/provider.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int index;

  const BottomNavigationBarWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.index;
  }


  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    Communities(),
    NotificationsPage(),
    MessageStartPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    Color color=Provider.of<UserProfileProvider>(context).titleColor;
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30),
            activeIcon: Icon(Icons.home, color: color, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30),
            activeIcon: Icon(Icons.search, color: color, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline, size: 30),
            activeIcon: Icon(Icons.people, color: color, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined, size: 30),
            activeIcon: Icon(Icons.notifications, color:color, size: 30),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline, size: 30),
            activeIcon: Icon(Icons.mail, color: color, size: 30),
            label: '',
          ),
        ],

        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}