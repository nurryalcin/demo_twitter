import 'package:flutter/material.dart';
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




  @override
  Widget build(BuildContext context) {
    return const MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Column(
           children: [
             WelcomePage(),
           ],


          ),
      )
    );
  }
}
