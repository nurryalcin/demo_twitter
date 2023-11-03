import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:twitter/ui/screens/addtweet/addtweet.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/settingsandprivacy/accountinformation.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/settingsandprivacy/accountpage.dart';
import 'package:twitter/ui/screens/loginpage/page/emailloginpage.dart';
import 'package:twitter/ui/screens/widgets/bottomnavigationbarwidget.dart';
import 'package:twitter/utils/class.dart';
import 'package:twitter/utils/provider.dart';
import 'package:twitter/utils/sharedpreferences.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProfileProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<bool> _isLoggedIn;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = UserPreferences().isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
       SystemUiOverlayStyle(
        statusBarColor: CardColor.fullScreenTitleColor,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: const CupertinoPageTransitionsBuilder(),
          },
        ),
        appBarTheme: AppBarTheme(
          elevation:2,
          backgroundColor: CardColor.fullScreenTitleColor,
          iconTheme: IconThemeData(color: CardColor.titleColor, size: 35),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/account': (context) => const AccountPage(),
        '/accountinformation': (context) => const AccountInformation(),
        '/home': (context) => BottomNavigationBarWidget(index: 0),
        '/search': (context) => BottomNavigationBarWidget(index: 1),
        '/communities':(context) => BottomNavigationBarWidget(index: 2),
        '/notifications': (context) => BottomNavigationBarWidget(index: 3),
        '/message': (context) => BottomNavigationBarWidget(index: 4),
        '/addtweet':(context) => AddTweet(),
      },
      home: Scaffold(
        body: FutureBuilder<bool>(
          future: _isLoggedIn,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData && snapshot.data == true) {
                return BottomNavigationBarWidget(index: 0);
              } else {
                return  EmailLoginPage();
              }
            }
          },
        ),

      ),
    );
  }
}
