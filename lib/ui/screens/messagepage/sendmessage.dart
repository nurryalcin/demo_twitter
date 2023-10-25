import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/messagepage/widget/writemessage/sendmessageappbar.dart';
import 'package:twitter/ui/screens/messagepage/widget/writemessage/writemessage.dart';

import '../../../model/user.dart';

class SendMessage extends StatelessWidget {
  final User? user;

  const SendMessage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SendMessageAppbar(),
          WriteMessage(user: user),

        ],
      ),
    );
  }
}
