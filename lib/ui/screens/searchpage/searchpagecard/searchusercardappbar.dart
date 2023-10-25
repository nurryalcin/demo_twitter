import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/ui/screens/profiledetail/profiledetail/profiletweetdetailpage.dart';
import 'package:twitter/ui/screens/searchpage/searchpagecard/searchuseravatar.dart';
import 'package:twitter/ui/screens/widgets/textwidget.dart';
import 'package:twitter/utils/class.dart';
import '../../../../model/user.dart';
import '../../../../utils/provider.dart';

class SearchUserCardAppbar extends StatelessWidget {
  const SearchUserCardAppbar({Key? key, required this.userList}) : super(key: key);

  final User userList;

  void _onCardTapped(BuildContext context) {

    int? userId= userList.id;
    final userProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProvider.selectedProfileuserId(userId);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileTweetDetailPage(index: 1,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onCardTapped(context),
      child: Row(
        children: [
          SearchUserAvatar(userList: userList),
          const Padding(padding: EdgeInsets.only(left: 15)),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                TextWidget(
                  titleText1: userList.fullname,
                  fontWeight: FontWeight.bold,
                  textSize: 15,
                  textColor: CardColor.titleColor,
                ),
                const Padding(padding: EdgeInsets.only(left: 15)),
                TextWidget(
                  titleText1: '@${userList.username}',
                  fontWeight: FontWeight.bold,
                  textSize: 15,
                  textColor: CardColor.userColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
