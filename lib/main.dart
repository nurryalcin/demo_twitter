import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:twitter/ui/screens/widgets/addtweet.dart';
import 'package:twitter/ui/screens/login.dart';
import 'package:twitter/ui/screens/widgets/tweetwidget.dart';
import 'package:twitter/ui/screens/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  List<Tweet> tweets = [];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Card(
            child: WelcomePage(),


          ),
      )
    );
  }
}
