import 'package:flutter/material.dart';
import 'package:twitter/model/user.dart';
import 'package:twitter/ui/screens/homepage/drawermenu/page/followpage/shortcardwidget.dart';

class SearchUserList extends StatelessWidget {
  final List<User> searchResults;

  SearchUserList(this.searchResults);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: searchResults.map((user) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ShortCardWidget(user: user),
        );
      }).toList(),
    );
  }
}
