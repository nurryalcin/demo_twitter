import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:twitter/utils/provider.dart';

class AvatarProfile extends StatefulWidget {
  const AvatarProfile({Key? key, this.radius = 25}) : super(key: key);
  final double radius;

  @override
  State<StatefulWidget> createState() => _AvatarProfileState();
}

class _AvatarProfileState extends State<AvatarProfile> {
  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    final userProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    String? imagePath = userProvider.imagePath;
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
