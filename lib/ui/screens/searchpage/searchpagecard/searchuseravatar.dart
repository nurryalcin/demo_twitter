import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../model/user.dart';

class SearchUserAvatar extends StatelessWidget{
  SearchUserAvatar({super.key, this.radius = 30,  required this.userList,});

  final User userList;
  final double radius;


  @override
  Widget build(BuildContext context) {
    final imagePath=userList!.avatarPhotoUrl;
    Widget imageWidget;

    if (imagePath != null) {
      if (imagePath.isNotEmpty) {
        imageWidget = Image.network(
          "http://192.168.1.70:5169/Profile/$imagePath",
          fit: BoxFit.cover,
        );
      } else {
        imageWidget = SvgPicture.asset("assets/images/default_profile.svg");
      }
    } else {
      imageWidget = SvgPicture.asset("assets/images/default_profile.svg");
    }

    return ClipOval(
      child: SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: imageWidget,
      ),
    );
  }

}