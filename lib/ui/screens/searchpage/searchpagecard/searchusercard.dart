import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/searchpage/searchpagecard/searchusercardappbar.dart';
import '../../../../model/user.dart';

class SearchUserCard extends StatelessWidget {
  const SearchUserCard({Key? key, required this.userList, }) : super(key: key);

  final User userList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,left: 10,bottom: 20,right: 10),
      child: Column(
        children: [
          ListTile(
            leading: SizedBox(
              width: 325,
              child: SearchUserCardAppbar(userList:userList ),
            ),
          ),
        ],
      ),
    );
  }
}
