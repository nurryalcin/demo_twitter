import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:twitter/ui/screens/addtweet/addtweet.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/settingsandprivacy/accountinformation.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/settingsandprivacy/accountpage.dart';
import 'package:twitter/ui/screens/welcomepage/welcome.dart';
import 'package:twitter/ui/screens/widgets/bottomnavigationbarwidget.dart';
import 'package:twitter/utils/provider.dart';
import 'package:twitter/utils/sharedpreferences.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProfileProvider(),
      child: MyApp(),
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
    final userPreferences = UserPreferences();

    userPreferences.getDarkMode().then((isDarkMode) {
      Provider.of<UserProfileProvider>(context, listen: false).isDarkMode = isDarkMode;
    });

    _isLoggedIn = userPreferences.isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<UserProfileProvider>(context).isDarkMode;

    final ThemeData lightTheme = ThemeData.light().copyWith(
      brightness: Brightness.light,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: const CupertinoPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Provider.of<UserProfileProvider>(context).titleColor, size: 35),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
    );

    final ThemeData darkTheme = ThemeData.dark().copyWith(
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Provider.of<UserProfileProvider>(context).titleColor),
        backgroundColor: Colors.blueGrey[900],
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.blueGrey[900],
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      drawerTheme: DrawerThemeData(backgroundColor: Colors.blueGrey[900]),
      scaffoldBackgroundColor: Colors.blueGrey[900],

      cardColor: Colors.blueGrey[900],
      colorScheme: ColorScheme.light(

        secondary: Colors.blue,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.blueGrey[900],
      ),


    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? darkTheme : lightTheme,
      initialRoute: '/',
      routes: {
        '/account': (context) => const AccountPage(),
        '/accountinformation': (context) => const AccountInformation(),
        '/home': (context) => const BottomNavigationBarWidget(index: 0),
        '/search': (context) => const BottomNavigationBarWidget(index: 1),
        '/communities': (context) => const BottomNavigationBarWidget(index: 2),
        '/notifications': (context) => const BottomNavigationBarWidget(index: 3),
        '/message': (context) => const BottomNavigationBarWidget(index: 4),
        '/addtweet': (context) => const AddTweet(),
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
                return const BottomNavigationBarWidget(index: 0);
              } else {
                return WelcomePage();
              }
            }
          },
        ),
      ),
    );
  }
}
