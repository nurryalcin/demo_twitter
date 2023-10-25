import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/searchpage/searchpagecard/searchusercard.dart';
import '../../../../model/user.dart';

class SearchUserList extends StatelessWidget {
  final List<User> searchResults;

  SearchUserList(this.searchResults);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: searchResults.map((user) {
        return SearchUserCard(userList: user);
      }).toList(),
    );
  }
}
