import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter/model/user.dart';

class FollowListAvatarProfile extends StatefulWidget {
  const FollowListAvatarProfile(
      {Key? key, this.radius = 25, required this.user})
      : super(key: key);
  final double radius;
  final User? user;

  @override
  State<StatefulWidget> createState() => _FollowListAvatarProfileState();
}

class _FollowListAvatarProfileState extends State<FollowListAvatarProfile> {
  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    String? imagePath = widget.user!.avatarPhotoUrl;
    if (imagePath != null && imagePath!.isNotEmpty) {
      imageWidget = Image.network(
        "http://192.168.1.70:5169/Profile/$imagePath",
        fit: BoxFit.cover,
      );
    } else {
      imageWidget = SvgPicture.asset("assets/images/default_profile.svg");
    }

    return ClipOval(
      child: SizedBox(
        width: widget.radius * 2,
        height: widget.radius * 2,
        child: imageWidget,
      ),
    );
  }
}
