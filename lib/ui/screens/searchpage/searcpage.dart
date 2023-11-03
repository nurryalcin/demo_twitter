import 'package:flutter/material.dart';
import 'package:twitter/api_service/user_service.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/drawermenü.dart';
import 'package:twitter/ui/screens/searchpage/widget/searchuserlist.dart';
import 'package:twitter/ui/screens/widgets/addtweetbutton.dart';
import 'package:twitter/ui/screens/widgets/avatarprofile.dart';
import 'package:twitter/model/user.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<User> searchResults = [];
  final TextEditingController _searchController = TextEditingController();
  bool showAvatar = true;

  void _searchUsers(String username) async {
    setState(() {
      searchResults.clear();
    });

    if (username.isEmpty) {
      return;
    }

    List<User>? results = await UserService().getUsername(username);

    if (results != null) {
      setState(() {
        searchResults = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
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
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: AvatarProfile(),
          ),
        ),
        title: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280, maxHeight: 35),
          child: TextField(
            controller: _searchController,
            onChanged: _searchUsers,
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
              hintText: 'Search X',
              hintStyle: const TextStyle(fontSize: 15),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(100.0),

              ),
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: () {
            
          }, icon: Icon(Icons.settings_outlined,size: 25,))
        ],

      ),
      body: SingleChildScrollView(
       child:SearchUserList(searchResults),

      ),
      floatingActionButton: AddTweetButton()
    );
  }
}