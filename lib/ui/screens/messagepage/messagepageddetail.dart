import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/messagepage/widget/messagedetail/choosepersonwidget.dart';
import 'package:twitter/ui/screens/messagepage/widget/messagedetail/searchwidget.dart';

class MessagePageDetail extends StatefulWidget{
  const MessagePageDetail({super.key});

  @override
  State<StatefulWidget> createState()=> _MessagePageDetailState();

}

class _MessagePageDetailState extends State<MessagePageDetail> {
  bool _isUserSelected = false;

  void _onSelectedUser(bool selected) {
    setState(() {
      _isUserSelected = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ChoosePerson(
            isUserSelected: _isUserSelected,
            onPressed: _isUserSelected ? () {

            } : null,
          ),
          SearchWidget(onUserSelected: _onSelectedUser),
        ],
      ),
    );
  }
}
