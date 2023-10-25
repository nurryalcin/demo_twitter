import 'package:flutter/material.dart';

import '../../../model/user.dart';

class ChatScreen extends StatefulWidget{
  const ChatScreen({super.key, this.user});

  final User? user;

  @override
  State<StatefulWidget> createState()=> _ChatScreenState();


}

class _ChatScreenState extends State<ChatScreen>{
  @override
  Widget build(BuildContext context) {
   return const Scaffold();
  }

}