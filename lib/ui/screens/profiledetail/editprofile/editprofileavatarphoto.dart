import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:twitter/utils/provider.dart';

class EditProfileAvatarPhoto extends StatefulWidget{
  const EditProfileAvatarPhoto({
    Key? key,
    this.radius = 30,
    this.imagePath,
  }) : super(key: key);

  final double radius;
  final String? imagePath;

  @override
  State<StatefulWidget> createState()=> _EditProfileAvatarPhotoState();

}

class _EditProfileAvatarPhotoState extends State<EditProfileAvatarPhoto> {

  @override
  Widget build(BuildContext context) {
    String? finalImagePath;

    final userProvider = Provider.of<UserProfileProvider>(context, listen: false);
    String? avatarPhotoUrl=userProvider.imagePath;

    if (widget.imagePath != null && widget.imagePath!.isNotEmpty) {
      return ClipOval(
        child: SizedBox(
          width: widget.radius * 2,
          height: widget.radius * 2,
          child: Image.file(
            File(widget.imagePath!),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (avatarPhotoUrl != null && avatarPhotoUrl!.isNotEmpty) {
      finalImagePath = "http://192.168.1.70:5169/Profile/$avatarPhotoUrl";
      return ClipOval(
        child: SizedBox(
          width: widget.radius * 2,
          height: widget.radius * 2,
          child: Image.network(
            finalImagePath,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return ClipOval(
      child: SizedBox(
        width: widget.radius * 2,
        height: widget.radius * 2,
        child: SvgPicture.asset("assets/images/default_profile.svg"),
      ),
    );
  }
}
