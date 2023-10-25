import 'package:flutter/material.dart';
import 'package:twitter/model/message.dart';
import '../../../../../api_service/message_service.dart';
import '../../../../../utils/sharedpreferences.dart';

class ListMessageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListMessageWidgetState();
}

class _ListMessageWidgetState extends State<ListMessageWidget> {
  List<Message> chatUser = [];

  @override
  void initState() {
    super.initState();
    //getChatUser();
  }

  /*Future<void> getChatUser() async {
    try {
      String? userId = await UserPreferences.getUserId();
      if (userId != null) {
        List<User> fetchedMessages =
        await MessageService().getSenderId(int.parse(userId));
        setState(() {
          chatUser = fetchedMessages;
        });
      } else {
        print('Kullanıcı ID bulunamadı.');
      }
    } catch (e) {
      print('Mesajları alma hatası: $e');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Column(
      children: chatUser.map((message) {
        return ListTile(
          title: Text(message.senderId.toString()),
          onTap: () {
          },
        );
      }).toList(),
    );
  }
}
