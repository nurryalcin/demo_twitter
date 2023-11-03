import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/drawermen%C3%BC.dart';
import 'package:twitter/ui/screens/messagepage/messagepageddetail.dart';
import 'package:twitter/ui/screens/widgets/avatarprofile.dart';

class MessageStartPage extends StatefulWidget {
  const MessageStartPage({super.key});

  @override
  State<StatefulWidget> createState() => _MessageStartPageState();
}

class _MessageStartPageState extends State<MessageStartPage> {
  bool showAvatar = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(4),
          child: GestureDetector(
            onTap: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: DrawerMenu(),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AvatarProfile(),
            ),
          ),
        ),
        title: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 250, maxHeight: 40),
          child: TextField(
           // controller: _searchController,
           // onChanged: _searchUsers,
            onTap: () {
              setState(() {
                showAvatar = false;
              });
            },
            onEditingComplete: () {
              setState(() {
                showAvatar = true;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search Direct Messages',
              hintStyle: const TextStyle(fontSize: 15),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings_outlined,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.mark_email_read_outlined,
          size: 30,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessagePageDetail(),
              ));
        },
      ),
    );
  }
}
