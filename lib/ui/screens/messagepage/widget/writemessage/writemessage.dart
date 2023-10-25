import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/utils/provider.dart';
import '../../../../../api_service/message_service.dart';
import '../../../../../model/message.dart';
import '../../../../../model/user.dart';
import '../../../../../utils/sharedpreferences.dart';


class WriteMessage extends StatefulWidget {
  final User? user;

  WriteMessage({required this.user});

  @override
  _WriteMessageState createState() => _WriteMessageState();
}

class _WriteMessageState extends State<WriteMessage> {

  TextEditingController _messageController = TextEditingController();
  bool _isMessageEmpty = true;
  int? userId;

  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    _messageController.addListener(_messageControllerListener);
    loadMessages();
  }

  final userPreferences= UserPreferences();

  void loadMessages() async {
    final userProvider = Provider.of<UserProfileProvider>(context, listen: false);


    int? savedUserId = await userPreferences.getUserId();

    if (userProvider.selectedUserId != null && savedUserId != null) {
      try {
        MessageService messageService = MessageService();
        List<Message> getMessages = await messageService.getMessages(savedUserId, userProvider.selectedUserId!);

        setState(() {
          messages = getMessages;
        });
      } catch (e) {
        print('Mesajları çekerken hata oluştu: $e');
      }
    }
  }



  void _messageControllerListener() {
    setState(() {
      _isMessageEmpty = _messageController.text.isEmpty;
    });
  }

  @override
  void dispose() {
    _messageController.removeListener(_messageControllerListener);
    _messageController.dispose();
    super.dispose();
  }

  void sendMessage() async {
    final userProvider = Provider.of<UserProfileProvider>(context, listen: false);

    int? savedUserId = await userPreferences.getUserId();

    if (userProvider.selectedUserId != null && savedUserId != null) {
      if (!_isMessageEmpty) {
        String message = _messageController.text;
        int selectedUserId = userProvider.selectedUserId!;

        print('Gönderilen Mesaj: $message');
        print('senderId: $savedUserId');
        print('selectedUserId:$selectedUserId');

        _messageController.clear();
        try {
          MessageService messageService = MessageService();
          await messageService.sendMessage(message,savedUserId, selectedUserId);
          setState(() {
            _isMessageEmpty = true;
          });
        } catch (e) {
        }
      }
    } else {
      print('Gönderilecek kişi yok.');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 300),
          child: TextField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: 'Mesaj yaz...',
              border: OutlineInputBorder(),
            ),
            maxLines: null,
          ),
        ),
        ElevatedButton(
          onPressed: _isMessageEmpty ? null : sendMessage,
          child: Text('Gönder'),
        ),
      ],
    );
  }
}