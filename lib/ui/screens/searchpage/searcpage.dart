import 'package:flutter/material.dart';
import 'package:twitter/api_service/user_service.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/drawermenü.dart';
import 'package:twitter/ui/screens/searchpage/widget/searchuserlist.dart';
import 'package:twitter/ui/screens/widgets/avatarprofile.dart';
import '../../../model/user.dart';

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
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
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
              hintText: 'Search',
              hintStyle: const TextStyle(fontSize: 20),
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

      ),
      body: SingleChildScrollView(
       child:SearchUserList(searchResults),

      ),
      floatingActionButton: FloatingActionButton(child:Icon(Icons.add,size: 30),onPressed: () {
        Navigator.pushNamed(context, '/addtweet');
      },),
    );
  }
}