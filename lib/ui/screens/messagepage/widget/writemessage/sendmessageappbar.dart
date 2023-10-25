import 'package:flutter/material.dart';
import 'package:twitter/ui/screens/widgets/avatarprofile.dart';
import 'package:twitter/ui/screens/widgets/bottomnavigationbarwidget.dart';

class SendMessageAppbar extends StatelessWidget{
  const SendMessageAppbar({super.key});




  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Row(
        children: [
          IconButton( icon:Icon(Icons.arrow_back_ios), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>BottomNavigationBarWidget(index: 3, ),));
          },),
          AvatarProfile(),
        ],


      ),
    );
  }

}